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
import '../Car/CarBookingPage.dart';
import '../flight/Children_DatabaseHelper.dart';
import '../flight/FilterPage.dart';
import '../flight/InfantDatabaseHelper.dart';
import '../flight/oneway_booking.dart';
import 'SeatSelectionPage.dart';


class Buslistscreen extends StatefulWidget {
  final add,
      adult,
      Pickup,
      dropoff,
      pickupdate,
      dropoffdate,
      pickuptime,
      dropoftime,
      children,
      infants,
      userId,
      currency,
      classtype;

  const Buslistscreen({
    super.key,
    required this.add,
    required this.adult,
    required this.children,
    required this.infants,
    required this.Pickup,
    required this.dropoff,
    required this.pickupdate,
    required this.dropoffdate,
    required this.pickuptime,
    required this.dropoftime,
    required this.userId,
    required this.currency,
    required this.classtype,
  });

  @override
  State<Buslistscreen> createState() => _OnewayFlightsListState();
}

class _OnewayFlightsListState extends State<Buslistscreen> {
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
  bool isRefundable = false;
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
  List<Map<String, String>> parseBoardingPoints(String? data) {
    if (data == null || data.isEmpty) return [];

    return data.split(',').map((e) {
      final parts = e.trim().split(RegExp(r'\s(?=\d)'));
      // splits before time (08:40 PM)

      return {
        'location': parts.isNotEmpty ? parts[0] : '',
        'time': parts.length > 1 ? parts[1] : '',
      };
    }).toList();
  }

