import 'dart:async';
import 'dart:convert';
import 'dart:developer';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../AdultDatabaseHelperCass.dart';
import '../../Booking/FamilyMembersModel.dart';
import '../../Booking/TwoWayBoardingFlightsList.dart';
import '../../DatabseHelper.dart';
import '../../Models/hotel_destination_models.dart';
import '../../Models/passenger_ddl_model.dart';

import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';
import 'AddTravellers_Flight.dart';
import 'Children_DatabaseHelper.dart';
import 'FlightScreenModel.dart';
import 'InfantDatabaseHelper.dart';
import 'multicity_flight_list.dart';
import 'one_way_flight_list.dart';

class FlightScreen extends StatefulWidget {
  const FlightScreen({Key? key}) : super(key: key);

  @override
  _FlightsScreenState createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightScreen> {
  bool isSwapped = false;
  bool __shouldShowReturn = true;
  bool __ToDestination = true;

  List<TripData> trips = [];
  String FinalOutput = 'Departure',
      FinalOutPut1 = 'Arrival',
      SelectionValue = '',
      fromCountry = '',
      SelectionValue1 = '',
      FinalOutputMulti = 'Departure',
      FinalOutput1Multi = 'Arrival',
      FinalOutputMultiSecond = 'Departure',
      FinalOutput1MultiSecond = 'Arrival',
      FinalOutputMultiThird = 'Departure',
      FinalOutput1MultiThird = 'Arrival',
      FinalOutputMultiFourth = '',
      FinalOutput1MultiFourth = '',
      OriginPlace = '',
      DestinationPlace = '';
  String selectedDate4 = '';
  bool isMulti = false;
  bool _isPassengersLoading = true;
  String Economy = '',
      PremiumEconomy = '',
      Business = '',
      isFirstSelected = '',
      selectedClass = '';
  int selectedClassId=0;
  int AdultCount = 1, childrenCount = 0, infantsCount = 0;
  String displayText1 = '';
  static String _displayOptionForPassengerDDl(PassengerDDL passengerDDL) =>
      passengerDDL.Name;
  bool isCityAdded = false;
  String validateField(String value) {
    if (value == 'Departure' || value == 'Arrival') {
      return '';
    }
    return value;
  }

  void toggleCity() {
    setState(() {
      if (isCityAdded) {
        // If a city is already added, remove the last box
        trips.removeLast();
      } else {
        // If no city is added, add a new box
        trips.add(TripData(from: '', to: '', date: null));
      }
      // Toggle the state of isCityAdded
      isCityAdded = !isCityAdded;
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
      await dbHelper.deleteAllRecords('children'); // Adjust table name if needed



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
  TextEditingController orginController = new TextEditingController();
  TextEditingController orginController1 = new TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController destinationController = new TextEditingController();
  TextEditingController destinationController1 = new TextEditingController();

  //String tripValue = 'Round trip';
  List tripOptions = [
    {"Id": 0, "Name": "Round trip"},
    {"Id": 1, "Name": "One Way"},
    {"Id": 2, "Name": "Multi-City"},
  ];
  Future<List<FlightScreenModel>> fetchAutocompleteData(String empName) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/FlightAirportAutocomplete?empName=$empName';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final xmlDocument = xml.XmlDocument.parse(response.body);
      final responseData = xmlDocument.findAllElements('string').first.text;

      final decodedData = json.decode(responseData);
      return decodedData
          .map<FlightScreenModel>((data) => FlightScreenModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load autocomplete data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    orginController.text = 'DEL';
    destinationController.text = 'MAA';
    orginController1.text = 'MAA';
    destinationController1.text = 'DXB';

    //searchBookingTravellers();
    tTripType = '1';
    isSelected = true;
    __shouldShowReturn = false;
    __ToDestination = false;
    //_loadSavedString();
    if (selectedClass == '') {
      selectedClass = 'Economy';
    }
    _retrieveSavedValues();
    super.initState();
  }

  _saveString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setInt('adultsCount', AdultCount);
    prefs.setInt('childrenCount', childrenCount);
    prefs.setInt('infantsCount', infantsCount);
    setState(() {
      prefs.setString('isEconomySelected', Economy);
      prefs.setString('PremiumEconomy', PremiumEconomy);
      prefs.setString('Business', Business);
      prefs.setString('isFirstSelected', isFirstSelected);
    });
  }

  List businessClass = [
    {"Id": 1, "Name": "All"},
    {"Id": 2, "Name": "Economy"},
    {"Id": 3, "Name": "PremiumEconomy"},
    {"Id": 4, "Name": "Business"},
    {"Id": 5, "Name": "PremiumBusiness"},
    {"Id": 6, "Name": "First"},
  ];
  String firstDropdownValue = '0';
  String secondDropdownValue = '0';
  String thirdDropdownValue = '0';

  List<String> numbers = List.generate(10, (index) => index.toString());

  List<String> commonOptions = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  var tClassType = '0';
  var tpolicyID = '-1';
  String tTripType = '0';
  var tFromCity = '';
  var tToCity = '';
  var tDepartDate = '';
  var tReturnDate = '';
  var tuserID = '';
  var tCorporateId = '';
  var tjsonTraveller = '';
  var tDefaultCurrency = 'SAR';

  DateTime selecteddDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime selectedReturnDate = DateTime.now();

  DateTime selecteddDate1 = DateTime.now();
  DateTime selecteddDate2 = DateTime.now();
  DateTime? selecteddDate3;
  DateTime? selecteddDate4;

  String formatSelectedDate(DateTime? date) {
    return date != null ? DateFormat('yyyy-MM-dd').format(date) : '';
  }


  Future<void> _selectDate(BuildContext context, int type) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now, // Disable past dates
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(data: ThemeData.light().copyWith(

          colorScheme: const ColorScheme.light(primary: Color(0xFF00ADEE)),
          datePickerTheme: const DatePickerThemeData(
            backgroundColor: Colors.white,
            dividerColor: Color(0xFF00ADEE),
            headerBackgroundColor: Color(0xFF00ADEE),
            headerForegroundColor: Colors.white, // Custom primary color
          ),), child: child!,


        );
      },
    );
    if (picked != null && picked != now) {
      setState(() {
        // Update selected date based on the type
        if (type == 1) {
          selecteddDate = picked;
        } else if (type == 2) {
          selectedReturnDate = picked;
        } else if (type == 3) {
          selectedDate = picked;
        } else if (type == 4) {
          selecteddDate1 = picked;
        } else if (type == 5) {
          selecteddDate2 = picked;
        } else if (type == 6) {
          selecteddDate3 = picked;
        } else {
          selecteddDate4 = picked;
        }
      });
    }
  }

  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';

  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
      print('Currsdency: $Currency');
      // Call sendFlightSearchRequest() here after SharedPreferences values are retrieved
    });
  }

  bool isSelected = false;
  bool isSelected1 = false;
  bool isSelected2 = false;

  @override
  Widget build(BuildContext context) {
    void navigate(Widget screen) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => screen));
    }

    if (Economy != '') {
      displayText1 = Economy;
      print('Is Economy Selected: $displayText1');
    }
    if (PremiumEconomy != '') {
      displayText1 = PremiumEconomy;
      print('Is Economy Selected: $displayText1');
    }
    if (Business != '') {
      displayText1 = Business;
      print('Is Economy Selected: $displayText1');
    }
    if (isFirstSelected != '') {
      displayText1 = isFirstSelected;
      print('Is Economy Selected: $displayText1');
    }
    String adultsText = AdultCount > 1 ? '$AdultCount Adults' : '1 Adult';
    String childrenText = childrenCount > 0 ? '$childrenCount Children' : '';
    String InfantCount = infantsCount > 0 ? '$infantsCount Infants' : '';

    String Adult = '$adultsText ';
    String Children = '$childrenText';
    String Infants = '$InfantCount';
    String _travelPolicyValue = 'Policy 1';
    var _travelPolicy = [
      'Policy 1',
      'Policy 2',
    ];

    var travelPolicy = ['-- Select --'];

    List hotelDestination = [
      HotelDestination(
          title: "Month End Off",
          subtitle: "80% offer for this month",
          image:
          "https://www.yatra.com/ythomepagecms/media/todayspick/2020/Oct/98d57b3ddef131c2160085fff31776a1.jpg"),
      HotelDestination(
          title: "Coupons",
          subtitle: "Offer upto Rs.7000",
          image:
          "https://cdn.via.com/static/img/v1/newui/sg/general/offer/1503382796693_InternationalFlight_Offer_21.jpg"),
      HotelDestination(
          title: "Offers",
          subtitle: "Air India Offers",
          image:
          "https://www.airindia.in/writereaddata/Portal/CMS_Template_Banner/8_1_special-offer-banner.jpg"),
    ];

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
              "Flight Booking",
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
      body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          tTripType = '1';
                                          __shouldShowReturn = false;
                                          __ToDestination = false;
                                          isSelected = true;
                                          isSelected1 = false;
                                          isSelected2 = false;
                                          print('object' + tTripType!.toString());
                                        });
                                      },
                                      child: Container(
                                        width: 97,
                                        padding: EdgeInsets.only(
                                            left: 5, bottom: 6, right: 5, top: 6),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.blue.shade50
                                              : Colors.white,
                                          border: Border.all(
                                              color: isSelected
                                                  ? Color(0xFF00ADEE)
                                                  : Colors.grey),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'One-way',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? Color(0xFF00ADEE)
                                                : Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          tTripType = '0';
                                          __shouldShowReturn = true;
                                          __ToDestination = true;
                                          isSelected1 = true;
                                          isSelected = false;
                                          isSelected2 = false;
                                          print('object' + isSelected1!.toString());
                                        });
                                      },
                                      child: Container(
                                        width: 97,
                                        padding: EdgeInsets.only(
                                            left: 5, bottom: 6, right: 5, top: 6),
                                        decoration: BoxDecoration(
                                          color: isSelected1
                                              ? Colors.blue.shade50
                                              : Colors.white,
                                          border: Border.all(
                                              color: isSelected1
                                                  ? Color(0xFF00ADEE)
                                                  : Colors.grey),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Roundtrip',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected1
                                                ? Color(0xFF00ADEE)
                                                : Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          tTripType = '2';
                                          isSelected1 = false;
                                          isSelected = false;
                                          isSelected2 = true;
                                          print('objecwdewet' +
                                              isSelected2!.toString());
                                        });
                                      },
                                      child: Container(
                                        width: 97,
                                        padding: EdgeInsets.only(
                                            left: 5, bottom: 6, right: 5, top: 6),
                                        decoration: BoxDecoration(
                                          color: isSelected2
                                              ? Colors.blue.shade50
                                              : Colors.white,
                                          border: Border.all(
                                              color: isSelected2
                                                  ? Color(0xFF00ADEE)
                                                  : Colors.grey),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Multi-City',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected2
                                                ? Color(0xFF00ADEE)
                                                : Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (tTripType == '1')
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, top: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              FinalOutput,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 27,
                                          child: Autocomplete<FlightScreenModel>(
                                            // Autocomplete widget for "From"
                                            optionsBuilder: (TextEditingValue
                                            textEditingValue) async {
                                              if (textEditingValue.text.isEmpty) {
                                                return const Iterable<
                                                    FlightScreenModel>.empty();
                                              }
                                              return await fetchAutocompleteData(
                                                  textEditingValue.text);
                                            },
                                            displayStringForOption: (FlightScreenModel
                                            option) =>
                                            '${option.name}, ${option.id}, ${option.iso_country}',
                                            onSelected: (FlightScreenModel?
                                            selectedOption) {
                                              if (selectedOption != null) {
                                                print(
                                                    'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                setState(() {
                                                  FinalOutput = selectedOption.id;
                                                  OriginPlace =
                                                      selectedOption.iso_country;
                                                  SelectionValue =
                                                      selectedOption.name;
                                                });
                                                // Do something with the selected option
                                              }
                                            },
                                            fieldViewBuilder: (context, controller,
                                                focusNode, onFieldSubmitted) {
                                              return TextFormField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                onFieldSubmitted: (String value) {
                                                  // Your logic here
                                                },
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: 'From',
                                                  isDense: true,
                                                  contentPadding:
                                                  EdgeInsets.only(top: 0),
                                                  border: InputBorder.none,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.1,
                                        color: Colors.grey,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10, top: 8),
                                        child: Text(
                                          FinalOutPut1,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 27,
                                          child: Autocomplete<FlightScreenModel>(
                                            // Autocomplete widget for "To"
                                            optionsBuilder: (TextEditingValue
                                            textEditingValue) async {
                                              if (textEditingValue.text.isEmpty) {
                                                return const Iterable<
                                                    FlightScreenModel>.empty();
                                              }
                                              return await fetchAutocompleteData(
                                                  textEditingValue.text);
                                            },
                                            displayStringForOption: (FlightScreenModel
                                            option) =>
                                            '${option.name}, ${option.id}, ${option.iso_country}',
                                            onSelected: (FlightScreenModel?
                                            selectedOption) {
                                              if (selectedOption != null) {
                                                print(
                                                    'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                setState(() {
                                                  FinalOutPut1 = selectedOption.id;
                                                  DestinationPlace =
                                                      selectedOption.municipality;
                                                });
                                                // Do something with the selected option
                                              }
                                            },
                                            fieldViewBuilder: (context, controller,
                                                focusNode, onFieldSubmitted) {
                                              return TextFormField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                onFieldSubmitted: (String value) {
                                                  // Your logic here
                                                },
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: 'To',
                                                  isDense: true,
                                                  contentPadding:
                                                  EdgeInsets.only(top: 0),
                                                  border: InputBorder.none,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.1,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Depart",
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      _selectDate(context, 1);
                                                    },
                                                    child: Text(
                                                      "${selecteddDate.toLocal()}"
                                                          .split(' ')[0],
                                                      style: TextStyle(
                                                          fontFamily: "Montserrat",
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Saturday",
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: __shouldShowReturn
                                                  ? () {
                                                // Handle the tap when __shouldShowReturn is true
                                                _selectDate(context, 2);
                                              }
                                                  : null, // Set onTap to null when __shouldShowReturn is false
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Return",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    __shouldShowReturn
                                                        ? "${selectedReturnDate.toLocal()}"
                                                        .split(' ')[0]
                                                        : "Select Date",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: __shouldShowReturn
                                                          ? Colors.black
                                                          : Colors.black38,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    __shouldShowReturn
                                                        ? "Friday"
                                                        : "book return",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                if (tTripType == '0')
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, top: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Display FinalOutput or FinalOutPut1 based on isSwapped
                                            Text(
                                              isSwapped
                                                  ? FinalOutPut1
                                                  : FinalOutput,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 27,
                                          child: Autocomplete<FlightScreenModel>(
                                            // Autocomplete widget for "From"
                                            optionsBuilder: (TextEditingValue
                                            textEditingValue) async {
                                              if (textEditingValue.text.isEmpty) {
                                                return const Iterable<
                                                    FlightScreenModel>.empty();
                                              }
                                              return await fetchAutocompleteData(
                                                  textEditingValue.text);
                                            },
                                            displayStringForOption: (FlightScreenModel
                                            option) =>
                                            '${option.name}, ${option.id}, ${option.iso_country}',
                                            onSelected: (FlightScreenModel?
                                            selectedOption) {
                                              if (selectedOption != null) {
                                                print(
                                                    'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                setState(() {
                                                  FinalOutput = selectedOption.id;
                                                  OriginPlace =
                                                      selectedOption.iso_country;
                                                  SelectionValue =
                                                      selectedOption.name;
                                                });
                                                // Do something with the selected option
                                              }
                                            },
                                            fieldViewBuilder: (context, controller,
                                                focusNode, onFieldSubmitted) {
                                              return TextFormField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                onFieldSubmitted: (String value) {
                                                  // Your logic here
                                                },
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: 'From',
                                                  isDense: true,
                                                  contentPadding:
                                                  EdgeInsets.only(top: 0),
                                                  border: InputBorder.none,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.1,
                                        color: Colors.grey,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10, top: 8),
                                        child: Text(
                                          isSwapped ? FinalOutput : FinalOutPut1,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 27,
                                          child: Autocomplete<FlightScreenModel>(
                                            // Autocomplete widget for "To"
                                            optionsBuilder: (TextEditingValue
                                            textEditingValue) async {
                                              if (textEditingValue.text.isEmpty) {
                                                return const Iterable<
                                                    FlightScreenModel>.empty();
                                              }
                                              return await fetchAutocompleteData(
                                                  textEditingValue.text);
                                            },
                                            displayStringForOption: (FlightScreenModel
                                            option) =>
                                            '${option.name}, ${option.id}, ${option.iso_country}',
                                            onSelected: (FlightScreenModel?
                                            selectedOption) {
                                              if (selectedOption != null) {
                                                print(
                                                    'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                setState(() {
                                                  FinalOutPut1 = selectedOption.id;
                                                  DestinationPlace =
                                                      selectedOption.iso_country;
                                                });
                                                // Do something with the selected option
                                              }
                                            },
                                            fieldViewBuilder: (context, controller,
                                                focusNode, onFieldSubmitted) {
                                              return TextFormField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                onFieldSubmitted: (String value) {
                                                  // Your logic here
                                                },
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: 'To',
                                                  isDense: true,
                                                  contentPadding:
                                                  EdgeInsets.only(top: 0),
                                                  border: InputBorder.none,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.1,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Depart",
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      _selectDate(context, 1);
                                                    },
                                                    child: Text(
                                                      "${selecteddDate.toLocal()}"
                                                          .split(' ')[0],
                                                      style: TextStyle(
                                                          fontFamily: "Montserrat",
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Saturday",
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: __shouldShowReturn
                                                  ? () {
                                                // Handle the tap when __shouldShowReturn is true
                                                _selectDate(context, 2);
                                              }
                                                  : null, // Set onTap to null when __shouldShowReturn is false
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Return",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    __shouldShowReturn
                                                        ? "${selectedReturnDate.toLocal()}"
                                                        .split(' ')[0]
                                                        : "Select Date",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: __shouldShowReturn
                                                          ? Colors.black
                                                          : Colors.black38,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    __shouldShowReturn
                                                        ? "Friday"
                                                        : "book return",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w500,
                                                    ),
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
                                  width: double.infinity,
                                  height: 0.1,
                                  color: Colors.grey,
                                ),
                                Visibility(
                                  visible: tTripType == '2',
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10,
                                                        bottom: 4,
                                                        top: 10),
                                                    child: Text(
                                                      isSwapped
                                                          ? FinalOutput
                                                          : FinalOutput,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10),
                                                    child: Container(
                                                      height: 27,
                                                      width: 75,
                                                      child: Autocomplete<
                                                          FlightScreenModel>(
                                                        optionsBuilder:
                                                            (TextEditingValue
                                                        textEditingValue) async {
                                                          if (textEditingValue
                                                              .text.isEmpty) {
                                                            return const Iterable<
                                                                FlightScreenModel>.empty();
                                                          }
                                                          return await fetchAutocompleteData(
                                                              textEditingValue
                                                                  .text);
                                                        },
                                                        displayStringForOption:
                                                            (FlightScreenModel
                                                        option) =>
                                                        '${option.name}, ${option.id}, ${option.iso_country}',
                                                        onSelected:
                                                            (FlightScreenModel?
                                                        selectedOption) {
                                                          if (selectedOption !=
                                                              null) {
                                                            print(
                                                                'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                            setState(() {
                                                              FinalOutput =
                                                                  selectedOption.id;
                                                              OriginPlace =
                                                                  selectedOption
                                                                      .iso_country;
                                                              SelectionValue =
                                                                  selectedOption
                                                                      .name;
                                                            });
                                                          }
                                                        },
                                                        fieldViewBuilder: (context,
                                                            controller,
                                                            focusNode,
                                                            onFieldSubmitted) {
                                                          return TextFormField(
                                                            controller: controller,
                                                            focusNode: focusNode,
                                                            onFieldSubmitted:
                                                                (String value) {
                                                              // Your logic here
                                                            },
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              color: Colors.black54,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                            ),
                                                            decoration:
                                                            InputDecoration(
                                                              hintText: 'From',
                                                              isDense: true,
                                                              contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 0),
                                                              border:
                                                              InputBorder.none,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 4, top: 10),
                                                    child: Text(
                                                      isSwapped
                                                          ? FinalOutPut1
                                                          : FinalOutPut1,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 27,
                                                    width: 75,
                                                    child: Autocomplete<
                                                        FlightScreenModel>(
                                                      optionsBuilder: (TextEditingValue
                                                      textEditingValue) async {
                                                        if (textEditingValue
                                                            .text.isEmpty) {
                                                          return const Iterable<
                                                              FlightScreenModel>.empty();
                                                        }
                                                        return await fetchAutocompleteData(
                                                            textEditingValue.text);
                                                      },
                                                      displayStringForOption:
                                                          (FlightScreenModel
                                                      option) =>
                                                      '${option.name}, ${option.id}, ${option.iso_country}',
                                                      onSelected:
                                                          (FlightScreenModel?
                                                      selectedOption) {
                                                        if (selectedOption !=
                                                            null) {
                                                          print(
                                                              'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                          setState(() {
                                                            FinalOutPut1 =
                                                                selectedOption.id;
                                                            DestinationPlace =
                                                                selectedOption
                                                                    .municipality;
                                                          });
                                                        }
                                                      },
                                                      fieldViewBuilder: (context,
                                                          controller,
                                                          focusNode,
                                                          onFieldSubmitted) {
                                                        return TextFormField(
                                                          controller: controller,
                                                          focusNode: focusNode,
                                                          onFieldSubmitted:
                                                              (String value) {
                                                            // Your logic here
                                                          },
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            color: Colors.black54,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                          ),
                                                          decoration:
                                                          InputDecoration(
                                                            hintText: 'To',
                                                            isDense: true,
                                                            contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0),
                                                            border:
                                                            InputBorder.none,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      _selectDate(context, 4);
                                                    },
                                                    child: Container(
                                                      width: 75,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 0, top: 5),
                                                        child: Text(
                                                          selecteddDate1 != null
                                                              ? DateFormat('dd-MMM')
                                                              .format(
                                                              selecteddDate1!)
                                                              : '',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    25, // Adjust the height as needed
                                                    child: Container(
                                                      width: 75,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 0),
                                                        child: TextField(
                                                          onTap: () {
                                                            _selectDate(context, 4);
                                                          },
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.black54,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                          controller:
                                                          TextEditingController(
                                                            text: selecteddDate1 !=
                                                                null
                                                                ? DateFormat('yyyy')
                                                                .format(
                                                                selecteddDate1!)
                                                                : '',
                                                          ),
                                                          readOnly: true,
                                                          decoration:
                                                          InputDecoration(
                                                            border:
                                                            InputBorder.none,
                                                            hintText: 'Select Year',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.1,
                                        color: Colors.grey,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10,
                                                        bottom: 4,
                                                        top: 10),
                                                    child: Text(
                                                      isSwapped
                                                          ? FinalOutputMultiSecond
                                                          : FinalOutputMultiSecond,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10),
                                                    child: Container(
                                                      height: 27,
                                                      width: 75,
                                                      child: Autocomplete<
                                                          FlightScreenModel>(
                                                        optionsBuilder:
                                                            (TextEditingValue
                                                        textEditingValue) async {
                                                          if (textEditingValue
                                                              .text.isEmpty) {
                                                            return const Iterable<
                                                                FlightScreenModel>.empty();
                                                          }
                                                          return await fetchAutocompleteData(
                                                              textEditingValue
                                                                  .text);
                                                        },
                                                        displayStringForOption:
                                                            (FlightScreenModel
                                                        option) =>
                                                        '${option.name}, ${option.id}, ${option.iso_country}',
                                                        onSelected:
                                                            (FlightScreenModel?
                                                        selectedOption) {
                                                          if (selectedOption !=
                                                              null) {
                                                            print(
                                                                'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                            setState(() {
                                                              FinalOutputMultiSecond =
                                                                  selectedOption.id;
                                                              OriginPlace =
                                                                  selectedOption
                                                                      .iso_country;
                                                              SelectionValue =
                                                                  selectedOption
                                                                      .name;
                                                            });
                                                          }
                                                        },
                                                        fieldViewBuilder: (context,
                                                            controller,
                                                            focusNode,
                                                            onFieldSubmitted) {
                                                          return TextFormField(
                                                            controller: controller,
                                                            focusNode: focusNode,
                                                            onFieldSubmitted:
                                                                (String value) {
                                                              // Your logic here
                                                            },
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              color: Colors.black54,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                            ),
                                                            decoration:
                                                            InputDecoration(
                                                              hintText: 'From',
                                                              isDense: true,
                                                              contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 0),
                                                              border:
                                                              InputBorder.none,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 4, top: 10),
                                                    child: Text(
                                                      isSwapped
                                                          ? FinalOutputMultiSecond
                                                          : FinalOutput1MultiSecond,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 27,
                                                    width: 75,
                                                    child: Autocomplete<
                                                        FlightScreenModel>(
                                                      optionsBuilder: (TextEditingValue
                                                      textEditingValue) async {
                                                        if (textEditingValue
                                                            .text.isEmpty) {
                                                          return const Iterable<
                                                              FlightScreenModel>.empty();
                                                        }
                                                        return await fetchAutocompleteData(
                                                            textEditingValue.text);
                                                      },
                                                      displayStringForOption:
                                                          (FlightScreenModel
                                                      option) =>
                                                      '${option.name}, ${option.id}, ${option.iso_country}',
                                                      onSelected:
                                                          (FlightScreenModel?
                                                      selectedOption) {
                                                        if (selectedOption !=
                                                            null) {
                                                          print(
                                                              'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                          setState(() {
                                                            FinalOutput1MultiSecond =
                                                                selectedOption.id;
                                                            DestinationPlace =
                                                                selectedOption
                                                                    .iso_country;
                                                          });
                                                        }
                                                      },
                                                      fieldViewBuilder: (context,
                                                          controller,
                                                          focusNode,
                                                          onFieldSubmitted) {
                                                        return TextFormField(
                                                          controller: controller,
                                                          focusNode: focusNode,
                                                          onFieldSubmitted:
                                                              (String value) {
                                                            // Your logic here
                                                          },
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            color: Colors.black54,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                          ),
                                                          decoration:
                                                          InputDecoration(
                                                            hintText: 'To',
                                                            isDense: true,
                                                            contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0),
                                                            border:
                                                            InputBorder.none,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      _selectDate(context, 5);
                                                    },
                                                    child: Container(
                                                      width: 75,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 0, top: 5),
                                                        child: Text(
                                                          selecteddDate2 != null
                                                              ? DateFormat('dd-MMM')
                                                              .format(
                                                              selecteddDate2!)
                                                              : '',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    25, // Adjust the height as needed
                                                    child: Container(
                                                      width: 75,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 0),
                                                        child: TextField(
                                                          onTap: () {
                                                            _selectDate(context, 5);
                                                          },
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.black54,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                          controller:
                                                          TextEditingController(
                                                            text: selecteddDate2 !=
                                                                null
                                                                ? DateFormat('yyyy')
                                                                .format(
                                                                selecteddDate2!)
                                                                : '',
                                                          ),
                                                          readOnly: true,
                                                          decoration:
                                                          InputDecoration(
                                                            border:
                                                            InputBorder.none,
                                                            hintText: 'Select Year',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.1,
                                        color: Colors.grey,
                                      ),
                                      Column(
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            bottom: 4,
                                                            top: 10),
                                                        child: Text(
                                                          isSwapped
                                                              ? FinalOutputMultiThird
                                                              : FinalOutputMultiThird,
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                        child: Container(
                                                          height: 27,
                                                          width: 75,
                                                          child: Autocomplete<
                                                              FlightScreenModel>(
                                                            optionsBuilder:
                                                                (TextEditingValue
                                                            textEditingValue) async {
                                                              if (textEditingValue
                                                                  .text.isEmpty) {
                                                                return const Iterable<
                                                                    FlightScreenModel>.empty();
                                                              }
                                                              return await fetchAutocompleteData(
                                                                  textEditingValue
                                                                      .text);
                                                            },
                                                            displayStringForOption:
                                                                (FlightScreenModel
                                                            option) =>
                                                            '${option.name}, ${option.id}, ${option.iso_country}',
                                                            onSelected:
                                                                (FlightScreenModel?
                                                            selectedOption) {
                                                              if (selectedOption !=
                                                                  null) {
                                                                print(
                                                                    'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                                setState(() {
                                                                  FinalOutputMultiThird =
                                                                      selectedOption
                                                                          .id;
                                                                  OriginPlace =
                                                                      selectedOption
                                                                          .iso_country;
                                                                  SelectionValue =
                                                                      selectedOption
                                                                          .name;
                                                                });
                                                              }
                                                            },
                                                            fieldViewBuilder: (context,
                                                                controller,
                                                                focusNode,
                                                                onFieldSubmitted) {
                                                              return TextFormField(
                                                                controller:
                                                                controller,
                                                                focusNode:
                                                                focusNode,
                                                                onFieldSubmitted:
                                                                    (String value) {
                                                                  // Your logic here
                                                                },
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                ),
                                                                decoration:
                                                                InputDecoration(
                                                                  hintText: 'From',
                                                                  isDense: true,
                                                                  contentPadding:
                                                                  EdgeInsets
                                                                      .only(
                                                                      top:
                                                                      0),
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            bottom: 4, top: 10),
                                                        child: Text(
                                                          isSwapped
                                                              ? FinalOutput1MultiThird
                                                              : FinalOutput1MultiThird,
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 27,
                                                        width: 75,
                                                        child: Autocomplete<
                                                            FlightScreenModel>(
                                                          optionsBuilder:
                                                              (TextEditingValue
                                                          textEditingValue) async {
                                                            if (textEditingValue
                                                                .text.isEmpty) {
                                                              return const Iterable<
                                                                  FlightScreenModel>.empty();
                                                            }
                                                            return await fetchAutocompleteData(
                                                                textEditingValue
                                                                    .text);
                                                          },
                                                          displayStringForOption:
                                                              (FlightScreenModel
                                                          option) =>
                                                          '${option.name}, ${option.id}, ${option.iso_country}',
                                                          onSelected:
                                                              (FlightScreenModel?
                                                          selectedOption) {
                                                            if (selectedOption !=
                                                                null) {
                                                              print(
                                                                  'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                              setState(() {
                                                                FinalOutput1MultiThird =
                                                                    selectedOption
                                                                        .id;
                                                                DestinationPlace =
                                                                    selectedOption
                                                                        .iso_country;
                                                              });
                                                            }
                                                          },
                                                          fieldViewBuilder: (context,
                                                              controller,
                                                              focusNode,
                                                              onFieldSubmitted) {
                                                            return TextFormField(
                                                              controller:
                                                              controller,
                                                              focusNode: focusNode,
                                                              onFieldSubmitted:
                                                                  (String value) {
                                                                // Your logic here
                                                              },
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                color:
                                                                Colors.black54,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                FontWeight.w500,
                                                              ),
                                                              decoration:
                                                              InputDecoration(
                                                                hintText: 'To',
                                                                isDense: true,
                                                                contentPadding:
                                                                EdgeInsets.only(
                                                                    top: 0),
                                                                border: InputBorder
                                                                    .none,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          _selectDate(context, 6);
                                                        },
                                                        child: Container(
                                                          width: 75,
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 0,
                                                                top: 5),
                                                            child: Text(
                                                              selecteddDate3 != null
                                                                  ? DateFormat(
                                                                  'dd-MMM')
                                                                  .format(
                                                                  selecteddDate3!)
                                                                  : '',
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                        25, // Adjust the height as needed
                                                        child: Container(
                                                          width: 75,
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(left: 0),
                                                            child: TextField(
                                                              onTap: () {
                                                                _selectDate(
                                                                    context, 6);
                                                              },
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                              controller:
                                                              TextEditingController(
                                                                text: selecteddDate3 !=
                                                                    null
                                                                    ? DateFormat(
                                                                    'yyyy')
                                                                    .format(
                                                                    selecteddDate3!)
                                                                    : '',
                                                              ),
                                                              readOnly: true,
                                                              decoration:
                                                              InputDecoration(
                                                                border: InputBorder
                                                                    .none,
                                                                hintText:
                                                                'Select Year',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.1,
                                        color: Colors.grey,
                                      ),
                                      for (int i = 0; i < trips.length; i++)
                                        Column(
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              bottom: 4,
                                                              top: 10),
                                                          child: Text(
                                                            isSwapped
                                                                ? FinalOutputMultiFourth
                                                                : FinalOutputMultiFourth,
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              color: Colors.black,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                          child: Container(
                                                            height: 27,
                                                            width: 75,
                                                            child: Autocomplete<
                                                                FlightScreenModel>(
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                              textEditingValue) async {
                                                                if (textEditingValue
                                                                    .text.isEmpty) {
                                                                  return const Iterable<
                                                                      FlightScreenModel>.empty();
                                                                }
                                                                return await fetchAutocompleteData(
                                                                    textEditingValue
                                                                        .text);
                                                              },
                                                              displayStringForOption:
                                                                  (FlightScreenModel
                                                              option) =>
                                                              '${option.name}, ${option.id}, ${option.iso_country}',
                                                              onSelected:
                                                                  (FlightScreenModel?
                                                              selectedOption) {
                                                                if (selectedOption !=
                                                                    null) {
                                                                  print(
                                                                      'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                                  setState(() {
                                                                    FinalOutputMultiFourth =
                                                                        selectedOption
                                                                            .id;
                                                                    OriginPlace =
                                                                        selectedOption
                                                                            .iso_country;
                                                                    SelectionValue =
                                                                        selectedOption
                                                                            .name;
                                                                  });
                                                                }
                                                              },
                                                              fieldViewBuilder:
                                                                  (context,
                                                                  controller,
                                                                  focusNode,
                                                                  onFieldSubmitted) {
                                                                return TextFormField(
                                                                  controller:
                                                                  controller,
                                                                  focusNode:
                                                                  focusNode,
                                                                  onFieldSubmitted:
                                                                      (String
                                                                  value) {
                                                                    // Your logic here
                                                                  },
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                    fontSize: 14,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                  decoration:
                                                                  InputDecoration(
                                                                    hintText:
                                                                    'From',
                                                                    isDense: true,
                                                                    contentPadding:
                                                                    EdgeInsets
                                                                        .only(
                                                                        top:
                                                                        0),
                                                                    border:
                                                                    InputBorder
                                                                        .none,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              bottom: 4,
                                                              top: 10),
                                                          child: Text(
                                                            isSwapped
                                                                ? FinalOutput1MultiFourth
                                                                : FinalOutput1MultiFourth,
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              color: Colors.black,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 27,
                                                          width: 75,
                                                          child: Autocomplete<
                                                              FlightScreenModel>(
                                                            optionsBuilder:
                                                                (TextEditingValue
                                                            textEditingValue) async {
                                                              if (textEditingValue
                                                                  .text.isEmpty) {
                                                                return const Iterable<
                                                                    FlightScreenModel>.empty();
                                                              }
                                                              return await fetchAutocompleteData(
                                                                  textEditingValue
                                                                      .text);
                                                            },
                                                            displayStringForOption:
                                                                (FlightScreenModel
                                                            option) =>
                                                            '${option.name}, ${option.id}, ${option.iso_country}',
                                                            onSelected:
                                                                (FlightScreenModel?
                                                            selectedOption) {
                                                              if (selectedOption !=
                                                                  null) {
                                                                print(
                                                                    'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                                setState(() {
                                                                  FinalOutput1MultiFourth =
                                                                      selectedOption
                                                                          .id;
                                                                  DestinationPlace =
                                                                      selectedOption
                                                                          .iso_country;
                                                                });
                                                              }
                                                            },
                                                            fieldViewBuilder: (context,
                                                                controller,
                                                                focusNode,
                                                                onFieldSubmitted) {
                                                              return TextFormField(
                                                                controller:
                                                                controller,
                                                                focusNode:
                                                                focusNode,
                                                                onFieldSubmitted:
                                                                    (String value) {
                                                                  // Your logic here
                                                                },
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                ),
                                                                decoration:
                                                                InputDecoration(
                                                                  hintText: 'To',
                                                                  isDense: true,
                                                                  contentPadding:
                                                                  EdgeInsets
                                                                      .only(
                                                                      top:
                                                                      0),
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            _selectDate(context, 7);
                                                          },
                                                          child: Container(
                                                            width: 75,
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 0,
                                                                  top: 5),
                                                              child: Text(
                                                                selecteddDate4 !=
                                                                    null
                                                                    ? DateFormat(
                                                                    'dd-MMM')
                                                                    .format(
                                                                    selecteddDate4!)
                                                                    : '',
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        SizedBox(
                                                          height:
                                                          25, // Adjust the height as needed
                                                          child: Container(
                                                            width: 75,
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 0),
                                                              child: TextField(
                                                                onTap: () {
                                                                  _selectDate(
                                                                      context, 7);
                                                                },
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                                controller:
                                                                TextEditingController(
                                                                  text: selecteddDate4 !=
                                                                      null
                                                                      ? DateFormat(
                                                                      'yyyy')
                                                                      .format(
                                                                      selecteddDate4!)
                                                                      : '',
                                                                ),
                                                                readOnly: true,
                                                                decoration:
                                                                InputDecoration(
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                  hintText:
                                                                  'Select Year',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: toggleCity,
                                            child: Container(
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                    5), // Set border radius
                                                border: Border.all(
                                                    color: Color(0xFF00ADEE)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  isCityAdded
                                                      ? 'REMOVE CITY'
                                                      : 'ADD CITY',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF00ADEE),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.1,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                                /*  Container(
                              width: double.infinity,
                              height: 0.1,
                              color: Colors.grey,
                            ),*/
                                SizedBox(
                                  height: 0,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 0.1,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 0),
                                  margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  AddTravellers_Flight(
                                                    adultsCount: AdultCount,
                                                    childrenCount: childrenCount,
                                                    infantsCount: infantsCount,
                                                    selectedClass: selectedClass,
                                                  )));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Travellers',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Spacer(), // Add some space between "From" and "To"
                                        Text(
                                          'Class',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 0),
                                  margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          _saveString();
                                          final selectedDates =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                      AddTravellers_Flight(
                                                        adultsCount:
                                                        AdultCount,
                                                        childrenCount:
                                                        childrenCount,
                                                        infantsCount:
                                                        infantsCount,
                                                        selectedClass:
                                                        selectedClass,
                                                      )));
                                          if (selectedDates != null) {
                                            setState(() {
                                              AdultCount =
                                              selectedDates['adultsCount'];
                                              childrenCount =
                                              selectedDates['childrenCount'];
                                              infantsCount =
                                              selectedDates['infantCount'];
                                              selectedClass =
                                              selectedDates['selectedClass'];
                                              selectedClassId =
                                              selectedDates['selectedClassId'];
                                              print(
                                                  'selectedClass' + selectedClass);
                                              print(
                                                  'selectedClassId' + selectedClassId.toString());
                                            });
                                          }
                                        },
                                        child: Text(
                                          Children + Adult + Infants,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Spacer(), // Add some space between "From" and "To"
                                      Text(
                                        selectedClass,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 0.1,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    width: 300,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 300,
                                          height: 46,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              _deleteAllRecordsAndGoBack();
                                              _deleteAllRecordsChildren();
                                              _deleteAllRecordsInfant();
                                              if (tTripType == '0') {
                                                print("abcd" + OriginPlace);
                                                /* if (OriginPlace == 'IN' &&
                                                DestinationPlace == 'IN') {
                                              navigate(TwoWayDomestic(
                                                adult: AdultCount.toString(),
                                                children

                                                    :
                                                    childrenCount.toString(),
                                                infants:
                                                    infantsCount.toString(),
                                                orgin: FinalOutput,
                                                originCountry: OriginPlace,
                                                destinationCourntry:
                                                    DestinationPlace,
                                                destination: FinalOutPut1,
                                                departDate: selecteddDate,
                                                returnDate: selectedReturnDate,
                                              ));
                                            } else {
                                              print('OriginPlace'+OriginPlace);*/
                                                navigate(
                                                    TwoWayBoardingFlightsList(

                                                      add: 'Add',
                                                      adult: AdultCount.toString(),
                                                      children:
                                                      childrenCount.toString(),
                                                      infants:
                                                      infantsCount.toString(),
                                                      orgin: FinalOutput,
                                                      originCountry: OriginPlace,
                                                      destinationCourntry:
                                                      DestinationPlace,
                                                      destination: FinalOutPut1,
                                                      departDate: selecteddDate,
                                                      returnDate: selectedReturnDate,
                                                    ));

                                              } else if (tTripType == "1") {
                                                _deleteAllRecordsAndGoBack();
                                                _deleteAllRecordsChildren();
                                                _deleteAllRecordsInfant();
                                                print('sfdf' + FinalOutput);
                                                print('ClassType: ${selectedClass.toString()}');
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OnewayFlightsList(
                                                              add:'ADD',
                                                              adult: AdultCount
                                                                  .toString(),
                                                              children:
                                                              childrenCount
                                                                  .toString(),
                                                              infants: infantsCount
                                                                  .toString(),
                                                              orgin: FinalOutput
                                                                  .toString(),
                                                              destination:
                                                              FinalOutPut1
                                                                  .toString(),
                                                              departDate:
                                                              selecteddDate
                                                                  .toString(),
                                                              userId: userID,
                                                              currency: Currency,
                                                              classtype:selectedClass),
                                                    ));
                                              } else if (tTripType == "2") {
                                                print('🔽 Values Passed to Next Page or API 🔽');
                                                print('add: Add');
                                                print('adult: ${AdultCount.toString()}');
                                                print('children: ${childrenCount.toString()}');
                                                print('infants: ${infantsCount.toString()}');

                                                print('✅ Selected origin1: $FinalOutput');
                                                print('✅ Selected destination1: $FinalOutPut1');


                                                print('origin2: ${validateField(FinalOutputMultiSecond)}');
                                                print('destination2: ${validateField(FinalOutput1MultiSecond)}');

                                                print('origin3: ${validateField(FinalOutputMultiThird)}');
                                                print('destination3: ${validateField(FinalOutput1MultiThird)}');

                                                print('origin4: ${validateField(FinalOutputMultiFourth)}');
                                                print('destination4: ${validateField(FinalOutput1MultiFourth)}');

                                                print('departDate1: ${formatSelectedDate(selecteddDate1)}');
                                                print('departDate2: ${formatSelectedDate(selecteddDate2)}');
                                                print('departDate3: ${formatSelectedDate(selecteddDate3)}');
                                                print('departDate4: ${formatSelectedDate(selecteddDate4)}');




                                                navigate(MultiCityFlightsList(
                                                  add:'Add',
                                                  adult: AdultCount.toString(),
                                                  children:
                                                  childrenCount.toString(),
                                                  infants: infantsCount.toString(),
                                                  origin1: FinalOutput,
                                                  destination1: FinalOutPut1.toString(),
                                                  origin2: validateField(FinalOutputMultiSecond),
                                                  destination2: validateField(FinalOutput1MultiSecond),
                                                  origin3: validateField(FinalOutputMultiThird),
                                                  destination3: validateField(FinalOutput1MultiThird),
                                                  origin4: validateField(FinalOutputMultiFourth),
                                                  destination4: validateField(FinalOutput1MultiFourth),
                                                  departdate2: formatSelectedDate(selecteddDate2),
                                                  departDate1: formatSelectedDate(selecteddDate1),
                                                  departDate3: formatSelectedDate(selecteddDate3),
                                                  departdate4: formatSelectedDate(selecteddDate4),
                                                  ClassType:selectedClass.toString(),
                                                ));
                                              }
                                            },
                                            child: Text(
                                              "SEARCH",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xFF00ADEE),

                                              // Background color of the button
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    20), // Circular radius of 20
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 231,
                      width: double.infinity,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            width: 330,
                            height: 200,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                            child: Card(
                              elevation: 10.0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Container(
                                    width: 330,
                                    height: 200,
                                    /*child: Image(
                      image: NetworkImage(hotelDestination[index].image),
                      fit: BoxFit.fill,
                    ),*/
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      'https://media.discoverafrica.com/wp-content/uploads/2023/08/adobestock_329639243_editorial_use_only-scaled.webp?strip=all&lossy=1&resize=1920%2C1080&ssl=1',
                                      placeholder: (context, url) => Center(
                                          child: SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: CircularProgressIndicator())),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                      width: 330,
                                      height: 55,
                                      color: Colors.black.withOpacity(0.6),
                                      padding: EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                hotelDestination[index].title,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: Text(
                                                  hotelDestination[index].subtitle,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      fontFamily: "Montserrat",
                                                      fontSize: 13,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Explore",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                elevation: 16.0),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: hotelDestination.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

Widget buildDropdown(
    List<String> items, String value, Function(Object?) onChanged) {
  return Container(
    width: 150,
    height: 30,
    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
    ),
    child: DropdownButton(
      dropdownColor: Colors.white,
      underline: SizedBox(),
      value: value,
      iconSize: 0.0,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 13,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    ),
  );
}

class TripData {
  String from = '';
  String to = '';
  DateTime? date;

  TripData({required this.from, required this.to, required this.date});
}
