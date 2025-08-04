import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/BookingCardModel.dart';
import '../utils/response_handler.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_preferences.dart';
import 'ViewBookingDetails.dart';

class BookingCard extends StatefulWidget {
  const BookingCard({Key? key}) : super(key: key);
  @override
  _BookingCardsState createState() => _BookingCardsState();
}

class _BookingCardsState extends State<BookingCard> {
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
  static Future<List<BookingCardModel>?> getLabels() async {
    List<BookingCardModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "BookingCardListGet",
        "UserTypeId=$userTypeID&UserId=$userID&StaffId=0&BookingNo=&BookingType=&Bookingdt=");

    return await __futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          BookingCardModel lm = BookingCardModel.fromJson(list[i]);

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
                  "Booking Card",
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
            backgroundColor:Color(0xFF00ADEE)),
        body: Center(
          child: FutureBuilder<List<BookingCardModel>?>(
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
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "BookingId: ${snapshot.data![index].bookFlightId ?? ""}",
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                    overflow: TextOverflow.ellipsis, // optional: adds "..." if overflow
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(
                                              height: 3,
                                            ),
                                            if (snapshot.data![index]
                                                .bookCardDescription.isNotEmpty)
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 320,
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .bookCardDescription,
                                                          style: TextStyle(
                                                              fontFamily:
                                                              "Montserrat",
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            if (snapshot.data![index]
                                                .bookCardPassenger.isNotEmpty)
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 320,
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .bookCardPassenger,
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
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
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ViewBookingDetails(
                                                                    id: snapshot
                                                                        .data![
                                                                    index]
                                                                        .bookFlightId),
                                                          ),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(left: 10),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                  7,
                                                                  3,
                                                                  7,
                                                                  3),
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .orange,
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
                                                                "View",
                                                                //snapshot.data![index].paidStatus,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "Montserrat",
                                                                    fontSize:
                                                                    15,
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
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                                                      decoration: BoxDecoration(
                                                        color: getBookingStatusColor(snapshot.data![index].bookingStatus),
                                                        border: Border.all(width: 0.1, color: Color(0xFF00ADEE)),
                                                        borderRadius: BorderRadius.circular(5.0),
                                                      ),
                                                      child: Text(
                                                        getDisplayStatus(snapshot.data![index].bookingStatus),
                                                        style: const TextStyle(
                                                          fontFamily: "Montserrat",
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.white,
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
                                                          "Booking Type: " +
                                                              snapshot
                                                                  .data![index]
                                                                  .bookingType,
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
                                                          .bookingAmount,
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
