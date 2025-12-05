import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/CancelledFlightBookingModel.dart';
import '../Models/UnconfirmedBookingModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';

class CancelledBooking extends StatefulWidget {
  const CancelledBooking({Key? key}) : super(key: key);

  @override
  State<CancelledBooking> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<CancelledBooking> {
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

  static Future<List<CancelledFlightBookingModel>?> getPartPaymentData() async {
    List<CancelledFlightBookingModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "BookingCancellationReportGet",
        "SerUserTypeId=$userTypeID&SerUserId=$userID&StaffId=0&FromDate=&ToDate=");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      log(jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          CancelledFlightBookingModel lm =
              CancelledFlightBookingModel.fromJson(list[i]);
          bookingCardData.add(lm);
        }
      } catch (error) {}
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
                "Cancelled Booking",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontSize: 19),
              ),
            ],
          ),
          actions: [
            Image.asset(
              'assets/images/lojolog.png',
              width: 100,
              height: 50,
            ),

          ],
          backgroundColor:Color(0xFF00ADEE),
        ),
        body: Center(
          child: FutureBuilder<List<CancelledFlightBookingModel>?>(
              future: getPartPaymentData(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
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
                                    margin: const EdgeInsets.only(right: 10, left: 10, top: 7),
                                    elevation: 5,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Booking ID: ${snapshot.data![index].bookingId}",
                                                      style: const TextStyle(
                                                        fontFamily: "Montserrat",
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                    SizedBox(height: 3),
                                                    Text(
                                                      snapshot.data![index].passenger,
                                                      style: const TextStyle(
                                                        fontFamily: "Montserrat",
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                    SizedBox(height: 3),
                                                    Text(
                                                      "Cancelled date: ${snapshot.data![index].bookedOnDt}",
                                                      style: const TextStyle(
                                                        fontFamily: "Montserrat",
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.redAccent,
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(width: 0.1, color: Color(0xFF00ADEE)),
                                                ),
                                                child: Text(
                                                  snapshot.data![index].bookingStatus,
                                                  style: const TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/tickiconpng.png',
                                                    color: Color(0xFF152238),
                                                    width: 16,
                                                    height: 16,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    "Trip Date: ${snapshot.data![index].tripDate}",
                                                    style: const TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                      color: Color(0xFF152238),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Divider(color: Color(0xffededed), thickness: 1),
                                              ),
                                              const SizedBox(width: 10),
                                              const Text(
                                                "Price(Incl. Tax)",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(Icons.book_outlined, size: 14),
                                                  const SizedBox(width: 4),
                                                  const Text(
                                                    "Journey Type: ",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data![index].journeyType,
                                                    style: const TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                snapshot.data![index].totalAmt,
                                                style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )

                                ]),
                              ])));
                        });
                  } else {
                    return Center(
                      child: Text(
                        'No data found',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    );
                  }
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}
