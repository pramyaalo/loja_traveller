import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Booking/TwoWayBooking.dart';
import '../../utils/response_handler.dart';

class TwoWayBoardingFlightsList extends StatefulWidget {
  final policyID,
      selectedPassenger,
      passengersFamily,
      orgin,
      destination,
      departDate,
      returnDate;
  const TwoWayBoardingFlightsList(
      {super.key,
      required this.policyID,
      required this.selectedPassenger,
      required this.passengersFamily,
      required this.orgin,
      required this.destination,
      required this.departDate,
      required this.returnDate});

  @override
  State<TwoWayBoardingFlightsList> createState() =>
      _TwoWayBoardingFlightsListState();
}

class _TwoWayBoardingFlightsListState extends State<TwoWayBoardingFlightsList> {
  var resultList = [];
  var resultFlightData = [];
  bool isLoading = false;
  bool isBookingLoading = false;

  void navigate(Widget screen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  void sendFlightSearchRequest() async {
    String fin_date =
        widget.departDate.toString().split(' ')[0].replaceAll('-', '/');
    String origin = widget.orgin;
    String destination = widget.destination;

    // Replace these values with your actual data
    var requestBody = {
      'AdultCount': '1',
      'ChildrenCount': '0',
      'InfantCount': '0',
      'Origin': 'DEL',
      'Destination': 'MAA',
      'fromCountry': 'India',
      'tocountry': 'Dubai',
      'DepartDate': '2024/01/28',
      'ReturnDate': '2024/02/21'
    };

    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaSearchFlightRoundWay');
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
        });
      } else {
        print('Error ${response.statusCode} : ${response.body}');
      }
    } catch (error) {
      print('Error sending request: $error');
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
                color: Colors.black,
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
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Select a flight',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: resultList.length,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Material(
                                elevation: 5,
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        child: Image.asset(
                                                          'assets/images/img.png',
                                                          height: 50,
                                                          width: 50,
                                                        )),
                                                    Text(
                                                      'Aksaa Air',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff777777)),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      '06:00 AM - 09:25 AM',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('DEL',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff777777),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13)),
                                                        Icon(Icons
                                                            .arrow_right_alt),
                                                        Text('MAA',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff777777),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '3 hr 25 min',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      '1 Stop',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  height: 60,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'INR 1,444',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Refundable',
                                                  style: TextStyle(
                                                      color: Color(0xff11A578),
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  'Fare Details',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  'More Details',
                                                  style: TextStyle(
                                                      color: Color(0xffdf7417),
                                                      fontSize: 13),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        child: Image.asset(
                                                          'assets/images/img.png',
                                                          height: 50,
                                                          width: 50,
                                                        )),
                                                    Text(
                                                      'Aksaa Air',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff777777)),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      '06:00 AM - 09:25 AM',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('DEL',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff777777),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13)),
                                                        Icon(Icons
                                                            .arrow_right_alt),
                                                        Text('MAA',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff777777),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '3 hr 25 min',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      '1 Stop',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  height: 60,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'INR 1,444',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Refundable',
                                                  style: TextStyle(
                                                      color: Color(0xff11A578),
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  'Fare Details',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  'More Details',
                                                  style: TextStyle(
                                                      color: Color(0xffdf7417),
                                                      fontSize: 13),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              navigate(TwoWayBooking(stopCount:'',flightDetailsList:resultList[index],TotalPrice:'',departCity:'',adultCount: '',stopCountForward:'',stopCountReturn:'',childrenCount: '',departdate: '',infantCount: '',
                                flightDetails: resultList[index],bookingapi: '',
                              ));
                            },
                          );
                        }))
              ],
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    sendFlightSearchRequest();
    super.initState();
  }
}
