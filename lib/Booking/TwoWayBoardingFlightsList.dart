import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../AdultDatabaseHelperCass.dart';
import '../DatabseHelper.dart';
import '../bookings/flight/Children_DatabaseHelper.dart';
import '../bookings/flight/FilterPage.dart';
import '../bookings/flight/InfantDatabaseHelper.dart';
import '../utils/commonutils.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'TwoWayBooking.dart';

class TwoWayBoardingFlightsList extends StatefulWidget {
  final add,
      adult,
      children,
      infants,
      orgin,
      originCountry,
      destinationCourntry,
      destination,
      departDate,
      returnDate;

  const TwoWayBoardingFlightsList(
      {super.key,
        required this.add,
        required this.adult,
        required this.children,
        required this.infants,
        required this.orgin,
        required this.originCountry,
        required this.destinationCourntry,
        required this.destination,
        required this.departDate,
        required this.returnDate});

  @override
  State<TwoWayBoardingFlightsList> createState() =>
      _TwoWayBoardingFlightsListState();
}

class _TwoWayBoardingFlightsListState extends State<TwoWayBoardingFlightsList> {
  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';

  @override
  void initState() {
    super.initState();
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
        // User is scrolling up, show the bottom bar
        if (!_isBottomBarVisible) {
          setState(() {
            _isBottomBarVisible = true;
          });
        }
      }
    });
  }

  void _deleteAllRecordsAndGoBack() async {
    try {
      // Initialize the database helper
      final dbHelper = AdultDatabaseHelper.instance;

      // Delete all records from the adults table (or your specific table)
      await dbHelper.deleteAllRecords('adults'); // Adjust table name if needed
    } catch (e) {
      print("Error deleting all records: $e");
      // Optionally, show a snackbar or error dialog to the user
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

  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
      print('Currency: $Currency');
      Map<String, dynamic> filters = {
        'isRefundable': isRefundable ? 'Refundable' : '',
        'isNonRefundable': isNonRefundable ? 'Non-Refundable' : '',
        // Add other filters as necessary
      };

      _initializeSearch();
    });
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
  List<dynamic> fullResultList = [];
  List<dynamic> filteredResults = [];
  bool isLoading = false;
  bool isBookingLoading = false;
  bool isRefundable = false; // Default to false
  bool isNonRefundable = false;

  bool isNonStop = false;
  bool isOneStop = false;
  bool isTwoPlusStops = false;
  bool isAirIndia = false;
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
  bool isMorningDeparture = false;
  bool isNoonDeparture = false;
  late ScrollController _scrollController;
  bool _isBottomBarVisible = true;

  void navigate(Widget screen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
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
  Map<String, bool> airlineCheckboxes = {};

  void sendFlightSearchRequest(Map<String, dynamic> filters) async {
    String finDate = DateFormat('yyyy-MM-dd').format(widget.departDate);
    String finDate1 = DateFormat('yyyy-MM-dd').format(widget.returnDate);

    String origin = widget.originCountry;
    String destination = widget.destinationCourntry;
    print('widget.departDate ${finDate}');
    print('widget.origin ${origin}');
    print('widget.destination ${destination}');
    tpToken = await getValidToken(); // Call token
    if (tpToken == null) {
      print('❌ Failed to retrieve TPToken');
      return;
    }

    // Replace these values with your actual data
    var requestBody = {
      'AdultCount': widget.adult,
      'ChildrenCount': widget.children,
      'InfantCount': widget.infants,
      'Origin': widget.orgin,
      'Destination': widget.destination,
      'Class': '2',
      'fromCountry': origin,
      'tocountry': destination,
      'DepartDate': finDate,
      'ReturnDate': finDate1,
      "TPToken": tpToken,
    };
    print('Request Body Details:');
    print('AdultCount: ${widget.adult}');
    print('ChildrenCount: ${widget.children}');
    print('InfantCount: ${widget.infants}');
    print('Origin (IATA): ${widget.orgin}');
    print('Destination (IATA): ${widget.destination}');
    print('Class: 2');
    print('From Country: $origin');
    print('To Country: $destination');
    print('DepartDate: $finDate');
    print('ReturnDate: $finDate1');
    print('TPToken: $tpToken');

    final url = Uri.parse(
        'https://boqoltravel.com/app/b2badminapi.asmx/Roundway_GetFlightDetails');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    try {
      setState(() {
        isLoading = true;
      });
      var response = await http.post(
        url,
        headers: headers,
        body: requestBody,
      );
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        // Handle the response data here
        print('Response: ${response.body}');

        setState(() {
          // Save full list
          fullResultList =
              json.decode(ResponseHandler.parseData(response.body));

// 🔁 Forward flights
          List forwardList = fullResultList
              .where((item) => item['RowTypeForward'] == 'MainRow')
              .toList();

// 🔁 Return flights
          List returnList = fullResultList
              .where((item) => item['RowTypeReturn'] == 'MainRow')
              .toList();

// 💡 Combine if needed (optional)
          resultList = [...forwardList, ...returnList];
          Set<String> carrierCodes = {};

          for (var item in resultList) {
            if (item['CarrierCodeForward'] != null) {
              carrierCodes.add(item['CarrierCodeForward']);
            }
            if (item['CarrierCodeReturn'] != null) {
              carrierCodes.add(item['CarrierCodeReturn']);
            }
          }

// ✅ Preserve previous airline selections
          airlineCheckboxes = {
            for (var code in carrierCodes)
              code: airlineCheckboxes.containsKey(code) ? airlineCheckboxes[code]! : false
          };

          print('✅ Airline Checkbox Map (Round Trip): $airlineCheckboxes');

          _applyFiltersToResult(resultList, filters);
        });
      } else {
        print('Error ${response.statusCode} : ${response.body}');
      }
    } catch (error) {
      print('Error sending request: $error');
    }
  }

  void _applyStopCountFilter(
      List<dynamic> results, Map<String, dynamic> filters) {
    if (filters['isNonStop'] == true) {
      // ✅ KEEP THIS BLOCK UNCHANGED (your original logic)
      resultList = results.where((flight) {
        String? stopCountForwardStr = flight['StopCountForward'];
        String? stopCountReturnStr = flight['StopCountReturn'];

        int stopCountForward = stopCountForwardStr != null
            ? int.tryParse(stopCountForwardStr) ?? 0
            : 0;
        int stopCountReturn = stopCountReturnStr != null
            ? int.tryParse(stopCountReturnStr) ?? 0
            : 0;

        return stopCountForward == 0 && stopCountReturn == 0;
      }).toList();
    } else {
      // ✅ WHEN TOGGLE IS OFF → Show ONLY MainRow (no filtering by stop)
      resultList = results
          .where((flight) =>
      flight['RowTypeForward'] == 'MainRow' &&
          flight['RowTypeReturn'] == 'MainRow')
          .toList();
    }
// ✅ Extract unique airlines for Round Trip


    // ✅ Update UI
    setState(() {
      resultList = resultList;
      //expandedList = List.generate(resultList.length, (_) => false);
    });
  }

  void _applyDepartureTimeFilter(
      List<dynamic> results, Map<String, dynamic> filters) {
    print('Displaying all flights: $results');

    List<dynamic> filteredResults = results.where((flight) {
      // ✅ Only include flights with MainRow for both Forward and Return
      if ((flight['RowTypeForward'] ?? '') != 'MainRow' ||
          (flight['RowTypeReturn'] ?? '') != 'MainRow') {
        return false;
      }

      // ✅ Get and parse Forward departure and arrival times only
      String? departureDateStr = flight['DepartureDateForward'];
      String? arrivalDateStr = flight['ArrivalDateForward'];

      DateTime departureDate = departureDateStr != null
          ? DateTime.tryParse(departureDateStr) ?? DateTime(1900)
          : DateTime(1900);
      DateTime arrivalDate = arrivalDateStr != null
          ? DateTime.tryParse(arrivalDateStr) ?? DateTime(1900)
          : DateTime(1900);

      // ✅ Check departure time filter
      bool matchesDeparture = (filters['isEarlyDeparture'] == true &&
          departureDate.hour < 6) ||
          (filters['isMorningDeparture'] == true &&
              departureDate.hour >= 6 &&
              departureDate.hour < 12) ||
          (filters['isNoonDeparture'] == true &&
              departureDate.hour >= 12 &&
              departureDate.hour < 18) ||
          (filters['isEveningDeparture'] == true && departureDate.hour >= 18);

      // ✅ Check arrival time filter
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

      // ✅ Final filter logic
      bool departureSelected = filters['isEarlyDeparture'] == true ||
          filters['isMorningDeparture'] == true ||
          filters['isNoonDeparture'] == true ||
          filters['isEveningDeparture'] == true;

      bool arrivalSelected = filters['ArrivalisEarlyDeparture'] == true ||
          filters['ArrivalisMorningDeparture'] == true ||
          filters['ArrivalisNoonDeparture'] == true ||
          filters['ArrivalisEveningDeparture'] == true;

      if (departureSelected && arrivalSelected) {
        return matchesDeparture && matchesArrival;
      } else if (departureSelected) {
        return matchesDeparture;
      } else if (arrivalSelected) {
        return matchesArrival;
      }

      // ❌ No filters selected
      return false;
    }).toList();

    setState(() {
      resultList = filteredResults;
    });

    print('🎯 Filtered flights count: ${filteredResults.length}');
  }

  void _applyFiltersToResult(List<dynamic> flights, Map<String, dynamic> filters) {
    List<dynamic> filteredResults = [];

    Map<String, bool> airlineCheckboxes =
    Map<String, bool>.from(filters['airlineCheckboxes'] ?? {});
    List<String> selectedAirlines = airlineCheckboxes.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    print('✅ Selected Airlines for Filtering: $selectedAirlines');

    bool hasActiveFilters = filters.values.any((value) =>
    value == 'Yes' || value == 'Refundable' || value == 'Non-Refundable');

    if (!hasActiveFilters && selectedAirlines.isEmpty) {
      setState(() {
        resultList =
            flights.where((f) => f['RowTypeForward'] == 'MainRow').toList();
        print('✅ No filters selected. Showing all flights.');
      });
      return;
    }

    for (var flight in flights) {
      try {
        bool matchesAirline = false;
        bool stopConditionMatches = false;
        bool refundableConditionMatches = false;
        bool departureConditionMatches = false;
        bool arrivalConditionMatches = false;

        // ✅ Airline filter (Forward only)
        String forwardCode = (flight['CarrierCodeForward'] ?? '').toString();
        if (selectedAirlines.isEmpty || selectedAirlines.contains(forwardCode)) {
          matchesAirline = true;
        }

        // ✅ Refundable filter
        String refundableStatus =
        (flight['Refundable'] ?? '').toString().toLowerCase();
        bool isFlightRefundable = refundableStatus == 'refundable';
        bool isFlightNonRefundable = refundableStatus == 'non-refundable';
        refundableConditionMatches = (isRefundable && isFlightRefundable) ||
            (isNonRefundable && isFlightNonRefundable);

        // ✅ Stop count filter
        int stopForward =
            int.tryParse((flight['StopCountForward'] ?? '0').toString()) ?? 0;
        stopConditionMatches =
            (isNonStop && stopForward == 0) ||
                (isOneStop && stopForward == 1) ||
                (isTwoPlusStops && stopForward >= 2);

        // ✅ Departure time filter
        DateTime departureForward =
            DateTime.tryParse(flight['DepartureDateForward'] ?? '') ??
                DateTime(1900);
        departureConditionMatches =
            (DepartisEarlySelected && departureForward.hour < 6) ||
                (DepartisMorningSelected &&
                    departureForward.hour >= 6 &&
                    departureForward.hour < 12) ||
                (DepartisNoonSelected &&
                    departureForward.hour >= 12 &&
                    departureForward.hour < 18) ||
                (DepartisEveningSelected && departureForward.hour >= 18);

        // ✅ Arrival time filter
        DateTime arrivalForward =
            DateTime.tryParse(flight['ArrivalDateForward'] ?? '') ??
                DateTime(1900);
        arrivalConditionMatches =
            (ArrivalisEarlySelected && arrivalForward.hour < 6) ||
                (ArrivalisMorningSelected &&
                    arrivalForward.hour >= 6 &&
                    arrivalForward.hour < 12) ||
                (ArrivalisNoonSelected &&
                    arrivalForward.hour >= 12 &&
                    arrivalForward.hour < 18) ||
                (ArrivalisEveningSelected && arrivalForward.hour >= 18);

        // ✅ Count Active Filters
        int activeFilters = 0;
        if (selectedAirlines.isNotEmpty) activeFilters++;
        if (isRefundable || isNonRefundable) activeFilters++;
        if (isNonStop || isOneStop || isTwoPlusStops) activeFilters++;
        if (DepartisEarlySelected || DepartisMorningSelected ||
            DepartisNoonSelected || DepartisEveningSelected) activeFilters++;
        if (ArrivalisEarlySelected || ArrivalisMorningSelected ||
            ArrivalisNoonSelected || ArrivalisEveningSelected) activeFilters++;

        // ✅ Count Matches
        int matchCount = 0;
        if (selectedAirlines.isEmpty || matchesAirline) matchCount++;
        if ((isRefundable || isNonRefundable) && refundableConditionMatches)
          matchCount++;
        if ((isNonStop || isOneStop || isTwoPlusStops) && stopConditionMatches)
          matchCount++;
        if ((DepartisEarlySelected || DepartisMorningSelected ||
            DepartisNoonSelected || DepartisEveningSelected) &&
            departureConditionMatches) matchCount++;
        if ((ArrivalisEarlySelected || ArrivalisMorningSelected ||
            ArrivalisNoonSelected || ArrivalisEveningSelected) &&
            arrivalConditionMatches) matchCount++;

        // ✅ Add flight if matches all active filters
        if (matchCount == activeFilters) {
          filteredResults.add(flight);
        }
      } catch (e) {
        print('⚠ Error filtering flight: $e');
      }
    }

    setState(() {
      resultList = filteredResults.where((f) => f['RowTypeForward'] == 'MainRow').toList();
      print('🎯 Filtered flights: ${resultList.length}');
    });
  }





  void _applySort(List<dynamic> results, String sortOrder) {
    // ✅ First filter to include only valid MainRows (Forward + Return)
    List<dynamic> filteredResults = results
        .where((flight) =>
    (flight['RowTypeForward'] ?? '') == 'MainRow' &&
        (flight['RowTypeReturn'] ?? '') == 'MainRow')
        .toList();

    // ✅ Apply sorting only on filtered data
    if (sortOrder == "Low to High") {
      filteredResults.sort((a, b) =>
          _parsePrice(a['TotalPrice']).compareTo(_parsePrice(b['TotalPrice'])));
      print("Sorting: Low to High");
    } else if (sortOrder == "High to Low") {
      filteredResults.sort((a, b) =>
          _parsePrice(b['TotalPrice']).compareTo(_parsePrice(a['TotalPrice'])));
      print("Sorting: High to Low");
    }

    // ✅ Update resultList and UI
    setState(() {
      resultList = filteredResults;
      // expandedList = List.generate(resultList.length, (_) => false);
    });

    print('Sorted flights: $filteredResults');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 1,
        title: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 27,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(width: 1), // Set the desired width
            Text(
              "Available FLights",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Montserrat",
                  fontSize: 18),
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
        backgroundColor:Color(0xFF00ADEE),
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
                    itemCount: resultList.length,
                    controller: _scrollController,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        margin:
                        EdgeInsets.only(top: 3, left: 8, right: 8),
                        padding: EdgeInsets.all(1),
                        child: Material(
                          color: Colors.white,
                          elevation: 15,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 5),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        resultList[index]
                                        ['CarrierCodeForward'] ??
                                            'Unknown',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/img.png',
                                            width: 30,
                                          ),
                                          SizedBox(width: 5),
                                          // Minimal spacing between image and text
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                resultList[index][
                                                'DepartureDateForward'] !=
                                                    null
                                                    ? '${CommonUtils.convertToFormattedTime(resultList[index]['DepartureDateForward']).toUpperCase()}'
                                                    : 'N/A',
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                resultList[index][
                                                'DepartCityCodeForward'] ??
                                                    'Unknown',
                                                style: TextStyle(
                                                  color:
                                                  Color(0xff777777),
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10),
                                          // Reduce this space for better alignment
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                resultList[index][
                                                'TravelTimeForward'] !=
                                                    null
                                                    ? resultList[index][
                                                'TravelTimeForward']
                                                    : 'N/A',
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 0),
                                                child: Image.asset(
                                                  resultList[index][
                                                  'StopCountForward'] ==
                                                      '0'
                                                      ? "assets/images/NonStop.png"
                                                      : (resultList[index]
                                                  [
                                                  'StopCountForward'] ==
                                                      '1'
                                                      ? "assets/images/oneStop.png"
                                                      : "assets/images/TwoStop.png"),
                                                  width: 50,
                                                  height: 10,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                              Text(
                                                '${resultList[index]['StopCountForward']?.toString() ?? 'Unknown'} stops',
                                                style: TextStyle(
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10),
                                          // Small gap between columns
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                resultList[index][
                                                'ArrivalDateForward'] !=
                                                    null
                                                    ? '${CommonUtils.convertToFormattedTime(resultList[index]['ArrivalDateForward']).toUpperCase()}'
                                                    : 'N/A',
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                resultList[index][
                                                'ArriveCityCodeForward'] ??
                                                    '',
                                                style: TextStyle(
                                                  color:
                                                  Color(0xff777777),
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            resultList[index][
                                            'CarrierCodeReturn'] ??
                                                'Unknown',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              '${resultList[index]['Currency']} ${resultList[index]['TotalPrice']}',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/images/img.png',
                                            width: 30,
                                          ),
                                          SizedBox(width: 5),
                                          // Add minimal space between the image and the text
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                resultList[index][
                                                'DepartureDateReturn'] !=
                                                    null
                                                    ? '${CommonUtils.convertToFormattedTime(resultList[index]['DepartureDateReturn']).toUpperCase()} '
                                                    : 'No ',
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                resultList[index][
                                                'DepartCityCodeReturn'] ??
                                                    'N/A',
                                                style: TextStyle(
                                                  color:
                                                  Color(0xff777777),
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10),
                                          // Add minimal gap between first and second column
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                resultList[index][
                                                'TravelTimeReturn'] !=
                                                    null
                                                    ? resultList[index][
                                                'TravelTimeReturn']
                                                    : 'No Travel Time',
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Image.asset(
                                                resultList[index][
                                                'StopCountReturn'] !=
                                                    null
                                                    ? (resultList[index][
                                                'StopCountReturn'] ==
                                                    '0'
                                                    ? "assets/images/oneStop.png"
                                                    : (resultList[index]
                                                [
                                                'StopCountReturn'] ==
                                                    '1'
                                                    ? "assets/images/oneStop.png"
                                                    : "assets/images/TwoStop.png"))
                                                    : "assets/images/oneStop.png",
                                                width: 45,
                                              ),
                                              Text(
                                                resultList[index][
                                                'StopCountReturn'] !=
                                                    null
                                                    ? '${resultList[index]['StopCountReturn']} stops'
                                                    : 'N/A stops',
                                                style: TextStyle(
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10),
                                          // Add minimal gap between second and third column
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                resultList[index][
                                                'ArrivalDateReturn'] !=
                                                    null
                                                    ? '${CommonUtils.convertToFormattedTime(resultList[index]['ArrivalDateReturn']).toUpperCase()}'
                                                    : 'No Arrival Time',
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                resultList[index][
                                                'ArriveCityCodeReturn'] ??
                                                    'N/A',
                                                style: TextStyle(
                                                  color:
                                                  Color(0xff777777),
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.book_outlined,
                                              size: 14,
                                            ),
                                            Text(
                                              resultList[index][
                                              'Refundable'] !=
                                                  null
                                                  ? resultList[index]
                                              ['Refundable']
                                                  : 'N/A',
                                              // Default text if Refundable is null
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight:
                                                FontWeight.w500,
                                                color: (resultList[index][
                                                'Refundable'] ==
                                                    'Refundable')
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            String mainRowForward =
                                            resultList[index][
                                            'MainRowNumberForward'];
                                            String mainRowReturn =
                                            resultList[index][
                                            'MainRowNumberReturn'];

                                            final matchingRows = fullResultList
                                                .where((item) =>
                                            item['MainRowNumberForward'] ==
                                                mainRowForward &&
                                                item['MainRowNumberReturn'] ==
                                                    mainRowReturn)
                                                .toList();

                                            printFullJson(matchingRows);
                                            print(
                                                "Flight Details: ${resultList[index]}");
                                            _deleteAllRecordsAndGoBack();
                                            _deleteAllRecordsChildren();
                                            _deleteAllRecordsInfant();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TwoWayBooking(
                                                      refundable:resultList[index]
                                                      ['Refundable'],
                                                      TPToken: tpToken,
                                                      arrivecityname: resultList[
                                                      index][
                                                      'ArriveCityNameForward'],
                                                      flightDetailsList:
                                                      matchingRows,
                                                      flightDetails:
                                                      resultList[index],
                                                      adultCount:
                                                      widget.adult,
                                                      childrenCount:
                                                      widget.children,
                                                      infantCount:
                                                      widget.infants,
                                                      departdate:
                                                      widget.departDate,
                                                      stopCountForward:
                                                      resultList[index][
                                                      "StopCountForward"],
                                                      stopCountReturn:
                                                      resultList[index][
                                                      "StopCountReturn"],
                                                      departCity: resultList[
                                                      index][
                                                      "DepartCityNameForward"],
                                                      TotalPrice:
                                                      resultList[index]
                                                      ["TotalPrice"],
                                                      TokenValue:
                                                      tpToken ?? '',
                                                    ),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              "View Details",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
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
                                      airlineCheckboxes: airlineCheckboxes,
                                      Refundable: isRefundable,
                                      NonRefundable: isNonRefundable,
                                      NonStop: isNonStop,
                                      oneStop: isOneStop,
                                      twoStop: isTwoPlusStops,
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
                                  selectedCount = result['selectedCount'] ?? 0;

                                  // ✅ Store airline selections
                                  airlineCheckboxes = Map<String, bool>.from(result['airlineCheckboxes'] ?? {});
                                  print('Updated airline selections: $airlineCheckboxes');

                                  // ✅ Update other filters
                                  isRefundable = result['isRefundable'] == 'Refundable';
                                  isNonRefundable = result['isNonRefundable'] == 'Non-Refundable';
                                  isNonStop = result['isNonStop'] == 'Yes';
                                  isOneStop = result['isOneStop'] == 'Yes';
                                  isTwoPlusStops = result['isTwoPlusStops'] == 'Yes';

                                  DepartisEarlySelected = result['isEarlyDeparture'] == 'Yes';
                                  DepartisMorningSelected = result['isMorningDeparture'] == 'Yes';
                                  DepartisNoonSelected = result['isNoonDeparture'] == 'Yes';
                                  DepartisEveningSelected = result['isEveningDeparture'] == 'Yes';

                                  ArrivalisEarlySelected = result['ArrivalIsEarlyDeparture'] == 'Yes';
                                  ArrivalisMorningSelected = result['ArrivalIsMorningDeparture'] == 'Yes';
                                  ArrivalisNoonSelected = result['ArrivalIsNoonDeparture'] == 'Yes';
                                  ArrivalisEveningSelected = result['ArrivalIsEveningDeparture'] == 'Yes';

                                  // ✅ Apply filters
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
                                    : Colors
                                    .grey, // Change color based on state
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
