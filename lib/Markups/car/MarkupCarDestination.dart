//branchlistapi branchid=0,

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';
import 'AddmarkupCarDestination.dart';
import 'EditmarkupcarDestination.dart';
import 'MarkupcarDestinationModel.dart';
import 'ViewmarkupcarDestination.dart';






class MarkupCarDestination extends StatefulWidget {
  const MarkupCarDestination({Key? key}) : super(key: key);

  @override
  State<MarkupCarDestination> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<MarkupCarDestination> {
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

  Future<List<MarkupcarDestinationModel>?> getFlightTicketOrderQueue() async {
    String SubAgencyId = '';
    List<MarkupcarDestinationModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "MarkupCarDestinationGet", "UserTypeId=$userTypeID&UserId=$userID&LoginUserTypeId=0&LoginUserId=0&Destination=0&Status=-1");

    return await __futureLabels?.then((value) async {
      String jsonResponse = ResponseHandler.parseData(value.body);
      //log(jsonResponse);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          MarkupcarDestinationModel lm = MarkupcarDestinationModel.fromJson(list[i]);
          bookingCardData.add(lm);
        }
      } catch (error) {
        // Fluttertoast.showToast(msg: error.toString());
      }
      return bookingCardData;
    });
  }

  Future<void> saveSubAgencyId(String subAgencyId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('subAgencyId', subAgencyId);
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
                "Car Destination",
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddmarkupCarDestination()),
            );
          },
          backgroundColor: Colors.pink,
          child: Icon(Icons.add),
        ),
        body: Center(
          child: FutureBuilder<List<MarkupcarDestinationModel>?>(
              future: getFlightTicketOrderQueue(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: SingleChildScrollView(
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: InkWell(
                                      child: PhysicalModel(
                                          color: Colors.white,
                                          elevation: 8,
                                          shadowColor: Color(0xff9a9ce3),
                                          borderRadius:
                                          BorderRadius.circular(4),
                                          child: Container(
                                            padding: EdgeInsets.all(10.0),
                                            child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      SizedBox(width: 320,
                                                        child: Text(
                                                          "Destination: "+snapshot.data![index]
                                                              .fromAirportName,
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
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      SizedBox(width: 320,
                                                        child: Text(
                                                          "Arrival: "+snapshot.data![index]
                                                              .toAirportName,
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
                                                  SizedBox(
                                                    height: 2,
                                                  ),

                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(left: 0),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 0),
                                                              child: Text(
                                                                "Type: " +
                                                                    snapshot
                                                                        .data![
                                                                    index]
                                                                        .markupType,
                                                                style:
                                                                TextStyle(
                                                                  fontFamily:
                                                                  "Montserrat",
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Row(
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                                'assets/images/tickiconpng.png'),
                                                            width: 16,
                                                            height: 16,
                                                            color: Color(0xFF00ADEE),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 3),
                                                            child: Text(
                                                              "Value: " +
                                                                  snapshot.data![index].markupValue +
                                                                  (snapshot.data![index].markupType == "Fixed" ? " INR" : " %"),
                                                              style: TextStyle(
                                                                fontFamily:
                                                                "Montserrat",
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontSize: 15,
                                                                color:
                                                                Color(0xFF00ADEE),
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
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(left: 0),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 0),
                                                              child: Text(
                                                                "Customer Type: " +
                                                                    snapshot
                                                                        .data![
                                                                    index]
                                                                        .customerType,
                                                                style:
                                                                TextStyle(
                                                                  fontFamily:
                                                                  "Montserrat",
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Row(
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                                'assets/images/tickiconpng.png'),
                                                            width: 16,
                                                            height: 16,
                                                            color: Color(0xFF00ADEE),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 3),
                                                            child: Text(
                                                              "Name: " +
                                                                  snapshot
                                                                      .data![
                                                                  index]
                                                                      .customerName,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                "Montserrat",
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontSize: 15,
                                                                color:
                                                                Color(0xFF00ADEE),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 320,
                                                        height: 1,
                                                        child: DecoratedBox(
                                                          decoration:
                                                          const BoxDecoration(
                                                              color: Color(
                                                                  0xffededed)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 29,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .book_outlined,
                                                                size: 14,
                                                              ),
                                                              Text(
                                                                "ID: ",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "Montserrat",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                    fontSize:
                                                                    15),
                                                              ),
                                                              Text(
                                                                snapshot
                                                                    .data![
                                                                index]
                                                                    .id,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "Montserrat",
                                                                    fontSize:
                                                                    15,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              top: 4,
                                                              left: 2),
                                                          child: Column(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {},
                                                                child:
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                      5.0,
                                                                      2.5,
                                                                      5,
                                                                      2.8),
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color: _getBackgroundColor(snapshot
                                                                        .data![
                                                                    index]
                                                                        .status),
                                                                    border: Border.all(
                                                                        width:
                                                                        0.1,
                                                                        color: Colors
                                                                            .orange), //https://stackoverflow.com/a/67395539/16076689
                                                                    borderRadius:
                                                                    new BorderRadius
                                                                        .circular(
                                                                        5.0),
                                                                  ),
                                                                  child: Text(
                                                                    snapshot.data![index].status ==
                                                                        "1"
                                                                        ? "Active"
                                                                        : "InActive",
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
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ViewmarkupcarDestination(Id:snapshot.data![index].id


                                                                    ),
                                                              ),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 4,
                                                                left: 10),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                      5,
                                                                      3,
                                                                      5,
                                                                      3),
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color: Colors
                                                                        .orange,
                                                                    border: Border.all(
                                                                        width:
                                                                        0.1,
                                                                        color: Colors
                                                                            .blue), //https://stackoverflow.com/a/67395539/16076689
                                                                    borderRadius:
                                                                    new BorderRadius
                                                                        .circular(
                                                                        5.0),
                                                                  ),
                                                                  child: Text(
                                                                    "View",
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

                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditmarkupcarDestination(ID:snapshot.data![index].id),
                                                              ),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 4,
                                                                left: 10),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                      5,
                                                                      3,
                                                                      5,
                                                                      3),
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color: Colors
                                                                        .orange,
                                                                    border: Border.all(
                                                                        width:
                                                                        0.1,
                                                                        color: Colors
                                                                            .blue), //https://stackoverflow.com/a/67395539/16076689
                                                                    borderRadius:
                                                                    new BorderRadius
                                                                        .circular(
                                                                        5.0),
                                                                  ),
                                                                  child: Text(
                                                                    "Edit",
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
                                                  ),
                                                ]),
                                          )),
                                    ))));
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}

Color _getBackgroundColor(String isActive) {
  if (isActive == '1') {
    return Color(0xFF16D39A);
  } else {
    return Color(0xFFFF7588);
  }
}
