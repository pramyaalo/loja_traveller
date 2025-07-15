import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Booking/Table22CreditNoteFlightReceiptModel.dart';
import '../Booking/Table24CreditNoteFlightReceiptModel.dart';
import '../Booking/Table26FlightOnwardSegmentModel.dart';
import '../Booking/Table3CreditNoteFlightPaymentDetailModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'CreditNoteFlightTaxModel.dart';
import 'Tabe48CreditNoteFareModel.dart';
import 'Table0CreditNoteFlightModsel.dart';

import 'Table2CreditNoteFlightreceiptModel.dart';

import 'Table50CreditMoteFlightReceiptModel.dart';
import 'Table5CreditNoteFlightReceiptModel.dart';
import 'Table6CreditNoteFlightReceiptModel.dart';

class CreditNoteFlightReceipt extends StatefulWidget {
  final String Id;

  CreditNoteFlightReceipt({required this.Id});
  @override
  State<CreditNoteFlightReceipt> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<CreditNoteFlightReceipt> {
  late List<dynamic> table0,
      table1,
      table2,
      table3,
      table4,
      table5,
      table6,
      table7,
      table8,
      table9,
      table10,
      table11,
      table12,
      table13,
      table14,
      table16,
      table18,
      table19,
      table22,
      table23,
      table24,
      table26,
      table34,
      table39,
      table50,
      table47,
      table48,
      table49,
      table20,
      table21;

  List<Table2CreditNoteFlightreceiptModel> tableData2 = [];
  List<Table26FlightOnwardSegmentModel> tableData26 = [];
  List<Table6CreditNoteFlightReceiptModel> tableData6 = [];
  List<Table24CreditNoteFlightReceiptModel> tableData24 = [];
  List<Table22CreditNoteFlightReceiptModel>tableData22=[];
  List<Table3CreditNoteFlightPaymentDetailModel>tableData3=[];
  static late String userTypeID;
  static late String userID;
  static late String Currency;
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
      Currency=prefs.getString(Prefs.PREFS_CURRENCY)?? '';
      print("userTypeID" + userTypeID);
      print("userID" + userID);
    });
  }
  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "CreditNoteViewGet", "BookFlightId=${widget.Id}");
    print('jfghhjghId' + widget.Id);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      print('jfghhjghIjsonResponsed' + jsonResponse);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map['Table1'];
      table2 = map["Table2"];
      table3=map['Table3'];
      table5 = map['Table5'];
      table6 = map['Table6'];
      table7 = map["Table7"];
      table8 = map['Table8'];
      table9 = map["Table9"];
      table10 = map["Table10"];
      table11 = map['Table11'];
      table13 = map["Table13"];
      table20 = map["Table20"];
      table22=map["Table23"];
      table18 = map['Table18'];
      table24=map["Table24"];
      table26=map['Table26'];
      return jsonResponse;
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
                "Credit Note Receipt",
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
          child: FutureBuilder<String?>(
              future: getLabels(),
              builder: (context, snapshot) {
                print('object' + snapshot.connectionState.toString());
                if (snapshot.connectionState == ConnectionState.done) {
                  try {
                    tableData26.clear();

                    if (table26.isNotEmpty) {
                      for (int i = 0; i < table26.length; i++) {
                        Table26FlightOnwardSegmentModel t1Data =
                        Table26FlightOnwardSegmentModel.fromJson(
                            table26[i]);
                        tableData26.add(t1Data);
                        print(
                            'Index12: $i, Table4 bfgLength: ${table26.length}, t1Data: $t1Data');
                      }
                    }
                    tableData6.clear();

                    if (table6.isNotEmpty) {
                      Table6CreditNoteFlightReceiptModel m6 =
                      Table6CreditNoteFlightReceiptModel.fromJson(table6[0]);

                      for (int i = 0; i < table6.length; i++) {
                        Table6CreditNoteFlightReceiptModel t1Data =
                        Table6CreditNoteFlightReceiptModel.fromJson(table6[i]);
                        tableData6.add(t1Data);
                        print('Index234: $i, Table4deftt Length: ${table6.length}, t1Data: $t1Data');
                      }
                    } else {
                      print("table6 is empty");
                    }


                    Table22CreditNoteFlightReceiptModel? m22;

                    tableData22.clear();

                    if (table22.isNotEmpty) {
                      m22 = Table22CreditNoteFlightReceiptModel.fromJson(table22[0]);

                      for (int i = 0; i < table22.length; i++) {
                        Table22CreditNoteFlightReceiptModel t1Data =
                        Table22CreditNoteFlightReceiptModel.fromJson(table22[i]);
                        tableData22.add(t1Data);
                        print('Index234: $i, Table4deftt Length: ${table22.length}, t1Data: $t1Data');
                      }
                    } else {
                      print("table22 is empty");
                    }


                    tableData24.clear();

                    if (table24.isNotEmpty) {
                      for (int i = 0; i < table24.length; i++) {
                        Table24CreditNoteFlightReceiptModel t6Data =
                        Table24CreditNoteFlightReceiptModel.fromJson(
                            table24[i]);
                        tableData24.add(t6Data);
                        print(
                            'Index: $i, Table4 Length: ${table6.length}, t1Data: $t6Data');
                      }
                    }

                    tableData3.clear();

                    if (table3.isNotEmpty) {
                      for (int i = 0; i < table3.length; i++) {
                        Table3CreditNoteFlightPaymentDetailModel t6Data =
                        Table3CreditNoteFlightPaymentDetailModel.fromJson(
                            table3[i]);
                        tableData3.add(t6Data);
                        print(
                            'Index: $i, Table4 Length: ${table3.length}, t1Data: $t6Data');
                      }
                    }
                    //
                    tableData2.clear();
                    Table2CreditNoteFlightreceiptModel m2 =
                    Table2CreditNoteFlightreceiptModel.fromJson(table2[0]);

                    if (table2.isNotEmpty) {
                      for (int i = 0; i < table2.length; i++) {
                        Table2CreditNoteFlightreceiptModel t1Data =
                        Table2CreditNoteFlightreceiptModel.fromJson(
                            table2[i]);
                        tableData2.add(t1Data);
                      }
                      print(' Table454 yuLength: ${table2.length}');
                    }

                    //Table6CreditNoteFlightReceiptModel

                    Table0CreditNoteFlightModsel m0 =
                    Table0CreditNoteFlightModsel.fromJson(table0[0]);
                    if (table0.isNotEmpty) {
                      m0 = Table0CreditNoteFlightModsel.fromJson(table0[0]);
                      print("fjhg" + m0.bookFlightId);
                    } else {
                      print('The list is empty.');
                    }
                    Table5CreditNoteFlightReceiptModel m5 =
                    Table5CreditNoteFlightReceiptModel.fromJson(table5[0]);
                    if (table5.isNotEmpty) {
                      m5 = Table5CreditNoteFlightReceiptModel.fromJson(
                          table5[0]);
                      print("fjhg" + m5.corporateName);
                    } else {
                      print('The list is empty.');
                    }


                    /* tableData50.clear();
                    Table50CreditMoteFlightReceiptModel m50 =
                        Table50CreditMoteFlightReceiptModel.fromJson(
                            table50[0]);
                    if (table50.isNotEmpty) {
                      for (int i = 0; i < table50.length; i++) {
                        Table50CreditMoteFlightReceiptModel t1Data =
                            Table50CreditMoteFlightReceiptModel.fromJson(
                                table50[i]);
                        tableData50.add(t1Data);
                        print(
                            'Inde34x: $i, Table4 Length: ${table50.length}, t1Data: $t1Data');
                      }
                    }*/
                    /* tableData2.clear();
                        Table2InvoiceListFlightReceiptModel m2 =
                            Table2InvoiceListFlightReceiptModel.fromJson(
                                table2[0]);
                        if (table2.isNotEmpty) {
                          for (int i = 0; i < table2.length; i++) {
                            Table2InvoiceListFlightReceiptModel t1Data =
                                Table2InvoiceListFlightReceiptModel.fromJson(
                                    table2[i]);
                            tableData2.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table2.length}, t1Data: $t1Data');
                          }
                        }*/

                    /* tableData6.clear();

                    if (table6.isNotEmpty) {
                      for (int i = 0; i < table6.length; i++) {
                        Table6CreditNoteFlightReceiptModel t1Data =
                            Table6CreditNoteFlightReceiptModel.fromJson(
                                table6[i]);
                        tableData6.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table6.length}, t1Data: $t1Data');
                      }
                    }*/
                    /*   Tabe48CreditNoteFareModel m48 =
                        Tabe48CreditNoteFareModel.fromJson(table48[0]);
                    if (table48.isNotEmpty) {
                      m48 = Tabe48CreditNoteFareModel.fromJson(table48[0]);
                      print("fjhg" + m48.totalFare);
                    } else {
                      print('The list is empty.');
                    }

                    CreditNoteFlightTaxModel m49 =
                        CreditNoteFlightTaxModel.fromJson(table49[0]);
                    if (table49.isNotEmpty) {
                      m49 = CreditNoteFlightTaxModel.fromJson(table49[0]);
                      print("fjhg" + m49.totalTax);
                    } else {
                      print('The list is empty.');
                    }*/

                    /*    Table7HotelReceiptModel m7 =
                      Table7HotelReceiptModel.fromJson(table7[0]);
                      if (table7.isNotEmpty) {
                        m7 = Table7HotelReceiptModel.fromJson(table7[0]);
                        print("fjhg" + m7.phone);
                      } else {
                        print('The list is empty.');
                      }

                      Table10hotelReceiptModel m10 =
                      Table10hotelReceiptModel.fromJson(table10[0]);
                      if (table10.isNotEmpty) {
                        m10 = Table10hotelReceiptModel.fromJson(table10[0]);
                        print("fjhg" + m10.totalSales);
                      } else {
                        print('The list is empty.');
                      }

                      Table47HotelDetailsModel m47 =
                      Table47HotelDetailsModel.fromJson(table47[0]);
                      if (table47.isNotEmpty) {
                        m47 = Table47HotelDetailsModel.fromJson(table47[0]);
                        print("fjhg" + m47.bookFlightId);
                      } else {
                        print('The list is empty.');
                      }

                      HOtelFareModel m48 =
                      HOtelFareModel.fromJson(table48[0]);
                      if (table48.isNotEmpty) {
                        m48 = HOtelFareModel.fromJson(table48[0]);
                        print("fjhg" + m48.totalFare);
                      } else {
                        print('The list is empty.');
                      }

                      HotelTaxModel m49 = HotelTaxModel.fromJson(table49[0]);
                      if (table49.isNotEmpty) {
                        m49 = HotelTaxModel.fromJson(table49[0]);
                        print("fjhg" + m49.totalTax);
                      } else {
                        print('The list is empty.');
                      }*/
                    return SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Credit Note',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Image.asset('assets/images/lojologo.png',
                                      width: 200, height: 50),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 3, left: 3),
                              child: Container(
                                height: 40,
                                color: Color(0xFFADD8E6),
                                alignment: Alignment.center,
                                child: Text('Credit Note',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17)),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15, top: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(m2.passenger,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15, top: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Email: ' + m2.custEmail,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15, top: 4),
                                  child: Row(
                                    children: [
                                      Text('Phone: ' + m2.custPhone,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15, top: 4),
                                  child: Row(
                                    children: [
                                      Text(
                                        m5.corporateName,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15, top: 4),
                                  child: Row(
                                    children: [
                                      Text(
                                        'PinCode: ' + m5.postCode,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15, top: 4),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Phone: ' + m5.phone,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15, top: 4),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Email: ' + m5.email,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Color(0xFFADD8E6),
                                    alignment: Alignment.centerLeft,
                                    child: Text('   Passenger Details:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17)),
                                  ),
                                ),
                                Column(
                                  children: (tableData2.contains(0) ||
                                      tableData2.isEmpty)
                                      ? [
                                    // Display "No data" text when the list is null or empty
                                    Text(
                                      'No data',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ]
                                      : List.generate(
                                    tableData2.length,
                                        (index) => Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 15,
                                              top: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                "${tableData2[index].passenger}",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                              Text(
                                                'Type: ${tableData2[index].type}',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 15, top: 4),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Passenger ID: ${tableData2[index].passengerID}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                  overflow: TextOverflow.ellipsis, // Prevent overflow
                                                ),
                                              ),
                                              SizedBox(width: 10), // Optional space between columns
                                              Text(
                                                'Age: ${tableData2[index].age}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 15,
                                              top: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                'Phone: ${tableData2[index].tfpPhoneNo}',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                'Ticket No: ${tableData2[index].ticketNo}',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Color(0xFFADD8E6),
                                    alignment: Alignment.centerLeft,
                                    child: Text('   OnWard Segment:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17)),
                                  ),
                                ),
                                Column(
                                  children: List.generate(
                                    tableData26.length,
                                        (index) => Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 15, top: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                    'Depart Date: ${tableData26[index].tfsDepDatedt}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 15))),

                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 15, top: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                    'Arrival Date: ${tableData26[index].tfsArrDatedt}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 15))),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 15, top: 4),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Depart: ${tableData26[index].tfsDepAirport}',
                                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,// Truncates long text with ...
                                                  ),
                                                ),
                                                SizedBox(width: 10), // Optional spacing between texts
                                                Expanded(
                                                  child: Text(
                                                    'Flight No: ${tableData26[index].tfsFlightNumber}',
                                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                    textAlign: TextAlign.right,  // Aligns right within the Expanded
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 15, top: 4),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Arrival: ${tableData26[index].tfsArrAirport}',
                                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                SizedBox(width: 10), // spacing between texts
                                                Expanded(
                                                  child: Text(
                                                    'Duration: ${tableData26[index].tfsDuration}',
                                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                    textAlign: TextAlign.right,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )

                                        ]),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Color(0xFFADD8E6),
                                    alignment: Alignment.centerLeft,
                                    child: Text('   Payment Details:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17)),
                                  ),
                                ),
                                Column(
                                  children: List.generate(
                                    tableData3.length,
                                        (index) =>
                                        Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 15, top: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                        '${tableData3[index].name}',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.w500)),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 15, top: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Tax: ${tableData3[index].currency} ${tableData3[index].inputTax}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15)),
                                                    ),
                                                    Text(
                                                        'Other Charges: ${tableData3[index].currency} ${tableData3[index].outputTax}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 15))),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 15, top: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [

                                                    Text(
                                                        'Base Fare: ${tableData3[index].currency} ${tableData3[index].totalSales}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 15))),
                                                    Text(
                                                        'Total: ${tableData3[index].currency} ${tableData3[index].totalNett}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 15))),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 15, top: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [

                                                  ],
                                                ),
                                              ),
                                            ]),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 3,
                                ),
                                m22 != null
                                    ? Table(
                                  columnWidths: {
                                    0: IntrinsicColumnWidth(),
                                    1: FixedColumnWidth(20),
                                    2: IntrinsicColumnWidth(),
                                  },
                                  children: [
                                    _buildTableRow('Total Net Amount', Currency, m22.totalFare),
                                    _buildTableRow('Total GST ${m22.gstPercent} %', Currency, m22.gstAmount),
                                    _buildTableRow('Service Charge and Tax', Currency, m22.gstAmount),
                                    _buildTableRow('Total Discount', Currency, m22.discountAmount),
                                    _buildTableRow('Total Price', Currency, m22.grandTotal, isBold: true),
                                  ],
                                )
                                    : Center(child: Text('No data available')),

                                /*  Padding(
                                  padding: const EdgeInsets.only(
                                      right: 3, left: 3, top: 10, bottom: 5),
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                    height: 0,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Total Fare',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    Text('     :   	',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Text(
                                        m48.totalFare,
                                      ),
                                    ),
                                    // Add more rows for Tax, T Fee, IGST, and Total Price
                                  ],
                                ),
                                SizedBox(
                                  height: 6,
                                ),*/
                                /*Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Total Tax',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    Text('       :    	',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Text(
                                        m49.totalTax,
                                      ),
                                    ),
                                    // Add more rows for Tax, T Fee, IGST, and Total Price
                                  ],
                                ),*/

                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Color(0xFFADD8E6),
                                    alignment: Alignment.centerLeft,
                                    child: Text(' Payment Credited Details:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17)),
                                  ),
                                ),
                                Column(
                                  children: (tableData6.contains(0) ||
                                      tableData6.isEmpty)
                                      ? [
                                    Text(
                                      'No data',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ]
                                      : List.generate(
                                    tableData6.length,
                                        (index) => Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                alignment:
                                                Alignment.centerLeft,
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 4),
                                                child: Text(
                                                  'Receipt No: ${tableData6[index].receiptNo}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment:
                                                Alignment.centerLeft,
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 3),
                                                child: Text(
                                                  'Allocated Amount: ${tableData6[index].allocatedAmount}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment:
                                                Alignment.centerLeft,
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 2),
                                                child: Text(
                                                  'Status:${tableData6[index].status}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment:
                                                Alignment.centerLeft,
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 2),
                                                child: Text(
                                                  'Date: ${tableData6[index].createdDate}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                        ]),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Color(0xFFADD8E6),
                                    alignment: Alignment.centerLeft,
                                    child: Text('  Terms And Conditions:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17)),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'This is a computer-generated Invoice and Digitally signed.',
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } catch (error) {
                    print('Unexpected error: $error');
                    return Text('An unexpected error occurred.');
                  }
                } else {
                  print('Unexpected errordfdfwreewe');
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
  TableRow _buildTableRow(String label,dynamic Currency, dynamic value, {bool isBold = false}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Align(
            alignment: Alignment.centerLeft, // Align text to the left
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: isBold ? 18 : 14,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              ':',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: isBold ? 18 : 14,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4, top: 6, bottom: 6),
          child: Align(
            alignment: Alignment.centerRight, // Align amount to the right
            child: Text(
              '$Currency $value',
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: isBold ? 18 : 14,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

}
