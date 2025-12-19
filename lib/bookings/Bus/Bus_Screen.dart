import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';

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
import '../Car/CarListScreen.dart';
import '../flight/AddTravellers_Flight.dart';
import '../flight/Children_DatabaseHelper.dart';
import '../flight/FlightScreenModel.dart';
import '../flight/InfantDatabaseHelper.dart';
import '../flight/multicity_flight_list.dart';
import '../flight/one_way_flight_list.dart';
import 'BusListScreen.dart';

class BusScreen extends StatefulWidget {
  const BusScreen({Key? key}) : super(key: key);

  @override
  _FlightsScreenState createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<BusScreen> {
  bool isSwapped = false;
  bool __ToDestination = true;
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  Timer? _timer;
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
  List<String> dropOffTimes = [
    "12:00 AM",
    "1:00 AM", "2:00 AM", "3:00 AM", "4:00 AM", "5:00 AM", "6:00 AM",
    "7:00 AM", "8:00 AM", "9:00 AM", "10:00 AM", "11:00 AM",
    "12:00 PM",
    "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM", "5:00 PM", "6:00 PM",
    "7:00 PM", "8:00 PM", "9:00 PM", "10:00 PM", "11:00 PM",
  ];

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
  final List<HotelDestination> hotelDestination = [
    HotelDestination(
        title: "Month End Off",
        subtitle: "80% offer for this month",
        image: "assets/images/flightimg.jpg"),
    HotelDestination(
        title: "Coupons",
        subtitle: "Offer upto Rs.7000",
        image: "assets/images/flightimg2.jpg"),
    HotelDestination(
        title: "Offers",
        subtitle: "Air India Offers",
        image: "assets/images/flightimg3.jpg"),
  ];
  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
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

    __ToDestination = false;
    //_loadSavedString();
    if (selectedClass == '') {
      selectedClass = 'Economy';
    }
    _retrieveSavedValues();
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < hotelDestination.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
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
  String selectedDropOffTime = "6:00 PM";

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

          colorScheme: const ColorScheme.light(primary:  Color(0xFF00ADEE)),
          datePickerTheme: const DatePickerThemeData(
            backgroundColor: Colors.white,
            dividerColor:  Color(0xFF00ADEE),
            headerBackgroundColor:  Color(0xFF00ADEE),
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
  String selectedTime = "6:00 AM";
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
    List<String> timeList = [
      "12:00 AM",
      "1:00 AM", "2:00 AM", "3:00 AM", "4:00 AM", "5:00 AM", "6:00 AM",
      "7:00 AM", "8:00 AM", "9:00 AM", "10:00 AM", "11:00 AM",
      "12:00 PM",
      "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM", "5:00 PM", "6:00 PM",
      "7:00 PM", "8:00 PM", "9:00 PM", "10:00 PM", "11:00 PM",
    ];

    // default (optional)

    var travelPolicy = ['-- Select --'];




    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 1,

        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:   Color(0xFF00ADEE), // Same as AppBar color
          statusBarIconBrightness: Brightness.light, // White icons
          statusBarBrightness: Brightness.dark, // For iOS
        ),
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
              "Bus Booking",
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
            'assets/images/lojologg.png',
            width: 100,
            height: 50,
          ),
        ],backgroundColor:Color(0xFF00ADEE),
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
                                            "From City",
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
                                                  'Selecteidd: ${selectedOption.municipality} (${selectedOption.id})');
                                              setState(() {
                                                OriginPlace = selectedOption.id;
                                                SelectionValue =
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
                                                hintText: 'Type From City',
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
                                        "To City",
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
                                                DestinationPlace = selectedOption.id;
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
                                                hintText: 'Type To City',
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
                                                "Departs On",
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54),
                                              ),
                                              SizedBox(
                                                height: 9,
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
                                                height: 9,
                                              ),





                                            ],
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

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Buslistscreen(
                                                    add: 'ADD',
                                                    adult: AdultCount.toString(),
                                                    children: childrenCount.toString(),
                                                    infants: infantsCount.toString(),
                                                    Pickup: OriginPlace.toString(),
                                                    dropoff: DestinationPlace.toString(),
                                                    pickupdate: selecteddDate.toString(),
                                                    dropoffdate:selectedReturnDate.toString(),
                                                    pickuptime:selectedTime.toString(),
                                                    dropoftime:selectedDropOffTime.toString(),
                                                    userId: userID,
                                                    currency: Currency,
                                                    classtype: selectedClass,
                                                  ),
                                                ),
                                              );
                                            },

                                            child: Text(
                                              "SEARCH",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:  Color(0xFF00ADEE),

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
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: hotelDestination.length,
                        itemBuilder: (context, index) {
                          final hotel = hotelDestination[index];
                          return Container(
                            width: 330,
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Card(
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Image.asset(
                                    hotel.image,
                                    width: 330,
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ),
                                  Container(
                                    width: 330,
                                    height: 55,
                                    color: Colors.black.withOpacity(0.6),
                                    padding: EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              hotel.title,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 5),
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                hotel.subtitle,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
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
                                            elevation: 16.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}



class TripData {
  String from = '';
  String to = '';
  DateTime? date;

  TripData({required this.from, required this.to, required this.date});
}
Widget buildDropdown({
  required String value,
  required List<String> items,
  required Function(String?) onChanged,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(5),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        isExpanded: false, // ❗ Very important → fixes arrow position
        icon: Icon(Icons.keyboard_arrow_down),
        alignment: Alignment.centerRight, // ❗ Arrow on right side
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Center(
              child: Text(
                item,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    ),
  );
}

