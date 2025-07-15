import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/BookingRefundDuegetModel.dart';
import '../utils/response_handler.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_preferences.dart';

class BookingRefundsDue extends StatefulWidget {
  const BookingRefundsDue({Key? key}) : super(key: key);

  @override
  State<BookingRefundsDue> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<BookingRefundsDue> {
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

  static Future<List<BookingRefundDuegetModel>?> getPartPaymentData() async {
    List<BookingRefundDuegetModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "BookingRefundsDueGet",
        "AgencyId=$userID&UserTypeId=$userTypeID&UserId=$userID&BookingType=");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          BookingRefundDuegetModel lm =
              BookingRefundDuegetModel.fromJson(list[i]);
          bookingCardData.add(lm);
        }
      } catch (error) {}
      return bookingCardData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                    "Booking Refunds",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontSize: 19),
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
                child: FutureBuilder<List<BookingRefundDuegetModel>?>(
                    future: getPartPaymentData(),
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
                                          color: Colors.white,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10, top: 10),
                                                    child: Text(
                                                      snapshot.data![index]
                                                          .passenger,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5, top: 10),
                                                    child: Text(
                                                      "Pay Mode: " +
                                                          snapshot.data![index]
                                                              .payMode,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          const IconData(0xefc6,
                                                              fontFamily:
                                                                  'MaterialIcons'),
                                                          size: 15,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 0),
                                                          child: Text(
                                                            "Product: " +
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .bookedProduct,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(), // Adds space between the two parts of the row
                                                  Row(
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
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Text(
                                                          "Paid Status: " +
                                                              snapshot
                                                                  .data![index]
                                                                  .paidStatus,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15,
                                                            color: Color(0xFF00ADEE),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  5.0, 3, 5, 3),
                                                          decoration:
                                                              new BoxDecoration(
                                                            color: _getBackgroundColor(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .bookingStatus),
                                                            border: Border.all(
                                                                width: 0.1,
                                                                color: Colors
                                                                    .blue), //https://stackoverflow.com/a/67395539/16076689
                                                            borderRadius:
                                                                new BorderRadius
                                                                    .circular(
                                                                    5.0),
                                                          ),
                                                          child: Text(
                                                            snapshot
                                                                .data![index]
                                                                .bookingStatus,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          0),
                                                              child: Image(
                                                                image: AssetImage(
                                                                    'assets/images/tickiconpng.png'),
                                                                color:
                                                                    Color(0xFF00ADEE),
                                                                width: 16,
                                                                height: 16,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          0),
                                                              child: Text(
                                                                "Trip Date: " +
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .tripDate,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Montserrat",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 250,
                                                    height: 1,
                                                    child: DecoratedBox(
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: Color(
                                                                  0xffededed)),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Price(Incl. Tax)",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                height: 25,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          FractionalOffset
                                                              .topLeft,
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "Booking ID: ",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15),
                                                          ),
                                                          Container(
                                                            width: 130,
                                                            child: Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .bookingId,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .totalAmt,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                    }))));
  }
}

Color _getBackgroundColor(String bookingStatus) {
  if (bookingStatus == 'TicketIssued') {
    return Color(0xFF16D39A);
  } else if (bookingStatus == 'Processing') {
    return Color(0xFFFF66CC);
  } else if (bookingStatus == 'Cancelled') {
    return Color(0xFFFF7588);
  } else if (bookingStatus == 'Confirmed') {
    return Colors.greenAccent;
  } else if (bookingStatus == 'Reserved') {
    return Colors.orange;
  } else if (bookingStatus == 'No') {
    return Color(0xFFFF7588);
  } else {
    return Colors.black;
  }
}
