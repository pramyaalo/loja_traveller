import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Booking/ViewBookingDetails.dart';
import '../Models/TicketOrderQueueModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'InvoiceReceipt.dart';

class TicketOrderQueue extends StatefulWidget {
  const TicketOrderQueue({Key? key}) : super(key: key);

  @override
  State<TicketOrderQueue> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<TicketOrderQueue> {
  static late String userTypeID;
  static late String userID;
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
      print("userTypeID" + userTypeID);
      print("userID" + userID);
    });
  }

  static Future<List<TicketOrderQueueModel>?>
      getFlightTicketOrderQueue() async {
    List<TicketOrderQueueModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "FlightTicketOrderQueueGet",
        "UserTypeId=$userTypeID&UserId=$userID&Bookingdt=&BookingNo=&BookingType=");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log("asdf" + jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          TicketOrderQueueModel lm = TicketOrderQueueModel.fromJson(list[i]);
          bookingCardData.add(lm);
        }
      } catch (error) {}
      return bookingCardData;
    });
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
              "Ticket Order Queue",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Montserrat", fontSize: 19),
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
      body: Center(
          child: FutureBuilder<List<TicketOrderQueueModel>?>(
              future: getFlightTicketOrderQueue(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        /* var amount = snapshot.data![index].bookCardAmount;
                        var displayAmount = amount.length > 19
                            ? amount.substring(0, 10) +
                                '...' +
                                amount.substring(amount.length - 9)
                            : amount;*/
                        return Container(
                            child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                              Column(children: [
                                Card(
                                  margin: const EdgeInsets.only(
                                      right: 10, left: 10, top: 7),
                                  elevation: 5,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(
                                              "Booking ID: " +
                                                  snapshot
                                                      .data![index].bookingId,
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          /*   GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewBookingDetails(),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 3, top: 3),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    2, 1, 2, 1),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Color(0xFF00ADEE),
                                                              border: Border.all(
                                                                  width: 0.1,
                                                                  color: Colors
                                                                      .blue),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.8),
                                                                  spreadRadius:
                                                                      2,
                                                                  blurRadius: 5,
                                                                  offset: Offset(
                                                                      0,
                                                                      3), // changes the position of the shadow
                                                                ),
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            child: Text(
                                                              'View',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),*/
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      if (snapshot.data![index]
                                          .bookCardDiscription.isNotEmpty)
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0),
                                                    child: Container(
                                                      width: 250,
                                                      child: Text(
                                                        snapshot.data![index]
                                                            .bookCardDiscription,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(), // Adds space between the two parts of the row
                                            /*   Row(
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      'assets/images/tickiconpng.png'),
                                                  width: 16,
                                                  height: 16,
                                                  color: Color(0xFF00ADEE),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                  child: Text(
                                                    "Paid Status: " +
                                                        snapshot.data![index]
                                                            .bookCardDiscription,
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                      color: Color(0xFF00ADEE),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),*/
                                          ],
                                        ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0),
                                                  child: Text(
                                                    "Booking Date: " +
                                                        snapshot.data![index]
                                                            .bookedOnDt,
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Adds space between the two parts of the row
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      if (snapshot.data![index]
                                          .bookCardServiceDt.isNotEmpty)
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0),
                                                    child: Container(
                                                      width: 320,
                                                      child: Text(
                                                        "Trip Date: " +
                                                            snapshot
                                                                .data![index]
                                                                .bookCardServiceDt,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Adds space between the two parts of the row
                                          ],
                                        ),
                                      if (snapshot.data![index]
                                          .bookCardPassenger.isNotEmpty)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 0),
                                              child: Text(
                                                snapshot.data![index]
                                                    .bookCardPassenger,
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            height: 1,
                                            child: DecoratedBox(
                                              decoration: const BoxDecoration(
                                                  color: Color(0xffededed)),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 4),
                                            child: Text(
                                              "Price(Incl. Tax)",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: 25,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Align(
                                                alignment:
                                                    FractionalOffset.topLeft,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Icon(
                                                      Icons.book_outlined,
                                                      size: 14,
                                                    ),
                                                    Text(
                                                      "BookingType: " +
                                                          snapshot.data![index]
                                                              .bookingType,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  FractionalOffset.topLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              4.0, 2, 4, 2),
                                                      decoration: BoxDecoration(
                                                        color: Colors.teal,
                                                        border: Border.all(
                                                            width: 0.1,
                                                            color: Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: Text(
                                                        'Issue',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4),
                                              child: Text(
                                                snapshot
                                                            .data![index]
                                                            .bookCardAmount
                                                            .length >
                                                        10
                                                    ? snapshot.data![index]
                                                        .bookCardAmount
                                                        .substring(0, 10)
                                                    : snapshot.data![index]
                                                        .bookCardAmount,
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                            ])));
                      });
                } else {
                  return CircularProgressIndicator();
                }
              })),
    );
  }
}
