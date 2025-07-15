import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../Models/HolidayPassengerModel.dart';
import '../Models/HotelPassengerModel.dart';

import '../utils/response_handler.dart';
import 'BookedItemViewModel.dart';
import 'CarAgentModel.dart';
import 'CarPassengerModel.dart';
import 'ContactAgentDetailModel.dart';
import 'HotelAgentModel.dart';
import 'Table10HotelLblModel.dart';
import 'Table19HolidayPassengerDetailsModel.dart';
import 'Table23BusLblDetailsModel.dart';
import 'Table3FLightPassengerListModel.dart';
import 'Table47FlightCOntactDetailsModel.dart';
import 'Table47HotelAGentDetailsModel.dart';
import 'Table47HotelAgentHolidayDetailsModel.dart';
import 'Table48FlightContactInformationModel.dart';

class ContactDetaails extends StatefulWidget {
  final id;

  ContactDetaails({super.key, required this.id});

  @override
  State<ContactDetaails> createState() => _ContactDetaailsState();
}

class _ContactDetaailsState extends State<ContactDetaails> {
  static String savedId = '';
  String? savedName;
  late List<dynamic> table0,
      table1,
      table47,
      table3,
      table4,
      table5,
      table6,
      table8,
      table9,
      table10,
      table12,
      table13,
      table14,
      table16,
      table18,
      table25,
      table19,
      table22,
      table23,
      table24,
      table39,
      table40,
      table48,
      table20,
      table21;
  List<BookedItemViewModel> tableData = [];
  List<Table47FlightCOntactDetailsModel> table47Data = [];
  List<Table47HotelAGentDetailsModel> table47Hotel = [];
  List<Table47HotelAgentHolidayDetailsModel>table47Holiday=[];
  List<Table48FlightContactInformationModel> tableData48 = [];
  List<Table3FLightPassengerListModel> table3Data = [];
  List<Table23BusLblDetailsModel> table23data = [];
  List<Table10HotelLblModel> table10Date = [];
  List<HotelAgentModel> table10Data = [];
  List<CarPassengerModel> table14Data = [];
  List<Table19HolidayPassengerDetailsModel> table19Data = [];
  List<CarAgentModel> table20Data = [];

