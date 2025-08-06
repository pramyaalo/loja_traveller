import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'dart:developer' as developer;

import '../../Booking/CommonUtils.dart';
import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';
import 'FilterPage.dart';
import 'multicity_booking.dart';

class MultiCityFlightsList extends StatefulWidget {
  final add,
      adult,
      orgin,
      destination,
      orgin2,
      destination2,
      orgin3,
      destination3,
      orgin4,
      destination4,
      departDate1,
      departdate2,
      departDate3,
      departdate4,
      children,
      infants;

    MultiCityFlightsList({



    required this. add,
    required this.adult,
    required this.orgin,
    required this.destination,
    required this.orgin2,
    required this.destination2,
    required this.orgin3,
    required this.destination3,
    required this.orgin4,
    required this.destination4,
    required this.departDate1,
    required this.departdate2,
    required this.departDate3,
    required this.departdate4,
    required this.children,
    required this.infants,
  });

  @override
  State<MultiCityFlightsList> createState() => _MultiCityFlightsListState();
}

class _MultiCityFlightsListState extends State<MultiCityFlightsList> {
  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _retrieveSavedValues();
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

  void _applyStopCountFilter(List<dynamic> results, Map<String, dynamic> filters) {
    if (filters['isNonStop'] == true) {
      // If the switch is ON, filter only non-stop flights (StopCount == 0 for all StopCounts)
      myResult = results.where((flight) {
        // Ensure the StopCounts are not null before parsing
        String? stopCountFirstStr = flight['StopCountFirst'];
        String? stopCountSecondStr = flight['StopCountSecond'];
        String? stopCountThirdStr = flight['StopCountThird'];
        String? stopCountFourthStr = flight['StopCountFourth'];

        // Use 0 as a fallback if parsing fails or the values are null
        int stopCountFirst = stopCountFirstStr != null
            ? int.tryParse(stopCountFirstStr) ?? 0
            : 0;
        int stopCountSecond = stopCountSecondStr != null
            ? int.tryParse(stopCountSecondStr) ?? 0
            : 0;
        int stopCountThird = stopCountThirdStr != null
            ? int.tryParse(stopCountThirdStr) ?? 0
            : 0;
        int stopCountFourth = stopCountFourthStr != null
            ? int.tryParse(stopCountFourthStr) ?? 0
            : 0;

        // Return true if all stop counts are 0 (non-stop)
        return stopCountFirst == 0 &&
            stopCountSecond == 0 &&
            stopCountThird == 0 &&
            stopCountFourth == 0;
      }).toList();
    } else {
      // If the switch is OFF, show all flights (no filtering)
      myResult = fullResultList; // Reset resultList to show all flights
    }

    // Now update the UI
    setState(() {
      myResult = myResult; // Refresh the list in the UI
    });
  }


