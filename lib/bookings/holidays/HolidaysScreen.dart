import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../../Booking/HolidayDatabaseHelper.dart';
 import '../../Models/hotel_destination_models.dart';
import '../flight/AddGuestes_Hotel.dart';
import '../flight/AddTravellers_Flight.dart';
import 'AddGuestsHolidays.dart';
import 'AutoFillHolidayModel.dart';
import 'HolidayChildrenDatabaseHelper.dart';
import 'holiday_list_screen.dart';

class Holidays extends StatefulWidget {
  @override
  _HotelsScreenState createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<Holidays> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int AdultCount = 1, childrenCount = 0;
  int AdultCount1 = 1, childrenCount1 = 0;
  int AdultCount2 = 1, childrenCount2 = 0;
  int AdultCount3 = 1, childrenCount3 = 0;
  String selecteddate = '', selecteddate1 = '';
  String RoomType = '1';
  int TotAdultCount = 1;
  int TotChildrenCount = 0;
  String LocationId = '';
  TextEditingController orginController = new TextEditingController();
  List hotelDestination = [
    HotelDestination(
      title: "Kenya",
      subtitle: "10 great deals",
      image: "https://images.unsplash.com/photo-1509099836639-18ba1795216d?auto=format&fit=crop&w=800&q=80",
    ),




    HotelDestination(
        title: "Karen Blixen Museum",
        subtitle: "4 great deals",
        image:
            "https://museums.or.ke/wp-content/uploads/2024/02/Karen-Blixen-Museum.jpg"),
  ];
  @override
  void initState() {
    // TODO: implement initState
    orginController.text = 'CHENNAI';
    setState(() {});

    super.initState();
  }

  void navigate(Widget screen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }
  void _deleteAllRecordsAndGoBack() async {
    try {
      // Initialize the database helper
      final dbHelper = HolidayDatabaseHelper.instance;

      // Delete all records from the adults table (or your specific table)
      await dbHelper.deleteAllholidayRecords('holidayadults'); // Adjust table name if needed
    } catch (e) {
      print("Error deleting all records: $e");
      // Optionally, show a snackbar or error dialog to the user
    }
  }
  void _deleteAllRecordsChildren() async {
    try {
      // Initialize the database helper
      final dbHelper = HolidayChildrenDatabaseHelper.instance;

      // Delete all records from the adults table (or your specific table)
      await dbHelper
          .deleteAllRecords('holidaychildrens'); // Adjust table name if needed
    } catch (e) {
      print("Error deleting all records: $e");
      // Optionally, show a snackbar or error dialog to the user
    }
  }
  Future<List<AutoFillHolidayModel>> fetchAutocompleteData(
      String cityName) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/TourGetCitiesAutocomplete?cityName=$cityName';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final xmlDocument = xml.XmlDocument.parse(response.body);
      final responseData = xmlDocument.findAllElements('string').first.text;

