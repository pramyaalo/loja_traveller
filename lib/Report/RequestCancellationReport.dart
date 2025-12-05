import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/BookingCancellationReportModel.dart';
import '../Models/BookingReportModel.dart';
import '../utils/response_handler.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_preferences.dart';
import 'RequestCancellationReportModel.dart';

class RequestCancellationReport extends StatefulWidget {
  const RequestCancellationReport({Key? key}) : super(key: key);

  @override
  _BookingReportState createState() => _BookingReportState();
}

class _BookingReportState extends State<RequestCancellationReport> {
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

  static Future<List<RequestCancellationReportModel>?> getLabels() async {
    List<RequestCancellationReportModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "RequestCancellationReportGet",
        "SerUserTypeId=$userTypeID&SerUserId=$userID&StaffId=0&FromDate=&ToDate=");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          RequestCancellationReportModel lm =
          RequestCancellationReportModel.fromJson(list[i]);
          labelData.add(lm);
        }
      } catch (error) {}
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
                "Request Cancellation",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Montserrat",
                    fontSize: 18),
              ),
            ],
          ),
          actions: [
            Image.asset(
              'assets/images/lojologg.png',
              width: 100,
              height: 50,
            ),

          ],
          backgroundColor:Color(0xFF00ADEE),
        ),
        body: Center(
          child: FutureBuilder<List<RequestCancellationReportModel>?>(
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
                                                        snapshot.data![index].bookingId,
                                                        style: TextStyle(
                                                          fontFamily: "Montserrat",
                                                          fontSize: 16,
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
                                                            const EdgeInsets.only(
                                                                right: 0),
                                                            child: Text(
                                                              "Request No: " +
                                                                  snapshot.data![index]
                                                                      .requestNumber,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                "Montserrat",
                                                                fontWeight:
                                                                FontWeight.w500,
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
                                                          color:  Color(0xFF152238),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                          child: Text(
                                                            "Status: " +
                                                                snapshot.data![index]
                                                                    .status,
                                                            style: TextStyle(
                                                              fontFamily: "Montserrat",
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 15,
                                                              color:  Color(0xFF152238),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
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
                                                          left: 10),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.only(
                                                                right: 0),
                                                            child: Text(
                                                              "Type: " +
                                                                  snapshot.data![index]
                                                                      .type,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                "Montserrat",
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                        padding: const EdgeInsets.only(
                                                            right: 5),
                                                        child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.end,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom: 0),
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
                                                                        bottom: 0),
                                                                    child: Text(
                                                                      snapshot
                                                                          .data![index]
                                                                          .createdDate,
                                                                      style: TextStyle(
                                                                        fontFamily:
                                                                        "Montserrat",
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                        fontSize: 14,
                                                                        color:
                                                                        Color(0xFF152238),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ])), // Adds space between the two parts of the row
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3,
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
                                                                10.0, 5, 10, 5),
                                                            decoration: BoxDecoration(
                                                              color: Colors.orange,
                                                              border: Border.all(
                                                                  width: 0.1,
                                                                  color: Colors.white),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  5.0),
                                                            ),
                                                            child: Text(
                                                              snapshot.data![index]
                                                                  .requestAction ==
                                                                  "0"
                                                                  ? "No"
                                                                  : "Yes",
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
                                                    Row(
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
                                                            "Time: " +
                                                                snapshot.data![index]
                                                                    .requestTime,
                                                            style: TextStyle(
                                                              fontFamily: "Montserrat",
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 15,
                                                              color:  Color(0xFF152238),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8,
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
              }),
        ));
  }
}
