import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'UnTicketReportModel.dart';

class UnTicketReport extends StatefulWidget {
  const UnTicketReport({Key? key}) : super(key: key);

  @override
  _TicketReportState createState() => _TicketReportState();
}

class _TicketReportState extends State<UnTicketReport> {
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

  static Future<List<UnTicketReportModel>?> getLabels() async {
    List<UnTicketReportModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "UnTicketReportGet",
        "UserTypeId=$userTypeID&UserId=$userID&BookingNumber=&FromDate=&ToDate=");
    print('jfghhjgh');
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          UnTicketReportModel lm = UnTicketReportModel.fromJson(list[i]);
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
                "UnTicket Report",
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
            child: FutureBuilder<List<UnTicketReportModel>?>(
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
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      child: PhysicalModel(
                                        color: Colors.white,
                                        elevation: 8,
                                        shadowColor: const Color(0xff9a9ce3),
                                        borderRadius: BorderRadius.circular(4),
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      snapshot.data![index].passenger,
                                                      style: const TextStyle(
                                                        fontFamily: "Montserrat",
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  'Booking Date: ' +
                                                      snapshot.data![index]
                                                          .bookedOnDt,
                                                  style: TextStyle(
                                                    fontFamily:
                                                    "Montserrat",
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),

                                              Row( mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,children: [   Container(
                                                padding:
                                                EdgeInsets.fromLTRB(
                                                    5.0, 3, 5, 3),
                                                decoration:
                                                new BoxDecoration(
                                                  color: Colors.redAccent,
                                                  border: Border.all(
                                                    width: 0.1,
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                  new BorderRadius
                                                      .circular(5.0),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "UnTicketed",
                                                        style: TextStyle(
                                                          fontFamily:
                                                          "Montserrat",
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          color:
                                                          Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ), Row(
                                                children: [
                                                  Image(
                                                    image: AssetImage(
                                                        'assets/images/tickiconpng.png'),
                                                    width: 16,
                                                    height: 16,
                                                    color: Color(0xFF00ADEE),
                                                  ),
                                                  Text(
                                                    "Product: " +
                                                        snapshot
                                                            .data![index]
                                                            .bookingProduct,
                                                    style: TextStyle(
                                                        fontFamily:
                                                        "Montserrat",
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 15,
                                                        color: Color(0xFF00ADEE)),
                                                  ),
                                                ],
                                              ),],),



                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 230,
                                                    height: 1,
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          color: Color(0xffededed)),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Price(Incl. Tax)",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: "Montserrat",
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 18,
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
                                                          "Booking Id: ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontFamily:
                                                              "Montserrat",
                                                              fontSize: 15),
                                                        ),
                                                        Container(
                                                          width: 95,
                                                          child: Text(
                                                            snapshot.data![index]
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
                                                    Text(
                                                      snapshot.data![index]
                                                          .bookCardAmount,
                                                      style: TextStyle(
                                                          fontFamily: "Montserrat",
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
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                })));
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
  } else if (bookingStatus == 'Reserved') {
    return Colors.orange;
  } else if (bookingStatus == 'No') {
    return Color(0xFFFF7588);
  } else {
    return Colors.black;
  }
}
