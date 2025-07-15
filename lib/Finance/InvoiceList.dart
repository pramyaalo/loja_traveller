import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'InvoiceBusReceipt.dart';
import 'InvoiceFlightListReceipt.dart';
import 'InvoiceHolidayReceipt.dart';
import 'InvoiceHotelReceipt.dart';
import 'InvoiceListHotel.dart';
import 'InvoiceReceiptModel.dart';
import 'InvoicecarReceipt.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({Key? key}) : super(key: key);

  @override
  State<InvoiceList> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<InvoiceList> {
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

  static Future<List<InvoiceReceiptModel>?> getLabels() async {
    List<InvoiceReceiptModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "InvoiceListGet",
        "UserTypeId=$userTypeID&UserId=$userID&LoginUserTypeId=0&LoginUserId=0&Status=&BookingNo=&RefferNo=&Bookingdt=&StaffId=0");
    print('jfghhjgh');
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        print('jfghhjtyttttgh' + map.toString());
        List<dynamic> list = map["Table"];
        print("fkghgjk" + list.length.toString());
        for (int i = 0; i < list.length; i++) {
          InvoiceReceiptModel lm = InvoiceReceiptModel.fromJson(list[i]);
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
                "Invoice List",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Montserrat",
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
          child: FutureBuilder<List<InvoiceReceiptModel>?>(
              future: getLabels(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(
                              right: 10, left: 10, top: 7),
                          elevation: 5,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].passenger,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Container(
                                          width: 320,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3),
                                            child: Text(
                                              snapshot.data![index]
                                                  .originDestination,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          const IconData(0xefc6,
                                              fontFamily: 'MaterialIcons'),
                                          size: 15,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(right: 0),
                                          child: Text(
                                            "Product: " +
                                                snapshot
                                                    .data![index].bookingType,
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
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
                                        color: Color(0xFF152238),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 5),
                                        child: Text(
                                          "Journey: " +
                                              snapshot.data![index].journey,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Color(0xFF152238),
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
//InvoiceListReceipt
                                      if (snapshot.data![index].bookingType ==
                                          "Flight") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                InvoiceListReceipt(
                                                    Id: snapshot.data![index]
                                                        .bookFlightId),
                                          ),
                                        );
                                      }
                                      if (snapshot.data![index].bookingType ==
                                          "Hotel") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                InvoiceListHotel(
                                                    Id: snapshot.data![index]
                                                        .bookFlightId),
                                          ),
                                        );
                                      }

                                      if (snapshot.data![index].bookingType ==
                                          "Car") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                InvoicecarReceipt(
                                                    Id: snapshot
                                                        .data![index]
                                                        .bookFlightId),
                                          ),
                                        );
                                      }
                                      if (snapshot.data![index].bookingType ==
                                          "Holiday") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                InvoiceHolidayReceipt(
                                                    Id: snapshot.data![index]
                                                        .bookFlightId),
                                          ),
                                        );
                                      }
                                      if (snapshot.data![index].bookingType ==
                                          "Bus") { Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              InvoiceBusReceipt(
                                                  Id: snapshot
                                                      .data![index]
                                                      .bookFlightId),
                                        ),
                                      );}


                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                3.0, 2, 3, 2),
                                            decoration: new BoxDecoration(
                                              color: Colors.orange,
                                              border: Border.all(
                                                  width: 0.1,
                                                  color: Color(0xFF152238)),
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  spreadRadius: 2,
                                                  blurRadius: 4,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              "Receipt",
                                              //snapshot.data![index].paidStatus,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/images/tickiconpng.png'),
                                                color: Color(0xFF152238),
                                                width: 16,
                                                height: 16,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0),
                                              child: Text(
                                                "Booking Date: " +
                                                    snapshot.data![index]
                                                        .bookedOnDt,
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color: Color(0xFF152238)),
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
                                  Text(
                                    "Price(Incl. Tax)",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Container(
                                height: 25,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: FractionalOffset.topLeft,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.book_outlined,
                                            size: 12,
                                          ),
                                          Text(
                                            "Booking ID: ",
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            snapshot.data![index].bookFlightId,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Text(
                                        snapshot.data![index].totalAmount,
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
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
