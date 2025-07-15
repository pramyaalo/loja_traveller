import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

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

      sendFlightSearchRequest(filters);
    });
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

  void sendFlightSearchRequest(Map<String, dynamic> filters) async {
    String fin_date =
        widget.departDate.toString().split(' ')[0].replaceAll('-', '/');
    String fin_date1 =
        widget.returnDate.toString().split(' ')[0].replaceAll('-', '/');
    String origin = widget.orgin;
    String destination = widget.destination;
    print('widget.departDate ${fin_date}');
    print('widget.origin ${widget.adult}');
    print('widget.destination ${widget.adult}');
    // Replace these values with your actual data
    var requestBody = {
      'AdultCount': widget.adult,
      'ChildrenCount': widget.children,
      'InfantCount': widget.infants,
      'Origin': widget.orgin,
      'Destination': widget.destination,
      'fromCountry': widget.originCountry,
      'tocountry': widget.destinationCourntry,
      'DepartDate': fin_date,
      'ReturnDate': fin_date1,
      'DefaultCurrency': 'KES',
      'UserID': '2611'
    };
    print('AdultCount: ${widget.adult}');
    print('ChildrenCount: ${widget.children}');
    print('InfantCount: ${widget.infants}');
    print('DepartDate: $fin_date');

    print('Origin: ${widget.orgin}');
    print('Destination: ${widget.destination}');
    print('TripType: OneWay');
    print('Destination: ${Currency}');
    print('TripType: ${userID}');
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/corporateapi.asmx/AdivahaSearchFlightRoundWay');
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
          resultList = json.decode(ResponseHandler.parseData(response.body));
          fullResultList = resultList;
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
      List<dynamic> results, Map<String, dynamic> filters)
  {
    if (filters['isNonStop'] == true) {
      // If the switch is ON, filter only non-stop flights (StopCount == 0 for both Forward and Return)
      resultList = results.where((flight) {
        // Ensure the StopCountForward and StopCountReturn are not null before parsing
        String? stopCountForwardStr = flight['StopCountForward'];
        String? stopCountReturnStr = flight['StopCountReturn'];

        // Use 0 as a fallback if parsing fails or the values are null
        int stopCountForward = stopCountForwardStr != null
            ? int.tryParse(stopCountForwardStr) ?? 0
            : 0;
        int stopCountReturn = stopCountReturnStr != null
            ? int.tryParse(stopCountReturnStr) ?? 0
            : 0;

        // Return true if both stop counts are 0 (non-stop)
        return stopCountForward == 0 && stopCountReturn == 0;
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
      List<dynamic> results, Map<String, dynamic> filters)
  {
    print('Displaying all flights: $results');

    // Filter based on departure and arrival time
    List<dynamic> filteredResults = results.where((flight) {
      // Check if DepartureDateForward and ArrivalDateForward exist and are non-null
      String? departureDateStr = flight['DepartureDateForward'];
      String? arrivalDateStr = flight['ArrivalDateForward'];

      // Default to a "far in the past" date if the string is null or parsing fails
      DateTime departureDate = departureDateStr != null
          ? DateTime.tryParse(departureDateStr) ?? DateTime(1900)
          : DateTime(1900);
      DateTime arrivalDate = arrivalDateStr != null
          ? DateTime.tryParse(arrivalDateStr) ?? DateTime(1900)
          : DateTime(1900);

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
        // AND condition: Both departure and arrival times must match
        return matchesDeparture && matchesArrival;
      }
      // Case 2: Only departure filters are selected (OR condition for departure match)
      else if (filters['isEarlyDeparture'] == true ||
          filters['isMorningDeparture'] == true ||
          filters['isNoonDeparture'] == true ||
          filters['isEveningDeparture'] == true) {
        return matchesDeparture;
      }
      // Case 3: Only arrival filters are selected (OR condition for arrival match)
      else if (filters['ArrivalisEarlyDeparture'] == true ||
          filters['ArrivalisMorningDeparture'] == true ||
          filters['ArrivalisNoonDeparture'] == true ||
          filters['ArrivalisEveningDeparture'] == true) {
        return matchesArrival;
      }

      // If no filters are selected, exclude this flight
      return false;
    }).toList();

    setState(() {
      this.resultList = filteredResults; // Update with filtered results
    });

    print('Filtered flights: $filteredResults');
  }

  void _applyFiltersToResult(
      List<dynamic> flights, Map<String, dynamic> filters)
  {
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

      // Check airline filters
      // Initialize matchesAirline

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
      if (isSriLankanAirlines) selectedAirlines.add('Sri Lankan Airlines');
      if (isTurkishAirlines) selectedAirlines.add('Turkish Airlines');
      if (isVistara) selectedAirlines.add('Vistara');

// Check if the flight's CarrierName matches any selected airlines
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
      departureConditionMatches = (DepartisEarlySelected && departureDate.hour < 6) ||
          (DepartisMorningSelected && departureDate.hour >= 6 && departureDate.hour < 12) ||
          (DepartisNoonSelected && departureDate.hour >= 12 && departureDate.hour < 18) ||
          (DepartisEveningSelected && departureDate.hour >= 18);

      // Check arrival time filters
      DateTime arrivalDate = DateTime.parse(flight['ArrivalDate']);
      arrivalConditionMatches = (ArrivalisEarlySelected && arrivalDate.hour < 6) ||
          (ArrivalisMorningSelected && arrivalDate.hour >= 6 && arrivalDate.hour < 12) ||
          (ArrivalisNoonSelected && arrivalDate.hour >= 12 && arrivalDate.hour < 18) ||
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

  void _applySort(List<dynamic> results, String sortOrder) {
    // Ensure sorting works correctly
    if (sortOrder == "Low to High") {
      results.sort((a, b) => _parsePrice(a['TotalPrice']).compareTo(_parsePrice(b['TotalPrice'])));
      print("Sorting: Low to High");
    } else if (sortOrder == "High to Low") {
      // Sort in descending order (high price to low price)
      results.sort((a, b) => _parsePrice(b['TotalPrice']).compareTo(_parsePrice(a['TotalPrice'])));
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
                  color: Colors.white, fontFamily: "Montserrat", fontSize: 19),
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
                        color: Color(0xFF00ADEE),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 16.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          color: Color(0xFF00ADEE),
                        ),
                        Container(
                          width: double.infinity,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          color: Color(0xFF00ADEE),
                        ),
                        Container(
                          width: double.infinity,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          color: Color(0xFF00ADEE),
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
                                                      ['CarrierNameForward'] ??
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
                                                          ? CommonUtils
                                                              .convertMinutesToHoursMinutes(
                                                                  resultList[
                                                                          index]
                                                                      [
                                                                      'TravelTimeForward'])
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
                                                          'CarrierNameForward'] ??
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
                                                          ? CommonUtils
                                                              .convertMinutesToHoursMinutes(
                                                                  resultList[
                                                                          index]
                                                                      [
                                                                      'TravelTimeReturn'])
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
                                                        stopCount: resultList[
                                                                index][
                                                            "StopCountForward"],
                                                        departCity: resultList[
                                                                index][
                                                            "DepartCityNameForward"],
                                                        TotalPrice:
                                                            resultList[index]
                                                                ["TotalPrice"],
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
                                          builder: (context) =>
                                              FilterPage(  Refundable:isRefundable,
                                                NonRefundable:isNonRefundable,
                                                NonStop:isNonStop,
                                                oneStop:isOneStop,
                                                twoStop:isTwoPlusStops,
                                                AirIndia:isAirIndia,
                                                AirIndiaExpress:isAirIndiaExpress,
                                                isBimanBangladesh:isBimanBangladesh,
                                                isBritishAirways:isBritishAirways,
                                                isEmirates:isEmirates,
                                                isEtihad:isEtihad,
                                                isGulfAir:isGulfAir,
                                                isIndigo:isIndigo,
                                                isLufthansa:isLufthansa,
                                                isOmanAviation:isOmanAviation,
                                                isQatarAirways:isQatarAirways,
                                                isSalamAir:isSalamAir,
                                                isSingaporeAirlines:isSingaporeAirlines,
                                                isSpiceJet:isSpiceJet,
                                                isSriLankanAirlines:isSriLankanAirlines,
                                                isTurkishAirlines:isTurkishAirlines,
                                                isVistara:isVistara,
                                                DepartisEarlySelected:DepartisEarlySelected,
                                                DepartisMorningSelected:DepartisMorningSelected,
                                                DepartisNoonSelected:DepartisNoonSelected,
                                                DepartisEveningSelected:DepartisEveningSelected,
                                                ArrivalisEarlySelected:ArrivalisEarlySelected,
                                                ArrivalisMorningSelected:ArrivalisMorningSelected,
                                                ArrivalisNoonSelected:ArrivalisNoonSelected,
                                                ArrivalisEveningSelected:ArrivalisEveningSelected,
                                                add: widget.add,)),
                                    );

                                    // If we received any result from the filter page
                                    if (result != null) {
                                      setState(() {
                                        selectedCount =
                                            result['selectedCount'] ?? 0;
                                        print(
                                            'Selected filter count: $selectedCount');
                                        isRefundable = result['isRefundable'] == 'Refundable';
                                        isNonRefundable = result['isNonRefundable'] == 'Non-Refundable';
                                        isNonStop = result['isNonStop'] == 'Yes';
                                        isOneStop = result['isOneStop'] == 'Yes';
                                        isTwoPlusStops = result['isTwoPlusStops'] == 'Yes';
                                        isAirIndia = result['isAirIndia'] == 'Yes';
                                        isAirIndiaExpress = result['isAirIndiaExpress'] == 'Yes';
                                        isBimanBangladesh = result['isBimanBangladesh'] == 'Yes';
                                        isBritishAirways = result['isBritishAirways'] == 'Yes';
                                        isEmirates = result['isEmirates'] == 'Yes';
                                        isEtihad = result['isEtihad'] == 'Yes';
                                        isGulfAir = result['isGulfAir'] == 'Yes';
                                        isIndigo = result['isIndigo'] == 'Yes';
                                        isLufthansa = result['isLufthansa'] == 'Yes';
                                        isOmanAviation = result['isOmanAviation'] == 'Yes';
                                        isQatarAirways = result['isQatarAirways'] == 'Yes';
                                        isSalamAir = result['isSalamAir'] == 'Yes';
                                        isSingaporeAirlines = result['isSingaporeAirlines'] == 'Yes';
                                        isSpiceJet = result['isSpiceJet'] == 'Yes';
                                        isSriLankanAirlines = result['isSriLankanAirlines'] == 'Yes';
                                        isTurkishAirlines = result['isTurkishAirlines'] == 'Yes';
                                        isVistara = result['isVistara'] == 'Yes';
                                        DepartisEarlySelected = result['isEarlyDeparture'] == 'Yes';
                                        DepartisMorningSelected = result['isMorningDeparture'] == 'Yes';
                                        DepartisNoonSelected = result['isNoonDeparture'] == 'Yes';
                                        DepartisEveningSelected = result['isEveningDeparture'] == 'Yes';
                                        ArrivalisEarlySelected = result['ArrivalIsEarlyDeparture'] == 'Yes';
                                        ArrivalisMorningSelected = result['ArrivalIsMorningDeparture'] == 'Yes';
                                        ArrivalisNoonSelected = result['ArrivalIsNoonDeparture'] == 'Yes';
                                        ArrivalisEveningSelected = result['ArrivalIsEveningDeparture'] == 'Yes';
                                        String add = 'Edit'; // Assuming this remains constant

                                        // Step 3: Print all filter values
                                        print('Selected filter count: $selectedCount');
                                        print('isRefundable: $isRefundable');
                                        print('isNonRefundable: $isNonRefundable');
                                        print('isNonStop: $isNonStop');
                                        print('isOneStop: $isOneStop');
                                        print('isTwoPlusStops: $isTwoPlusStops');
                                        print('isAirIndia: $isAirIndia');
                                        print('isAirIndiaExpress: $isAirIndiaExpress');
                                        print('isBimanBangladesh: $isBimanBangladesh');
                                        print('isBritishAirways: $isBritishAirways');
                                        print('isEmirates: $isEmirates');
                                        print('isEtihad: $isEtihad');
                                        print('isGulfAir: $isGulfAir');
                                        print('isIndigo: $isIndigo');
                                        print('isLufthansa: $isLufthansa');
                                        print('isOmanAviation: $isOmanAviation');
                                        print('isQatarAirways: $isQatarAirways');
                                        print('isSalamAir: $isSalamAir');
                                        print('isSingaporeAirlines: $isSingaporeAirlines');
                                        print('isSpiceJet: $isSpiceJet');
                                        print('isSriLankanAirlines: $isSriLankanAirlines');
                                        print('isTurkishAirlines: $isTurkishAirlines');
                                        print('isVistara: $isVistara');
                                        print('isEarlyDeparture: $DepartisEarlySelected');
                                        print('isMorningDeparture: $DepartisMorningSelected');
                                        print('isNoonDeparture: $DepartisNoonSelected');
                                        print('isEveningDeparture: $DepartisEveningSelected');
                                        print('arrivalIsEarlyDeparture: $ArrivalisEarlySelected');
                                        print('arrivalIsMorningDeparture: $ArrivalisMorningSelected');
                                        print('arrivalIsNoonDeparture: $ArrivalisNoonSelected');
                                        print('arrivalIsEveningDeparture: $ArrivalisEveningSelected');
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
                                          ? Color(0xFF00ADEE)
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
                                                    ?Color(0xFF00ADEE)
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
