import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Booking/EmailTicketModel.dart';
import '../Receipt/InvoiceReceipt.dart';
import '../Receipt/IssueVouchersReceipt.dart';
import 'package:http/http.dart' as http;

import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
class EmailTicket extends StatefulWidget {
  const EmailTicket({Key? key}) : super(key: key);

  @override
  State<EmailTicket> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<EmailTicket> {
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
  static Future<List<EmailTicketModel>?> getLabels() async {
    List<EmailTicketModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "CustomerTicketMailGet",
        "UserTypeId=$userTypeID&UserId=$userID&BookingType=&Bookingdt=&BookFlightId=0");
    print('jfghhjgh');
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        print('jfghhjgh');
        for (int i = 0; i < list.length; i++) {
          EmailTicketModel lm = EmailTicketModel.fromJson(list[i]);
          labelData.add(lm);
        }
      } catch (error) {
        log(error.toString());
      }
      return labelData;
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
                      "Email Ticket",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontSize: 17.5),
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
                child: FutureBuilder<List<EmailTicketModel>?>(
                    future: getLabels(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
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
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(
                                                              left: 10, top: 10),
                                                          child: Text(
                                                            "Booking Ref: " +
                                                                snapshot.data![index]
                                                                    .bookingNumber,
                                                            style: TextStyle(
                                                              fontFamily: "Montserrat",
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.bold,
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
                                                          padding: const EdgeInsets.only(
                                                            left: 10,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(width: 320,
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets.only(
                                                                      right: 0),
                                                                  child: Text(

                                                                        snapshot.data![index]
                                                                            .bookCardPassenger,
                                                                    style: TextStyle(
                                                                      fontFamily:
                                                                      "Montserrat",
                                                                      fontWeight:
                                                                      FontWeight.w500,
                                                                      fontSize: 14,
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
                                                      color:  Color(0xFF152238),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: Text(
                                                        snapshot.data![index]
                                                            .bookingNumber,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                          color:  Color(0xFF152238),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),*/
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        SizedBox(width:250,
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(
                                                                left: 10),
                                                            child: Text(
                                                              "Date: " +
                                                                  snapshot
                                                                      .data![index].bookingCardServiceDate,
                                                              style: TextStyle(
                                                                fontFamily: "Montserrat",
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(
                                                              right: 5),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                EdgeInsets.fromLTRB(
                                                                    5.0, 2.5, 5, 2.5),
                                                                decoration: BoxDecoration(
                                                                  color: _getBackgroundColor(
                                                                      snapshot.data![index]
                                                                          .bookingStatus),
                                                                  border: Border.all(
                                                                      width: 0.1,
                                                                      color: Colors.white),
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      5.0),
                                                                ),
                                                                child: Text(
                                                                  snapshot
                                                                      .data![index]
                                                                      .bookingStatus
                                                                      .isEmpty ||
                                                                      snapshot
                                                                          .data![
                                                                      index]
                                                                          .bookingStatus ==
                                                                          null
                                                                      ? "Null"
                                                                      : snapshot
                                                                      .data![index]
                                                                      .bookingStatus,
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
                                                        /*Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Row(
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
                                                                            15),
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      'assets/images/tickiconpng.png'),
                                                                  color: Colors
                                                                      .blue,
                                                                  width: 16,
                                                                  height: 16,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            15),
                                                                child: Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .BookingType,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "Montserrat",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ])),*/
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: 230,
                                                          height: 1,
                                                          child: DecoratedBox(
                                                            decoration: const BoxDecoration(
                                                                color: Color(0xffededed)),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(
                                                              right: 4),
                                                          child: Text(
                                                            "Amount (Incl. Tax)",
                                                            style: TextStyle(
                                                                fontFamily: "Montserrat",
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight.w500),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Expanded( // Makes sure left content doesn't push right content out
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 10),
                                                              child: Row(
                                                                children: [
                                                                  Icon(Icons.book_outlined, size: 14),
                                                                  SizedBox(width: 4),
                                                                  Text(
                                                                    "Booking Type: ",
                                                                    style: TextStyle(
                                                                      fontFamily: "Montserrat",
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 14,
                                                                    ),
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                  SizedBox(width: 2),
                                                                  Expanded(
                                                                    child: Text(
                                                                      snapshot.data![index].bookingType,
                                                                      style: TextStyle(
                                                                        fontFamily: "Montserrat",
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                      overflow: TextOverflow.ellipsis,
                                                                      maxLines: 1,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(right: 4),
                                                            child: Text(
                                                              snapshot.data![index].bookCardAmount,
                                                              style: TextStyle(
                                                                fontFamily: "Montserrat",
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
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
                    })))
    );
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
  } else if (bookingStatus == 'CONFIRMED') {
    return Colors.greenAccent;
  } else if (bookingStatus == 'Booked') {
    return Colors.orange;
  } else if (bookingStatus == 'No') {
    return Color(0xFFFF7588);
  } else if (bookingStatus == 'Null') {
    return Color(0xFFFF7588);
  } else {
    return Color(0xFFFF7588);
  }
}