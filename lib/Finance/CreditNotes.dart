import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Booking/CreditNoteBusReceipt.dart';
import '../Booking/CreditNoteCarReceipt.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'CreditNoteHolidayReceipt.dart';
import 'CreditNoteHotelReceipt.dart';
import 'CreditNoteListModel.dart';
import 'CreditNoteFlightReceipt.dart';

class CreditNoteInvoiceList extends StatefulWidget {
  const CreditNoteInvoiceList({Key? key}) : super(key: key);

  @override
  State<CreditNoteInvoiceList> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<CreditNoteInvoiceList> {
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

  static Future<List<CreditNoteListModel>?> getLabels() async {
    List<CreditNoteListModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "CreditNoteGet",
        "UserTypeId=$userTypeID&UserId=$userID&LoginUserTypeId=0&LoginUserId=0&Status=&BookingNo=&RefferNo=&Bookingdt=&StaffId=0");
    print('jfghhjgh');
    return await __futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        print('jfghhjtyttttgh' + map.toString());



        List<dynamic> list = map["Table"];
        print("fkghgjk" + list.length.toString());
        for (int i = 0; i < list.length; i++) {
          CreditNoteListModel lm = CreditNoteListModel.fromJson(list[i]);
          labelData.add(lm);
          print("fkghgjk" + lm.bookingStatus);
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
                "Credit Note",
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
          child: FutureBuilder<List<CreditNoteListModel>?>(
              future: getLabels(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(
                              right: 10, left: 10, top: 7),
                          elevation: 5,
                          shadowColor: Color(0xff9a9ce3),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        snapshot.data![index].passenger,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.fromLTRB(5.0, 3, 5, 3),
                                      decoration: new BoxDecoration(
                                        color: Colors.orange,
                                        border: Border.all(
                                          width: 0.1,
                                          color: Color(0xFF00ADEE),
                                        ),
                                        borderRadius:
                                        new BorderRadius.circular(5.0),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (snapshot
                                              .data![index].bookingType ==
                                              "Flight") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CreditNoteFlightReceipt(
                                                        Id: snapshot
                                                            .data![index]
                                                            .bookFlightId),
                                              ),
                                            );
                                          }

                                          if (snapshot
                                              .data![index].bookingType ==
                                              "Holiday") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CreditNoteHolidayReceipt(
                                                        Id: snapshot
                                                            .data![index]
                                                            .bookFlightId),
                                              ),
                                            );
                                          }

                                          if (snapshot
                                              .data![index].bookingType ==
                                              "Hotel") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CreditNoteHotelReceipt(
                                                        Id: snapshot
                                                            .data![index]
                                                            .bookFlightId),
                                              ),
                                            );
                                          }
                                          if (snapshot
                                              .data![index].bookingType ==
                                              "Car") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CreditNoteCarReceipt(
                                                        Id: snapshot
                                                            .data![index]
                                                            .bookFlightId),
                                              ),
                                            );
                                          }

                                          if (snapshot
                                              .data![index].bookingType ==
                                              "Bus") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CreditNoteBusReceipt(
                                                        Id: snapshot
                                                            .data![index]
                                                            .bookFlightId),
                                              ),
                                            );
                                          }
                                          //
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "View",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 290,
                                      child: Text(
                                        snapshot.data![index].bookingType +
                                            " " +
                                            "Details: " +
                                            snapshot.data![index].originDestination,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 160,
                                      child: Text(
                                        "Type: " +
                                            snapshot.data![index].bookingType,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: 10), // Adjust spacing as needed
                                    Text(
                                      'Fare: ' +snapshot.data![index].currency+" "+
                                          snapshot.data![index].totalFare,
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Date: " +
                                            snapshot.data![index].bookedOnDt,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      flex: 5,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "GST: " +snapshot.data![index].currency+" "+
                                            snapshot.data![index].gst,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      flex: 5,
                                    ), // Adjust spacing as needed
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "PNR: " +
                                            snapshot.data![index].ticketNo,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      flex: 5,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "Tax: " +snapshot.data![index].currency+" "+
                                            snapshot.data![index].serviceTax,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      flex: 5,
                                    ), // Adjust spacing as needed
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 246,
                                      height: 1,
                                      child: DecoratedBox(
                                        decoration: const BoxDecoration(
                                            color: Color(0xffededed)),
                                      ),
                                    ),
                                    Text(
                                      "Total Amount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Montserrat",
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 26,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Booking ID: " +
                                                snapshot.data![index].bookFlightId,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Montserrat",
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        snapshot.data![index].totalAmount,
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}
