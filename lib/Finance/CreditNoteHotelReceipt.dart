import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Booking/Table0CreditNoteHotelreceiptModel.dart';
import '../Booking/Table1CreditNoteHotelreceiptModel.dart';
import '../Booking/Table21CreditNoteHotelreceiptModel.dart';
import '../Booking/Table22CreditNoteHoteReceiptModel.dart';
import '../Booking/Table22CreditNotelHotelTermsandConditionModel.dart';
import '../Booking/Table23HOtelCreditNoteTotalPriceModel.dart';
import '../Booking/Table3CreditNoteHotelreceiptModel.dart';
import '../Booking/Table4CreditNoteHotelreceiptModel.dart';
import '../Booking/Table5CreditNoteHotelreceiptModel.dart';
import '../Booking/Table6CreditNoteHotelPaymentCreditedModel.dart';
import '../Booking/Table7CreditNoteHotelreceiptModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'CreditNoteFlightTaxModel.dart';
import 'CreditNoteHolidayTaxModel.dart';
import 'Tabe48CreditNoteFareModel.dart';
import 'Table0CreditNoteFlightModsel.dart';
import 'Table10CreditNoteHotelreceiptModel.dart';


import 'Table22CrediutNoteHolidayReceiptModel.dart';
import 'Table23CreditNoteHolidayReceiptModel.dart';
import 'Table25HolidayModel.dart';

import 'Table9CreditNoteHoteleceipt.dart';

class CreditNoteHotelReceipt extends StatefulWidget {
  final String Id;

  CreditNoteHotelReceipt({required this.Id});
  @override
  State<CreditNoteHotelReceipt> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<CreditNoteHotelReceipt> {
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
      table25,
      table39,
      table50,
      table47,
      table48,
      table49,
      table20,
      table21;

  List<Table7CreditNoteHotelreceiptModel> tableData7 = [];
  List<Table22CreditNoteHoteReceiptModel>tableData22=[];
  List<Table9CreditNoteHoteleceipt> tableData9 = [];
  List<Table10CreditNoteHotelreceiptModel> tableData10 = [];
  List<Table23CreditNoteHolidayReceiptModel> tableData23 = [];
  List<Table25HolidayModel> tableData25 = [];
  List<Table1CreditNoteHotelreceiptModel>tableData1=[];
  List<Table3CreditNoteHotelreceiptModel>tableData3=[];
  List<Table4CreditNoteHotelreceiptModel>tableData4=[];
  List<Table5CreditNoteHotelreceiptModel>tableData5=[];
  List<Table6CreditNoteHotelPaymentCreditedModel>tableData6=[];
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
      table1=map["Table1"];
      table3=map["Table3"];
      table4=map["Table4"];
      table5=map["Table5"];
      table6=map['Table6'];
      table7 = map["Table7"];
      table9 = map["Table9"];
      table10 = map["Table10"];
      table11 = map['Table11'];
      table21=map["Table21"];
      table22 = map["Table22"];
      table20 = map["Table20"];
      table23 = map['Table23'];
      table25 = map['Table25'];
      table47 = map["Table47"];
      table48 = map["Table48"];
      table49 = map['Table49'];
      table50 = map['Table50'];
      return jsonResponse;
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
                    "Hotel Receipt",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
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
                        Table0CreditNoteHotelreceiptModel m0 =
                        Table0CreditNoteHotelreceiptModel.fromJson(table0[0]);
                        if (table0.isNotEmpty) {
                          m0 = Table0CreditNoteHotelreceiptModel.fromJson(table0[0]);
                          print("fjhg" + m0.bookFlightId);
                        } else {
                          print('The list is empty.');
                        }
                        //
                        tableData1.clear();
                        Table1CreditNoteHotelreceiptModel m1 =
                        Table1CreditNoteHotelreceiptModel.fromJson(table1[0]);
                        if (table1.isNotEmpty) {
                          for (int i = 0; i < table1.length; i++) {
                            Table1CreditNoteHotelreceiptModel t1Data =
                            Table1CreditNoteHotelreceiptModel.fromJson(table1[i]);
                            tableData1.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table3
                                    .length}, t1Data: $t1Data');
                          }
                        }
                        tableData3.clear();
                        Table3CreditNoteHotelreceiptModel m3 =
                        Table3CreditNoteHotelreceiptModel.fromJson(table3[0]);
                        if (table3.isNotEmpty) {
                          for (int i = 0; i < table3.length; i++) {
                            Table3CreditNoteHotelreceiptModel t1Data =
                            Table3CreditNoteHotelreceiptModel.fromJson(table3[i]);
                            tableData3.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table3
                                    .length}, t1Data: $t1Data');
                          }
                        }
                        tableData4.clear();
                        Table4CreditNoteHotelreceiptModel m4 =
                        Table4CreditNoteHotelreceiptModel.fromJson(table4[0]);
                        if (table4.isNotEmpty) {
                          for (int i = 0; i < table4.length; i++) {
                            Table4CreditNoteHotelreceiptModel t1Data =
                            Table4CreditNoteHotelreceiptModel.fromJson(table4[i]);
                            tableData4.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table4
                                    .length}, t1Data: $t1Data');
                          }
                        }