  void _applyDepartureTimeFilter(
      List<dynamic> results, Map<String, dynamic> filters) {
    print('Displaying all flights: $results');

    // Filter based on departure and arrival time
    List<dynamic> filteredResults = results.where((flight) {
      // Check if DepartureDateForward and ArrivalDateForward exist and are non-null
      String? departureDateStr = flight['DepartureDateFirst'];
      String? arrivalDateStr = flight['ArrivalDateFirst'];

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
      this.myResult = filteredResults; // Update with filtered results
    });

    print('Filtered flights: $filteredResults');
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
      sendMultiWayFlightSearchRequest(filters);
    });
  }

  String? selectedSortOption = "Low to High";
  int selectedCount = 0;
  Map<String, bool> airlineCheckboxes = {};
  bool isNonStopSelected = false;
  bool DepartisEarlySelected = false;
  bool DepartisMorningSelected = false;
  bool DepartisNoonSelected = false;
  bool DepartisEveningSelected = false;

  bool ArrivalisEarlySelected = false;
  bool ArrivalisMorningSelected = false;
  bool ArrivalisNoonSelected = false;
  bool ArrivalisEveningSelected = false;

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

  late ScrollController _scrollController;
  bool _isBottomBarVisible = true;
  var myResult = [];

  Future<void> sendMultiWayFlightSearchRequest(
      Map<String, dynamic> filters) async {
    String fin_date =
        widget.departDate1.toString().split(' ')[0].replaceAll('-', '-');
    String fin_date1 =
        widget.departdate2.toString().split(' ')[0].replaceAll('-', '-');
    String fin_date2 =
        widget.departDate3.toString().split(' ')[0].replaceAll('-', '-');
    String fin_date3 =
        widget.departdate4.toString().split(' ')[0].replaceAll('-', '-');
    var requestBody = {
      'OriginFirst': widget.orgin ?? '',
      'DestinationFirst': widget.destination ?? '',
      'OriginSecond': widget.orgin2 ?? '',
      'DestinationSecond': widget.destination2 ?? '',
      'DepartDateFirst': fin_date ?? '',
      'DepartDateSecond': fin_date1 ?? '',
      'OriginThird': widget.orgin3 ?? '',
      'DestinationThird': widget.destination3 ?? '',
      'DepartDateThird': fin_date2 ?? '',
      'OriginFourth': widget.orgin4 ?? '',
      'DestinationFourth': widget.destination4 ?? '',
      'DepartDateFourth': fin_date3 ?? '',
      'AdultCount': widget.adult ?? '',
      'ChildrenCount': widget.children ?? '',
      'InfantCount': widget.infants ?? '',
      'Class': '3',
      'DefaultCurrency': Currency ?? '',
      'UserID': userID ?? '',
    };
    print('OriginFirst: ${widget.orgin}');
    print('DestinationFirst: ${widget.destination}');
    print('OriginSecond: ${widget.orgin2}');
    print('DestinationSecond: ${widget.destination2}');
    print('DepartDateFirst: $fin_date');
    print('DepartDateSecond: $fin_date1');
    print('OriginThird: ${widget.orgin3}');
    print('DestinationThird: ${widget.destination3}');
    print('DepartDateThird: $fin_date2');
    print('OriginFourth: ${widget.orgin4}');
    print('DestinationFourth: ${widget.destination4}');
    print('DepartDateFourth: $fin_date3');
    print('AdultCount: ${widget.adult}');
    print('ChildrenCount: ${widget.children}');
    print('InfantCount: ${widget.infants}');
    print('Class: 3');
    print('DefaultCurrency: $Currency');
    print('UserID: $userID');

    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaSearchFlightMultiWay');
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
        print('✅ Response: ${response.body}');

        final parsedData =
        json.decode(ResponseHandler.parseData(response.body));

        // Save full data (MainRow + SubRow)
        fullResultList = parsedData;

        // Filter only MainRow items for UI display
        myResult = fullResultList
            .where((item) =>
        item['RowTypeFirst'] == 'MainRow' ||
            item['RowTypeSecond'] == 'MainRow' ||
            item['RowTypeThird'] == 'MainRow' ||
            item['RowTypeFourth'] == 'MainRow')
            .toList();

        print('✅ Total MainRow items: ${myResult.length}');
        for (var i = 0; i < myResult.length; i++) {
          print(
              'MainRow ${i + 1}: ${myResult[i]['FlightNumber']} - MainRowNumber: ${myResult[i]['MainRowNumber']}');
        }

        // Optional: log sub-row count
        final subRowCount =
            fullResultList.where((item) => item['RowType'] == 'SubRow').length;
        print('ℹ️ Total SubRow items: $subRowCount');

        Set<String> carrierCodes = {};

        for (var item in fullResultList) {
          if (item['CarrierNameFirst'] != null) {
            carrierCodes.add(item['CarrierNameFirst']);
          }

        }

// ✅ Preserve previous airline selections
        airlineCheckboxes = {
          for (var code in carrierCodes)
            code: airlineCheckboxes.containsKey(code) ? airlineCheckboxes[code]! : false
        };

        print('✅ Airline Checkbox Map (Round Trip): $airlineCheckboxes');
        // Apply filters on MainRow list
        _applyFiltersToResult(myResult, filters);
      }
      else {
        print('❌ Error ${response.statusCode} : ${response.body}');
      }
    } catch (error) {
      print('Error sending request: $error');
    }
  }

  void navigate(Widget screen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }
  void _applyFiltersToResult(List<dynamic> flights, Map<String, dynamic> filters) {
    List<dynamic> filteredResults = [];

    // Selected Airlines (checkbox map from filters)
    Map<String, bool> airlineCheckboxes =
    Map<String, bool>.from(filters['airlineCheckboxes'] ?? {});
    List<String> selectedAirlines = airlineCheckboxes.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    for (var flight in flights) {
      bool matchesAirline = false;
      bool stopMatches = false;
      bool refundableMatches = false;
      bool departMatches = false;
      bool arriveMatches = false;

      /*--------- Airline Match ----------*/
      String carrierName = flight['CarrierNameFirst']?.toString() ?? '';
      if (selectedAirlines.isEmpty) {
        matchesAirline = true; // no filter → accept
      } else {
        matchesAirline = selectedAirlines.any((s) =>
            carrierName.replaceAll(RegExp(r'[^A-Za-z]'), '').toLowerCase().contains(
                s.replaceAll(RegExp(r'[^A-Za-z]'), '').toLowerCase()));
      }

      /*--------- Refundable Match ----------*/
      String ref = (flight['Refundable'] ?? '').toString().toLowerCase();
      bool isFlightRef = ref == 'refundable';
      bool isFlightNonRef = ref == 'non-refundable';
      if (!filters['isRefundable'] && !filters['isNonRefundable']) {
        refundableMatches = true;
      } else {
        refundableMatches =
            (filters['isRefundable'] == 'Yes' && isFlightRef) ||
                (filters['isNonRefundable'] == 'Yes' && isFlightNonRef);
      }

      /*--------- Stops Match ----------*/
      int stop = int.tryParse(flight['StopCountFirst'] ?? '0') ?? 0;
      if (!filters['isNonStop'] &&
          !filters['isOneStop'] &&
          !filters['isTwoPlusStops']) {
        stopMatches = true;
      } else {
        stopMatches = (filters['isNonStop'] == 'Yes' && stop == 0) ||
            (filters['isOneStop'] == 'Yes' && stop == 1) ||
            (filters['isTwoPlusStops'] == 'Yes' && stop >= 2);
      }

      /*--------- Departure Match ----------*/
      DateTime d = DateTime.tryParse(flight['DepartureDateFirst'] ?? '') ??
          DateTime(1900);
      if (!filters['isEarlyDeparture'] &&
          !filters['isMorningDeparture'] &&
          !filters['isNoonDeparture'] &&
          !filters['isEveningDeparture']) {
        departMatches = true;
      } else {
        departMatches =
            (filters['isEarlyDeparture'] == 'Yes' && d.hour < 6) ||
                (filters['isMorningDeparture'] == 'Yes' &&
                    d.hour >= 6 &&
                    d.hour < 12) ||
                (filters['isNoonDeparture'] == 'Yes' &&
                    d.hour >= 12 &&
                    d.hour < 18) ||
                (filters['isEveningDeparture'] == 'Yes' && d.hour >= 18);
      }

      /*--------- Arrival Match ----------*/
      DateTime a = DateTime.tryParse(flight['ArrivalDateFirst'] ?? '') ??
          DateTime(1900);
      if (!filters['ArrivalIsEarlyDeparture'] &&
          !filters['ArrivalIsMorningDeparture'] &&
          !filters['ArrivalIsNoonDeparture'] &&
          !filters['ArrivalIsEveningDeparture']) {
        arriveMatches = true;
      } else {
        arriveMatches =
            (filters['ArrivalIsEarlyDeparture'] == 'Yes' && a.hour < 6) ||
                (filters['ArrivalIsMorningDeparture'] == 'Yes' &&
                    a.hour >= 6 &&
                    a.hour < 12) ||
                (filters['ArrivalIsNoonDeparture'] == 'Yes' &&
                    a.hour >= 12 &&
                    a.hour < 18) ||
                (filters['ArrivalIsEveningDeparture'] == 'Yes' && a.hour >= 18);
      }

      // ✅ Add only if all match
      if (matchesAirline &&
          stopMatches &&
          refundableMatches &&
          departMatches &&
          arriveMatches) {
        filteredResults.add(flight);
      }
    }

    /*--------- Remove Duplicates ----------*/
    final seen = <String>{};
    filteredResults = filteredResults.where((flight) {
      final key =
          '${flight['CarrierNameFirst']}_${flight['DepartureDateFirst']}_${flight['ArrivalDateFirst']}';
      if (seen.contains(key)) return false;
      seen.add(key);
      return true;
    }).toList();

    /*--------- Show only MainRow ----------*/
    setState(() {
      myResult =
          filteredResults.where((f) => f['RowTypeFirst'] == 'MainRow').toList();
      print('🎯 Filtered results after duplicate-remove: ${myResult.length}');
    });
  }

  void _applySort(List<dynamic> results, String sortOrder) {
    if (sortOrder == "Low to High") {
      results.sort((a, b) {
        // Convert 'TotalPrice' to a number, use 0 or a high value as fallback if the conversion fails
        double priceA = double.tryParse(a['TotalPrice']?.toString() ?? '') ??
            double.maxFinite;
        double priceB = double.tryParse(b['TotalPrice']?.toString() ?? '') ??
            double.maxFinite;
        return priceA.compareTo(priceB);
      });
    } else if (sortOrder == "High to Low") {
      results.sort((a, b) {
        double priceA =
            double.tryParse(a['TotalPrice']?.toString() ?? '') ?? 0.0;
        double priceB =
            double.tryParse(b['TotalPrice']?.toString() ?? '') ?? 0.0;
        return priceB.compareTo(priceA);
      });
    }

    // After sorting, update the result list
    setState(() {
      myResult = results; // Update with sorted results
    });

    print('Sorted flights: $results'); // Debugging sorted results
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
                color: Colors.black,
                size: 27,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(width: 1), // Set the desired width
            Text(
              "Multi City Flights",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Montserrat", fontSize: 19),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/logo.png',
            width: 150,
            height: 50,
          ),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: Colors.white,
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
                          itemCount: myResult.length,
                          controller: _scrollController,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                                margin:
                                    EdgeInsets.only(left: 8, right: 8, top: 2),
                                padding: EdgeInsets.all(2),
                                child: Material(
                                  color: Colors.white,
                                  elevation: 15,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 5, right: 5, bottom: 5, top: 5),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  myResult[index][
                                                              'CarrierNameFirst'] !=
                                                          null
                                                      ? myResult[index][
                                                              'CarrierNameFirst']
                                                          .toString()
                                                      : '',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                    'assets/images/img.png'),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      myResult[index][
                                                                  'DepartureDateFirst'] !=
                                                              null
                                                          ? CommonUtils.convertToFormattedTime(
                                                                      myResult[
                                                                              index]
                                                                          [
                                                                          'DepartureDateFirst'])
                                                                  ?.toUpperCase() ??
                                                              'Not Available'
                                                          : 'Not Available',
                                                      // Default if DepartureDateFirst is null
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      myResult[index][
                                                              'DepartCityCodeFirst'] ??
                                                          'Not Available',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff777777),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      myResult[index][
                                                                  'TravelTimeFirst'] !=
                                                              null
                                                          ? CommonUtils.convertMinutesToHoursMinutes(
                                                                  myResult[
                                                                          index]
                                                                      [
                                                                      'TravelTimeFirst']) ??
                                                              'Not Available'
                                                          : 'Not Available',
                                                      // Handle null case for TravelTimeFirst
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      (myResult[index][
                                                                  'StopCountFirst'] !=
                                                              null)
                                                          ? (myResult[index][
                                                                      'StopCountFirst'] ==
                                                                  '0'
                                                              ? "assets/images/NonStop.png"
                                                              : (myResult[index]
                                                                          [
                                                                          'StopCountFirst'] ==
                                                                      '1'
                                                                  ? "assets/images/oneStop.png"
                                                                  : "assets/images/TwoStop.png"))
                                                          : "assets/images/NonStop.png",
                                                      // Fallback for StopCountFirst if null
                                                      width: 70,
                                                    ),
                                                    Text(
                                                      '${myResult[index]['StopCountFirst'] ?? '0'} stops',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      myResult[index][
                                                                  'ArrivalDateFirst'] !=
                                                              null
                                                          ? CommonUtils.convertToFormattedTime(
                                                                      myResult[
                                                                              index]
                                                                          [
                                                                          'ArrivalDateFirst'])
                                                                  ?.toUpperCase() ??
                                                              'Not Available'
                                                          : 'Not Available',
                                                      // Default if ArrivalDateFirst is null
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      myResult[index][
                                                              'ArriveCityCodeFirst'] ??
                                                          'Not Available',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff777777),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  myResult[index][
                                                              'CarrierNameSecond'] !=
                                                          null
                                                      ? myResult[index][
                                                              'CarrierNameSecond']
                                                          .toString()
                                                      : '',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Text(
                                                    '${myResult[index]['Currency']} ${myResult[index]['TotalPrice']}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                    'assets/images/img.png'),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      CommonUtils.convertToFormattedTime(
                                                                  myResult[index]
                                                                          [
                                                                          'DepartureDateSecond'] ??
                                                                      '')
                                                              ?.toUpperCase() ??
                                                          'Not Available',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      myResult[index][
                                                              'DepartCityCodeSecond'] ??
                                                          'Not Available',
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
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      myResult[index][
                                                                  'TravelTimeSecond'] !=
                                                              null
                                                          ? CommonUtils.convertMinutesToHoursMinutes(
                                                                  myResult[
                                                                          index]
                                                                      [
                                                                      'TravelTimeSecond']) ??
                                                              'Not Available'
                                                          : 'Not Available',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      myResult[index][
                                                                  'StopCountSecond'] !=
                                                              null
                                                          ? (myResult[index][
                                                                      'StopCountSecond'] ==
                                                                  '0'
                                                              ? "assets/images/NonStop.png"
                                                              : (myResult[index]
                                                                          [
                                                                          'StopCountSecond'] ==
                                                                      '1'
                                                                  ? "assets/images/oneStop.png"
                                                                  : "assets/images/TwoStop.png"))
                                                          : "assets/images/NonStop.png",
                                                      // Fallback image if StopCountSecond is null
                                                      width: 60,
                                                    ),
                                                    Text(
                                                      '${myResult[index]['StopCountSecond'] ?? '0'} stops',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      CommonUtils.convertToFormattedTime(
                                                                  myResult[index]
                                                                          [
                                                                          'ArrivalDateSecond'] ??
                                                                      '')
                                                              ?.toUpperCase() ??
                                                          'Not Available',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      myResult[index][
                                                              'ArriveCityCodeSecond'] ??
                                                          'Not Available',
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
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                              // Add vertical padding for spacing
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    myResult[index][
                                                                'CarrierNameThird'] !=
                                                            null
                                                        ? myResult[index][
                                                                'CarrierNameThird']
                                                            .toString()
                                                        : '',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize:
                                                          16, // Increase font size for emphasis
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  // Space between carrier name and row below
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Image.asset(
                                                          'assets/images/img.png'),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            CommonUtils.convertToFormattedTime(
                                                                        myResult[index]['DepartureDateThird'] ??
                                                                            '')
                                                                    ?.toUpperCase() ??
                                                                'Not Available',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          Text(
                                                            myResult[index][
                                                                    'DepartCityCodeThird'] ??
                                                                'Not Available',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff777777),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      // Travel Time and Stops Column
                                                      Column(
                                                        children: [
                                                          Text(
                                                            myResult[index][
                                                                        'TravelTimeThird'] !=
                                                                    null
                                                                ? CommonUtils.convertMinutesToHoursMinutes(
                                                                        myResult[index]
                                                                            [
                                                                            'TravelTimeThird']) ??
                                                                    'Not Available'
                                                                : 'Not Available',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                          // Image for Stop Count
                                                          Image.asset(
                                                            myResult[index][
                                                                        'StopCountThird'] !=
                                                                    null
                                                                ? (myResult[index]
                                                                            [
                                                                            'StopCountThird'] ==
                                                                        '0'
                                                                    ? "assets/images/NonStop.png"
                                                                    : (myResult[index]['StopCountThird'] ==
                                                                            '1'
                                                                        ? "assets/images/oneStop.png"
                                                                        : "assets/images/TwoStop.png"))
                                                                : "assets/images/NonStop.png",
                                                            // Default image if null
                                                            width: 70,
                                                          ),
                                                          Text(
                                                            '${myResult[index]['StopCountThird'] ?? '0'} stops',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      // Arrival Column
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            CommonUtils.convertToFormattedTime(
                                                                        myResult[index]['ArrivalDateThird'] ??
                                                                            '')
                                                                    ?.toUpperCase() ??
                                                                'Not Available',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          Text(
                                                            myResult[index][
                                                                    'ArriveCityCodeThird'] ??
                                                                'Not Available',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff777777),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0),
                                              // Add vertical padding for spacing
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Carrier Name Section
                                                  if (myResult[index][
                                                          'CarrierNameFourth'] !=
                                                      null)
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                            'assets/images/img.png'),
                                                        Container(
                                                          width: 65,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          child: Text(
                                                            myResult[index][
                                                                    'CarrierNameFourth']
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 9),
                                                        // Space after carrier name
                                                      ],
                                                    ),

                                                  // Departure and Arrival Dates Section
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            if (myResult[index][
                                                                    'DepartureDateFourth'] !=
                                                                null)
                                                              Text(
                                                                '${CommonUtils.convertToFormattedTime(myResult[index]['DepartureDateFourth']).toString().toUpperCase()}',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            if (myResult[index][
                                                                    'ArrivalDateFourth'] !=
                                                                null)
                                                              Text(
                                                                '${CommonUtils.convertToFormattedTime(myResult[index]['ArrivalDateFourth']).toString().toUpperCase()}',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                          ],
                                                        ),

                                                        // Travel Time and Stop Count Section
                                                        Row(
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                if (myResult[
                                                                            index]
                                                                        [
                                                                        'TravelTimeFourth'] !=
                                                                    null)
                                                                  Text(
                                                                    CommonUtils
                                                                        .convertMinutesToHoursMinutes(
                                                                      myResult[index]
                                                                              [
                                                                              'TravelTimeFourth']
                                                                          .toString(),
                                                                    ),
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                  ),
                                                                if (myResult[
                                                                            index]
                                                                        [
                                                                        'StopCountFourth'] !=
                                                                    null)
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20),
                                                                    child: Image
                                                                        .asset(
                                                                      myResult[index]['StopCountFourth'] ==
                                                                              '0'
                                                                          ? "assets/images/NonStop.png"
                                                                          : (myResult[index]['StopCountFourth'] == '1'
                                                                              ? "assets/images/oneStop.png"
                                                                              : "assets/images/TwoStop.png"),
                                                                      width: 70,
                                                                      height:
                                                                          20,
                                                                      fit: BoxFit
                                                                          .fitWidth,
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),

                                                        // Departure and Arrival City Codes Section
                                                        if (myResult[index][
                                                                'ArriveCityCodeFourth'] !=
                                                            null)
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: 10),
                                                              if (myResult[
                                                                          index]
                                                                      [
                                                                      'DepartCityCodeFourth'] !=
                                                                  null)
                                                                Text(
                                                                  myResult[index]
                                                                          [
                                                                          'DepartCityCodeFourth']
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xff777777),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                ),
                                                              SizedBox(
                                                                  width: 60),
                                                              if (myResult[
                                                                          index]
                                                                      [
                                                                      'StopCountFourth'] !=
                                                                  null)
                                                                Text(
                                                                  '${myResult[index]['StopCountFourth']} stops',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                              SizedBox(
                                                                  width: 60),
                                                              if (myResult[
                                                                          index]
                                                                      [
                                                                      'ArriveCityCodeFourth'] !=
                                                                  null)
                                                                Text(
                                                                  myResult[index]
                                                                          [
                                                                          'ArriveCityCodeFourth']
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xff777777),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                ),
                                                            ],
                                                          ),

                                                        // Divider
                                                        if (myResult[index][
                                                                'ArriveCityCodeFourth'] !=
                                                            null)
                                                          Column(
                                                            children: [
                                                              SizedBox(
                                                                  height: 5),
                                                              SizedBox(
                                                                width: 250,
                                                                height: 1,
                                                                child:
                                                                    DecoratedBox(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Color(
                                                                        0xffededed),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
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
                                                    myResult[index]
                                                            ['Refundable']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: (myResult[index][
                                                                    'Refundable'] ==
                                                                'Refundable')
                                                            ? Colors.green
                                                            : Colors.red,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  //TwoWayBooking
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MultiCityBooking(
                                                        flightDetails:
                                                            myResult[index],
                                                        adultCount:
                                                            widget.adult,
                                                        childrenCount:
                                                            widget.children,
                                                        infantCount:
                                                            widget.infants,
                                                            StopCountFirst:myResult[index]['StopCountFirst'],
                                                            StopCountSecond:myResult[index]['StopCountSecond'],
                                                            StopCountThird:myResult[index]['StopCountThird'],
                                                            TotalPrice:myResult[index]['TotalPrice'],
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
                                      ]),
                                    ),
                                  ),
                                ));
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
                                          builder: (context) => FilterPage(airlineCheckboxes: airlineCheckboxes,
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

                                        airlineCheckboxes = Map<String, bool>.from(result['airlineCheckboxes'] ?? {});
                                        selectedCount = result['selectedCount'] ?? 0;

                                        print('✅ Selected filter count: $selectedCount');
                                        print('✅ Airline Checkbox Map: $airlineCheckboxes');
                                        sendMultiWayFlightSearchRequest(result);
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