  final List<Map<String, String>> boardingPoints = [
    {"location": "Koyambedu", "time": "06:25 PM"},
    {"location": "Porur", "time": "06:55 PM"},
    {"location": "Kilambakkam Bus Stand", "time": "07:40 PM"},
    {"location": "SRM University", "time": "07:50 PM"},
    {"location": "Chengalpattu", "time": "08:10 PM"},
    {"location": "Villupuram Bypass", "time": "10:10 PM"},
  ];

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
  List allVehicleMakeList = [];
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
  String formatTimeString(String time) {
    final parsed = DateFormat('h:mm a').parse(time);
    return DateFormat('hh:mm a').format(parsed);
  }
  void sendFlightSearchRequest(Map<String, dynamic> filters) async {
    DateTime parsedDate = DateTime.parse(widget.pickupdate);
    String finDate = DateFormat('dd-MM-yyyy').format(parsedDate);

    DateTime parsedDate1 = DateTime.parse(widget.dropoffdate);
    String dropoffdate = DateFormat('dd-MM-yyyy').format(parsedDate1);
    String pickuptime = formatTimeString(widget.pickuptime);
    String dropoftime = formatTimeString(widget.dropoftime);

    var requestBody = {
      'Origin': "2069",
      'Destination': "5504",
      'TravelDate': finDate,
    };
    print("📤 Sending Request Body:");
    requestBody.forEach((key, value) {
      print("➡️ $key : $value");
    });
    var url = Uri.parse(
        'https://lojatravel.com/app/b2badminapi.asmx/Bus1_List');

    try {
      setState(() {
        isLoading = true;
        resultList.clear();
      });

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: requestBody,
      );

      setState(() => isLoading = false);

      if (response.statusCode == 200) {
        print("✅ API Success");

        var document = xml.XmlDocument.parse(response.body);

        // Get all <string> nodes
        final stringNodes = document.findAllElements('string').toList();

        // 🔹 Bus Operators (optional)
        var operatorJson = stringNodes[0].text;
        List operatorList = json.decode(operatorJson);

        // 🔹 MAIN BUS RESULT DATA (IMPORTANT)
        var busResultJson = stringNodes[3].text;

        print("🚌 Bus Result JSON:\n$busResultJson");

        List<Map<String, dynamic>> busList =
        List<Map<String, dynamic>>.from(json.decode(busResultJson));

        setState(() {
          fullResultList = busList;
          resultList = List.from(busList);
        });

        print("🚍 FINAL BUS LIST COUNT: ${busList.length}");
      }

    } catch (e) {
      setState(() => isLoading = false);
      print("❌ Error: $e");
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
  String formatDateTime(String dateTime) {
    DateTime dt = DateTime.parse(dateTime);
    return DateFormat('dd/MM/yyyy hh:mm a').format(dt);
  }
  String safeFormatDateTime(dynamic value) {
    if (value == null) return '--';
    try {
      return DateFormat('dd/MM/yyyy hh:mm a')
          .format(DateTime.parse(value.toString()));
    } catch (e) {
      return '--';
    }
  }

  int expandedIndex = -1; // -1 = none expanded


  String safeText(dynamic value, [String fallback = '-']) {
    if (value == null) return fallback;
    if (value.toString().isEmpty) return fallback;
    return value.toString();
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
              "Available Bus",
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
        itemCount: 10,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListTile(
              leading: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 16, color: Colors.white),
                  const SizedBox(height: 6),
                  Container(height: 12, color: Colors.white),
                  const SizedBox(height: 6),
                  Container(height: 12, color: Colors.white),
                ],
              ),
            ),
          );
        },
      )
          :ListView.builder(
        controller: _scrollController,
        itemCount: resultList.length,
        itemBuilder: (context, index) {
          final item = resultList[index];

          final boardingPoints =
          parseBoardingPoints(item['BoardingPointsDetails']);

          final droppingPoints =
          parseBoardingPoints(item['DroppingPointsDetails']);

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🚌 TRAVEL NAME
                    Text(
                      safeText(item['TravelName']),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// BUS TYPE
                    Text(
                      safeText(item['BusType']),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// ⏰ DEPARTURE
                    Text(
                      "Departure: ${safeText(item['Origin'])},${safeFormatDateTime(item['DepartureTimeFormat'])}",
                      style: TextStyle( color: Colors.grey[700], fontSize: 13),
                    ),


                    const SizedBox(height: 6),

                    /// ARRIVAL + PRICE
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Arrival: ${safeText(item['Destination'])},${safeFormatDateTime(item['ArrivalTimeFormat'])}",
                                style:   TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 13,
                                ),
                              ),

                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${safeText(item['CurrencyCode'], 'INR')} ${safeText(item['BasePrice'], '0')}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),

                    const Divider(),

                    /// 🔽 SEATS | BOOK | BOARDING
                    Row(
                      children: [

                        Text(
                          "Seats: ${safeText(item['AvailableSeats'], '0')}",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const Spacer(),

                        GestureDetector(
                          onTap: () {
                            print("🚌 Selected Bus JSON ARRAY:");

                            // 👇 PRINT AS [{ }]
                            printJsonAsArray(item);

                            // 👇 SEND AS [{ }] TO NEXT PAGE
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SeatSelectionPage(
                                  BusJson: jsonEncode([item]), // 👈 IMPORTANT
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Select Seat",
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),




                        const Spacer(),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              expandedIndex =
                              expandedIndex == index ? -1 : index;
                            });
                          },
                          child: Row(
                            children: [
                              const Text(
                                "Boarding & Dropping",
                                style: TextStyle(fontSize: 12),
                              ),
                              AnimatedRotation(
                                turns: expandedIndex == index ? 0.5 : 0.0,
                                duration: const Duration(milliseconds: 200),
                                child: const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    /// 🔽 EXPAND CONTENT
                    AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      child: expandedIndex == index
                          ? Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// 🚏 BOARDING POINTS
                            const Text(
                              "Boarding Points",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 6),

                            boardingPoints.isNotEmpty
                                ? Column(
                              children: boardingPoints.map((point) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 2),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          safeText(point['location']),
                                          style:
                                          const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Text(
                                        safeText(point['time']),
                                        style:
                                        const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            )
                                : const Text(
                              "No boarding points available",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),

                            const Divider(),

                            /// 🏁 DROPPING POINTS
                            const Text(
                              "Dropping Points",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 6),

                            droppingPoints.isNotEmpty
                                ? Column(
                              children: droppingPoints.map((point) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 2),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          safeText(point['location']),
                                          style:
                                          const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Text(
                                        safeText(point['time']),
                                        style:
                                        const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            )
                                : const Text(
                              "No dropping points available",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),

                  ],
                ),
              ),
            ),
          );





        },
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


  void printJsonAsArray(Map<String, dynamic> item) {
    final List<Map<String, dynamic>> jsonArray = [item]; // 👈 wrap in []
    const encoder = JsonEncoder.withIndent('  ');
    debugPrint(encoder.convert(jsonArray), wrapWidth: 4096);
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

