import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'WalletSTatementReportModel.dart';


class WalletStateMentreport extends StatefulWidget {
  const WalletStateMentreport({Key? key}) : super(key: key);

  @override
  State<WalletStateMentreport> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<WalletStateMentreport> {
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

  static Future<List<WalletSTatementReportModel>?> getLabels() async {
    List<WalletSTatementReportModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "WalletStatementGet",
        "UserTypeId=$userTypeID&UserId=$userID&LoginUserTypeId=0&LoginUserId=0&FromDate=&ToDate=");
    print('jfghhjgh');
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        print('jfghhjtyttttgh' + map.toString());
        List<dynamic> list = map["Table"];
        print("fkghgjk" + list.length.toString());
        for (int i = 0; i < list.length; i++) {
          WalletSTatementReportModel lm = WalletSTatementReportModel.fromJson(list[i]);
          labelData.add(lm);
          print("fkghgjk" + lm.credit);
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
                "Wallet Statement",
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
          child: FutureBuilder<List<WalletSTatementReportModel>?>(
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
                                        SizedBox(width:270,
                                          child: Text("Cus Name: "+
                                            snapshot.data![index].customerName,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                                             "Date: "+ snapshot.data![index]
                                                  .dateCreated,
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

                                        Padding(
                                          padding:
                                          const EdgeInsets.only(right: 0),
                                          child: Text(
                                            "Credit: " +snapshot.data![index].currency+" "+
                                                snapshot
                                                    .data![index].credit,
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
                                        color: Colors.blue,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 5),
                                        child: Text(
                                          "Debit: " +snapshot.data![index].currency+" "+
                                              snapshot.data![index].debit,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.blue,
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
                              Container(
                                width: 320,
                                child: Padding(
                                  padding: const EdgeInsets.only(left:10,right:5,
                                      bottom: 3),
                                  child: Text(
                                    "Status: "+ snapshot.data![index]
                                        .message,
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 265,
                                    height: 1,
                                    child: DecoratedBox(
                                      decoration: const BoxDecoration(
                                          color: Color(0xffededed)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      "Price(Incl. Tax)",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
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
                                            "Type: ",
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            snapshot.data![index].customerType,
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
                                       "Balance: "+snapshot.data![index].currency+" "+ snapshot.data![index].outstandingBalance,
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
Color _getBackgroundColor(String bookingStatus) {
  if (bookingStatus == 'TicketIssued') {
    return Color(0xFF16D39A);
  } else if (bookingStatus == 'Processing') {
    return Color(0xFFFF66CC);
  } else if (bookingStatus == 'Cancelled') {
    return Colors.red;
  } else if (bookingStatus == 'Pending') {
    return Colors.red;
  } else if (bookingStatus == 'Confirmed') {
    return  Color(0xFF009E60);
  } else if (bookingStatus == 'CONFIRMED') {
    return  Color(0xFF009E60);
  } else if (bookingStatus == 'Reserved') {
    return Colors.orange;
  } else if (bookingStatus == '') {
    return Color(0xFFFF7588);
  } else if (bookingStatus == 'Booked') {
    return Color(0xFFFF7588);
  } else {
    return Colors.black;
  }
}