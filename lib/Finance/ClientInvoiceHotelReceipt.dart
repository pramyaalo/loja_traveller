import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Booking/Table1InvoiceHotelReceiptModel.dart';
import '../Booking/Table21ClientInvoiceHotelreceiptModel.dart';
import '../Booking/Table22TermsnadCondfitionHolidayModel.dart';
import '../Booking/Table23CLientInvoiceHotelreceiptModel.dart';
import '../Booking/Table3ClientInvoiceHotelreceiptModel.dart';
import '../Booking/Table4ClientInvoiceHotelreceiptModel.dart';
import '../Booking/Table5ClientInvoicehotelreceiptModel.dart';
import '../Booking/Table6ClientInvoiceHotelreceiptModel.dart';
import '../Booking/Table7HolidayRemittanceHotelModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'ClientInvoiceHotelModel.dart';
import 'CreditNoteFlightTaxModel.dart';
import 'CreditNoteHolidayTaxModel.dart';
import 'Tabe48CreditNoteFareModel.dart';
import 'Table0CreditNoteFlightModsel.dart';
import 'Table0InvoiceFlighteceiptModel.dart';
import 'Table10ClientInvopiceHotelReceiptModel.dart';


import 'Table25HolidayModel.dart';


import 'Table9ClientInvoiceHoiytelReceiptModel.dart';
import 'Table9CreditNoteHoteleceipt.dart';

class ClientInvoiceHotelReceipt extends StatefulWidget {
  final String Id;

