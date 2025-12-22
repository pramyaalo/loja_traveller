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
import 'SeatModel.dart';


class SeatSelectionPage extends StatefulWidget {



  @override
  State<SeatSelectionPage> createState() => _OnewayFlightsListState();
}

class _OnewayFlightsListState extends State<SeatSelectionPage> with SingleTickerProviderStateMixin  {
  late List<Seat> lowerDeckSeats;
  late List<Seat> upperDeckSeats;
  bool isLoading = false;
  String? selectedSortOption = "Low to High";
  int selectedCount = 0;
  bool isNonStopSelected = false;
  bool DepartisEarlySelected = false;
  bool DepartisMorningSelected = false;
  bool DepartisNoonSelected = false;
  bool DepartisEveningSelected = false;
  late TabController _tabController;
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
    _tabController = TabController(length: 2, vsync: this);
    /// Dummy seats (API la irundhu varum)
    lowerDeckSeats = List.generate(
      16, // ✅ FIXED
          (i) => Seat(
        seatNo: "L${i + 1}",
        isSleeper: true,
        price: 899,
        status: i == 2 || i == 5
            ? SeatStatus.booked
            : SeatStatus.available,
      ),
    );


    upperDeckSeats = List.generate(
      16,
          (i) => Seat(
        seatNo: "U${i + 1}",
        isSleeper: true,
        price: 699,
        status: i == 3
            ? SeatStatus.femaleOnly
            : SeatStatus.available,
      ),
    );

  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  /// Selected seats
  List<Seat> get selectedSeats => [
    ...lowerDeckSeats.where((e) => e.isSelected),
    ...upperDeckSeats.where((e) => e.isSelected),
  ];
  Widget seatItem(Seat seat) {
    Color borderColor;
    Color bgColor = Colors.white;
    IconData? icon;

    switch (seat.status) {
      case SeatStatus.available:
        borderColor = Colors.green;
        break;
      case SeatStatus.booked:
        borderColor = Colors.grey;
        bgColor = Colors.grey.shade200;
        break;
      case SeatStatus.femaleOnly:
        borderColor = Colors.pink;
        icon = Icons.female;
        break;
      case SeatStatus.femaleOnly:
        borderColor = Colors.blue;
        icon = Icons.male;
        break;
    }

    if (seat.isSelected) {
      bgColor = Colors.green.withOpacity(0.15);
    }

    return GestureDetector(
      onTap: seat.status == SeatStatus.booked
          ? null
          : () {
        setState(() {
          seat.isSelected = !seat.isSelected;
        });
      },
      child: Column(
        children: [
          Container(
            height: seat.isSleeper ? 60 : 40,
            width: 35,
            decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: icon != null
                ? Icon(icon, size: 16, color: borderColor)
                : null,
          ),
          const SizedBox(height: 2),
          Text(
            "₹${seat.price.toInt()}",
            style: const TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
  Widget sleeperBerth(Seat seat) {
    final bool isBooked = seat.status == SeatStatus.booked;

    return GestureDetector(
      onTap: isBooked
          ? null
          : () {
        setState(() {
          seat.isSelected = !seat.isSelected;
        });
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(2  ),
            height: 60,
            width: 50,
            decoration: BoxDecoration(
              color: seat.isSelected
                  ? Colors.green.withOpacity(0.25)
                  : isBooked
                  ? Colors.grey.shade300
                  : Colors.white,
              border: Border.all(
                color: seat.isSelected
                    ? Colors.green
                    : isBooked
                    ? Colors.grey
                    : Colors.green,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                seat.seatNo,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Text(
            "₹${seat.price.toInt()}",
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
  static const double seatWidth = 60;
  static const double smallGap = 16;
  static const double aisleGap = 28;

  static const double leftBlockWidth =
      seatWidth * 3 + smallGap; // ✅ FIXED

  Widget sleeperRow({
    Widget? left1,
    Widget? left2,
    Widget? right,
    bool isLastRow = false, // 👈 ADD THIS
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT BLOCK
          SizedBox(
            width: isLastRow
                ? seatWidth // 👈 ONLY ONE SEAT WIDTH
                : leftBlockWidth, // normal rows
            child: Row(
              children: [
                if (left1 != null) left1,
                if (!isLastRow && left2 != null)
                  SizedBox(width: smallGap),
                if (!isLastRow && left2 != null) left2,
              ],
            ),
          ),

          // AISLE (only for normal rows)
          if (!isLastRow) SizedBox(width: aisleGap),

          // RIGHT SIDE (only for normal rows)
          if (!isLastRow)
            SizedBox(
              width: seatWidth,
              child: right ?? const SizedBox(),
            ),
        ],
      ),
    );
  }









  Widget seatGrid(List<Seat> seats) {
    final isSleeperBus = seats.isNotEmpty && seats.first.isSleeper;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isSleeperBus ? 3 : 4,

        // 🔥 IMPORTANT FIX
        mainAxisExtent: isSleeperBus ? 80 : 40,

        // 🔥 NO GAP
        mainAxisSpacing: 25,
        crossAxisSpacing: 0,
      ),
      itemCount: seats.length,
      itemBuilder: (context, index) {
        return seatItem(seats[index]);
      },
    );
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


    var requestBody = {
      'Origin': "2069",
      'Destination': "5504",
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
  Seat getUpperSeat(String seatNo) {
    return upperDeckSeats.firstWhere(
          (e) => e.seatNo == seatNo,
      orElse: () => throw Exception("Seat $seatNo not found"),
    );
  }

  Widget upperDeckLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sleeperRow(
          left1: sleeperBerth(getUpperSeat('U1')),
          left2: sleeperBerth(getUpperSeat('U2')),
          right: sleeperBerth(getUpperSeat('U3')),
        ),
        sleeperRow(
          left1: sleeperBerth(getUpperSeat('U4')),
          left2: sleeperBerth(getUpperSeat('U5')),
          right: sleeperBerth(getUpperSeat('U6')),
        ),
        sleeperRow(
          left1: sleeperBerth(getUpperSeat('U7')),
          left2: sleeperBerth(getUpperSeat('U8')),
          right: sleeperBerth(getUpperSeat('U9')),
        ),
        sleeperRow(
          left1: sleeperBerth(getUpperSeat('U10')),
          left2: sleeperBerth(getUpperSeat('U11')),
          right: sleeperBerth(getUpperSeat('U12')),
        ),
        sleeperRow(
          left1: sleeperBerth(getUpperSeat('U13')),
          left2: sleeperBerth(getUpperSeat('U14')),
          right: sleeperBerth(getUpperSeat('U15')),
        ),
        sleeperRow(
          left1: sleeperBerth(getUpperSeat('U16')),
        ),
      ],
    );
  }

  Seat getLowerSeat(String seatNo) {
    return lowerDeckSeats.firstWhere(
          (e) => e.seatNo == seatNo,
      orElse: () => throw Exception("Seat $seatNo not found"),
    );
  }


  Widget lowerDeckLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sleeperRow(
          left1: sleeperBerth(getLowerSeat('L1')),
          left2: sleeperBerth(getLowerSeat('L2')),
          right: sleeperBerth(getLowerSeat('L3')),
        ),
        sleeperRow(
          left1: sleeperBerth(getLowerSeat('L4')),
          left2: sleeperBerth(getLowerSeat('L5')),
          right: sleeperBerth(getLowerSeat('L6')),
        ),
        sleeperRow(
          left1: sleeperBerth(getLowerSeat('L7')),
          left2: sleeperBerth(getLowerSeat('L8')),
          right: sleeperBerth(getLowerSeat('L9')),
        ),
        sleeperRow(
          left1: sleeperBerth(getLowerSeat('L10')),
          left2: sleeperBerth(getLowerSeat('L11')),
          right: sleeperBerth(getLowerSeat('L12')),
        ),
        sleeperRow(
          left1: sleeperBerth(getLowerSeat('L13')),
          left2: sleeperBerth(getLowerSeat('L14')),
          right: sleeperBerth(getLowerSeat('L15')),
        ),
        sleeperRow(
          left1: sleeperBerth(getLowerSeat('L16')),
        ),
      ],
    );
  }


  String safeText(dynamic value, [String fallback = '-']) {
    if (value == null) return fallback;
    if (value.toString().isEmpty) return fallback;
    return value.toString();
  }
  int selectedDeck = 0; // 0 = Lower, 1 = Upper
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final totalPrice =
    selectedSeats.fold(0.0, (sum, e) => sum + e.price);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00ADEE),
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 27,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 4),
            const Text(
              "Select Seats",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset(
              'assets/images/lojologg.png',
              width: 90,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        ],

        // 👇 TAB BAR
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(30),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                tabs: const [
                  Tab(text: "Lower Deck"),
                  Tab(text: "Upper Deck"),
                ],
              ),
            ),
          ),
        ),
      ),


      body: TabBarView(
        controller: _tabController,
        children: [

          /// 🟢 LOWER DECK (REAL BUS)
          SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Lower Deck (Sleeper Berths)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                lowerDeckLayout(),
              ],
            ),
          ),

          /// 🔵 UPPER DECK (REAL BUS)
          SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Upper Deck (Sleeper Berths)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 12),
                upperDeckLayout(),
              ],
            ),
          ),
        ],
      ),


      /// 🔻 BOTTOM BAR
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "₹${totalPrice.toInt()} | ${selectedSeats.length} Seats",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: selectedSeats.isEmpty ? null : () {},
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
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

