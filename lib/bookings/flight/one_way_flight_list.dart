import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as developer;

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
  List<dynamic> fullResultList = [];
  List<dynamic> filteredResults = [];
  bool isRefundable = false; // Default to false
  bool isNonRefundable = false;
  Map<String, bool> airlineCheckboxes = {};
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
        // User is scrolling up, show the bottom bar
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
      // Add other filters as necessary
    };

    // Call the API request method
    sendFlightSearchRequest(filters);
  }

  void _deleteAllRecordsAndGoBack() async {
    try {
      // Initialize the database helper
      final dbHelper = DatabaseHelper.instance;

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
          .deleteAllRecords('childrens'); // Adjust table name if needed
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

  void sendFlightSearchRequest(Map<String, dynamic> filters) async {

    DateTime parsedDate = DateTime.parse(widget.departDate); // String → DateTime
    String finDate = DateFormat('dd-MM-yyyy').format(parsedDate);


    String origin = widget.orgin; // Fixed typo: 'orgin' to 'origin'
    String destination = widget.destination;
    String travelClass = widget.classtype.toString();
    // Include filters in the request body
    var requestBody = {
      'AdultCount': widget.adult.toString(),
      'ChildrenCount': widget.children.toString(),
      'InfantCount': widget.infants.toString(),
      'DepartDate': finDate,
      'Class': "2",
      'Origin': origin,
      'Destination': destination,
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
        'https://lojatravel.com/app/b2badminapi.asmx/FlightSearch_OneWay');

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



        print('✅ Reqasdadfsduest successful: ${response.statusCode}');

        try {
          // Parse XML response
          var document = xml.XmlDocument.parse(response.body);

          // Second <string> element text
          var flightsJsonString = document.findAllElements('string').elementAt(1).text;

          if (kDebugMode) print('🔍 Extracted Flights JSON: $flightsJsonString');

          var flightsJson = json.decode(flightsJsonString);

          if (flightsJson is List) {
            fullResultList = flightsJson.map((e) => Map<String, dynamic>.from(e)).toList();
            resultList = fullResultList.where((item) => item['RowType'] == 'MainRow').toList();

            // Extract unique CarrierName
            Set<String> carrierNames = {};
            for (var item in resultList) {
              if (item['CarrierName'] != null) carrierNames.add(item['CarrierName']);
            }

            // Initialize airline checkboxes
            airlineCheckboxes = {
              for (var name in carrierNames)
                name: airlineCheckboxes.containsKey(name) ? airlineCheckboxes[name]! : false
            };

            print('✅ Airline Checkbox Map: $airlineCheckboxes');

            filters['selectedCount'] =
                airlineCheckboxes.values.where((v) => v == true).length;
            _applyFiltersToResult(resultList, filters);
          } else {
            print('❌ Unexpected JSON format: $flightsJson');
          }
        } catch (e) {
          print('❌ ParsingSDdds error: $e');
        }
      }
      else {
        print('❌ Request failed: ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        isLoading = false; // Stop loading if an error occurs
        print('Error sending request: $error');
      });
    }
  }


  void _applyStopCountFilter(
      List<dynamic> results,
      Map<String, dynamic> filters,
      ) {
    // Only keep flights that are MainRow
    List<dynamic> filtered = results.where((flight) {
      bool isMainRow = flight['RowType'] == 'MainRow';

      if (!isMainRow) return false;

      // If non-stop filter is on, only keep StopCount == 0
      if (filters['isNonStop'] == true) {
        int stopCount = int.tryParse(flight['StopCount']) ?? 0;
        return stopCount == 0;
      }

      // Otherwise keep all main rows
      return true;
    }).toList();

    setState(() {
      resultList = filtered; // Only MainRow will be in the UI
    });
  }
  DateTime parseFlightDate(String dateStr) {
    // Try ISO format first
    DateTime? parsedDate = DateTime.tryParse(dateStr);
    if (parsedDate != null) return parsedDate;

    // Fallback to MM/dd/yyyy hh:mm:ss a format
    try {
      return DateFormat("MM/dd/yyyy hh:mm:ss a").parse(dateStr);
    } catch (e) {
      print("Failed to parse date: $dateStr, using now() as fallback");
      return DateTime.now();
    }
  }
  void _applyDepartureTimeFilter(List<dynamic> results, Map<String, dynamic> filters) {
    print('Displaying all flights: $results');

    List<dynamic> filteredResults = results.where((flight) {
      // Only consider MainRow entries
      if (flight['RowType'] != 'MainRow') return false;

      DateTime departureDate = parseFlightDate(flight['DepartureDate']);
      DateTime arrivalDate = parseFlightDate(flight['ArrivalDate']);

      // Departure time match
      bool matchesDeparture = (filters['isEarlyDeparture'] == true && departureDate.hour < 6) ||
          (filters['isMorningDeparture'] == true && departureDate.hour >= 6 && departureDate.hour < 12) ||
          (filters['isNoonDeparture'] == true && departureDate.hour >= 12 && departureDate.hour < 18) ||
          (filters['isEveningDeparture'] == true && departureDate.hour >= 18);

      // Arrival time match
      bool matchesArrival = (filters['ArrivalisEarlyDeparture'] == true && arrivalDate.hour < 6) ||
          (filters['ArrivalisMorningDeparture'] == true && arrivalDate.hour >= 6 && arrivalDate.hour < 12) ||
          (filters['ArrivalisNoonDeparture'] == true && arrivalDate.hour >= 12 && arrivalDate.hour < 18) ||
          (filters['ArrivalisEveningDeparture'] == true && arrivalDate.hour >= 18);

      // Both departure and arrival filters selected: AND condition
      if ((filters['isEarlyDeparture'] == true || filters['isMorningDeparture'] == true ||
          filters['isNoonDeparture'] == true || filters['isEveningDeparture'] == true) &&
          (filters['ArrivalisEarlyDeparture'] == true || filters['ArrivalisMorningDeparture'] == true ||
              filters['ArrivalisNoonDeparture'] == true || filters['ArrivalisEveningDeparture'] == true)) {
        return matchesDeparture && matchesArrival;
      }
      // Only departure filters selected
      else if (filters['isEarlyDeparture'] == true || filters['isMorningDeparture'] == true ||
          filters['isNoonDeparture'] == true || filters['isEveningDeparture'] == true) {
        return matchesDeparture;
      }
      // Only arrival filters selected
      else if (filters['ArrivalisEarlyDeparture'] == true || filters['ArrivalisMorningDeparture'] == true ||
          filters['ArrivalisNoonDeparture'] == true || filters['ArrivalisEveningDeparture'] == true) {
        return matchesArrival;
      }

      // No filters selected
      return false;
    }).toList();

    setState(() {
      this.resultList = filteredResults; // Update with filtered results
    });

    print('Filtered flights: $filteredResults');
  }


  void _applySort(List<dynamic> results, String sortOrder) {
    // Filter only MainRow entries
    List<dynamic> mainRowResults = results.where((flight) => flight['RowType'] == 'MainRow').toList();

    // Ensure sorting works correctly
    if (sortOrder == "Low to High") {
      mainRowResults.sort((a, b) => _parsePrice(a['TotalPrice']).compareTo(_parsePrice(b['TotalPrice'])));
      print("Sorting: Low to High");
    } else if (sortOrder == "High to Low") {
      mainRowResults.sort((a, b) => _parsePrice(b['TotalPrice']).compareTo(_parsePrice(a['TotalPrice'])));
      print("Sorting: High to Low");
    }

    // Update the result list with only MainRow entries sorted
    setState(() {
      resultList = mainRowResults;
    });

    print('Sorted flights (MainRow only): $mainRowResults');
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



  void _applyFiltersToResult(List<dynamic> flights, Map<String, dynamic> filters) {
    List<dynamic> filteredResults = [];

    for (var flight in flights) {
      bool matchesAirline = false;
      bool stopConditionMatches = false;
      bool refundableConditionMatches = false;
      bool departureConditionMatches = false;
      bool arrivalConditionMatches = false;

      // ✅ Selected airlines
      Set<String> selectedAirlines = airlineCheckboxes.entries
          .where((e) => e.value == true)
          .map((e) => e.key)
          .toSet();

      String carrierName = flight['CarrierName']?.toString() ?? '';
      // airline match (true if no airline selected = skip this filter)
      if (selectedAirlines.isEmpty) {
        matchesAirline = true;
      } else {
        matchesAirline = selectedAirlines.any((selected) {
          String s = selected.replaceAll(RegExp(r'[^A-Za-z]'), '').toLowerCase();
          String c = carrierName.replaceAll(RegExp(r'[^A-Za-z]'), '').toLowerCase();
          return c.contains(s);
        });
      }

      // ✅ Refundable filter
      String refundableStatus = flight['Refundable']?.toLowerCase() ?? '';
      bool isFlightRefundable = refundableStatus == 'refundable';
      bool isFlightNonRefundable = refundableStatus == 'non-refundable';

      if (!isRefundable && !isNonRefundable) {
        refundableConditionMatches = true;
      } else {
        refundableConditionMatches =
            (isRefundable && isFlightRefundable) ||
                (isNonRefundable && isFlightNonRefundable);
      }

      // ✅ Stops filter
      int stopCount = int.tryParse(flight['StopCount']) ?? 0;
      if (!isNonStop && !isOneStop && !isTwoPlusStops) {
        stopConditionMatches = true;
      } else {
        stopConditionMatches = (isNonStop && stopCount == 0) ||
            (isOneStop && stopCount == 1) ||
            (isTwoPlusStops && stopCount >= 2);
      }

      // ✅ Departure time filter
      DateTime? departureDate = parseFlightDate(flight['DepartureDate']);
      if (!DepartisEarlySelected &&
          !DepartisMorningSelected &&
          !DepartisNoonSelected &&
          !DepartisEveningSelected) {
        departureConditionMatches = true;
      } else {
        departureConditionMatches = departureDate == null || (
            (DepartisEarlySelected && departureDate.hour < 6) ||
                (DepartisMorningSelected && departureDate.hour >= 6 && departureDate.hour < 12) ||
                (DepartisNoonSelected && departureDate.hour >= 12 && departureDate.hour < 18) ||
                (DepartisEveningSelected && departureDate.hour >= 18)
        );
      }

      // ✅ Arrival time filter
      DateTime? arrivalDate = parseFlightDate(flight['ArrivalDate']);
      if (!ArrivalisEarlySelected &&
          !ArrivalisMorningSelected &&
          !ArrivalisNoonSelected &&
          !ArrivalisEveningSelected) {
        arrivalConditionMatches = true;
      } else {
        arrivalConditionMatches = arrivalDate == null || (
            (ArrivalisEarlySelected && arrivalDate.hour < 6) ||
                (ArrivalisMorningSelected && arrivalDate.hour >= 6 && arrivalDate.hour < 12) ||
                (ArrivalisNoonSelected && arrivalDate.hour >= 12 && arrivalDate.hour < 18) ||
                (ArrivalisEveningSelected && arrivalDate.hour >= 18)
        );
      }

      // ✅ FINAL: everything must pass (airline OR ALL + optional stop inside)
      if (matchesAirline &&
          stopConditionMatches &&
          refundableConditionMatches &&
          departureConditionMatches &&
          arrivalConditionMatches) {
        filteredResults.add(flight);
      }
    }

    setState(() {
      resultList = filteredResults;
      print('🎯 Filtered count: ${filteredResults.length}');
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
  String formattedDate(String dateStr) {
    try {
      DateTime dt = DateFormat("MM/dd/yyyy hh:mm:ss a").parse(dateStr);
      return DateFormat("dd-MM-yyyy\nh.mm a").format(dt); // 25-12-2025\n7.55 AM
    } catch (e) {
      return dateStr; // fallback
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
              "Available Flights",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Montserrat",
                  fontSize: 18),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/lojologg.png',
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
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 5, top: 4,bottom: 7),
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Carrier Icon
                                            Padding(
                                              padding: const EdgeInsets.only(right: 4, top: 6),
                                              child: Image.asset(
                                                "assets/images/img.png",
                                                width: 30,
                                              ),
                                            ),

                                            // Departure info
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    formattedDate(resultList[index]['DepartureDate'].toString().toUpperCase()),
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    resultList[index]['DepartCityCode'],
                                                    style: TextStyle(color: Color(0xff777777), fontWeight: FontWeight.bold, fontSize: 12),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Travel time & stops
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    CommonUtils.convertMinutesToHoursMinutes(resultList[index]['TravelTime']),
                                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Image.asset(
                                                    (resultList[index]['StopCount'] == '0')
                                                        ? "assets/images/NonStop.png"
                                                        : (resultList[index]['StopCount'] == '1')
                                                        ? "assets/images/oneStop.png"
                                                        : "assets/images/TwoStop.png",
                                                    width: 70,
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                  Text(
                                                    '${resultList[index]['StopCount']} stops',
                                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Arrival info
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    formattedDate(resultList[index]['ArrivalDate'].toString().toUpperCase()),
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    resultList[index]['ArriveCityCode'],
                                                    style: TextStyle(color: Color(0xff777777), fontWeight: FontWeight.bold, fontSize: 12),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Price & View Details
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${resultList[index]['Currency']} ${resultList[index]['TotalPrice']}',
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                                    overflow: TextOverflow.ellipsis,
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
                                                                departureDate: DateFormat("dd-MM-yyyy HH:mm").format(
                                                                    parseFlightDate(resultList[index]['DepartureDate'])
                                                                ),

                                                                stopcount:
                                                                resultList[index]
                                                                [
                                                                'StopCount'],
                                                                traveltime:
                                                                CommonUtils.convertMinutesToHoursMinutes(resultList[index]
                                                                [
                                                                'TravelTime']),
                                                                totalamount:
                                                                resultList[index]
                                                                [
                                                                'TotalPrice'],
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

                                        // Cheapest Text
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5,top: 6,
                                              bottom: 5), // Adjusted padding
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xFF152238)),
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
                                                  color:
                                                      Color(0xFF152238), // Icon color
                                                  size: 13, // Icon size
                                                ),
                                                // Spacing between the icon and text
                                                Text(
                                                  resultList[index]
                                                      ['Refundable'],
                                                  style: TextStyle(
                                                    color: Color(0xFF152238),
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
                                          DepartisEarlySelected: DepartisEarlySelected,
                                          DepartisMorningSelected: DepartisMorningSelected,
                                          DepartisNoonSelected: DepartisNoonSelected,
                                          DepartisEveningSelected: DepartisEveningSelected,
                                          ArrivalisEarlySelected: ArrivalisEarlySelected,
                                          ArrivalisMorningSelected: ArrivalisMorningSelected,
                                          ArrivalisNoonSelected: ArrivalisNoonSelected,
                                          ArrivalisEveningSelected: ArrivalisEveningSelected,
                                          add: widget.add,
                                        ),
                                      ),
                                    );
                                    print('✅ Selected Airlines updatedAirlineCheckboxes Returning: $airlineCheckboxes');

                                    // ✅ If user applied filters
                                    if (result != null) {
                                      setState(() {
                                        selectedCount = result['selectedCount'] ?? 0;

                                        isRefundable = result['isRefundable'] == 'Refundable';
                                        isNonRefundable = result['isNonRefundable'] == 'Non-Refundable';
                                        isNonStop = result['isNonStop'] == 'Yes';
                                        isOneStop = result['isOneStop'] == 'Yes';
                                        isTwoPlusStops = result['isTwoPlusStops'] == 'Yes';

                                        // ✅ Update airline checkboxes from result
                                        airlineCheckboxes = Map<String, bool>.from(result['airlineCheckboxes'] ?? {});
                                        print('✅ Selected Airlines After Returning: $airlineCheckboxes');
                                        airlineCheckboxes.forEach((airline, selected) {
                                          if (selected) print("✔ $airline");
                                        });

                                        // ✅ Other filters for departure/arrival time
                                        DepartisEarlySelected = result['isEarlyDeparture'] == 'Yes';
                                        DepartisMorningSelected = result['isMorningDeparture'] == 'Yes';
                                        DepartisNoonSelected = result['isNoonDeparture'] == 'Yes';
                                        DepartisEveningSelected = result['isEveningDeparture'] == 'Yes';
                                        ArrivalisEarlySelected = result['ArrivalIsEarlyDeparture'] == 'Yes';
                                        ArrivalisMorningSelected = result['ArrivalIsMorningDeparture'] == 'Yes';
                                        ArrivalisNoonSelected = result['ArrivalIsNoonDeparture'] == 'Yes';
                                        ArrivalisEveningSelected = result['ArrivalIsEveningDeparture'] == 'Yes';

                                        print('Selected filter count: $selectedCount');

                                        // ✅ Call API again with filters
                                        sendFlightSearchRequest(result);
                                      });
                                    }
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.filter_alt_outlined,
                                        size: 20,
                                        color: Colors.grey.shade600,
                                      ),
                                      SizedBox(height: 7),
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
                                    mainAxisSize: MainAxisSize.min, // Ensures the row only takes necessary space
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        size: 20, // Adjust the size of the icon as needed
                                        color: Colors.grey.shade600, // Match the icon color with the text
                                      ),
                                      SizedBox(height: 7), // Optional: Add a tiny width for spacing
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
                                      isNonStopSelected = !isNonStopSelected; // Toggle switch state
                                      // Call filter function if necessary
                                      Map<String, dynamic> filters = {
                                        'isNonStop': isNonStopSelected, // Non-stop filter
                                      };
                                      _applyStopCountFilter(fullResultList, filters);
                                    });
                                  },
                                  child: Container(
                                    width: 35, // Adjusted width
                                    height: 20, // Adjusted height
                                    decoration: BoxDecoration(
                                      color: isNonStopSelected ? Colors.pink.shade200 : Colors.grey, // Change color based on state
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Stack(
                                      children: [
                                        // White circle
                                        AnimatedAlign(
                                          alignment: isNonStopSelected ? Alignment.centerRight : Alignment.centerLeft,
                                          duration: Duration(milliseconds: 200),
                                          child: Container(
                                            width: 15, // Adjusted width for the white circle
                                            height: 15, // Adjusted height for the white circle
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                isNonStopSelected ? Icons.check : Icons.close, // Display tick or close icon
                                                size: 14, // Adjusted icon size
                                                color: isNonStopSelected ? Colors.pink.shade200 : Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
SizedBox(height: 7,),
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
                                    mainAxisSize: MainAxisSize.min, // Ensure no extra space is taken
                                    children: [
                                      Icon(
                                        Icons.sort,
                                        size: 20, // Adjust the size as needed
                                        color: Colors.grey.shade600,
                                      ),
                                   SizedBox(height: 7,),
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
      isDismissible: false, // Prevent closing by tapping outside or pressing back
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
                      Spacer(flex: 2), // Optional: Add this if you want space after the text
                    ],
                  ),



                  Divider(color: Colors.grey.shade400),

                  // Departure Time Section
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      'Departure Time',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
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

Divider(color: Colors.grey.shade400,),

                  Padding(
                    padding: const EdgeInsets.only(top: 8,bottom: 8),
                    child: Text(
                      'Arrival Time',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
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
                          _applySort(fullResultList, selectedSortOption!); // Use the non-null assertion operator
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


  void printFullJson(List<dynamic> matchingRows) {
    final encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(matchingRows);
    developer.log(prettyJson, name: 'FilteredFlightDetails');
  }

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
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes space between children
      children: [
        Expanded( // Allows text to take up remaining space
          child: Text(
            title,
            textAlign: TextAlign.left, // Ensure text is left-aligned
          ),
        ),
        Checkbox(
          value: value,
          onChanged: onChanged,
          visualDensity: VisualDensity.compact, // Reduces the default padding around the checkbox
        ),
        SizedBox(width: 4), // Reduced space between checkbox and text
      ],
    );
  }

}