//
                        tableData5.clear();
                        Table5CreditNoteHotelreceiptModel m5 =
                        Table5CreditNoteHotelreceiptModel.fromJson(table5[0]);
                        if (table5.isNotEmpty) {
                          for (int i = 0; i < table5.length; i++) {
                            Table5CreditNoteHotelreceiptModel t1Data =
                            Table5CreditNoteHotelreceiptModel.fromJson(table5[i]);
                            tableData5.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table5
                                    .length}, t1Data: $t1Data');
                          }
                        }

                        tableData6.clear();

                        if (table6.isNotEmpty) {
                          Table6CreditNoteHotelPaymentCreditedModel m6 =
                          Table6CreditNoteHotelPaymentCreditedModel.fromJson(table6[0]);

                          for (int i = 0; i < table6.length; i++) {
                            Table6CreditNoteHotelPaymentCreditedModel t1Data =
                            Table6CreditNoteHotelPaymentCreditedModel.fromJson(table6[i]);
                            tableData6.add(t1Data);
                            print('Index: $i, Table4 Length: ${table6.length}, t1Data: $t1Data');
                          }
                        } else {
                          print("table6 is empty");
                        }


                        //
                        //
                        /*tableData9.clear();
                    Table9InvoiceListHotelModel m9 =
                        Table9InvoiceListHotelModel.fromJson(table9[0]);
                    if (table9.isNotEmpty) {
                      for (int i = 0; i < table9.length; i++) {
                        Table9InvoiceListHotelModel t1Data =
                            Table9InvoiceListHotelModel.fromJson(table9[i]);
                        tableData9.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table9.length}, t1Data: $t1Data');
                      }
                    }*/
                        tableData7.clear();
                        Table7CreditNoteHotelreceiptModel m7 =
                        Table7CreditNoteHotelreceiptModel.fromJson(table7[0]);
                        if (table7.isNotEmpty) {
                          for (int i = 0; i < table7.length; i++) {
                            Table7CreditNoteHotelreceiptModel t1Data =
                            Table7CreditNoteHotelreceiptModel.fromJson(table7[i]);
                            tableData7.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table1.length}, t1Data: $t1Data');
                          }
                        }

                        /*   Table11InvoiceHotelreceiptModel m11 =
                        Table11InvoiceHotelreceiptModel.fromJson(table11[0]);
                    if (table11.isNotEmpty) {
                      m11 =
                          Table11InvoiceHotelreceiptModel.fromJson(table11[0]);
                      print("fjhg" + m11.phone);
                    } else {
                      print('The list is empty.');
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

                        /*    tableData10.clear();
                    Table10InvoiceHotelfareBreakdownListModel m10 =
                        Table10InvoiceHotelfareBreakdownListModel.fromJson(
                            table10[0]);
                    if (table10.isNotEmpty) {
                      for (int i = 0; i < table10.length; i++) {
                        Table10InvoiceHotelfareBreakdownListModel t1Data =
                            Table10InvoiceHotelfareBreakdownListModel.fromJson(
                                table10[i]);
                        tableData10.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table10.length}, t1Data: $t1Data');
                      }
                    }*/
                        if (table21.isNotEmpty) {
                          Table21CreditNoteHotelreceiptModel m21 = Table21CreditNoteHotelreceiptModel.fromJson(table21[0]);
                          // Use m21 as needed
                        }

                        Table22CreditNotelHotelTermsandConditionModel? m22; // Nullable, since it may not be initialized

                        if (table22.isNotEmpty) {
                          m22 = Table22CreditNotelHotelTermsandConditionModel.fromJson(table22[0]);
                        }