  ClientInvoiceHotelReceipt({required this.Id});
  @override
  State<ClientInvoiceHotelReceipt> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<ClientInvoiceHotelReceipt> {
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

  List<Table7HolidayRemittanceHotelModel> tableData7 = [];
  List<Table23CLientInvoiceHotelreceiptModel>tableData23=[];
  List<Table22TermsnadCondfitionHolidayModel>tableData22=[];
  List<Table9ClientInvoiceHoiytelReceiptModel> tableData9 = [];
  List<Table10ClientInvopiceHotelReceiptModel> tableData10 = [];
  List<Table6ClientInvoiceHotelreceiptModel>tableData6=[];
  List<Table25HolidayModel> tableData25 = [];
  List<Table1InvoiceHotelReceiptModel>tableData1=[];
  List<Table3ClientInvoiceHotelreceiptModel>tableData3=[];
  List<Table4ClientInvoiceHotelreceiptModel>tableData4=[];
  List<Table5ClientInvoicehotelreceiptModel>tableData5=[];
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
        "ClientInvoiceViewGet", "BookFlightId=${widget.Id}");
    print('jfghhjghId' + widget.Id);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      print('jfghhjghIjsonResponsed' + jsonResponse);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1=map["Table1"];
      table3=map["Table3"];
      table6=map["Table6"];
      table7 = map["Table7"];
      table9 = map["Table9"];
      table10 = map["Table10"];
      table11 = map['Table11'];
      table23 = map["Table23"];
      table20 = map["Table20"];
      table21=map["Table21"];
      table22=map["Table22"];
      table23 = map['Table23'];
      table25 = map['Table25'];
      table13 = map["Table13"];
      table4=map["Table4"];
      table5=map["Table5"];
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
              child: FutureBuilder<String?>(
                  future: getLabels(),
                  builder: (context, snapshot) {
                    print('object' + snapshot.connectionState.toString());
                    if (snapshot.connectionState == ConnectionState.done) {
                      try {
                        Table0InvoiceFlighteceiptModel m0 =
                        Table0InvoiceFlighteceiptModel.fromJson(table0[0]);
                        if (table0.isNotEmpty) {
                          m0 = Table0InvoiceFlighteceiptModel.fromJson(table0[0]);
                          print("fjhg" + m0.bookFlightId);
                        } else {
                          print('The list is empty.');
                        }
                        tableData6.clear();

                        if (table6.isNotEmpty) {
                          for (int i = 0; i < table6.length; i++) {
                            Table6ClientInvoiceHotelreceiptModel t6Data =
                            Table6ClientInvoiceHotelreceiptModel.fromJson(
                                table6[i]);
                            tableData6.add(t6Data);
                            print(
                                'Index: $i, Table4 Length: ${table6.length}, t1Data: $t6Data');
                          }
                        }
                        tableData1.clear();
                        Table1InvoiceHotelReceiptModel m1 =
                        Table1InvoiceHotelReceiptModel.fromJson(table1[0]);
                        if (table1.isNotEmpty) {
                          for (int i = 0; i < table1.length; i++) {
                            Table1InvoiceHotelReceiptModel t1Data =
                            Table1InvoiceHotelReceiptModel.fromJson(table1[i]);
                            tableData1.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table3
                                    .length}, t1Data: $t1Data');
                          }
                        }
                        tableData3.clear();
                        Table3ClientInvoiceHotelreceiptModel m3 =
                        Table3ClientInvoiceHotelreceiptModel.fromJson(table3[0]);
                        if (table3.isNotEmpty) {
                          for (int i = 0; i < table3.length; i++) {
                            Table3ClientInvoiceHotelreceiptModel t1Data =
                            Table3ClientInvoiceHotelreceiptModel.fromJson(table3[i]);
                            tableData3.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table3
                                    .length}, t1Data: $t1Data');
                          }
                        }
                        tableData4.clear();
                        Table4ClientInvoiceHotelreceiptModel m4 =
                        Table4ClientInvoiceHotelreceiptModel.fromJson(table4[0]);
                        if (table4.isNotEmpty) {
                          for (int i = 0; i < table4.length; i++) {
                            Table4ClientInvoiceHotelreceiptModel t1Data =
                            Table4ClientInvoiceHotelreceiptModel.fromJson(table4[i]);
                            tableData4.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table4
                                    .length}, t1Data: $t1Data');
                          }
                        }

                        tableData5.clear();
                        Table5ClientInvoicehotelreceiptModel m5 =
                        Table5ClientInvoicehotelreceiptModel.fromJson(table5[0]);
                        if (table5.isNotEmpty) {
                          for (int i = 0; i < table5.length; i++) {
                            Table5ClientInvoicehotelreceiptModel t1Data =
                            Table5ClientInvoicehotelreceiptModel.fromJson(table5[i]);
                            tableData5.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table5
                                    .length}, t1Data: $t1Data');
                          }
                        }
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
                        Table7HolidayRemittanceHotelModel m7 =
                        Table7HolidayRemittanceHotelModel.fromJson(table7[0]);
                        if (table7.isNotEmpty) {
                          for (int i = 0; i < table7.length; i++) {
                            Table7HolidayRemittanceHotelModel t1Data =
                            Table7HolidayRemittanceHotelModel.fromJson(table7[i]);
                            tableData7.add(t1Data);
                            print(
                                'Index: $i, Table4 Length: ${table1.length}, t1Data: $t1Data');
                          }
                        }


                        if (table21 != null && table21.isNotEmpty) {
                          Table21ClientInvoiceHotelreceiptModel m21 =
                          Table21ClientInvoiceHotelreceiptModel.fromJson(table21[0]);
                          // Use m21 safely here
                        } else {
                          print("table21 is empty or null");
                        }

                        Table23CLientInvoiceHotelreceiptModel? m23; // Declare outside so it's accessible later

                        tableData23.clear();

                        if (table23 != null && table23.isNotEmpty) {
                          m23 = Table23CLientInvoiceHotelreceiptModel.fromJson(table23[0]);

                          for (int i = 0; i < table23.length; i++) {
                            Table23CLientInvoiceHotelreceiptModel t6Data =
                            Table23CLientInvoiceHotelreceiptModel.fromJson(table23[i]);
                            tableData23.add(t6Data);
                            print(
                                'Index: $i, Table22 Length: ${table23.length}, t6Data: $t6Data');
                          }

                          // Now m22 is safe to use here and outside
                          print("Total Nett from m22: ${m23.gstAmount}");
                        } else {
                          print('table22 is empty or null');
                        }

