import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:xml/xml.dart';
import '../../Booking/HotelChildrendatabasehelper.dart';
import '../../Booking/HoteldatabaseHelper.dart';
import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';
import 'HotelReviewBooking.dart';

class HotelDescription extends StatefulWidget {
  final dynamic hotelDetail,
      hotelid,
      resultindex,
      traceid,
      Starcategory,
      RoomCount,
      adultCount,
      childrenCount,
      Checkindate,
      CheckoutDate,
      hotelname,
      hoteladdress,
      imageurl,
      totaldays;
  const HotelDescription(
      {super.key,
      required this.hotelDetail,
      required this.hotelid,
      required this.resultindex,
      required this.traceid,
      required this.Starcategory,
      required this.RoomCount,
      required this.adultCount,
      required this.childrenCount,
      required this.Checkindate,
      required this.CheckoutDate,
      required this.hotelname,
      required this.hoteladdress,
      required this.imageurl,
      required this.totaldays});

  @override
  State<HotelDescription> createState() => _HotelDescriptionState();
}

class _HotelDescriptionState extends State<HotelDescription> {
  bool isDetailsLoading = false;
  bool isRoomDetailsLoading = false;
  var hotelResult = [];
  List<String> images = [];
  var RoomResult = [];
  List<String> imageUrls = [];
  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';

  @override
  void initState() {
    super.initState();
    _retrieveSavedValues();
  }

  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
      print('Currency: $Currency');
      // Call sendFlightSearchRequest() here after SharedPreferences values are retrieved
      getHotelDetailsByHotelID();
    });
  }

