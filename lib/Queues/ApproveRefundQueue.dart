import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'ApproveRefundOnHoldModel.dart';

class ApproveRefundQueue extends StatefulWidget {
  const ApproveRefundQueue({Key? key}) : super(key: key);

  @override
  State<ApproveRefundQueue> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<ApproveRefundQueue> {
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

  Future<http.Response>? __futureLogin;
  static Future<List<ApproveRefundOnHoldModel>?>
      getFlightTicketOrderQueue() async {
    List<ApproveRefundOnHoldModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "ApproveRefundOnHoldQueueGet",
        "UserTypeId=$userTypeID&UserId=$userID&BookingType=");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      //log(jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          ApproveRefundOnHoldModel lm =
              ApproveRefundOnHoldModel.fromJson(list[i]);
          bookingCardData.add(lm);
        }
      } catch (error) {}
      return bookingCardData;
    });
  }

  void reloadPageAndHideData() {
    setState(() {
      // Toggle the flag to hide data

      // Pop the current route
      Navigator.of(context).pop();

      // Push the same page again
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => ApproveRefundQueue(),
        ),
      );
    });
  }
  /* static Future<List<FlightTicketOrderQueueGet>?>
  getFlightTicketOrderQueue() async {
    List<FlightTicketOrderQueueGet> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "FlightTicketOrderQueueGet",
        "UserTypeId=2&UserId=1035&Bookingdt=&BookingNo=&BookingType=flight");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      //log(jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          FlightTicketOrderQueueGet lm =
          FlightTicketOrderQueueGet.fromMap(list[i]);
          bookingCardData.add(lm);
        }
      } catch (error) {
        Fluttertoast.showToast(msg: error.toString());
      }
      return bookingCardData;
    });
  }*/

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
              "Approve Refund Queue",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Montserrat", fontSize: 17),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/lojologo.png',
            width: 150,
            height: 50,
          ),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: Color(0xFF00ADEE),
      ),
      body: Center(
        child: FutureBuilder<List<ApproveRefundOnHoldModel>?>(
            future: getFlightTicketOrderQueue(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!.length > 0) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
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
                                  color: Color(0xFF00ADEE),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 3,
                                      ),
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
                                                  child: Container(
                                                    width: 320,
                                                    child: Text(
                                                      "Trip Date: " +
                                                          snapshot.data![index]
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
                                        height: 28,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.book_outlined,
                                                    size: 14,
                                                  ),
                                                  Text(
                                                    "Booking Type: " +
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
                                            GestureDetector(
                                              onTap: () {
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: <Widget>[
                                                    CircularProgressIndicator(
                                                        color: Colors
                                                            .yellow), // Place the CircularProgressIndicator on top
                                                  ],
                                                );

                                                __futureLogin =
                                                    ResponseHandler.performPost(
                                                        "ApproveRefundQueueSet",
                                                        'BookFlightId=' +
                                                            snapshot
                                                                .data![index]
                                                                .bookFlightId);
                                                print(
                                                    'Response body: ${snapshot.data![index].bookFlightId}');
                                                __futureLogin?.then((value) {
                                                  print(
                                                      'Response body: ${value.body}');

                                                  String jsonResponse =
                                                      ResponseHandler.parseData(
                                                          value.body);

                                                  print(
                                                      'JSON Respertttonse: ghhj ${jsonResponse}');
                                                  reloadPageAndHideData();
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              5.0, 3, 5, 3),
                                                      decoration: BoxDecoration(
                                                        color: Colors.teal,
                                                        border: Border.all(
                                                            width: 0.1,
                                                            color: Color(0xFF00ADEE)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: Text(
                                                        'Approve',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(0xFF00ADEE),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5, bottom: 10),
                                              child: Text(
                                                snapshot
                                                    .data![index].paidAmount,
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
                                SizedBox(
                                  height: 7,
                                ),
                              ]),
                            ])));
                      });
                } else {
                  return Center(
                    child: Text(
                      'No data found',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
