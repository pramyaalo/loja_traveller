import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/PartPaymentModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';

class PartPayment extends StatefulWidget {
  const PartPayment({Key? key}) : super(key: key);

  @override
  State<PartPayment> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<PartPayment> {
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

  static Future<List<PartPaymentModel>?> getPartPaymentData() async {
    List<PartPaymentModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "PartPaymentListGet",
        "UserId=$userID&UserTypeId=$userTypeID&BookingType=");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          PartPaymentModel lm = PartPaymentModel.fromJson(list[i]);
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
              "Part Payment",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Montserrat", fontSize: 19),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/lojolog.png',
            width: 100,
            height: 50,
          ),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: Color(0xFF152238),
      ),
      body: Center(
        child: FutureBuilder<List<PartPaymentModel>?>(
          future: getPartPaymentData(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.length > 0) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(7),
                        child: InkWell(
                          child: PhysicalModel(
                            color: Colors.white,
                            elevation: 8,
                            shadowColor: Color(0xff9a9ce3),
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                // Add any other widgets on the right end of the second row

                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data![index].FullName ?? "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Product: " +
                                                  snapshot.data![index]
                                                      .BookingType ??
                                              "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          )),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 0),
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/tickiconpng.png'),
                                                        color:  Color(0xFF152238),
                                                        width: 16,
                                                        height: 16,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 0),
                                                      child: Text(
                                                        "Booking Date: " +
                                                            snapshot
                                                                .data![index]
                                                                .BookedOnDt,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          color:  Color(0xFF152238),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ])),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Trip Date: " +
                                                  snapshot.data![index]
                                                      .DateOfPayment ??
                                              "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          )),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 0),
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/tickiconpng.png'),
                                                        color:  Color(0xFF152238),
                                                        width: 16,
                                                        height: 16,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 0),
                                                      child: Text(
                                                        "Due Date: " +
                                                            snapshot
                                                                .data![index]
                                                                .DueDate,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          color:  Color(0xFF152238),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ])),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0,
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
                                      Text(
                                        "Price(Incl. Tax)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat",
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 18,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: FractionalOffset.topLeft,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 2,
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
                                                snapshot.data![index].BookingId,
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data![index].Currency}" +
                                              "${snapshot.data![index].PartPayment}",
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
                          ),
                          onTap: () {},
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
          },
        ),
      ),
    ));
  }
}
