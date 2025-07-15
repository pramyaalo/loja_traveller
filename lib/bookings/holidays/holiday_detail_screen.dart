import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../Booking/HolidayDatabaseHelper.dart';
import '../../utils/response_handler.dart';
import 'HolidayChildrenDatabaseHelper.dart';
import 'HolidayReviewBooking.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HolidayDescription extends StatefulWidget {
  final dynamic holidayList,
      Tourcode,
      SightSeeingMarkup,
      defaultCurrency,
      DefaultyCurrencyvalue,
      RoomCount,
      adultCount,
      childrenCount,
      Checkindate,
      imageUrl;

  const HolidayDescription({
    super.key,
    required this.holidayList,
    required this.Tourcode,
    required this.SightSeeingMarkup,
    required this.defaultCurrency,
    required this.DefaultyCurrencyvalue,
    required this.RoomCount,
    required this.adultCount,
    required this.childrenCount,
    required this.Checkindate,
    required this.imageUrl,
  });

  @override
  State<HolidayDescription> createState() => _HotelDescriptionState();
}

class _HotelDescriptionState extends State<HolidayDescription> {
  List<String> images = [];
  String featuresInclusion = '';
  String featuresExclusion = '';
  bool isDetailsLoading = false;
  var hotelResult = [];
  var RoomResult = [];
  Future<void> getHolidayDetails() async {
    DateTime checkinDateTime = DateTime.parse(widget.Checkindate.toString());
    String finDate = DateFormat('yyyy-MM-dd').format(checkinDateTime);
    print('finDate' + finDate);
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/TourGetDetails');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body =
        'TourCode=${widget.Tourcode.toString()}&FromDate=${finDate.toString()}&ToDate=${finDate.toString()}&AdultCount=${widget.adultCount.toString()}'
        '&ChildCount=${widget.childrenCount.toString()}&UserId=1107&SightSeeingMarkup=${widget.SightSeeingMarkup.toString()}'
        '&DefaultCurrency=${widget.defaultCurrency.toString()}&DefaultCurrencyValue=${widget.DefaultyCurrencyvalue.toString()}';
    print(body);
    setState(() {
      isDetailsLoading = true;
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        var data = ResponseHandler.parseData(response.body);
        print(data);
        List<String> jsonStrings = data.split('|||');
        print(jsonStrings.length);
        if (jsonStrings.length > 1) {
          // Store data from the first array
          var firstArrayData = jsonStrings[0];

          // Store data from the second array
          var secondArrayData = jsonStrings[1];

          setState(() {
            var firstJsonArray = json.decode(firstArrayData);
            print(firstJsonArray);
            hotelResult = firstJsonArray;
            featuresInclusion = hotelResult[0]['featuresInclusion'].toString();
            featuresExclusion = hotelResult[0]['featuresExclusion'].toString();
            String Imageurl = hotelResult[0]['BigImages'].toString();
            images = Imageurl.split("||")
                .where((element) => element.isNotEmpty)
                .toList();
            print('featuresInchjtlusion' + featuresInclusion);
            var secondJsonArray = json.decode(secondArrayData);
            RoomResult = secondJsonArray;
            print(secondJsonArray);
          });
        } else {
          print('Invalid data format');
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending request: $error');
    }
    setState(() {
      isDetailsLoading = false;
    });
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
  @override
  void initState() {
    // TODO: implement initState
    getHolidayDetails();
    super.initState();
  }

  List<Widget> createIconsForWords(String features) {
    List<String> words = features.split(",");
    List<Widget> icons = [];

    for (String word in words) {
      // Trim the word to remove any leading or trailing spaces
      String trimmedWord = word.trim();

      // Only add the icon and text if the word is not empty
      if (trimmedWord.isNotEmpty) {
        icons.add(Row(
          children: [
            Icon(Icons.check, color: Colors.green),
            Container(
              width: 148,
              child: Text(
                trimmedWord, // Display the trimmed word
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ));
      }
    }

    return icons;
  }


  List<Widget> createIconsForWords1(String features) {
    // Split the features string into a list of words
    List<String> words = features.split(",");
    print("words: " + words.toString());
    List<Widget> icons = [];

    // Check if the words array is non-empty and the first word is not empty
    if (words.isNotEmpty && words.first.trim().isNotEmpty) {
      icons.add(
        Row(
          children: [
            Icon(Icons.check, color: Colors.red),
            Container(
              width: 148,
              child: Text(
                words.first.trim(), // Trim to remove extra spaces
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    }

    return icons;
  }





  @override
  Widget build(BuildContext context) {
    if (hotelResult.isNotEmpty && RoomResult.isNotEmpty) {
      List<Widget> iconsForFeaturesInclusion =
          createIconsForWords(featuresInclusion);
      List<Widget> iconsForFeaturesExclusion =
          createIconsForWords1(featuresExclusion);

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 1,
          backgroundColor:Color(0xFF00ADEE), // Custom dark color
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
                "Holiday Description",
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
              'assets/images/lojologo.png',
              width: 100,
              height: 50,
            ),

          ],
        ),
        body:isDetailsLoading // Show loading indicator if data is loading
            ? Center(child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: images.isNotEmpty
                    ? CarouselSlider(
                  items: images.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(
                          imageUrl,
                          fit: BoxFit.fill,
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration:
                    Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true,
                    enlargeCenterPage: true,
                  ),
                )
                    : Container(), // Placeholder if no images
              ),
              SizedBox(height: 20),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      height: 22,
                      color: Colors.white,
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 100,
                      height: 16,
                      color: Colors.white,
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 100,
                      height: 20,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    // Add more shimmer widgets as needed
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 80,
                          height: 20,
                          color: Colors.white,
                        ),
                        Container(
                          width: 80,
                          height: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    // More loading placeholders
                    Container(
                      width: double.infinity,
                      height: 100,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ): SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: CarouselSlider(
                  items: images.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(
                          imageUrl,
                          fit: BoxFit.fill,
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      // Handle page change
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10, top: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotelResult[0]['tourname'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      hotelResult[0]['destinationname'] +
                          "," +
                          hotelResult[0]['countryname'],
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Valid From',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.red)),
                        Text('Valid To',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, color: Colors.red))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.Checkindate.toString().substring(0, 10),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        Text(widget.Checkindate.toString().substring(0, 10),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Categories',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(hotelResult[0]['Categories'].toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Guest',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.adultCount.toString() + " " + "Guests",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  left: 15,
                ),
                child: Text(
                  'Operationdays',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(hotelResult[0]['Operationdays'].toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  left: 15,
                ),
                child: Text(
                  'About Destination',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: Container(
                      width: 320,
                      child: Text(
                          hotelResult[0]['content_description'].toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 15, top: 8),
                child: Text(
                  'Inclusion & Exclusion',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Inclusions',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: iconsForFeaturesInclusion,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 6),
                child: Text(
                  'Exclusions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: iconsForFeaturesExclusion,
                ),
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'Modalities',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: RoomResult.length,
            itemBuilder: (BuildContext context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT SIDE
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            RoomResult[index]['modalities_name'],
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            RoomResult[index]['durationvalue'] +
                                RoomResult[index]['durationmetric'],
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            "Cancellation Amount From ${RoomResult[index]['cancelpolicyDate']} is ${RoomResult[index]['cancelpolicypAmount']}",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 10),

                    // RIGHT SIDE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          RoomResult[index]['modalities_rate'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            _deleteAllRecordsAndGoBack();
                            _deleteAllRecordsChildren();
                            navigate(HolidayReviewBooking(
                              holidayName: hotelResult[0]['tourname'],
                              touraddress: hotelResult[0]['destinationname'] +
                                  "," +
                                  hotelResult[0]['countryname'],
                              CheckinDate: widget.Checkindate.toString().substring(0, 10),
                              RoomCount: widget.RoomCount,
                              adultCount: widget.adultCount,
                              Tourcode: widget.Tourcode,
                              featuresInclusion: featuresInclusion,
                              featuresExclusion: featuresExclusion,
                              price: RoomResult[index]['modalities_rate'],
                              modalities_rateKey: RoomResult[index]['modalities_rateKey'],
                              ModalitiesCode: RoomResult[index]['modalities_code'],
                              childrenCount: widget.childrenCount,
                              imageurl: widget.imageUrl,
                            ));
                            print('Container tapped!');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff3093c7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: Center(
                              child: Text(
                                'Book Now',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),

          ],
              ),
            ],
          ),
        ),
      );
    } else
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
              SizedBox(width: 1),
              Text(
                "Holiday",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
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
            SizedBox(
              width: 10,
            )
          ],
          backgroundColor:Color(0xFF00ADEE),
        ),
        body: Center(
          child:
              CircularProgressIndicator(), // Or any other loading indicator or message
        ),
      );
  }
}

double _getInitialRating(int starCategory) {
  if (starCategory >= 1 && starCategory <= 5) {
    return starCategory.toDouble();
  } else {
    return 1.0; // Set a default of one star if 'StarCategory' is not in the valid range
  }
}