// Method to get hotel details
  // Call both API methods in sequence
  List<Map<String, dynamic>> roomDetails = [];


  Future<void> _deleteAllRecordsAdults() async {

    await HoteldatabaseHelper.instance.deleteAllhotelRecords('hoteladults');

  }
  Future<void> _deleteAllRecords() async {

      await HotelChildrendatabasehelper.instance.deleteAllRecords('hotelchildrens');

  }
  Future<void> getHotelDetailsByHotelID() async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaHotelGetDetailsByHotelID');

    // Constructing the body for the POST request
    final body =
        'HotelID=${widget.hotelid}&ResultIndex=${widget.resultindex}&TraceId=${widget.traceid}';

    // Setting the content type for the request headers
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    // Printing hotel details for debugging purposes
    print('HotelID: ${widget.hotelid}');
    print('ResultIndex: ${widget.resultindex}');
    print('TraceId: ${widget.traceid}');

    try {
      // Set the loading state before sending the request
      setState(() {
        isDetailsLoading = true;
      });

      // Making the POST request
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      // Set the loading state to false after receiving the response
      setState(() {
        isDetailsLoading = false;
      });

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Check if the response contains XML data
        if (response.body.contains('<?xml')) {
          // Parse the XML response
          print('XML Response: ${response.body}');
          final document = XmlDocument.parse(response.body);

          // Extract the content inside the <string> tag, which might contain JSON
          final jsonString = document.findAllElements('string').single.text;

          // Check if the content inside the XML is a JSON-formatted string
          if (jsonString.startsWith('[') || jsonString.startsWith('{')) {
            // Decode the extracted JSON string
            var jsonResult = json.decode(jsonString);

            // Set the hotel result state
            setState(() {
              hotelResult = jsonResult;

              String imageUrl = hotelResult[0]['HotelImages'].toString();
                images = imageUrl.split(", ")
                  .where((element) => element.isNotEmpty)
                  .toList();
            });

              // Call the second API to get room details
            getRoomDetails();

            print('Hotel result length: ${hotelResult.length}');
          } else {
            print('Invalid JSON content inside XML: $jsonString');
          }
        } else {
          // Handle plain JSON response (if the response is not XML)
          print('Request successful!');
          developer.log(response.body);

          // Parse the JSON response directly
          var jsonResult = json.decode(response.body);

          // Set the hotel result state
          setState(() {
            hotelResult = jsonResult;

            // Parse image URLs if available
            String imageUrl = hotelResult[0]['HotelImages'].toString();
            images = imageUrl.split(", ")
                .where((element) => element.isNotEmpty)
                .toList();
          });


          // Call the second API to get room details
          getRoomDetails();

          print('Hotel result length: ${hotelResult.length}');
        }
      } else {
        // Handle non-200 status codes
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions or errors that occurred during the request
      print('Error sending request: $error');
    }
  }




  Future<void> getRoomDetails() async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaHotelGetRoomTypesByHotelID');

    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final requestBody = {
      'HotelID': widget.hotelid.toString(),
      'ResultIndex': widget.resultindex.toString(),
      'TraceId': widget.traceid.toString(),
      'UserID': userID.toString(),
      'UserTypeID': userTypeID.toString(),
      'DefaultCurrency': Currency.toString(),
    };
    print('HotelID: ${widget.hotelid}');
    print('ResultIndex: ${widget.resultindex}');
    print('TraceID: ${widget.traceid}');
    print('UserID: $userID');
    print('UserTypeID: $userTypeID');
    print('DefaultCurrency: $Currency');
    try {
      setState(() {
        isRoomDetailsLoading = true;
      });
      final response = await http.post(
        url,
        headers: headers,
        body: requestBody,
      );
      setState(() {
        isRoomDetailsLoading = false;
      });
      if (response.statusCode == 200) {
        // Handle the successful response here
        print('Request successful! Response:');
        developer.log(response.body);
        var jsonResult = json.decode(ResponseHandler.parseData(response.body));
        setState(() {
          RoomResult = jsonResult;
        });

        print('hotelResult length ${RoomResult.length}');
      } else {
        // Handle the failure scenario
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions or errors that occurred during the request
      print('Error sending request: $error');
    }
  }

  void navigate(Widget screen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    String amenities = hotelResult != null && hotelResult.isNotEmpty
        ? hotelResult[0]['HotelFacilities']
        : '';

    List<String> amenityList = amenities.split(', ');

    String formattedAmenities = amenityList.join(', ');
    print('formattedAmenities' + amenityList.toString());

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
              "Hotel Description",
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
      body: isDetailsLoading // Show loading indicator if data is loading
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
      )
          : hotelResult != null && hotelResult.isNotEmpty
              ? SingleChildScrollView(
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
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
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
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotelResult[0]['HotelName'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 22),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            RatingBar.builder(
                              initialRating:
                                  double.parse(widget.Starcategory.toString()),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 15,
                              itemPadding: EdgeInsets.symmetric(horizontal: 0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              hotelResult[0]['HotelAddress'],
                              style: TextStyle(),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.monetization_on_rounded,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  ' Non-refundable',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.green),
                                )
                              ],
                            )
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
                                Text('CheckIn',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red)),
                                Text('CheckOut',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red))
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    widget.Checkindate.toString()
                                        .substring(0, 10),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                Text(
                                    widget.CheckoutDate.toString()
                                        .substring(0, 10),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
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
                                Text('Rooms & Guests',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(widget.RoomCount.toString() + "Room",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                Text(widget.adultCount.toString() + "Guests",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          'Available Rooms & Rates',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      (isDetailsLoading == false &&
                              isRoomDetailsLoading == false)
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: RoomResult.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                150,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              RoomResult[index]['RoomTypeName'],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              RoomResult[index]['RatePlanName'],
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            RoomResult[index]['RoomPrice'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.green),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: ()async  {
                                               await _deleteAllRecords();
                                               await _deleteAllRecordsAdults();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          HotelReviewBooking(
                                                    RoomDetail:
                                                        RoomResult[index],
                                                    Roomtypename:
                                                        RoomResult[index]
                                                                ['RoomTypeName']
                                                            .toString(),
                                                    Roomprice: RoomResult[index]
                                                            ['RoomPrice']
                                                        .toString(),
                                                    adultCount:
                                                        widget.adultCount,
                                                    RoomCount: widget.RoomCount,
                                                    Starcategory:
                                                        widget.Starcategory,
                                                    childrenCount:
                                                        widget.childrenCount,
                                                    Checkindate:
                                                        widget.Checkindate,
                                                    CheckoutDate:
                                                        widget.CheckoutDate,
                                                    hotelname: widget.hotelname,
                                                    hoteladdress:
                                                        widget.hoteladdress,
                                                    hotelid: widget.hotelid,
                                                    resultindex:
                                                        widget.resultindex,
                                                    traceid: widget.traceid,
                                                    roomindex: RoomResult[index]
                                                            ['RoomIndex']
                                                        .toString(),
                                                    roomtypecode:
                                                        RoomResult[index]
                                                                ['RoomTypeCode']
                                                            .toString(),
                                                    imageurl: widget.imageurl,
                                                    totaldays: widget.totaldays,


                                                  ),
                                                ),
                                              );
                                              print(
                                                  'Invaasdflid index: $index');
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xff3093c7),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 20),
                                              child: Center(
                                                child: Text(
                                                  'Book Now',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),

                                          /*  GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          HotelReviewBooking(
                                                            hotelDetail:
                                                                hotelResult[
                                                                    index],
                                                            RoomDetail:
                                                                RoomResult[
                                                                    index],
                                                            hotelid:
                                                                widget.hotelid,
                                                            Roomtypename:
                                                                RoomResult[index]
                                                                        [
                                                                        'RoomTypeName']
                                                                    .toString(),
                                                            Roomprice: RoomResult[
                                                                        index][
                                                                    'RoomPrice']
                                                                .toString(),
                                                            hotelname: hotelResult[
                                                                        index][
                                                                    'HotelName']
                                                                .toString(),
                                                            hoteladdress:
                                                                hotelResult[index]
                                                                        [
                                                                        'HotelAddress']
                                                                    .toString(),
                                                            RoomCount: widget
                                                                .RoomCount,
                                                            adultCount: widget
                                                                .adultCount,
                                                            childrenCount: widget
                                                                .childrenCount,
                                                            Checkindate: widget
                                                                .Checkindate,
                                                            CheckoutDate: widget
                                                                .CheckoutDate,
                                                            Starcategory: widget
                                                                .Starcategory,
                                                          )));

                                              print(
                                                  RoomResult[index].toString());
                                              print('Container tapped!');
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xff3093c7),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 20),
                                              child: Center(
                                                child: Text(
                                                  'Book Now',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )*/
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                'No rooms available.',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          'Hotel Facilities',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: amenityList
                            .map(
                              (amenity) => Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.check, size: 16),
                                SizedBox(width: 10),
                                Expanded( // Wrap text so it doesn't overflow
                                  child: Text(
                                    amenity.trim(),
                                    style: TextStyle(fontSize: 14),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                            .toList(),
                      ),

                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          'Nearest Attractions',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 300,
                                  child: Text(
                                    hotelResult[0]['Attractions'].toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          'Hotel Description',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('HeadLine : ' +
                                  hotelResult[0]['HotelDescription']),
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 10),
                          child: Text(
                            'Disclaimer notification: Amenities are subject to availability and may be chargeable as per the hotel policy. ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ))
                    ],
                  ),
                )
              : Center(
                  // Display error message if data failed to load
                  child: Text('Failed to load data.'),
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
