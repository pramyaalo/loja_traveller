import 'dart:async';
import 'dart:convert';
 import 'package:get/get.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as developer;

import '../../AdultDatabaseHelperCass.dart';
import '../../DatabseHelper.dart';
import '../../utils/commonutils.dart';
import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';
import 'Children_DatabaseHelper.dart';
import 'FilterPage.dart';
import 'InfantDatabaseHelper.dart';
import 'oneway_booking.dart';

class OnewayFlightsList extends StatefulWidget {
  final add,
      adult,
      orgin,
      destination,
      departDate,
      children,
      infants,
      userId,
      currency,
      classtype;

  const OnewayFlightsList({
    super.key,
    required this.add,
    required this.adult,
    required this.children,
    required this.infants,
    required this.orgin,
    required this.destination,
    required this.departDate,
    required this.userId,
    required this.currency,
    required this.classtype,
  });

  @override
  State<OnewayFlightsList> createState() => _OnewayFlightsListState();
}

class _OnewayFlightsListState extends State<OnewayFlightsList> {
  bool isLoading = false;
  String? selectedSortOption = "Low to High";
  int selectedCount = 0;
  bool isNonStopSelected = false;
  bool DepartisEarlySelected = false;
  bool DepartisMorningSelected = false;
  bool DepartisNoonSelected = false;
  bool DepartisEveningSelected = false;

  bool ArrivalisEarlySelected = false;
  bool ArrivalisMorningSelected = false;
  bool ArrivalisNoonSelected = false;
  bool ArrivalisEveningSelected = false;
  var resultList = [];
  var mainRows = [];
  List<dynamic> fullResultList = [];
  List<dynamic> filteredResults = [];
  bool isRefundable = false; // Default to false
  bool isNonRefundable = false;

  bool isNonStop = false;
  bool isOneStop = false;
  bool isTwoPlusStops = false;
  bool isAirIndia = false;
  bool isMorningDeparture = false;
  bool isNoonDeparture = false;
  bool isAirIndiaExpress = false;
  bool isBimanBangladesh = false;
  bool isBritishAirways = false;
  bool isEmirates = false;
  bool isEtihad = false;
  bool isGulfAir = false;
  bool isIndigo = false;
  bool isLufthansa = false;
  bool isOmanAviation = false;
  bool isQatarAirways = false;
  bool isSalamAir = false;
  bool isSingaporeAirlines = false;
  bool isSpiceJet = false;
  bool isSriLankanAirlines = false;
  bool isTurkishAirlines = false;
  bool isVistara = false;

  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';
  String fin_date = '';
  late ScrollController _scrollController;
  bool _isBottomBarVisible = true;