      final decodedData = json.decode(responseData);
      return decodedData
          .map<AutoFillHolidayModel>(
              (data) => AutoFillHolidayModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load autocomplete data');
    }
  }

  DateTime selectedDate = DateTime.now();
  DateTime selectedReturnDate = DateTime.now();
  Future<void> _selectDate(BuildContext context, int type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101), builder: (BuildContext context, Widget? child) {
      return Theme(data: ThemeData.light().copyWith(

        colorScheme: const ColorScheme.light(primary: Color(0xFF00ADEE)),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          dividerColor: Color(0xFF00ADEE),
          headerBackgroundColor: Color(0xFF00ADEE),
          headerForegroundColor: Colors.white, // Custom primary color
        ),), child: child!,


      );
    },);
    if (picked != null && picked != selectedDate) {
      setState(() {
        if (type == 1) {
          selectedDate = picked;
          print(selectedDate);
        } else {
          selectedReturnDate = picked;
          print(selectedReturnDate);
        }
      });
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
              "Holiday Booking",
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
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          color: Color(0xFF00ADEE),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                          color: Colors.white,
                          child: Material(
                            elevation: 5,
                            child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          right: 10, left: 10, top: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "From City",
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 280,
                                                child: Autocomplete<
                                                    AutoFillHolidayModel>(
                                                  optionsBuilder: (TextEditingValue
                                                      textEditingValue) async {
                                                    if (textEditingValue
                                                        .text.isEmpty) {
                                                      return const Iterable<
                                                          AutoFillHolidayModel>.empty();
                                                    }
                                                    return await fetchAutocompleteData(
                                                        textEditingValue.text);
                                                  },
                                                  displayStringForOption:
                                                      (AutoFillHolidayModel
                                                              option) =>
                                                          '${option.latinFullName}, ${option.country}, ${option.locationId}',
                                                  onSelected:
                                                      (AutoFillHolidayModel?
                                                          selectedOption) {
                                                    if (selectedOption !=
                                                        null) {
                                                      print(
                                                          'Selected: ${selectedOption.latinFullName} (${selectedOption.locationId})');
                                                      setState(() {
                                                        LocationId =
                                                            selectedOption
                                                                .locationId;
                                                        print(LocationId);
                                                      });
                                                      // Do something with the selected option
                                                    }
                                                  },
                                                  fieldViewBuilder: (context,
                                                      controller,
                                                      focusNode,
                                                      onFieldSubmitted) {
                                                    return Container(
                                                      height: 38,
                                                      width: 150,
                                                      child: TextFormField(
                                                        controller: controller,
                                                        focusNode: focusNode,
                                                        // Adjust the signature of onFieldSubmitted to accept a String parameter
                                                        onFieldSubmitted:
                                                            (String value) {
                                                          // Your logic here
                                                        },
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(10),
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
                                                "Departure Date",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print('selecteddate' +
                                                      selecteddate);

                                                  _selectDate(context, 1);
                                                },
                                                child: Text(
                                                  checkInDate != ''
                                                      ? "${selectedDate.toLocal()}"
                                                          .split(' ')[0]
                                                      : "${checkInDate}",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Saturday",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Guests',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(bottom: 0),
                                                margin: EdgeInsets.only(
                                                    left: 0, right: 0, top: 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        print('AdultCount' +
                                                            AdultCount
                                                                .toString());
                                                        final selectedDates = await Navigator
                                                            .push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        AddGuestsHolidays(
                                                                          checkInDate:
                                                                              selectedDate,
                                                                          checkOutDate:
                                                                              selectedReturnDate,
                                                                          roomcount:
                                                                              RoomType,
                                                                          adultsCount:
                                                                              AdultCount,
                                                                          childrenCount:
                                                                              childrenCount,
                                                                          adultsCount1:
                                                                              AdultCount1,
                                                                          childrenCount1:
                                                                              childrenCount1,
                                                                          adultsCount2:
                                                                              AdultCount2,
                                                                          childrenCount2:
                                                                              childrenCount2,
                                                                          adultsCount3:
                                                                              AdultCount3,
                                                                          childrenCount3:
                                                                              childrenCount3,
                                                                        )));
                                                        if (selectedDates !=
                                                            null) {
                                                          setState(() {
                                                            checkInDate =
                                                                selectedDates[
                                                                    'checkInDate'];
                                                            checkOutDate =
                                                                selectedDates[
                                                                    'checkOutDate'];
                                                            print('checkInDate' +
                                                                checkInDate!
                                                                    .toIso8601String());
                                                            RoomType =
                                                                selectedDates[
                                                                    'roomcount'];
                                                            print('RoomTydffpe' +
                                                                RoomType!
                                                                    .toString());
                                                            if (RoomType ==
                                                                '1') {
                                                              AdultCount =
                                                                  selectedDates[
                                                                      'adultsCount'];
                                                              childrenCount =
                                                                  selectedDates[
                                                                      'childrenCount'];
                                                              TotAdultCount =
                                                                  AdultCount;
                                                              TotChildrenCount =
                                                                  childrenCount;
                                                              print('object' +
                                                                  AdultCount
                                                                      .toString());
                                                            }
                                                            if (RoomType ==
                                                                '2') {
                                                              print('object' +
                                                                  AdultCount
                                                                      .toString());
                                                              print('object1' +
                                                                  AdultCount1
                                                                      .toString());
                                                              AdultCount =
                                                                  selectedDates[
                                                                      'adultsCount'];
                                                              childrenCount =
                                                                  selectedDates[
                                                                      'childrenCount'];
                                                              AdultCount1 =
                                                                  selectedDates[
                                                                      'adultsCount1'];
                                                              childrenCount1 =
                                                                  selectedDates[
                                                                      'childrenCount1'];

                                                              TotAdultCount =
                                                                  AdultCount +
                                                                      AdultCount1;
                                                              TotChildrenCount =
                                                                  childrenCount +
                                                                      childrenCount1;
                                                            }

                                                            if (RoomType ==
                                                                '3') {
                                                              AdultCount =
                                                                  selectedDates[
                                                                      'adultsCount'];
                                                              childrenCount =
                                                                  selectedDates[
                                                                      'childrenCount'];
                                                              AdultCount1 =
                                                                  selectedDates[
                                                                      'adultsCount1'];
                                                              childrenCount1 =
                                                                  selectedDates[
                                                                      'childrenCount1'];
                                                              AdultCount2 =
                                                                  selectedDates[
                                                                      'adultsCount2'];
                                                              childrenCount2 =
                                                                  selectedDates[
                                                                      'childrenCount2'];

                                                              TotAdultCount =
                                                                  AdultCount +
                                                                      AdultCount1 +
                                                                      AdultCount2;
                                                              TotChildrenCount =
                                                                  childrenCount +
                                                                      childrenCount1 +
                                                                      childrenCount2;
                                                            }
                                                            AdultCount =
                                                                selectedDates[
                                                                    'adultsCount'];
                                                            print('AdultCoudfnt' +
                                                                AdultCount
                                                                    .toString());
                                                            childrenCount =
                                                                selectedDates[
                                                                    'childrenCount'];
                                                            AdultCount1 =
                                                                selectedDates[
                                                                    'adultsCount1'];
                                                            childrenCount1 =
                                                                selectedDates[
                                                                    'childrenCount1'];
                                                            AdultCount2 =
                                                                selectedDates[
                                                                    'adultsCount2'];
                                                            childrenCount2 =
                                                                selectedDates[
                                                                    'childrenCount2'];
                                                            AdultCount3 =
                                                                selectedDates[
                                                                    'adultsCount3'];
                                                            childrenCount3 =
                                                                selectedDates[
                                                                    'childrenCount3'];
                                                            /* if (RoomType == '4') {
                                                    AdultCount = selectedDates[
                                                        'adultCount'];
                                                    childrenCount =
                                                        selectedDates[
                                                            'childrenCount'];
                                                    AdultCount1 = selectedDates[
                                                        'adultsCountRoom1'];
                                                    childrenCount1 =
                                                        selectedDates[
                                                            'childrenCountRoom1'];
                                                    AdultCount2 = selectedDates[
                                                        'adultsCountRoom2'];
                                                    childrenCount2 =
                                                        selectedDates[
                                                            'childrenCountRoom2'];
                                                    AdultCount3 = selectedDates[
                                                        'adultsCountRoom3'];
                                                    childrenCount3 =
                                                        selectedDates[
                                                            'childrenCountRoom3'];

                                                    TotAdultCount = AdultCount +
                                                        AdultCount1 +
                                                        AdultCount2 +
                                                        AdultCount3;
                                                    TotChildrenCount =
                                                        childrenCount +
                                                            childrenCount1 +
                                                            childrenCount2 +
                                                            childrenCount3;
                                                    print(
                                                        'TotAdultCount Count: $TotAdultCount');
                                                  }*/
                                                          });
                                                        }
                                                      },
                                                      child: Text(
                                                        TotAdultCount
                                                                .toString() +
                                                            " " +
                                                            "Guests",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(bottom: 0),
                                                margin: EdgeInsets.only(
                                                    left: 0, right: 0, top: 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      TotAdultCount.toString() +
                                                          " " +
                                                          "Adult" +
                                                          "," +
                                                          " " +
                                                          TotChildrenCount
                                                              .toString() +
                                                          " " +
                                                          'Children',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 300,
                                            height: 46,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                _deleteAllRecordsAndGoBack();
                                                _deleteAllRecordsChildren();
                                                print(
                                                    'adfjhiufhiu$selectedDate$selectedReturnDate$RoomType$AdultCount$childrenCount$AdultCount1$childrenCount1$AdultCount2$childrenCount2$AdultCount3$childrenCount3');
                                                navigate(HolidayListScreen(
                                                    checkinDate: selectedDate,
                                                    RoomCount: RoomType,
                                                    AdultCountRoom1: AdultCount,
                                                    ChildrenCountRoom1:
                                                        childrenCount,
                                                    AdultCountRoom2:
                                                        AdultCount1,
                                                    ChildrenCountRoom2:
                                                        childrenCount1,
                                                    AdultCountRoom3:
                                                        AdultCount2,
                                                    ChildrenCountRoom3:
                                                        childrenCount2,
                                                    AdultCountRoom4:
                                                        AdultCount3,
                                                    ChildrenCountRoom4:
                                                        childrenCount3,
                                                    Locationid: LocationId));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xFF00ADEE),

                                                // Background color of the button
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // Circular radius of 20
                                                ),
                                              ),
                                              child: const Text(
                                                "SEARCH HOLIDAYS",
                                                style: TextStyle(
                                                    fontFamily: "Montserrat"),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 230,
                      width: double.infinity,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            width: 330,
                            height: 200,
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                            child: Card(
                              elevation: 10.0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  SizedBox(
                                    width: 330,
                                    height: 200,

                                    child: CachedNetworkImage(
                                      imageUrl: hotelDestination[index].image,
                                      placeholder: (context, url) => const Center(
                                          child: SizedBox(
                                              height: 40,
                                              width: 40,
                                              child:
                                                  CircularProgressIndicator())),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                      width: 330,
                                      height: 55,
                                      color: Colors.black.withOpacity(0.6),
                                      padding: const EdgeInsets.all(5.0),
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
                                                style: const TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: Text(
                                                  hotelDestination[index]
                                                      .subtitle,
                                                  maxLines: 1,
                                                  style: const TextStyle(
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
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                elevation: 16.0),
                                            child: const Text(
                                              "Explore",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                              ),
                                            ),
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
                    SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: CarouselSlider(
                          items: [
                            Image.asset(
                              "assets/images/toursmorarir.jpg",
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              "assets/images/holiii.jpg",
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              "assets/images/tourspascal.jpg",
                              fit: BoxFit.cover,
                            ),
                          ],
                          options: CarouselOptions(
                            autoPlay: true,
                            viewportFraction: 1,
                            enlargeCenterPage: false,
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Travel Safely in this pandemic",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Your safety is our priority",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            width: 250,
                            height: 150,
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                            child: Card(
                              elevation: 10.0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: SizedBox(
                                width: 250,
                                height: 150,
                                /*child: Image(
                          image: NetworkImage(hotelDestination[index].image),
                          fit: BoxFit.fill,
                        ),*/
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://img.freepik.com/free-psd/travel-safely-banner-template_23-2149203644.jpg',
                                  placeholder: (context, url) => const Center(
                                      child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: CircularProgressIndicator())),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 250,
                            height: 150,
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                            child: Card(
                              elevation: 10.0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: SizedBox(
                                width: 250,
                                height: 150,
                                /*child: Image(
                          image: NetworkImage(hotelDestination[index].image),
                          fit: BoxFit.fill,
                        ),*/
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://cdn5.vectorstock.com/i/1000x1000/58/94/covid-safe-travel-logo-banner-with-passengers-vector-41645894.jpg',
                                  placeholder: (context, url) => const Center(
                                      child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: CircularProgressIndicator())),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 250,
                            height: 150,
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                            child: Card(
                              elevation: 10.0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: SizedBox(
                                width: 250,
                                height: 150,
                                /*child: Image(
                          image: NetworkImage(hotelDestination[index].image),
                          fit: BoxFit.fill,
                        ),*/
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://previews.123rf.com/images/decorwithme/decorwithme1903/decorwithme190300110/124429946-travel-insurance-colorful-flat-design-style-web-banner-on-white-background-with-copy-space-for.jpg',
                                  placeholder: (context, url) => const Center(
                                      child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: CircularProgressIndicator())),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "What's new about us?",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "We're different from others in terms of service",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            height: 250,
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                            child: Card(
                              elevation: 10.0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: SizedBox(
                                width: 150,
                                height: 250,
                                /*child: Image(
                          image: NetworkImage(hotelDestination[index].image),
                          fit: BoxFit.fill,
                        ),*/
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://marketplace.canva.com/EAE-oK6TfmI/1/0/800w/canva-elegant-grand-opening-annoncement-invitation-banner-portrait-ZkcmPUyKFRY.jpg',
                                  placeholder: (context, url) => const Center(
                                      child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: CircularProgressIndicator())),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 250,
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                            child: Card(
                              elevation: 10.0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: SizedBox(
                                width: 150,
                                height: 250,
                                /*child: Image(
                          image: NetworkImage(hotelDestination[index].image),
                          fit: BoxFit.fill,
                        ),*/
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/travel-banner-design-template-74c2986da1078a325518f2202d02d74e_screen.jpg?ts=1661668122',
                                  placeholder: (context, url) => const Center(
                                      child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: CircularProgressIndicator())),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 250,
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                            child: Card(
                              elevation: 10.0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: SizedBox(
                                width: 150,
                                height: 250,
                                /*child: Image(
                          image: NetworkImage(hotelDestination[index].image),
                          fit: BoxFit.fill,
                        ),*/
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://marketplace.canva.com/EAEbm1h5br4/1/0/1200w/canva-blue-red-clean-%26-corporate-workplace-health-%26-safety-rules-health-explainer-poster-y07YKNJaiQ4.jpg',
                                  placeholder: (context, url) => const Center(
                                      child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: CircularProgressIndicator())),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