                        Table22TermsnadCondfitionHolidayModel? m22; // Declare outside so it's accessible later

                        tableData22.clear();

                        if (table22 != null && table22.isNotEmpty) {
                          m22 = Table22TermsnadCondfitionHolidayModel.fromJson(table22[0]);

                          for (int i = 0; i < table22.length; i++) {
                            Table22TermsnadCondfitionHolidayModel t6Data =
                            Table22TermsnadCondfitionHolidayModel.fromJson(table22[i]);
                            tableData22.add(t6Data);
                            print(
                                'Index: $i, Table22 Length: ${table23.length}, t6Data: $t6Data');
                          }

                          // Now m22 is safe to use here and outside
                          print("Total Nett from m22: ${m22.bookFlightId}");
                        } else {
                          print('table22 is empty or null');
                        }


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
                                      Text('Client Invoice',
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
                                    child: Text('Client Invoice',
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
                                          Text(m5.corporateName,
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
                                            m5.addressLine1 +
                                                m5.addressLine2 +
                                                m5.addressLine3,
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
                                          Text('City:' + m5.city,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 15, top: 4),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Post Code & Phone: ' +
                                                m5.postCode +
                                                "|" +
                                                m5.phone,
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 15, top: 4),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Invoice date: ' + m0.bookedOnDt,
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
                                            'Invoice Number: ' + m0.bookFlightId,
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
                                            'Booking Status: ' + m0.bookingStatus,
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
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                      "${tableData3[index].passenger}",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                          FontWeight.w500)),
                                                  Text(
                                                    'Type:+ ${tableData3[index].type}',
                                                    style: (TextStyle(
                                                        fontWeight: FontWeight.w500,
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
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                      'PNR: ${tableData3[index].pnr}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text(
                                                      'Age : ${tableData3[index].age}',
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
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                      'Phone : ${tableData3[index].tfpPhoneNo}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15))),
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
                                        child: Text('   Hotel Details:',
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
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Hotel Name: ${tableData1[index].hotelName}',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10, right: 15, top: 4),
                                                  child: Text(
                                                    'Room Type: ${tableData1[index].roomType}',
                                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 10, right: 15, top: 4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(

                                                        child: Text(
                                                            'Check In: ${tableData1[index].checkInDt}',
                                                            style: (TextStyle(
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                fontSize: 15))),
                                                      ),

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
                                                          'Check Out: ${tableData1[index].checkOutDt}',
                                                          style: (TextStyle(
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 15))),
                                                      Text(
                                                        'Nights:  ${tableData1[index].noOfNights}',
                                                        style: (TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 15)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                        )),
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
                                                            '${tableData4[0].passenger}',
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
                                                          'Tax: ${tableData4[0].currency} ${tableData4[0].inputTax}',
                                                          style: (TextStyle(
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 15)),
                                                        ),
                                                        Text(
                                                            'Other Charges: ${tableData4[0].currency} ${tableData4[0].outputTax}',
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
                                                            'Base Fare: ${tableData4[0].currency} ${tableData4[0].totalSales}',
                                                            style: (TextStyle(
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                fontSize: 15))),
                                                        Text(
                                                            'Total: ${tableData4[0].currency} ${tableData4[0].totalNett}',
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

                                    Padding(
                                      padding:
                                      const EdgeInsets.only(right: 3, left: 3),
                                      child: Container(
                                        height: 40,
                                        color: Color(0xFFADD8E6),
                                        alignment: Alignment.centerLeft,
                                        child: Text('  Invoice Total $Currency:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
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
                                        _buildTableRow('Total Discount',m23!.currency, m23.discountAmount),

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
                                        child: Text(' Remittance:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),

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
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Lead Passenger: ${tableData7[0].passenger}',
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
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(

                                                        child: Text(
                                                            '	Booking Ref: ${tableData7[0].bookingNumber}',
                                                            style: (TextStyle(
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                fontSize: 15))),
                                                      ),

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
                                                      Container(

                                                        child: Text(
                                                            'CheckOut date: ${tableData7[0].checkOutDtt}',
                                                            style: (TextStyle(
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                fontSize: 15))),
                                                      ),

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
                                                          'Consultant: ${tableData7[0].name}',
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
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Total: ${tableData7[0].totalNett}',
                                                          style: (TextStyle(
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 15))),

                                                    ],
                                                  ),
                                                ),
                                              ]),


                                    Padding(
                                      padding:
                                      const EdgeInsets.only(right: 3, left: 3),
                                      child: Container(
                                        height: 40,
                                        color: Color(0xFFADD8E6),
                                        alignment: Alignment.centerLeft,
                                        child: Text('  Received Payments:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Column(
                                        children: List.generate(
                                          tableData6.length,
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
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Receipt No: ${tableData6[index].receiptNo}',
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
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Allocated Amount: ${tableData6[index].allocatedAmount}',
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
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Status: ${tableData6[index].status}',
                                                          style: (TextStyle(
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 15))),
                                                      Text(
                                                        'Date:  ${tableData6[index].createdDatedt}',
                                                        style: (TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 15)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                        )),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(right: 3, left: 3),
                                      child: Container(
                                        height: 40,
                                        color: Color(0xFFADD8E6),
                                        alignment: Alignment.centerLeft,
                                        child: Text('  Terms And Conditions:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17)),
                                      ),
                                    ),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Heading only once
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                              child: Text(
                                                'Room Description',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                              ),
                                            ),

                                            // List of all room descriptions
                                            ...tableData22.map((data) => Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                              child: Text(data.roomDescription ?? ''),
                                            )),
                                          ],
                                        ),
                                        const Divider(),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                              child: Text(
                                                'Room Promotion',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                              ),
                                            ),

                                            // Only non-empty roomPromotion values
                                            ...tableData22
                                                .where((data) => (data.roomPromotion ?? '').trim().isNotEmpty)
                                                .map((data) => Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                              child: Text(data.roomPromotion!),
                                            ))
                                                .toList(),
                                          ],
                                        ),

                                        // Smoking Preference Section
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                              child: Text(
                                                'Smoking Preference',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                              ),
                                            ),
                                            ...tableData22
                                                .where((data) => (data.smokingPreference ?? '').trim().isNotEmpty)
                                                .map((data) => Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                              child: Text(data.smokingPreference!),
                                            ))
                                                .toList(),
                                          ],
                                        ),