  @override
  void initState() {
    super.initState();
    print('userID: ${widget.infants}');
    _scrollController = ScrollController();

    _retrieveSavedValues();
    setState(() {
      filteredResults = List.from(resultList);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isBottomBarVisible) {
          setState(() {
            _isBottomBarVisible = false;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isBottomBarVisible) {
          setState(() {
            _isBottomBarVisible = true;
          });
        }
      }
    });
  }

  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
    });

    Map<String, dynamic> filters = {
      'isRefundable': isRefundable ? 'Refundable' : '',
      'isNonRefundable': isNonRefundable ? 'Non-Refundable' : '',
    };
    _initializeSearch();

  }
  void _initializeSearch() async {
    String? token = await fetchAndStoreToken(); // 🔐 Get the token

    if (token != null) {
      Map<String, dynamic> filters = {}; // or pass actual filters
      sendFlightSearchRequest(filters); // ✅ Now call API
    } else {
      print("Failed to fetch token");
    }
  }
  void _deleteAllRecordsAndGoBack() async {
    try {
      final dbHelper = AdultDatabaseHelper.instance;

      await dbHelper.deleteAllRecords('adults');
    } catch (e) {
      print("Error deleting all records: $e");
    }
  }

  void _deleteAllRecordsChildren() async {
    try {
      // Initialize the database helper
      final dbHelper = ChildrenDatabaseHelper.instance;

      // Delete all records from the adults table (or your specific table)
      await dbHelper
          .deleteAllRecords('children'); // Adjust table name if needed
    } catch (e) {
      print("Error deleting all records: $e");
      // Optionally, show a snackbar or error dialog to the user
    }
  }

  void _deleteAllRecordsInfant() async {
    try {
      // Initialize the database helper
      final dbHelper = InfantDatabaseHelper.instance;

      // Delete all records from the adults table (or your specific table)
      await dbHelper.deleteAllRecords('infants'); // Adjust table name if needed
    } catch (e) {
      print("Error deleting all records: $e");
      // Optionally, show a snackbar or error dialog to the user
    }
  }
  String? tpToken;
  Future<String?> getValidToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('TPToken');
    final savedTime = prefs.getString('TokenSavedTime');

    if (token != null && savedTime != null) {
      final savedDateTime = DateTime.tryParse(savedTime);
      if (savedDateTime != null) {
        final now = DateTime.now();
        final diff = now.difference(savedDateTime).inHours;

        if (diff < 24) {
          print('✅ Existing token is still valid (${24 - diff} hours left)');
          return token;
        } else {
          print('⌛ Token expired after $diff hours. Fetching new token...');
        }
      } else {
        print('⚠️ Invalid saved token time. Fetching new token...');
      }
    } else {
      print('ℹ️ No token found. Fetching new token...');
    }

    // Delete old token data
    await prefs.remove('TPToken');
    await prefs.remove('TokenSavedTime');

    // Fetch and save new token
    return await fetchAndStoreToken();
  }
  Future<String?> fetchAndStoreToken() async {
    final url = Uri.parse('https://boqoltravel.com/app/b2badminapi.asmx');

    final envelope = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                   xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                   xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <TravelPort_GetToken xmlns="http://tempuri.org/" />
      </soap:Body>
    </soap:Envelope>''';

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'text/xml; charset=utf-8',
          'SOAPAction': 'http://tempuri.org/TravelPort_GetToken',
        },
        body: envelope,
      );

      print('🔃 Status Code: ${response.statusCode}');
      print('📥 Raw Response: ${response.body}');

      if (response.statusCode == 200) {
        final rawXml = response.body;

        // ✅ Corrected: Extract token from <TravelPort_GetTokenResult>
        final token = RegExp(
            r'<TravelPort_GetTokenResult>(.*?)</TravelPort_GetTokenResult>',
            dotAll: true)
            .firstMatch(rawXml)
            ?.group(1);

        if (token != null && token.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('TPToken', token);
          await prefs.setString(
              'TokenSavedTime', DateTime.now().toIso8601String());

          printFullString('✅ Token saved: $token');
          return token;
        } else {
          print('⚠️ Token not found in XML');
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Exception occurred: $e');
    }

    return null;
  }
  void printFullString(String text) {
    const int chunkSize = 800;
    for (int i = 0; i < text.length; i += chunkSize) {
      int endIndex = i + chunkSize;
      if (endIndex > text.length) endIndex = text.length;
      debugPrint(
          text.substring(i, endIndex)); // Automatically handles long logs
    }
  }
  void sendFlightSearchRequest(Map<String, dynamic> filters) async {
    String finDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.departDate));
    String origin = widget.orgin;
    String destination = widget.destination;
    String Class = widget.classtype.toString();

    print('widget.classtype: ${Class}');
    print('Final Depart Date (finDate): $finDate');
    print('Origin: $origin');
    print('Destination: $destination');

    tpToken = await getValidToken(); // Call token
    if (tpToken == null) {
      print('❌ Failed to retrieve TPToken');
      return;
    }
    var requestBody = {
      'AdultCount': widget.adult.toString(),
      'ChildrenCount': widget.children.toString(),
      'InfantCount': widget.infants.toString(),
      'DepartDate': finDate,
      'Class': Class,
      'Origin': origin,
      'Destination': destination,
      'TripType': 'Oneway',
      'DefaultCurrency': 'ETB',
      'TPtoken':tpToken,
    };

    // Check and include the refundable filter
    if (filters['isRefundable'] == 'Refundable') {
      requestBody['Refundable'] = 'Refundable';
    } else if (filters['isNonRefundable'] == 'Non-Refundable') {
      requestBody['Refundable'] = 'Non-refundable';
    }
    selectedCount = filters['selectedCount'] ?? 0;
    print('Sending flightselectedCount: $selectedCount');
    print('Sending flight search request with parameters: $requestBody');

    var url = Uri.parse(
        'https://boqoltravel.com/app/b2badminapi.asmx/Oneway_GetFlightDetails');

    try {
      setState(() {
        isLoading = true;
        resultList.clear(); // Clear previous results
      });

      // Adding a timeout of 60 seconds for the HTTP request
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: requestBody,
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        print('Request successful: ${response.statusCode}');

        // Parse XML response
        var document = xml.XmlDocument.parse(response.body);

        // Extract the JSON string from the XML
        var jsonString = document.findAllElements('string').first.text;
        print(
            'Extracted JSON string: $jsonString'); // Log the extracted JSON string

        // Decode the JSON string into a List
        var jsonResponse = json.decode(jsonString);

        // Save the data in resultList
        resultList = jsonResponse;

        print('✅ Total rows received from API: ${jsonResponse.length}');

// Save full result with all rows (MainRow + SubRow)
        fullResultList = jsonResponse.map((e) => Map<String, dynamic>.from(e)).toList();

// Filter and assign only MainRow flights
        resultList = fullResultList
            .where((item) => item['RowType'] == 'MainRow')
            .toList();

        print('✅ Total MainRow items: ${resultList.length}');
        for (var i = 0; i < resultList.length; i++) {
          print('MainRow ${i + 1}: ${resultList[i]['FlightNumber']} - MainRowNumber: ${resultList[i]['MainRowNumber']}');
        }

// Optional: print all SubRow count too if needed
        final subRowCount = fullResultList
            .where((item) => item['RowType'] == 'SubRow')
            .length;
        print('ℹ️ Total SubRow items: $subRowCount');

        print('Extracted filters: $filters[isTurkishAirlines]');

        // Apply filters to the results if applicable
        _applyFiltersToResult(
            resultList, filters); // Pass filters to the filtering function
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        isLoading = false; // Stop loading if an error occurs
        print('Error sending request: $error');
      });
    }
  }

  void _applyStopCountFilter(
      List<dynamic> results, Map<String, dynamic> filters) {
    if (filters['isNonStop'] == true) {
      // If the switch is ON, filter only non-stop flights (StopCount == 0)
      resultList = results.where((flight) {
        int stopCount = int.tryParse(flight['StopCount']) ?? 0;
        return stopCount == 0;
      }).toList();
    } else {
      // If the switch is OFF, show all flights (no filtering)
      resultList = fullResultList; // Reset resultList to show all flights
    }

    // Now update the UI
    setState(() {
      resultList = resultList; // Refresh the list in the UI
    });
  }

  void _applyDepartureTimeFilter(
      List<dynamic> results, Map<String, dynamic> filters) {
    print('Displaying all flights: $results');

    // Filter based on departure and arrival time
    List<dynamic> filteredResults = results.where((flight) {
      DateTime departureDate = DateTime.parse(flight['DepartureDate']);
      DateTime arrivalDate = DateTime.parse(flight[
          'ArrivalDate']); // Assuming 'ArrivalDate' exists in the flight data

      // Check if the flight matches any of the selected departure time filters
      bool matchesDeparture = (filters['isEarlyDeparture'] == true &&
              departureDate.hour < 6) ||
          (filters['isMorningDeparture'] == true &&
              departureDate.hour >= 6 &&
              departureDate.hour < 12) ||
          (filters['isNoonDeparture'] == true &&
              departureDate.hour >= 12 &&
              departureDate.hour < 18) ||
          (filters['isEveningDeparture'] == true && departureDate.hour >= 18);

      // Check if the flight matches any of the selected arrival time filters
      bool matchesArrival = (filters['ArrivalisEarlyDeparture'] == true &&
              arrivalDate.hour < 6) ||
          (filters['ArrivalisMorningDeparture'] == true &&
              arrivalDate.hour >= 6 &&
              arrivalDate.hour < 12) ||
          (filters['ArrivalisNoonDeparture'] == true &&
              arrivalDate.hour >= 12 &&
              arrivalDate.hour < 18) ||
          (filters['ArrivalisEveningDeparture'] == true &&
              arrivalDate.hour >= 18);

      // Case 1: Both departure and arrival filters are selected (AND condition)
      if ((filters['isEarlyDeparture'] == true ||
              filters['isMorningDeparture'] == true ||
              filters['isNoonDeparture'] == true ||
              filters['isEveningDeparture'] == true) &&
          (filters['ArrivalisEarlyDeparture'] == true ||
              filters['ArrivalisMorningDeparture'] == true ||
              filters['ArrivalisNoonDeparture'] == true ||
              filters['ArrivalisEveningDeparture'] == true)) {
        return matchesDeparture && matchesArrival;
      } else if (filters['isEarlyDeparture'] == true ||
          filters['isMorningDeparture'] == true ||
          filters['isNoonDeparture'] == true ||
          filters['isEveningDeparture'] == true) {
        return matchesDeparture;
      } else if (filters['ArrivalisEarlyDeparture'] == true ||
          filters['ArrivalisMorningDeparture'] == true ||
          filters['ArrivalisNoonDeparture'] == true ||
          filters['ArrivalisEveningDeparture'] == true) {
        return matchesArrival;
      }

      return false;
    }).toList();

    setState(() {
      this.resultList = filteredResults; // Update with filtered results
    });

    print('Filtered flights: $filteredResults');
  }

  void _applySort(List<dynamic> results, String sortOrder) {
    // Ensure sorting works correctly
    if (sortOrder == "Low to High") {
      results.sort((a, b) =>
          _parsePrice(a['TotalPrice']).compareTo(_parsePrice(b['TotalPrice'])));
      print("Sorting: Low to High");
    } else if (sortOrder == "High to Low") {
      // Sort in descending order (high price to low price)
      results.sort((a, b) =>
          _parsePrice(b['TotalPrice']).compareTo(_parsePrice(a['TotalPrice'])));
      print("Sorting: High to Low");
    }

    // After sorting, update the result list
    setState(() {
      resultList = results; // Update with sorted results
    });

    print('Sorted hotels: $results');
  }

  double _parsePrice(dynamic price) {
    if (price is String) {
      return double.tryParse(price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
    } else if (price is num) {
      return price.toDouble();
    } else {
      return 0.0; // Fallback if it's neither string nor number
    }
  }

  void _applyFiltersToResult(
      List<dynamic> flights, Map<String, dynamic> filters) {
    List<dynamic> filteredResults = [];

    // Check if any filters are active
    bool hasActiveFilters = filters.values.any((value) =>
        value == 'Yes' || value == 'Refundable' || value == 'Non-Refundable');

    if (!hasActiveFilters) {
      setState(() {
        resultList = flights;

        print('Displaying all flights: $flights'); // Log for debugging
      });
      return;
    }

    for (var flight in flights) {
      bool matchesAirline = false;
      bool stopConditionMatches = false;
      bool refundableConditionMatches = false;
      bool departureConditionMatches = false;
      bool arrivalConditionMatches = false;

      Set<String> selectedAirlines = {};

      if (isAirIndia) selectedAirlines.add('Air India');
      if (isAirIndiaExpress) selectedAirlines.add('Air India Express');
      if (isBimanBangladesh) selectedAirlines.add('Biman Bangladesh Airlines');
      if (isBritishAirways) selectedAirlines.add('British Airways');
      if (isEmirates) selectedAirlines.add('Emirates');
      if (isEtihad) selectedAirlines.add('Etihad Airways');
      if (isGulfAir) selectedAirlines.add('Gulf Air');
      if (isIndigo) selectedAirlines.add('Indigo');
      if (isLufthansa) selectedAirlines.add('Lufthansa');
      if (isOmanAviation) selectedAirlines.add('Oman Aviation');
      if (isQatarAirways) selectedAirlines.add('Qatar Airways');
      if (isSalamAir) selectedAirlines.add('Salam Air');
      if (isSingaporeAirlines) selectedAirlines.add('Singapore Airlines');
      if (isSpiceJet) selectedAirlines.add('SpiceJet');
      if (isSriLankanAirlines) selectedAirlines.add('SriLankan Airlines');
      if (isTurkishAirlines) selectedAirlines.add('Turkish Airlines');
      if (isVistara) selectedAirlines.add('Vistara');

      if (selectedAirlines.contains(flight['CarrierName'])) {
        matchesAirline = true;
      }

// Debugging output
      if (matchesAirline) {
        print(
            'Flight ${flight['CarrierName']} matches selected airline filters.');
      } else {
        print(
            'Flight ${flight['CarrierName']} does not match selected airline filters.');
      }

      // Check refundable filters
      String refundableStatus = flight['Refundable']?.toLowerCase() ?? '';
      bool isFlightRefundable = refundableStatus == 'refundable';
      bool isFlightNonRefundable = refundableStatus == 'non-refundable';

      refundableConditionMatches = (isRefundable && isFlightRefundable) ||
          (isNonRefundable && isFlightNonRefundable);

      // Check stop count filters
      int stopCount = int.tryParse(flight['StopCount']) ?? 0;
      stopConditionMatches = (isNonStop && stopCount == 0) ||
          (isOneStop && stopCount == 1) ||
          (isTwoPlusStops && stopCount >= 2);

      // Check departure time filters
      DateTime departureDate = DateTime.parse(flight['DepartureDate']);
      departureConditionMatches =
          (DepartisEarlySelected && departureDate.hour < 6) ||
              (DepartisMorningSelected &&
                  departureDate.hour >= 6 &&
                  departureDate.hour < 12) ||
              (DepartisNoonSelected &&
                  departureDate.hour >= 12 &&
                  departureDate.hour < 18) ||
              (DepartisEveningSelected && departureDate.hour >= 18);

      // Check arrival time filters
      DateTime arrivalDate = DateTime.parse(flight['ArrivalDate']);
      arrivalConditionMatches =
          (ArrivalisEarlySelected && arrivalDate.hour < 6) ||
              (ArrivalisMorningSelected &&
                  arrivalDate.hour >= 6 &&
                  arrivalDate.hour < 12) ||
              (ArrivalisNoonSelected &&
                  arrivalDate.hour >= 12 &&
                  arrivalDate.hour < 18) ||
              (ArrivalisEveningSelected && arrivalDate.hour >= 18);
      // Check if any of the conditions match
      int selectedCount = filters['selectedCount'] ?? 0; // Get selectedCount
      print('Sending flight selectedCount: $selectedCount');

      int trueConditionCount = 0;

      if (matchesAirline) trueConditionCount++;
      if (refundableConditionMatches) trueConditionCount++;
      if (stopConditionMatches) trueConditionCount++;
      if (departureConditionMatches) trueConditionCount++;
      if (arrivalConditionMatches) trueConditionCount++;

// Log for debugging
      print('True condition count: $trueConditionCount');
      bool atLeastFiveConditionsMatch = trueConditionCount >= 5;
      bool atLeastFourConditionsMatch = trueConditionCount >= 4;
      bool atLeastThreeConditionsMatch = trueConditionCount >= 3;
// Ensure at least two conditions are true to add to results
      bool atLeastTwoConditionsMatch = trueConditionCount >= 2;

// Check if exactly one condition is true
      bool anySingleConditionMatch = trueConditionCount == 1;

// Use selectedCount to determine if we should add the flight
      if (selectedCount >= 5) {
        // Only add to results if at least two conditions match
        if (atLeastFiveConditionsMatch) {
          filteredResults.add(flight);
          print(
              'Adding flight to filtered results due to atLeastFiveConditionsMatch: $flight');
        } else {
          // Skip if neither condition is met
          print(
              'Skipping flight due to insufficient condition matches: $flight');
        }
      } else if (selectedCount >= 4) {
        // Only add to results if at least two conditions match
        if (atLeastFourConditionsMatch) {
          filteredResults.add(flight);
          print(
              'Adding flight to filtered results due to atLeastThreeConditionsMatch: $flight');
        } else {
          // Skip if neither condition is met
          print(
              'Skipping flight due to insufficient condition matches: $flight');
        }
      } else if (selectedCount >= 3) {
        // Only add to results if at least two conditions match
        if (atLeastThreeConditionsMatch) {
          filteredResults.add(flight);
          print(
              'Adding flight to filtered results due to atLeastThreeConditionsMatch: $flight');
        } else {
          // Skip if neither condition is met
          print(
              'Skipping flight due to insufficient condition matches: $flight');
        }
      } else if (selectedCount >= 2) {
        // Only add to results if at least two conditions match
        if (atLeastTwoConditionsMatch) {
          filteredResults.add(flight);
          print(
              'Adding flight to filtered results due to atLeastTwoConditionsMatch: $flight');
        } else {
          // Skip if neither condition is met
          print(
              'Skipping flight due to insufficient condition matches: $flight');
        }
      } else if (selectedCount == 1) {
        // Only add to results if exactly one condition matches
        if (anySingleConditionMatch) {
          filteredResults.add(flight);
          print(
              'Adding flight to filtered results due to anySingleConditionMatch: $flight');
        } else {
          // Skip if neither condition is met
          print(
              'Skipping flight due to insufficient condition matches: $flight');
        }
      } else {
        filteredResults.add(flight);
        print('Skipping flight due to selectedCount being 0 or less: $flight');
      }
    }

    setState(() {
      resultList =
          filteredResults; // Update the resultList with filtered results
      print('Filtered results: $resultList'); // Log for debugging
    });
  }

  String formatDepartureDate(String departureDate) {
    // Parse the date string into a DateTime object
    DateTime date = DateTime.parse(departureDate);

    // Format the date to get the day of the week and month
    String formattedDate = DateFormat('EEE, d MMM').format(date);
    print('formatedadate' + formattedDate.toString());

    // Get the day of the month to add the ordinal suffix (st, nd, rd, th)
    String dayWithSuffix = _addOrdinalSuffix(date.day);

    // Replace the day in the formatted string with the day + suffix
    return formattedDate.replaceFirst(RegExp(r'\d+'), dayWithSuffix);
  }

// Helper function to add ordinal suffix
  String _addOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '$day'; // Special case for 11th, 12th, 13th
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 1,
        backgroundColor:Color(0xFF00ADEE),
        // Custom dark color
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 27),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 1),
            Text(
              "Available FLights",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontSize: 19,
              ),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/lojologo.png',
            width: 100,
            height: 50,
          ),
        ],
      ),
      body: isLoading
          ? ListView.builder(
              itemCount: 10, // Number of skeleton items
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListTile(
                    leading: Container(
                      width: 64.0,
                      height: 64.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 16.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          color: Colors.white,
                        ),
                        Container(
                          width: double.infinity,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          color: Colors.white,
                        ),
                        Container(
                          width: double.infinity,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                );
              })
          : Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: resultList.length,
                            itemBuilder: (BuildContext context, index) {
                              return InkWell(
                                child: Container(
                                  color: Colors.grey.shade300,
                                  padding: EdgeInsets.only(left: 6, right: 6),
                                  child: Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.only(top: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5, top: 4),
                                                    child: Text(
                                                      resultList[index]
                                                          ['CarrierName'],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 4,
                                                                top: 6),
                                                        child: Image(
                                                          image: AssetImage(
                                                              "assets/images/img.png"),
                                                          width: 30,
                                                        ),
                                                      ),
                                                      // Departure date and city code
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 3,
                                                                bottom: 0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 9),
                                                              child: Text(
                                                                '${CommonUtils.convertToFormattedTime(resultList[index]['DepartureDate']).toString().toUpperCase()}',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 8),
                                                              child: Text(
                                                                resultList[
                                                                        index][
                                                                    'DepartCityCode'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff777777),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // Travel time and stops
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 15,
                                                                bottom: 0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              resultList[index][
                                                                  'TravelTime'],
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 11,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 0,
                                                                      bottom:
                                                                          0),
                                                              child:
                                                                  Image.asset(
                                                                (resultList[index]
                                                                            [
                                                                            'StopCount'] ==
                                                                        '0')
                                                                    ? "assets/images/NonStop.png"
                                                                    : (resultList[index]['StopCount'] ==
                                                                            '1')
                                                                        ? "assets/images/oneStop.png"
                                                                        : "assets/images/TwoStop.png",
                                                                width: 70,
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10),
                                                              child: Text(
                                                                '${resultList[index]['StopCount']} stops',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // Arrival date and city code
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 5,
                                                                bottom: 0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 15,
                                                                      top: 9),
                                                              child: Text(
                                                                '${CommonUtils.convertToFormattedTime(resultList[index]['ArrivalDate']).toString().toUpperCase()}',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10),
                                                              child: Text(
                                                                resultList[
                                                                        index][
                                                                    'ArriveCityCode'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff777777),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 15,
                                                                bottom: 0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      top: 9),
                                                              child: Text(
                                                                '${resultList[index]['Currency']} ${resultList[index]['TotalPrice']}',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13,
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                final selectedMainRowNumber =
                                                                    resultList[
                                                                            index]
                                                                        ['MainRowNumber'];

                                                                final matchingRows = fullResultList.where((item) =>
                                                                item['MainRowNumber'] == selectedMainRowNumber
                                                                ).toList();
                                                                printFullJson(
                                                                    matchingRows);
                                                                print(
                                                                    "Flight Details: ${fullResultList[index]}");
                                                                _deleteAllRecordsAndGoBack();
                                                                _deleteAllRecordsChildren();
                                                                _deleteAllRecordsInfant();
                                                                print(
                                                                    'Flight Details for index $index:');
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        OneWayBooking(
                                                                          refundable:resultList[index]
                                                                          ['Refundable'],
                                                                          TPToken:tpToken,
                                                                      flightDetailsList:
                                                                          matchingRows,
                                                                      flightDetails:
                                                                          resultList[
                                                                              index],
                                                                      adultCount:
                                                                          widget
                                                                              .adult,
                                                                      childrenCount:
                                                                          widget
                                                                              .children,
                                                                      infantCount:
                                                                          widget
                                                                              .infants,
                                                                      userid: widget
                                                                          .userId,
                                                                      currency:
                                                                          widget
                                                                              .currency,
                                                                      departDate:
                                                                          fin_date
                                                                              .toString(),
                                                                      departcityname:
                                                                          resultList[index]
                                                                              [
                                                                              'DepartCityName'],
                                                                      arrivecityname:
                                                                          resultList[index]
                                                                              [
                                                                              'ArriveCityName'],
                                                                      departureDate:
                                                                          formatDepartureDate(resultList[index]
                                                                              [
                                                                              'DepartureDate']),
                                                                      stopcount:
                                                                          resultList[index]
                                                                              [
                                                                              'StopCount'],
                                                                      traveltime:
                                                                          (resultList[index]
                                                                              [
                                                                              'TravelTime']),
                                                                      totalamount:
                                                                          resultList[index]
                                                                              [
                                                                              'TotalPrice'],
                                                                            TokenValue:tpToken,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  'View Details',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Cheapest Text
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5,
                                              bottom: 5), // Adjusted padding
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xFF00ADEE)),
                                              // Blue border
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10), // Rounded corners
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 2),
                                            // Padding inside the container
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              // Ensures the container adjusts to the content
                                              children: [
                                                Icon(
                                                  Icons
                                                      .airplane_ticket_outlined,
                                                  // Choose the desired icon
                                                  color: Color(
                                                      0xFF1C5870), // Icon color
                                                  size: 13, // Icon size
                                                ),
                                                // Spacing between the icon and text
                                                Text(
                                                  resultList[index]
                                                      ['Refundable'],
                                                  style: TextStyle(
                                                    color: Color(0xFF00ADEE),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {},
                              );
                            }))
                  ],
                ),
                if (_isBottomBarVisible)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Filter Icon and Text

                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    // Navigate to FilterPage and pass the current 'add' state
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FilterPage(
                                                Refundable: isRefundable,
                                                NonRefundable: isNonRefundable,
                                                NonStop: isNonStop,
                                                oneStop: isOneStop,
                                                twoStop: isTwoPlusStops,
                                                AirIndia: isAirIndia,
                                                AirIndiaExpress:
                                                    isAirIndiaExpress,
                                                isBimanBangladesh:
                                                    isBimanBangladesh,
                                                isBritishAirways:
                                                    isBritishAirways,
                                                isEmirates: isEmirates,
                                                isEtihad: isEtihad,
                                                isGulfAir: isGulfAir,
                                                isIndigo: isIndigo,
                                                isLufthansa: isLufthansa,
                                                isOmanAviation: isOmanAviation,
                                                isQatarAirways: isQatarAirways,
                                                isSalamAir: isSalamAir,
                                                isSingaporeAirlines:
                                                    isSingaporeAirlines,
                                                isSpiceJet: isSpiceJet,
                                                isSriLankanAirlines:
                                                    isSriLankanAirlines,
                                                isTurkishAirlines:
                                                    isTurkishAirlines,
                                                isVistara: isVistara,
                                                DepartisEarlySelected:
                                                    DepartisEarlySelected,
                                                DepartisMorningSelected:
                                                    DepartisMorningSelected,
                                                DepartisNoonSelected:
                                                    DepartisNoonSelected,
                                                DepartisEveningSelected:
                                                    DepartisEveningSelected,
                                                ArrivalisEarlySelected:
                                                    ArrivalisEarlySelected,
                                                ArrivalisMorningSelected:
                                                    ArrivalisMorningSelected,
                                                ArrivalisNoonSelected:
                                                    ArrivalisNoonSelected,
                                                ArrivalisEveningSelected:
                                                    ArrivalisEveningSelected,
                                                add: widget.add,
                                              )),
                                    );

                                    // If we received any result from the filter page
                                    if (result != null) {
                                      setState(() {
                                        selectedCount =
                                            result['selectedCount'] ?? 0;
                                        print(
                                            'Selected filter count: $selectedCount');
                                        isRefundable = result['isRefundable'] ==
                                            'Refundable';
                                        isNonRefundable =
                                            result['isNonRefundable'] ==
                                                'Non-Refundable';
                                        isNonStop =
                                            result['isNonStop'] == 'Yes';
                                        isOneStop =
                                            result['isOneStop'] == 'Yes';
                                        isTwoPlusStops =
                                            result['isTwoPlusStops'] == 'Yes';
                                        isAirIndia =
                                            result['isAirIndia'] == 'Yes';
                                        isAirIndiaExpress =
                                            result['isAirIndiaExpress'] ==
                                                'Yes';
                                        isBimanBangladesh =
                                            result['isBimanBangladesh'] ==
                                                'Yes';
                                        isBritishAirways =
                                            result['isBritishAirways'] == 'Yes';
                                        isEmirates =
                                            result['isEmirates'] == 'Yes';
                                        isEtihad = result['isEtihad'] == 'Yes';
                                        isGulfAir =
                                            result['isGulfAir'] == 'Yes';
                                        isIndigo = result['isIndigo'] == 'Yes';
                                        isLufthansa =
                                            result['isLufthansa'] == 'Yes';
                                        isOmanAviation =
                                            result['isOmanAviation'] == 'Yes';
                                        isQatarAirways =
                                            result['isQatarAirways'] == 'Yes';
                                        isSalamAir =
                                            result['isSalamAir'] == 'Yes';
                                        isSingaporeAirlines =
                                            result['isSingaporeAirlines'] ==
                                                'Yes';
                                        isSpiceJet =
                                            result['isSpiceJet'] == 'Yes';
                                        isSriLankanAirlines =
                                            result['isSriLankanAirlines'] ==
                                                'Yes';
                                        isTurkishAirlines =
                                            result['isTurkishAirlines'] ==
                                                'Yes';
                                        isVistara =
                                            result['isVistara'] == 'Yes';
                                        DepartisEarlySelected =
                                            result['isEarlyDeparture'] == 'Yes';
                                        DepartisMorningSelected =
                                            result['isMorningDeparture'] ==
                                                'Yes';
                                        DepartisNoonSelected =
                                            result['isNoonDeparture'] == 'Yes';
                                        DepartisEveningSelected =
                                            result['isEveningDeparture'] ==
                                                'Yes';
                                        ArrivalisEarlySelected =
                                            result['ArrivalIsEarlyDeparture'] ==
                                                'Yes';
                                        ArrivalisMorningSelected = result[
                                                'ArrivalIsMorningDeparture'] ==
                                            'Yes';
                                        ArrivalisNoonSelected =
                                            result['ArrivalIsNoonDeparture'] ==
                                                'Yes';
                                        ArrivalisEveningSelected = result[
                                                'ArrivalIsEveningDeparture'] ==
                                            'Yes';
                                        String add =
                                            'Edit'; // Assuming this remains constant

                                        // Step 3: Print all filter values
                                        print(
                                            'Selected filter count: $selectedCount');
                                        print('isRefundable: $isRefundable');
                                        print(
                                            'isNonRefundable: $isNonRefundable');
                                        print('isNonStop: $isNonStop');
                                        print('isOneStop: $isOneStop');
                                        print(
                                            'isTwoPlusStops: $isTwoPlusStops');
                                        print('isAirIndia: $isAirIndia');
                                        print(
                                            'isAirIndiaExpress: $isAirIndiaExpress');
                                        print(
                                            'isBimanBangladesh: $isBimanBangladesh');
                                        print(
                                            'isBritishAirways: $isBritishAirways');
                                        print('isEmirates: $isEmirates');
                                        print('isEtihad: $isEtihad');
                                        print('isGulfAir: $isGulfAir');
                                        print('isIndigo: $isIndigo');
                                        print('isLufthansa: $isLufthansa');
                                        print(
                                            'isOmanAviation: $isOmanAviation');
                                        print(
                                            'isQatarAirways: $isQatarAirways');
                                        print('isSalamAir: $isSalamAir');
                                        print(
                                            'isSingaporeAirlines: $isSingaporeAirlines');
                                        print('isSpiceJet: $isSpiceJet');
                                        print(
                                            'isSriLankanAirlines: $isSriLankanAirlines');
                                        print(
                                            'isTurkishAirlines: $isTurkishAirlines');
                                        print('isVistara: $isVistara');
                                        print(
                                            'isEarlyDeparture: $DepartisEarlySelected');
                                        print(
                                            'isMorningDeparture: $DepartisMorningSelected');
                                        print(
                                            'isNoonDeparture: $DepartisNoonSelected');
                                        print(
                                            'isEveningDeparture: $DepartisEveningSelected');
                                        print(
                                            'arrivalIsEarlyDeparture: $ArrivalisEarlySelected');
                                        print(
                                            'arrivalIsMorningDeparture: $ArrivalisMorningSelected');
                                        print(
                                            'arrivalIsNoonDeparture: $ArrivalisNoonSelected');
                                        print(
                                            'arrivalIsEveningDeparture: $ArrivalisEveningSelected');
                                        print('add: $add');
                                        sendFlightSearchRequest(result);
                                      });
                                    }
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // Ensures the row only takes necessary space
                                    children: [
                                      Icon(
                                        Icons.filter_alt_outlined,
                                        size:
                                            20, // Adjust the icon size as needed
                                        color: Colors.grey.shade600,
                                      ),
                                      SizedBox(height: 7),
                                      // Optional: Adjust this for spacing between icon and text
                                      Text(
                                        "Filter",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Time Icon and Text
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showTimeBottomSheet(context);
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // Ensures the row only takes necessary space
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        size: 20,
                                        // Adjust the size of the icon as needed
                                        color: Colors.grey
                                            .shade600, // Match the icon color with the text
                                      ),
                                      SizedBox(height: 7),
                                      // Optional: Add a tiny width for spacing
                                      Text(
                                        "Time",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // NonStop Icon and Text
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isNonStopSelected =
                                          !isNonStopSelected; // Toggle switch state
                                      // Call filter function if necessary
                                      Map<String, dynamic> filters = {
                                        'isNonStop': isNonStopSelected,
                                        // Non-stop filter
                                      };
                                      _applyStopCountFilter(
                                          fullResultList, filters);
                                    });
                                  },
                                  child: Container(
                                    width: 35, // Adjusted width
                                    height: 20, // Adjusted height
                                    decoration: BoxDecoration(
                                      color: isNonStopSelected
                                          ? Colors.pink.shade200
                                          : Colors.grey,
                                      // Change color based on state
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Stack(
                                      children: [
                                        // White circle
                                        AnimatedAlign(
                                          alignment: isNonStopSelected
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          duration: Duration(milliseconds: 200),
                                          child: Container(
                                            width: 15,
                                            // Adjusted width for the white circle
                                            height: 15,
                                            // Adjusted height for the white circle
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                isNonStopSelected
                                                    ? Icons.check
                                                    : Icons.close,
                                                // Display tick or close icon
                                                size: 14, // Adjusted icon size
                                                color: isNonStopSelected
                                                    ? Colors.pink.shade200
                                                    : Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "NonStop",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),

                            // Sort Icon and Text
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showSortBottomSheet(context);
                                    print("Sort tapped");
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // Ensure no extra space is taken
                                    children: [
                                      Icon(
                                        Icons.sort,
                                        size: 20, // Adjust the size as needed
                                        color: Colors.grey.shade600,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "Sort",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  void _showTimeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      // Prevent closing by tapping outside or pressing back
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter bottomSheetSetState) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.86,
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading with close icon
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context); // Close the bottom sheet
                        },
                      ),
                      // Spacer to take up the remaining space between the icon and the text
                      Spacer(),
                      // Center the "Time" text
                      Text(
                        "Time",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(flex: 2),
                      // Optional: Add this if you want space after the text
                    ],
                  ),

                  Divider(color: Colors.grey.shade400),

                  // Departure Time Section
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      'Departure Time',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),

                  // Departure Time Checkboxes

                  Column(
                    children: [
                      CustomCheckbox(
                        title: 'Early (Before 6AM)',
                        value: DepartisEarlySelected,
                        onChanged: (bool? value) {
                          bottomSheetSetState(() {
                            DepartisEarlySelected = value ?? false;
                          });
                          setState(() {});
                        },
                      ),
                      CustomCheckbox(
                        title: 'Morning (6AM - 12PM)',
                        value: DepartisMorningSelected,
                        onChanged: (bool? value) {
                          bottomSheetSetState(() {
                            DepartisMorningSelected = value ?? false;
                          });
                          setState(() {});
                        },
                      ),
                      CustomCheckbox(
                        title: 'Noon (12PM - 6PM)',
                        value: DepartisNoonSelected,
                        onChanged: (bool? value) {
                          bottomSheetSetState(() {
                            DepartisNoonSelected = value ?? false;
                          });
                          setState(() {});
                        },
                      ),
                      CustomCheckbox(
                        title: 'Evening (After 6PM)',
                        value: DepartisEveningSelected,
                        onChanged: (bool? value) {
                          bottomSheetSetState(() {
                            DepartisEveningSelected = value ?? false;
                          });
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  Divider(
                    color: Colors.grey.shade400,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      'Arrival Time',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                  // No padding above Arrival Time

                  // Arrival Time Checkboxes
                  Column(
                    children: [
                      CustomCheckbox(
                        title: 'Early (Before 6AM)',
                        value: ArrivalisEarlySelected,
                        onChanged: (bool? value) {
                          bottomSheetSetState(() {
                            ArrivalisEarlySelected = value ?? false;
                          });
                          setState(() {});
                        },
                      ),
                      CustomCheckbox(
                        title: 'Morning (6AM - 12PM)',
                        value: ArrivalisMorningSelected,
                        onChanged: (bool? value) {
                          bottomSheetSetState(() {
                            ArrivalisMorningSelected = value ?? false;
                          });
                          setState(() {});
                        },
                      ),
                      CustomCheckbox(
                        title: 'Noon (12PM - 6PM)',
                        value: ArrivalisNoonSelected,
                        onChanged: (bool? value) {
                          bottomSheetSetState(() {
                            ArrivalisNoonSelected = value ?? false;
                          });
                          setState(() {});
                        },
                      ),
                      CustomCheckbox(
                        title: 'Evening (After 6PM)',
                        value: ArrivalisEveningSelected,
                        onChanged: (bool? value) {
                          bottomSheetSetState(() {
                            ArrivalisEveningSelected = value ?? false;
                          });
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  // Show Flights Button
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Map<String, dynamic> filters = {
                          'isEarlyDeparture': DepartisEarlySelected,
                          'isMorningDeparture': DepartisMorningSelected,
                          'isNoonDeparture': DepartisNoonSelected,
                          'isEveningDeparture': DepartisEveningSelected,
                          'ArrivalisEarlyDeparture': ArrivalisEarlySelected,
                          'ArrivalisMorningDeparture': ArrivalisMorningSelected,
                          'ArrivalisNoonDeparture': ArrivalisNoonSelected,
                          'ArrivalisEveningDeparture': ArrivalisEveningSelected,
                        };
                        _applyDepartureTimeFilter(fullResultList, filters);
                        Navigator.pop(context);
                        print("Show Flights pressed.");
                      },
                      child: Text(
                        'Show Flights',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Close Button
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context); // Close the bottom sheet
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Sort",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey.shade400),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Low to High
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSortOption = "Low to High";
                            print("Selected: Low to High");
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Minimize space
                          children: [
                            Radio<String>(
                              value: "Low to High",
                              groupValue: selectedSortOption,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedSortOption = value;
                                  print("Selected: Low to High");
                                });
                              },
                            ),
                            Text("Low to High"),
                          ],
                        ),
                      ),

                      // High to Low with no space
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSortOption = "High to Low";
                            print("Selected: High to Low");
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Minimize space
                          children: [
                            Radio<String>(
                              value: "High to Low",
                              groupValue: selectedSortOption,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedSortOption = value;
                                  print("Selected: High to Low");
                                });
                              },
                            ),
                            Text("High to Low"),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Display Results Button
                  SizedBox(height: 16), // Spacing before the button
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (selectedSortOption != null) {
                          // Call the _applySort function with the fullResultList and the selected sort option
                          _applySort(fullResultList,
                              selectedSortOption!); // Use the non-null assertion operator
                        } else {
                          print("No sorting option selected.");
                        }
                        Navigator.pop(context);
                        print("Show Flights pressed.");
                      },
                      child: Text(
                        'Show Flights',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

void printFullJson(List<dynamic> matchingRows) {
  final encoder = JsonEncoder.withIndent('  ');
  final prettyJson = encoder.convert(matchingRows);
  developer.log(prettyJson, name: 'FilteredFlightDetails');
}

class CustomCheckbox extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // Distributes space between children
      children: [
        Expanded(
          // Allows text to take up remaining space
          child: Text(
            title,
            textAlign: TextAlign.left, // Ensure text is left-aligned
          ),
        ),
        Checkbox(
          value: value,
          onChanged: onChanged,
          visualDensity: VisualDensity
              .compact, // Reduces the default padding around the checkbox
        ),
        SizedBox(width: 4), // Reduced space between checkbox and text
      ],
    );
  }
}