  @override
  void initState() {
    super.initState();
  }

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "BookingCardViewGet", "BookFlightId=${widget.id}&StaffId=0");
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);

      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table47 = map["Table47"];
      table3 = map["Table3"];
      table8 = map['Table8'];
      table5 = map["Table5"];
      table10 = map["Table10"];
      table14 = map["Table14"];
      table20 = map["Table20"];
      table18 = map['Table18'];
      table19=map['Table19'];
      table23 = map['Table23'];
      table25 = map["Table25"];
      table48 = map["Table48"];
      return jsonResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<String?>(
            future: getLabels(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                try {
                  if (table0.isNotEmpty) {
                    BookedItemViewModel m0 =
                    BookedItemViewModel.fromJson(table0[0]);
                    for (int i = 0; i < table0.length; i++) {
                      BookedItemViewModel t1Data =
                      BookedItemViewModel.fromJson(table0[i]);
                      tableData.add(t1Data);
                      print(
                          'Index: $i, Table4 Length: ${table0.length}, t1Data: $t1Data');
                    }
                  }

                  Table3FLightPassengerListModel? m3; // Declare it first

                  table3Data.clear();

                  if (table3.isNotEmpty) {
                    m3 = Table3FLightPassengerListModel.fromJson(table3[0]);

                    for (int i = 0; i < table3.length; i++) {
                      Table3FLightPassengerListModel t2Data =
                      Table3FLightPassengerListModel.fromJson(table3[i]);
                      table3Data.add(t2Data);
                      print(
                          'Index: $i, Tablsdse4 Length: ${table3.length}, t1Data: $t2Data');
                    }
                  } else {
                    print("table3 is empty");
                  }

                  if (m3 != null) {
                    // use m3
                  }

                  table23data.clear();

                  if (table23.isNotEmpty) {
                    Table23BusLblDetailsModel m23 =
                    Table23BusLblDetailsModel.fromJson(table23[0]);

                    for (int i = 0; i < table23.length; i++) {
                      Table23BusLblDetailsModel t2Data =
                      Table23BusLblDetailsModel.fromJson(table23[i]);
                      table23data.add(t2Data);
                      print(
                          'Index: $i, Table23 Length: ${table23.length}, t2Data: $t2Data');
                    }

                    // Now you can safely use m23
                  } else {
                    print("table23 is empty");
                  }

                  Table47FlightCOntactDetailsModel? m47; // Declare it first

                  table47Data.clear();
                  print("table367 is empty");
                  if (table47.isNotEmpty) {
                    m47 = Table47FlightCOntactDetailsModel.fromJson(table47[0]);
                    print(m47.city);
                  } else {
                    print("table3 is empty");
                  }

                  /*   table47Data.clear();
                  Table47FlightCOntactDetailsModel m47 =
                  Table47FlightCOntactDetailsModel.fromJson(table47[0]);
                  if (table47.isNotEmpty) {

                    for (int i = 0; i < table47Data.length; i++) {
                      Table47FlightCOntactDetailsModel t2Data =
                      Table47FlightCOntactDetailsModel.fromJson(table47[i]);
                      table47Data.add(t2Data);
                      print(
                          'Index: $i, tabdsgfgle5 Length: ${table47Data.length}, t1Data: $t2Data');
                    }
                  }*/

                  table47Hotel.clear();
                  Table47HotelAGentDetailsModel m47hotel =
                  Table47HotelAGentDetailsModel.fromJson(table47[0]);
                  if (table47.isNotEmpty) {
                    for (int i = 0; i < table47Data.length; i++) {
                      Table47HotelAGentDetailsModel t2Data =
                      Table47HotelAGentDetailsModel.fromJson(table47[i]);
                      table47Hotel.add(t2Data);
                      print(
                          'Index: $i, tabdsgfgle5 Length: ${table47Data.length}, t1Data: $t2Data');
                    }
                  }


                  table47Holiday.clear();
                  Table47HotelAgentHolidayDetailsModel m47holiday =
                  Table47HotelAgentHolidayDetailsModel.fromJson(table47[0]);
                  if (table47.isNotEmpty) {
                    for (int i = 0; i < table47Data.length; i++) {
                      Table47HotelAgentHolidayDetailsModel t2Data =
                      Table47HotelAgentHolidayDetailsModel.fromJson(table47[i]);
                      table47Holiday.add(t2Data);
                      print(
                          'Index: $i, tabdsgfgle5 Length: ${table47Data.length}, t1Data: $t2Data');
                    }
                  }
                  //Table47HotelAgentHolidayDetailsModel
                  tableData48.clear();
                  Table48FlightContactInformationModel m48 =
                  Table48FlightContactInformationModel.fromJson(table48[0]);
                  if (table48.isNotEmpty) {
                    for (int i = 0; i < table48.length; i++) {
                      Table48FlightContactInformationModel t2Data =
                      Table48FlightContactInformationModel.fromJson(
                          table48[i]);
                      tableData48.add(t2Data);
                      print(
                          'Index: $i, table5 Length: ${table48.length}, t1Data: $t2Data');
                    }
                  }
                  table10Date.clear();
                  if (table10.isNotEmpty) {
                    Table10HotelLblModel m8 =
                    Table10HotelLblModel.fromJson(table10[0]);
                    for (int i = 0; i < table10.length; i++) {
                      Table10HotelLblModel t8Data =
                      Table10HotelLblModel.fromJson(table10[i]);
                      table10Date.add(t8Data);
                      print(
                          'Index: $i, Table8 Length: ${table8.length}, t1Data: $t8Data');
                    }
                  }
                  table10Data.clear();
                  if (table10.isNotEmpty) {
                    HotelAgentModel m10 = HotelAgentModel.fromJson(table10[0]);
                    for (int i = 0; i < table10.length; i++) {
                      HotelAgentModel t9Data =
                      HotelAgentModel.fromJson(table10[i]);
                      table10Data.add(t9Data);
                      print(
                          'Index: $i, Table6 Length: ${table10.length}, t1Data: $t9Data');
                    }
                  }
                  table14Data.clear();
                  if (table14.isNotEmpty) {
                    CarPassengerModel m16 =
                    CarPassengerModel.fromJson(table14[0]);

                    for (int i = 0; i < table14.length; i++) {
                      CarPassengerModel t13Data =
                      CarPassengerModel.fromJson(table14[i]);
                      table14Data.add(t13Data);
                      print(
                          'Index: $i, Table12 Length: ${table14.length}, t1Data: $t13Data');
                    }
                  }
                  table19Data.clear();
                  if (table19.isNotEmpty) {
                    Table19HolidayPassengerDetailsModel m16 =
                    Table19HolidayPassengerDetailsModel.fromJson(table19[0]);

                    for (int i = 0; i < table19.length; i++) {
                      Table19HolidayPassengerDetailsModel t18Data =
                      Table19HolidayPassengerDetailsModel.fromJson(table19[i]);
                      table19Data.add(t18Data);
                      print(
                          'Index: $i, Table16 Length: ${table19.length}, t1Data: $t18Data');
                    }
                  }

                  return SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                            children: List.generate(
                                tableData.length,
                                    (index) => Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Agent Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      if (tableData[index].bookingType ==
                                          "Flight")
                                        m47 == null
                                            ? SizedBox
                                            .shrink() // or a placeholder widget
                                            : Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets
                                                  .symmetric(
                                                  vertical: 10),
                                              child: PhysicalModel(
                                                color: Colors.white,
                                                elevation: 8,
                                                shadowColor:
                                                const Color(
                                                    0xff9a9ce3),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(4),
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      buildRow("Name",
                                                          m47.corporateName),
                                                      buildRow(
                                                          "Email",
                                                          m47.email),
                                                      buildRow(
                                                          "Phone",
                                                          m47.phone),
                                                      buildRow(
                                                          "Address",
                                                          "${m47.addressLine1} ${m47.addressLine2} ${m47.addressLine3}"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (tableData[index].bookingType ==
                                          "Hotel")
                                        Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets
                                                  .symmetric(vertical: 10),
                                              child: PhysicalModel(
                                                color: Colors.white,
                                                elevation: 8,
                                                shadowColor:
                                                const Color(0xff9a9ce3),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    4),
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m47hotel
                                                                  .corporateName,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Email',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m47hotel
                                                                  .email,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Phone',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m47hotel
                                                                  .phone,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Address',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 210,
                                                            child: Text(
                                                              m47hotel.addressLine1 +
                                                                  m47hotel
                                                                      .addressLine2 +
                                                                  m47hotel
                                                                      .addressLine3,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (tableData[index].bookingType ==
                                          "Bus")
                                        Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets
                                                  .symmetric(vertical: 10),
                                              child: PhysicalModel(
                                                color: Colors.white,
                                                elevation: 8,
                                                shadowColor:
                                                const Color(0xff9a9ce3),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    4),
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m47hotel
                                                                  .corporateName,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Email',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m47hotel
                                                                  .email,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Phone',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m47hotel
                                                                  .phone,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Address',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 210,
                                                            child: Text(
                                                              m47hotel.addressLine1 +
                                                                  m47hotel
                                                                      .addressLine2 +
                                                                  m47hotel
                                                                      .addressLine3,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (tableData[index].bookingType ==
                                          "Holiday")
                                        Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets
                                                  .symmetric(vertical: 10),
                                              child: PhysicalModel(
                                                color: Colors.white,
                                                elevation: 8,
                                                shadowColor:
                                                const Color(0xff9a9ce3),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    4),
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m47holiday
                                                                  .corporateName,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Email',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m47holiday
                                                                  .email,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Phone',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m47holiday
                                                                  .phone,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Address',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 210,
                                                            child: Text(
                                                              m47hotel.addressLine1 +
                                                                  m47hotel
                                                                      .addressLine2 +
                                                                  m47hotel
                                                                      .addressLine3,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (tableData[index].bookingType ==
                                          "Car")
                                        Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets
                                                  .symmetric(vertical: 10),
                                              child: PhysicalModel(
                                                color: Colors.white,
                                                elevation: 8,
                                                shadowColor:
                                                const Color(0xff9a9ce3),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    4),
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m47hotel
                                                                  .corporateName,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Email',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m47hotel
                                                                  .email,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Phone',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m47hotel
                                                                  .phone,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Address',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 210,
                                                            child: Text(
                                                              m47hotel.addressLine1 +
                                                                  m47hotel
                                                                      .addressLine2 +
                                                                  m47hotel
                                                                      .addressLine3,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Contact Information",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      if (tableData[index].bookingType ==
                                          "Flight")
                                        Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets
                                                  .symmetric(vertical: 10),
                                              child: PhysicalModel(
                                                color: Colors.white,
                                                elevation: 8,
                                                shadowColor:
                                                const Color(0xff9a9ce3),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    4),
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.name,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Email',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.email,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Phone',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.phone,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Address',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 210,
                                                            child: Text(
                                                              m48.address,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (tableData[index].bookingType ==
                                          "Hotel")
                                        Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets
                                                  .symmetric(vertical: 10),
                                              child: PhysicalModel(
                                                color: Colors.white,
                                                elevation: 8,
                                                shadowColor:
                                                const Color(0xff9a9ce3),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    4),
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.name,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Email',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.email,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Phone',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.phone,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Address',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 210,
                                                            child: Text(
                                                              m48.address,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (tableData[index].bookingType ==
                                          "Bus")
                                        Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets
                                                  .symmetric(vertical: 10),
                                              child: PhysicalModel(
                                                color: Colors.white,
                                                elevation: 8,
                                                shadowColor:
                                                const Color(0xff9a9ce3),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    4),
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.name,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Email',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.email,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Phone',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.phone,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Address',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 210,
                                                            child: Text(
                                                              m48.address,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (tableData[index].bookingType ==
                                          "Holiday")
                                        Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets
                                                  .symmetric(vertical: 10),
                                              child: PhysicalModel(
                                                color: Colors.white,
                                                elevation: 8,
                                                shadowColor:
                                                const Color(0xff9a9ce3),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    4),
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.name,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Email',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.email,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Phone',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.phone,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Address',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 210,
                                                            child: Text(
                                                              m48.address,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (tableData[index].bookingType ==
                                          "Car")
                                        Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets
                                                  .symmetric(vertical: 10),
                                              child: PhysicalModel(
                                                color: Colors.white,
                                                elevation: 8,
                                                shadowColor:
                                                const Color(0xff9a9ce3),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    4),
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.name,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Email',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.email,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Phone',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              m48.phone,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              'Address',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 210,
                                                            child: Text(
                                                              m48.address,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "LBL User Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      if (tableData[index].bookingType ==
                                          "Flight")
                                        Container(
                                          margin:
                                          const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: PhysicalModel(
                                            color: Colors.white,
                                            elevation: 8,
                                            shadowColor:
                                            const Color(0xff9a9ce3),
                                            borderRadius:
                                            BorderRadius.circular(4),
                                            child: Container(
                                              padding: const EdgeInsets.all(
                                                  10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 100,
                                                        child: Text(
                                                          'Name',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          m3?.passenger ??
                                                              '',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontSize: 15),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 100,
                                                        child: Text(
                                                          'Email',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          m3?.tfpEmail ??
                                                              '',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontSize: 15),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 100,
                                                        child: Text(
                                                          'Phone',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          m3?.tfpPhoneNo ??
                                                              '',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontSize: 15),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (tableData[index].bookingType ==
                                          "Hotel")

                                            Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10),
                                                  child: PhysicalModel(
                                                    color: Colors.white,
                                                    elevation: 8,
                                                    shadowColor:
                                                    const Color(
                                                        0xff9a9ce3),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(4),
                                                    child: Container(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child: Text(
                                                                  'Name',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .bold,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  table10Date[
                                                                  0]
                                                                      .passenger,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child: Text(
                                                                  'Email',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .bold,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  table10Date[
                                                                  0]
                                                                      .tfpEmail,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child: Text(
                                                                  'Phone',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .bold,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  table10Date[
                                                                  0]
                                                                      .tfpPhoneNo,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child: Text(
                                                                  'DOB',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .bold,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 210,
                                                                child: Text(
                                                                  table10Date[
                                                                  0]
                                                                      .tfpDOB,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                      if (tableData[index].bookingType ==
                                          "Bus")
                                        table23data.isNotEmpty
                                            ? Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.symmetric(vertical: 10),
                                              child: PhysicalModel(
                                                color: Colors.white,
                                                elevation: 8,
                                                shadowColor: const Color(0xff9a9ce3),
                                                borderRadius: BorderRadius.circular(4),
                                                child: Container(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      _buildRow("Name", table23data[0].passenger),
                                                      SizedBox(height: 5),
                                                      _buildRow("Email", table23data[0].email),
                                                      SizedBox(height: 4),
                                                      _buildRow("Phone", table23data[0].phoneNo),
                                                      SizedBox(height: 4),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                            : Center(
                                          child: Text(
                                            "No data",
                                            style: TextStyle(fontSize: 16, color: Colors.grey),
                                          ),
                                        ),



                                      if (tableData[index].bookingType ==
                                          "Car")
                                         Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10),
                                                  child: PhysicalModel(
                                                    color: Colors.white,
                                                    elevation: 8,
                                                    shadowColor:
                                                    const Color(
                                                        0xff9a9ce3),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(4),
                                                    child: Container(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child: Text(
                                                                  'Name',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .bold,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  table14Data[
                                                                  0]
                                                                      .passenger,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child: Text(
                                                                  'Email',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .bold,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  table14Data[
                                                                  0]
                                                                      .tfpEmail,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child: Text(
                                                                  'Phone',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .bold,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  table14Data[
                                                                  0]
                                                                      .tfpPhoneNo,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child: Text(
                                                                  'DOB',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .bold,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 210,
                                                                child: Text(
                                                                  table14Data[
                                                                  0]
                                                                      .tfpDOB,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                      if (tableData[index].bookingType ==
                                          "Holiday")
                                         Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10),
                                                  child: PhysicalModel(
                                                    color: Colors.white,
                                                    elevation: 8,
                                                    shadowColor:
                                                    const Color(
                                                        0xff9a9ce3),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(4),
                                                    child: Container(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child: Text(
                                                                  'Name',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .bold,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  table19Data[
                                                                  0]
                                                                      .passenger,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child: Text(
                                                                  'Email',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .bold,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  table19Data[
                                                                  0]
                                                                      .email,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child: Text(
                                                                  'Phone',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .bold,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  table19Data[
                                                                  0]
                                                                      .phoneNo,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      15),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                    ])))),
                  );
                } catch (error) {
                  print('Unexpected error: $error');
                  return Text('An unexpected error occurred.');
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}

Widget buildRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 100,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRow(String label, String value) {
  return Row(
    children: [
      Container(
        width: 100,
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
      ),
    ],
  );
}
