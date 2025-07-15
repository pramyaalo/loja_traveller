import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Booking/ViewBookingDetails.dart';
 import '../utils/response_handler.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_preferences.dart';
import 'FlightTicketListFlightVoucher.dart';
import 'FlightTicketListModel.dart';

class FlightTicketList extends StatefulWidget {
  const FlightTicketList({Key? key}) : super(key: key);
  @override
  _BookingCardsState createState() => _BookingCardsState();
}

class _BookingCardsState extends State<FlightTicketList> {
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

  static String? Id;
  static Future<List<FlightTicketListModel>?> getLabels() async {
    List<FlightTicketListModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "FlightTicketGet",
        "SerUserTypeId=$userTypeID&SerUserId=$userID&LoginUserTypeId=0&LoginUserId=0&Bookingdt=&RefferNo=");

    return await __futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          FlightTicketListModel lm = FlightTicketListModel.fromJson(list[i]);

          bookingCardData.add(lm);
        }
      } catch (error) {
        // Fluttertoast.showToast(msg: error.toString());
      }
      return bookingCardData;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                "Flight Tickets",
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
        body: Center(
          child: FutureBuilder<List<FlightTicketListModel>?>(
              future: getLabels(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.length > 0) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: SingleChildScrollView(
                              child: Column(children: [
                                Container(
                                  margin: EdgeInsets.all(7),
                                  child: InkWell(
                                    child: PhysicalModel(
                                      color: Colors.white,
                                      elevation: 8,
                                      shadowColor: Color(0xff9a9ce3),
                                      borderRadius: BorderRadius.circular(4),
                                      child: Container(
                                        padding: EdgeInsets.all(7.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            if (snapshot.data![index]
                                                .ticketNo.isNotEmpty)
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Ticket No: ${snapshot.data![index].ticketNo ?? ""}",
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                    overflow: TextOverflow.ellipsis, // optional: adds "..." if overflow
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(
                                              height: 3,
                                            ),


                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 0), // Optional padding
                                              child: Text(
                                                snapshot.data![index].originDestination,
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2, // You can adjust as needed
                                                softWrap: true,
                                              ),
                                            ),


                                            SizedBox(
                                              height: 2,
                                            ),


                                            Row(
                                              children: [
                                                Expanded( // Ensures it takes available space
                                                  child: Text(
                                                    snapshot.data![index].passenger,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                    overflow: TextOverflow.ellipsis, // Shows "..." if too long
                                                    maxLines: 1,
                                                    softWrap: false,
                                                  ),
                                                ),
                                              ],
                                            ),


                                            SizedBox(height: 0),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Booking Date: " +
                                                          snapshot.data![index]
                                                              .bookedOnDt,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                          "Montserrat",
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (snapshot
                                                            .data![index].bookingType ==
                                                            "Flight") {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FlightTicketListFlightVoucher(PassengerID: snapshot
                                                                      .data![index]
                                                                      .passengerId,
                                                                      Id: snapshot
                                                                          .data![index]
                                                                          .bookFlightId),
                                                            ),
                                                          );
                                                        }
                                                        if (snapshot
                                                            .data![index].bookingType ==
                                                            "Hotel") {
                                                          /*Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  VouchersHotelReceipt(
                                                                      Id: snapshot
                                                                          .data![index]
                                                                          .bookFlightId),
                                                            ),
                                                          );*/
                                                        }

                                                        if (snapshot
                                                            .data![index].bookingType ==
                                                            "Car") {
                                                         /* Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  VouchersCarReceipt(
                                                                      Id: snapshot
                                                                          .data![index]
                                                                          .bookFlightId),
                                                            ),
                                                          );*/
                                                        }
                                                        if (snapshot
                                                            .data![index].bookingType ==
                                                            "Holiday") {
                                                        /*  Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  VouchersHolidayReceipt(
                                                                      Id: snapshot
                                                                          .data![index]
                                                                          .bookFlightId),
                                                            ),
                                                          );*/
                                                        }
                                                        if (snapshot
                                                            .data![index].bookingType ==
                                                            "Bus") {
                                                         /* Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  VouchersBusReceipt(
                                                                      Id: snapshot
                                                                          .data![index]
                                                                          .bookFlightId),
                                                            ),
                                                          );*/
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(right: 5),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets.fromLTRB(
                                                                  5.0, 3, 5, 3),
                                                              decoration: new BoxDecoration(
                                                                color: Colors.orange,
                                                                border: Border.all(
                                                                    width: 0.1,
                                                                    color: Colors
                                                                        .blue), //https://stackoverflow.com/a/67395539/16076689
                                                                borderRadius:
                                                                new BorderRadius.circular(
                                                                    5.0),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors.black
                                                                        .withOpacity(
                                                                        0.4), // Set the shadow color
                                                                    spreadRadius:
                                                                    2, // Set the spread radius of the shadow
                                                                    blurRadius:
                                                                    4, // Set the blur radius of the shadow
                                                                    offset: Offset(0,
                                                                        2), // Set the offset of the shadow
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Text(
                                                                "Receipt",
                                                                //snapshot.data![index].paidStatus,
                                                                style: TextStyle(
                                                                    fontFamily: "Montserrat",
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                    FontWeight.w500,
                                                                    color: Colors.white),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
SizedBox(height: 3,),

                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 230,
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
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontFamily: "Montserrat",
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await saveIdToPreferences(
                                                    snapshot.data![index]
                                                        .bookFlightId);
                                                print('prami' +
                                                    snapshot.data![index]
                                                        .bookFlightId);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewBookingDetails(
                                                            id: snapshot
                                                                .data![index]
                                                                .bookFlightId),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 20,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.book_outlined,
                                                          size: 14,
                                                        ),
                                                        Text(
                                                          "Journey Type: " +
                                                              snapshot
                                                                  .data![index]
                                                                  .journey,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                              "Montserrat",
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontSize: 15,
                                                              color:
                                                              Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .totalAmount,
                                                      style: TextStyle(
                                                          fontFamily:
                                                          "Montserrat",
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            BookingCardMenu()
                    )
                );*/
                                    },
                                  ),
                                ),
                              ]),
                            ),
                          );
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
        ));
  }
}Color getBookingStatusColor(String? status) {
  if (status == null || status.trim().isEmpty || status.trim().toLowerCase() == "null" || status == "Unconfirmed") {
    return Colors.purple; // Violet
  } else if (status == "Processing") {
    return Colors.redAccent; // Cancelling
  } else {
    return _getBackgroundColor(status);
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
  } else if (bookingStatus == 'Null') {
    return Color(0xFFFF7588);
  } else {
    return Color(0xFFFF7588);
  }
}
String getDisplayStatus(String? status) {
  if (status == null || status.trim().isEmpty || status.trim().toLowerCase() == "null") {
    return "Unconfirmed";
  } else if (status == "Processing") {
    return "Cancelling";
  } else {
    return status;
  }
}

Future<void> saveIdToPreferences(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userId', id);
}