// Now you can safely use m22 later, but check for null first
                        if (m22 != null) {
                          // Use m22 here
                        }

                        Table23HOtelCreditNoteTotalPriceModel? m23; // Nullable, since it may not be initialized

                        if (table23.isNotEmpty) {
                          m23 = Table23HOtelCreditNoteTotalPriceModel.fromJson(table23[0]);
                        }

// Now you can safely use m22 later, but check for null first
                        if (m23 != null) {
                          // Use m22 here
                        }
                        /*  InvoiceListHotelFareModel m48 =
                        InvoiceListHotelFareModel.fromJson(table48[0]);
                    if (table48.isNotEmpty) {
                      m48 = InvoiceListHotelFareModel.fromJson(table48[0]);
                      print("fjhg" + m48.totalFare);
                    } else {
                      print('The list is empty.');
                    }

                    Table47InvoiceHotelListModel m47 =
                        Table47InvoiceHotelListModel.fromJson(table47[0]);
                    if (table47.isNotEmpty) {
                      m47 = Table47InvoiceHotelListModel.fromJson(table47[0]);
                      print("fjhg" + m47.cancellationPolicy);
                    } else {
                      print('The list is empty.');
                    }

                    OInvoiceListHoteltaxModel m49 =
                        OInvoiceListHoteltaxModel.fromJson(table49[0]);
                    if (table49.isNotEmpty) {
                      m49 = OInvoiceListHoteltaxModel.fromJson(table49[0]);
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
                                      Image.asset(
                                          'assets/images/lojologo.png',
                                          width: 200,
                                          height: 50),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 3, left: 3),
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                    height: 0,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 3, left: 3),
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
                                Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 15, top: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(m3.passenger,
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
                                          'Email: ' + m3.tfpEmail,
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
                                        Text('Phone: ' + m3.tfpPhoneNo,
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
                                    padding: const EdgeInsets.only(
                                        right: 3, left: 3),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 2,
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 3, left: 3),
                                    child: Container(
                                      height: 40,
                                      color: Color(0xFFADD8E6),
                                      alignment: Alignment.centerLeft,
                                      child: Text('   Traveller Details:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17)),
                                    ),
                                  ),
                                  Column(
                                    children: List.generate(
                                      tableData3.length,
                                          (index) => Column(
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
                                                    "${tableData3[index].passenger}",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                        FontWeight.w500)),
                                                Text(
                                                  'Type: ${tableData3[index].type}',
                                                  style: (TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15)),
                                                ),
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
                                                    'Phone: ${tableData3[index].tfpPhoneNo}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 15))),
                                                Text(
                                                    'Age: ${tableData3[index].age}',
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
                                                  'PNR: ${tableData3[index].pnr}',
                                                  style: (TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15)),
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
                                    padding: const EdgeInsets.only(
                                        right: 3, left: 3, top: 10),
                                    child: Divider(
                                      color: Colors.black,
                                      thickness: 1,
                                      height: 0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 3, left: 3),
                                    child: Container(
                                      height: 40,
                                      color: Color(0xFFADD8E6),
                                      alignment: Alignment.centerLeft,
                                      child: Text('   Hotel details:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17)),
                                    ),
                                  ),
                                  Column(
                                    children: List.generate(
                                      tableData1.length,
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
                                                      'Hotel Name: ${tableData1[index].hotelName}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10, right: 15, top: 4),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded( // or Flexible
                                                    child: Text(
                                                      'Room Type: ${tableData1[index].roomType}',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15,
                                                      ),
                                                      overflow: TextOverflow.ellipsis, // to handle long text gracefully
                                                    ),
                                                  ),
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
                                                      'Check In: ${tableData1[index].checkInDt}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text(
                                                    'Nights: ${tableData1[index].noOfNights}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 15)),
                                                  ),
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
                                                      'Check Out: ${tableData1[index].checkOutDt}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15))),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 3, left: 3, top: 10),
                                    child: Divider(
                                      color: Colors.black,
                                      thickness: 1,
                                      height: 0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 3, left: 3),
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
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 15, top: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  'Tax:${tableData4[0].currency}${tableData4[0].inputTax}',
                                                  style: (TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15)),
                                                ),
                                                Text(
                                                    'Other Charges: 	${tableData4[0].currency}${tableData4[0].outputTax}',
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
                                                    'Base Fare: ${tableData4[0].currency}${tableData4[0].totalSales}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 15))),
                                                Text(
                                                    'Total: 	${tableData4[0].currency}${tableData4[0].totalNett}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 15))),
                                              ],
                                            ),
                                          ),

                                          SizedBox(
                                            height: 6,
                                          ),
                                        ],
                                      ),

                                ]),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 3, left: 3, top: 10, bottom: 5),
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                    height: 0,
                                  ),
                                ),

                                Table(
                                  columnWidths: {
                                    0: IntrinsicColumnWidth(), // Label Column
                                    1: FixedColumnWidth(20),   // Colon Column
                                    2: IntrinsicColumnWidth(), // Value Column
                                  },
                                  children: [
                                    _buildTableRow('Total Net Amount',m23!.currency, m23!.totalFare),
                                    _buildTableRow('Total GST ${m23.gstPercent} %',m23!.currency, m23.gstAmount),
                                    _buildTableRow('Service Charge and Tax',m23!.currency, m23.gstAmount),
                                    _buildTableRow('Total Discounts',m23!.currency, m23.discountAmount),
                                    _buildTableRow('Total Price',m23!.currency, m23.grandTotal, isBold: true),
                                  ],
                                ),
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
                                  children: tableData6.isEmpty
                                      ? [
                                    // Display "No data" text when the list is empty
                                    Text(
                                      'No data',
                                      style: TextStyle(
                                          fontSize: 15,
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
                                                    FontWeight.w500),
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
                                                    FontWeight.w500),
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
                                                'Status: ${tableData6[index].status}',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w500),
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
                                                'Date: ${tableData6[index].createdDatedt}',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 3, left: 3, top: 10),
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                    height: 0,
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 280,
                                        child: Text(
                                            'Room Description: ' +
                                                m22!.roomDescription,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        m22.roomPromotion.isNotEmpty
                                            ? 'Room Promotion: ${m22
                                            .roomPromotion}'
                                            : 'No Promotion Available',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),

                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        m22.smokingPreference.isNotEmpty
                                            ? 'Smoking Preference: ${m22
                                            .smokingPreference}'
                                            : 'No',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),

                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        m22.amenity.isNotEmpty
                                            ? 'Amenity: ${m22.amenity}'
                                            : 'No',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text('Inclusion: ' + m22.inclusion,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text('Hotel Policy:     ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(m22.hotelNorms,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text('Cancellation Policy:     ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          m22.cancellationPolicy ?? '',
                                          style: TextStyle(fontWeight: FontWeight.w600),
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
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
            )));
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