// Amenity Section
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                              child: Text(
                                                'Amenity',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                              ),
                                            ),
                                            ...tableData22
                                                .where((data) => (data.amenities ?? '').trim().isNotEmpty)
                                                .map((data) => Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                              child: Text(data.amenities!),
                                            ))
                                                .toList(),
                                          ],
                                        ),


                                        const Divider(),

                                        // Inclusion Section
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                          child: Text('Inclusion:', style: TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                        ...tableData22.map((data) => Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                          child: Text(data.inclusion ?? ''),
                                        )),


                                        const Divider(),

                                        // Hotel Policy Section
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                              child: Text('Hotel Policy:', style: TextStyle(fontWeight: FontWeight.bold)),
                                            ),
                                            ...tableData22
                                                .where((data) => (data.hotelPolicyDetail ?? '').trim().isNotEmpty)
                                                .map((data) => Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                              child: Text(data.hotelPolicyDetail!),
                                            ))
                                                .toList(),
                                          ],
                                        ),



                                        const Divider(),

                                        // Cancellation Policy Section
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                          child: Text('Cancellation Policy:', style: TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                        ...tableData22.map((data) => Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                          child: Text(data.cancellationPolicy ?? ''),
                                        )),

                                        const SizedBox(height: 10),
                                      ],
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
                                    )
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
