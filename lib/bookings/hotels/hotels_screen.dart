import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../../Booking/HotelChildrendatabasehelper.dart';
import '../../Booking/HoteldatabaseHelper.dart';
import '../../models/hotel_destination_models.dart';
import '../../utils/response_handler.dart';
import '../AutofilHotelModel.dart';
import '../flight/AddGuestes_Hotel.dart';
import '../flight/AddTravellers_Flight.dart';
import 'hotel_detail_screen.dart';

class HotelsScreen extends StatefulWidget {
  @override
  _HotelsScreenState createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  DateTime? checkInDate;
  int nights=1;
  Future<http.Response>? __futureAirlinesDDL;
  DateTime? checkOutDate;
  String Cityid = '', countrycode = '',CityName='';
  int AdultCount = 1, childrenCount = 0;
  int AdultCount1 = 1, childrenCount1 = 0;
  int AdultCount2 = 1, childrenCount2 = 0;
  int AdultCount3 = 1, childrenCount3 = 0;
  String selecteddate = '', selecteddate1 = '';
  String RoomType = '1';
  int TotAdultCount = 1;
  String fromTextHolder = "";
  List<AutofilHotelModel> AutofilHotelModelList = [];
  static String _displayOptionForAirportDDL(
      AutofilHotelModel AutofilHotelModel) =>
      AutofilHotelModel.className;
  int TotChildrenCount = 0;
  late AutofilHotelModel selectedPassenger;
  TextEditingController orginController = new TextEditingController();
  List hotelDestination = [
    HotelDestination(
        title: "Fairview Nairobi",
        subtitle: "4 great deals",
        image:
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/c3/8f/9c/fairview-hotel.jpg?w=1200&h=-1&s=1"),
    HotelDestination(
        title: "Diani Reef Beach Resort",
        subtitle: "10 great deals",
        image:
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/95/4a/ce/diani-reef-beach-resort.jpg?w=1200&h=-1&s=1"),
    HotelDestination(
        title: "Southern Palms Beach Resort",
        subtitle: "7 great deals",
        image:
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/b8/4a/4a/southern-palms-beach.jpg?w=1200&h=-1&s=1"),
  ];
  @override
  void initState() {
    orginController.text = 'DUBAI';

    super.initState();
  }

  void navigate(Widget screen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }


  List<AutofilHotelModel> passengers = [];
  bool _isPassengersLoading = true;
  DateTime selectedDate = DateTime.now();
  DateTime selectedReturnDate = DateTime.now();


  Future<void> _selectDate(BuildContext context, int type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF00ADEE)),
            datePickerTheme: const DatePickerThemeData(
              backgroundColor: Colors.white,
              dividerColor: Color(0xFF00ADEE),
              headerBackgroundColor: Color(0xFF00ADEE),
              headerForegroundColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        if (type == 1) {
          selectedDate = picked;
          print('Check-in: $selectedDate');
        } else {
          selectedReturnDate = picked;
          print('Check-out: $selectedReturnDate');
        }

        // ✅ Calculate nights difference whenever date changes
        if (selectedDate != null && selectedReturnDate != null) {
          nights = selectedReturnDate.difference(selectedDate).inDays;
          if (nights < 1) {
            nights = 1; // Minimum 1 night
          }
          print('Nights: $nights');
        }
      });
    }
  }





  Future<void> _deleteAllRecordsAdults() async {

    await HoteldatabaseHelper.instance.deleteAllRecords();

  }
  Future<void> _deleteAllRecords() async {

    await HotelChildrendatabasehelper.instance.deleteAllRecords('hotelchildrens');

  }
  Future<List<AutofilHotelModel>> fetchAutocompleteData(String cityName) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/HotelGetCitiesAutocomplete?cityName=$cityName';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final xmlDocument = xml.XmlDocument.parse(response.body);
      final responseData = xmlDocument.findAllElements('string').first.text;

      final decodedData = json.decode(responseData);
      return decodedData
          .map<AutofilHotelModel>((data) => AutofilHotelModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load autocomplete data');
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
              "Hotel Booking",
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
                                            "City/Area/Landmark/Hotel",
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded( // ✅ Makes the Autocomplete take available space dynamically
                                                child: Autocomplete<AutofilHotelModel>(
                                                  optionsBuilder: (TextEditingValue textEditingValue) async {
                                                    if (textEditingValue.text.isEmpty) {
                                                      return const Iterable<AutofilHotelModel>.empty();
                                                    }
                                                    return await fetchAutocompleteData(textEditingValue.text);
                                                  },
                                                  displayStringForOption: (AutofilHotelModel option) =>
                                                  '${option.latinFullName}, ${option.countryCode}, ${option.regionId}',
                                                  onSelected: (AutofilHotelModel? selectedOption) {
                                                    if (selectedOption != null) {
                                                      print(
                                                          'Selected: ${selectedOption.latinFullName} (${selectedOption.className})');
                                                      setState(() {
                                                        Cityid = selectedOption.regionId;

                                                        /// ✅ Split safely (avoid error if no comma present)
                                                        String fullName = selectedOption.latinFullName;
                                                        CityName = fullName.contains(',')
                                                            ? fullName.split(',')[0].trim()
                                                            : fullName;

                                                        countrycode = selectedOption.countryCode;

                                                        print("City: $CityName | Country: $countrycode | ID: $Cityid");
                                                      });
                                                    }
                                                  },
                                                  fieldViewBuilder:
                                                      (context, controller, focusNode, onFieldSubmitted) {
                                                    return TextFormField(
                                                      controller: controller,
                                                      focusNode: focusNode,
                                                      onFieldSubmitted: (String value) {},
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      decoration: InputDecoration(
                                                        isDense: true,
                                                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),

                                                        hintText: 'Enter City',
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
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
                                                "CheckIn",
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
                                                  print('selecteddate: $selecteddate');
                                                  _selectDate(context, 1);
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      checkInDate != ''
                                                          ? "${selectedDate.toLocal()}".split(' ')[0]
                                                          : "${checkInDate}",
                                                      style: TextStyle(
                                                        fontFamily: "Montserrat",
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      checkInDate != ''
                                                          ? DateFormat('EEEE').format(selectedDate) // ✅ Get day name
                                                          : '',
                                                      style: TextStyle(
                                                        fontFamily: "Montserrat",
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                nights.toString(),
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),

                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Nights",
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54),
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
                                                "CheckOut",
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  _selectDate(context, 2);
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      DateFormat('dd-MM-yyyy').format(selectedReturnDate), // ✅ Proper date format
                                                      style: TextStyle(
                                                        fontFamily: "Montserrat",
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Center(
                                                      child: Text(
                                                        DateFormat('EEEE').format(selectedReturnDate), // ✅ Dynamic day name
                                                        style: TextStyle(
                                                          fontFamily: "Montserrat",
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black54,
                                                        ),
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
                                    Container(
                                      width: double.infinity,
                                      height: 0.1,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      height: 0,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 0),
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Rooms/Guests',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 0),
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              print('AdultCount' +
                                                  AdultCount.toString());
                                              final selectedDates =
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          AddGuestes_Hotel(
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
                                              if (selectedDates != null) {
                                                setState(() {
                                                  checkInDate = selectedDates[
                                                  'checkInDate'];
                                                  checkOutDate = selectedDates[
                                                  'checkOutDate'];
                                                  print('checkInDate' +
                                                      checkInDate!
                                                          .toIso8601String());
                                                  RoomType = selectedDates[
                                                  'roomcount'];
                                                  print('RoomTydffpe' +
                                                      RoomType!.toString());
                                                  if (RoomType == '1') {
                                                    AdultCount = selectedDates[
                                                    'adultsCount'];
                                                    childrenCount =
                                                    selectedDates[
                                                    'childrenCount'];
                                                    TotAdultCount = AdultCount;
                                                    TotChildrenCount =
                                                        childrenCount;
                                                    print('object' +
                                                        AdultCount.toString());
                                                  }
                                                  if (RoomType == '2') {
                                                    print('object' +
                                                        AdultCount.toString());
                                                    print('object1' +
                                                        AdultCount1.toString());
                                                    AdultCount = selectedDates[
                                                    'adultsCount'];
                                                    childrenCount =
                                                    selectedDates[
                                                    'childrenCount'];
                                                    AdultCount1 = selectedDates[
                                                    'adultsCount1'];
                                                    childrenCount1 =
                                                    selectedDates[
                                                    'childrenCount1'];

                                                    TotAdultCount = AdultCount +
                                                        AdultCount1;
                                                    TotChildrenCount =
                                                        childrenCount +
                                                            childrenCount1;
                                                  }

                                                  if (RoomType == '3') {
                                                    AdultCount = selectedDates[
                                                    'adultsCount'];
                                                    childrenCount =
                                                    selectedDates[
                                                    'childrenCount'];
                                                    AdultCount1 = selectedDates[
                                                    'adultsCount1'];
                                                    childrenCount1 =
                                                    selectedDates[
                                                    'childrenCount1'];
                                                    AdultCount2 = selectedDates[
                                                    'adultsCount2'];
                                                    childrenCount2 =
                                                    selectedDates[
                                                    'childrenCount2'];

                                                    TotAdultCount = AdultCount +
                                                        AdultCount1 +
                                                        AdultCount2;
                                                    TotChildrenCount =
                                                        childrenCount +
                                                            childrenCount1 +
                                                            childrenCount2;
                                                  }
                                                  AdultCount = selectedDates[
                                                  'adultsCount'];
                                                  print('AdultCoudfnt' +
                                                      AdultCount.toString());
                                                  childrenCount = selectedDates[
                                                  'childrenCount'];
                                                  AdultCount1 = selectedDates[
                                                  'adultsCount1'];
                                                  childrenCount1 =
                                                  selectedDates[
                                                  'childrenCount1'];
                                                  AdultCount2 = selectedDates[
                                                  'adultsCount2'];
                                                  childrenCount2 =
                                                  selectedDates[
                                                  'childrenCount2'];
                                                  AdultCount3 = selectedDates[
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
                                              RoomType.toString() +
                                                  " " +
                                                  'Room' +
                                                  ',' +
                                                  TotAdultCount.toString() +
                                                  " " +
                                                  "Guests",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 0),
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            TotAdultCount.toString() +
                                                " " +
                                                "Adult" +
                                                "," +
                                                " " +
                                                TotChildrenCount.toString() +
                                                " " +
                                                'Children',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
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

                                              onPressed: () async {
                                                await _deleteAllRecordsAdults();
                                                await _deleteAllRecords();
                                                print(
                                                    'adfjhiufhiu$selectedDate$selectedReturnDate$RoomType$AdultCount$childrenCount$AdultCount1$childrenCount1$AdultCount2$childrenCount2$AdultCount3$childrenCount3');
                                                navigate(HotelDetail(
                                                    regionID:Cityid,
                                                    checkinDate: selectedDate,
                                                    checkoutDate:
                                                    selectedReturnDate,
                                                    RoomCount: RoomType,
                                                    AdultCountRoom1: AdultCount,
                                                    ChildrenCountRoom1:
                                                    childrenCount,
                                                    AdultCountRoom2: AdultCount1,
                                                    ChildrenCountRoom2:
                                                    childrenCount1,
                                                    AdultCountRoom3: AdultCount2,
                                                    ChildrenCountRoom3:
                                                    childrenCount2,
                                                    AdultCountRoom4: AdultCount3,
                                                    ChildrenCountRoom4:
                                                    childrenCount3,
                                                    cityid: Cityid,
                                                    Cityname:CityName,
                                                    countrycode: countrycode,
                                                    TotalAdultCount:TotAdultCount,
                                                    TotalChildrenCOunt:TotChildrenCount,
                                                    NoOfnights:nights.toString()
                                                ));
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
                                                "SEARCH HOTELS",
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
                                    /*child: Image(
                          image: NetworkImage(hotelDestination[index].image),
                          fit: BoxFit.fill,
                        ),*/
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
                                                    color: Color(0xFF00ADEE)),
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
                                                      color: Color(0xFF00ADEE)),
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
                              "assets/images/kenyahotel.jpg",
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              "assets/images/kenyahotel1.jpg",
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
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Your safety is our priority",
                            style: TextStyle(
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
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "We're different from others in terms of service",
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
