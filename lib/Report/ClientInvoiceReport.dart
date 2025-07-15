import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/response_handler.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_preferences.dart';
import 'ClientInvoiceReportModel.dart';

class ClientInvoiceReport extends StatefulWidget {
  const ClientInvoiceReport({Key? key}) : super(key: key);

  @override
  _ClientInvoiceReportState createState() => _ClientInvoiceReportState();
}

class _ClientInvoiceReportState extends State<ClientInvoiceReport> {
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

  static Future<List<ClientInvoiceReportModel>?> getLabels() async {
    List<ClientInvoiceReportModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "ClientInvoiceReportGet",
        "BookingID=&BookingNo=&UserTypeId=$userTypeID&UserId=$userID&StaffId=0&Status=");
    print('jfghhjgh');
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          ClientInvoiceReportModel lm =
          ClientInvoiceReportModel.fromJson(list[i]);
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
                "Client Invoice Report",
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
        body: Center(
            child: FutureBuilder<List<ClientInvoiceReportModel>?>(
                future: getLabels(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.isEmpty) {
                      return Text('No data');
                    } else {
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
                                                          snapshot
                                                              .data![index].passenger,
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
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 10),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              const Padding(
                                                                padding: EdgeInsets.only(left: 10, right: 4),
                                                                child: Icon(
                                                                  IconData(0xefc6, fontFamily: 'MaterialIcons'),
                                                                  size: 15,
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  "Product: ${snapshot.data![index].bookingType}",
                                                                  style: const TextStyle(
                                                                    fontFamily: "Montserrat",
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 15,
                                                                  ),
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              const Image(
                                                                image: AssetImage('assets/images/tickiconpng.png'),
                                                                width: 16,
                                                                height: 16,
                                                                color: Color(0xFF152238),
                                                              ),
                                                              const SizedBox(width: 4),
                                                              Flexible(
                                                                child: Text(
                                                                  "Ticket No: ${snapshot.data![index].ticketNo}",
                                                                  style: const TextStyle(
                                                                    fontFamily: "Montserrat",
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 15,
                                                                    color: Color(0xFF152238),
                                                                  ),
                                                                  overflow: TextOverflow.ellipsis,
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),


                                                  SizedBox(
                                                    height: 0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 10),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              padding:
                                                              EdgeInsets.fromLTRB(
                                                                  7.0, 2.5, 7, 2.5),
                                                              decoration: BoxDecoration(
                                                                color: (snapshot.data![index].bookingStatus == "" || snapshot.data![index].bookingStatus != "NO")
                                                                    ? Colors.green
                                                                    : Colors.red,
                                                                border: Border.all(
                                                                    width: 0.1,
                                                                    color: Colors.white),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(5.0),
                                                              ),
                                                              child: Text(
                                                                (snapshot.data![index].bookingStatus == "" || snapshot.data![index].bookingStatus != "NO")
                                                                    ? "Confirmed"
                                                                    : "Pending",
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
                                                      Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              right: 10),
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
                                                                          0),
                                                                      child: Image(
                                                                        image: AssetImage(
                                                                            'assets/images/tickiconpng.png'),
                                                                        color:
                                                                        Color(0xFF152238),
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
                                                                        "Booking Date: " +
                                                                            snapshot
                                                                                .data![
                                                                            index]
                                                                                .bookedOnDt,
                                                                        style:
                                                                        TextStyle(
                                                                          fontFamily:
                                                                          "Montserrat",
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                          fontSize: 15,
                                                                          color: Colors
                                                                              .blue,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ])),
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
                                                          decoration:
                                                          const BoxDecoration(
                                                              color: Color(
                                                                  0xffededed)),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            right: 4),
                                                        child: Text(
                                                          "Price(Incl. Tax)",
                                                          style: TextStyle(
                                                              fontFamily: "Montserrat",
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [

                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 10),
                                                              child: Text(
                                                                "Booking Id: ",
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontFamily: "Montserrat",
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: 4),
                                                            Expanded(
                                                              child: Text(
                                                                snapshot.data![index].bookingId,
                                                                style: TextStyle(
                                                                  fontFamily: "Montserrat",
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                                softWrap: true,
                                                                overflow: TextOverflow.visible,
                                                                maxLines: 3, // Wrap into max 3 lines
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10),
                                                        child: Text(
                                                          snapshot.data![index].totalAmount,
                                                          style: TextStyle(
                                                            fontFamily: "Montserrat",
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                        ])));
                          });
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                })));
  }
}

Color _getBackgroundColor(String bookingStatus) {
  if (bookingStatus == 'TicketIssued') {
    return Color(0xFF16D39A);
  }else  if (bookingStatus == 'CONFIRMED') {
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
