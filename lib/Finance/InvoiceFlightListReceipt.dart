import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loja_traveller/Finance/table7FlightRemittanceModel.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../Booking/Table23FlightInvoiceTotalModel.dart';
import '../Booking/Table26FlightOnwardRoundWayModel.dart';
import '../Booking/Table27FlightReturnRoundWayModel.dart';
import '../Booking/Table3FlightRemittanceModel.dart';
import '../Booking/Table5InvoiceFlightInvoiceModel.dart';
import '../Booking/Table5InvoiceFlightlistDub.dart';
import '../Booking/table7FlightRemittanceModel.dart';
import '../Models/HOtelFareModel.dart';
import '../Models/HotelTaxModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'InvoiceListFlightFareModel.dart';
import 'InvoiceListFlighttaxModel.dart';
import 'Table0InvoiceFlighteceiptModel.dart';
import 'Table1InvoivceFlightReceiptModel.dart';

import 'Table22InvoiceFlightModel.dart';
import 'Table24InvoiceFlightModel.dart';
import 'Table2InvoiceListFlightReceiptModel.dart';
import 'package:http/http.dart' as http;

import 'Table5InvoiceFlightListReceiptModel.dart';
import 'Table5InvoiceFlightlistDub1.dart';
import 'Table6FlightReceiptModel.dart';

class InvoiceListReceipt extends StatefulWidget {
  final String Id;

  InvoiceListReceipt({required this.Id});
  @override
  State<InvoiceListReceipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<InvoiceListReceipt> {
  late List<dynamic> table0,
      table1,
      table2,
      table26,
      table34,
      table39,
      table50,
      table27,
      table3,
      table4,
      table5,
      table6,
      table7,
      table8,
      table9,
      table10,
      table12,
      table13,
      table14,
      table16,
      table18,
      table19,
      table22,
      table23,
      table24,

      table48,
      table49,
      table20,
      table21;

  List<Table26FlightOnwardRoundWayModel>tabledata26=[];
  List<Table27FlightReturnRoundWayModel>tabledata27=[];
  List<Table2InvoiceListFlightReceiptModel> tableData2 = [];
  List<Table23FlightInvoiceTotalModel> tableData23 = [];
  List<Table1InvoivceFlightReceiptModel> tableData1 = [];
  List<Table6FlightReceiptModel>tableData6=[];
  List<Table22InvoiceFlightModel> tableData22 = [];
  List<Table24InvoiceFlightModel>tableData24=[];
  List<Table3FlightRemittanceModel>tableData3=[];
  List<table7FlightRemittanceModel>tableData7=[];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "InvoiceListViewGet", "BookFlightId=${widget.Id}");
    print('jfghhjghId' + widget.Id);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      print('jfghhjghIjsonResponsed' + jsonResponse);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map['Table1'];
      table2 = map["Table2"];
      table3 = map["Table3"];
      table6=map["Table6"];
      table7=map['Table7'];
      table8 = map['Table8'];
      table5 = map["Table5"];
      table10 = map["Table10"];
      table13 = map["Table13"];
      table20 = map["Table20"];
      table18 = map['Table18'];
      table22 = map['Table22'];
      table23=map['Table23'];
      table24=map["Table24"];
      table26=map["Table26"];
      table27=map["Table27"];
      return jsonResponse;
    });
  }
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
                  "Flight Invoice",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 19,
                ),
                )
              ],
            ),
            actions: [
              Image.asset(
                'assets/images/lojolog.png',
                width: 100,
                height: 50,
              ),

            ],
            backgroundColor:Color(0xFF00ADEE)),
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
                    tableData1.clear();
                    Table1InvoivceFlightReceiptModel m1 =
                    Table1InvoivceFlightReceiptModel.fromJson(table1[0]);
                    if (table1.isNotEmpty) {
                      for (int i = 0; i < table1.length; i++) {
                        Table1InvoivceFlightReceiptModel t1Data =
                        Table1InvoivceFlightReceiptModel.fromJson(
                            table1[i]);
                        tableData1.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table1.length}, t1Data: $t1Data');
                      }
                    }
                    tabledata27.clear();

                    if (table27.isNotEmpty) {
                      Table27FlightReturnRoundWayModel m27 =
                      Table27FlightReturnRoundWayModel.fromJson(table27[0]);

                      for (int i = 0; i < table27.length; i++) {
                        Table27FlightReturnRoundWayModel t1Data =
                        Table27FlightReturnRoundWayModel.fromJson(table27[i]);
                        tabledata27.add(t1Data);
                        print('Index: $i, Table2 Length: ${table27.length}, t1Data: $t1Data');
                      }
                    } else {
                      print("table2 is empty");
                    }
                    tabledata26.clear();

                    if (table26.isNotEmpty) {
                      Table26FlightOnwardRoundWayModel m26 =
                      Table26FlightOnwardRoundWayModel.fromJson(table26[0]);

                      for (int i = 0; i < table26.length; i++) {
                        Table26FlightOnwardRoundWayModel t1Data =
                        Table26FlightOnwardRoundWayModel.fromJson(table26[i]);
                        tabledata26.add(t1Data);
                        print('Index: $i, Table2 Length: ${table26.length}, t1Data: $t1Data');
                      }
                    } else {
                      print("table2 is empty");
                    }
                    tableData2.clear();
                    Table2InvoiceListFlightReceiptModel m2 =
                    Table2InvoiceListFlightReceiptModel.fromJson(table2[0]);
                    if (table2.isNotEmpty) {
                      for (int i = 0; i < table2.length; i++) {
                        Table2InvoiceListFlightReceiptModel t1Data =
                        Table2InvoiceListFlightReceiptModel.fromJson(
                            table2[i]);
                        tableData2.add(t1Data);
                        print(
                            'Index: $i, TableSDF4 Length: ${table2.length}, t1Data: $t1Data');
                      }
                    }

                    tableData3.clear();

                    if (table3.isNotEmpty) {
                      Table3FlightRemittanceModel m3 = Table3FlightRemittanceModel.fromJson(table3[0]);

                      for (int i = 0; i < table3.length; i++) {
                        Table3FlightRemittanceModel t1Data = Table3FlightRemittanceModel.fromJson(table3[i]);
                        tableData3.add(t1Data);
                        print('Index: $i, table3 Length: ${table3.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table3 is empty, skipping processing');
                    }


                    tableData7.clear();

                    if (table7.isNotEmpty) {
                      table7FlightRemittanceModel m7 = table7FlightRemittanceModel.fromJson(table7[0]);

                      for (int i = 0; i < table7.length; i++) {
                        table7FlightRemittanceModel t1Data = table7FlightRemittanceModel.fromJson(table7[i]);
                        tableData7.add(t1Data);
                        print('Index: $i, Table7 Length: ${table7.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table7 is empty, skipping processing');
                    }


                    Table23FlightInvoiceTotalModel? m23; // nullable, initially null

                    if (table23.isNotEmpty) {
                      m23 = Table23FlightInvoiceTotalModel.fromJson(table23[0]);
                      for (int i = 0; i < table23.length; i++) {
                        Table23FlightInvoiceTotalModel t1Data = Table23FlightInvoiceTotalModel.fromJson(table23[i]);
                        tableData23.add(t1Data);
                        print('Index: $i, Table23 Length: ${table23.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table23 is empty, skipping processing');
                    }

// Now you can safely use m23 **only after checking if it's not null**
                    if (m23 != null) {
                      // use m23 here, e.g. access m23.totalFare
                    }




                    tableData24.clear();

                    Table24InvoiceFlightModel? m24;  // Declare nullable m24

                    if (table24.isNotEmpty) {
                      m24 = Table24InvoiceFlightModel.fromJson(table24[0]);  // Assign only if not empty
                      for (int i = 0; i < table24.length; i++) {
                        Table24InvoiceFlightModel t6Data = Table24InvoiceFlightModel.fromJson(table24[i]);
                        tableData24.add(t6Data);
                        print('Index: $i, Table24 Length: ${table24.length}, t6Data: $t6Data');
                      }
                    } else {
                      print('table24 is empty');
                    }

// Now m24 can be used safely after null check
                    if (m24 != null) {
                      // Use m24 here
                    }

//
                    /*  tableData50.clear();
                    Table50InvoiceFlightReceiptModel m50 =
                        Table50InvoiceFlightReceiptModel.fromJson(table50[0]);
                    if (table50.isNotEmpty) {
                      for (int i = 0; i < table50.length; i++) {
                        Table50InvoiceFlightReceiptModel t1Data =
                            Table50InvoiceFlightReceiptModel.fromJson(
                                table50[i]);
                        tableData50.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table50.length}, t1Data: $t1Data');
                      }
                    }*/
                    /* Table43RefunfFlightreceipt m43 =
                    Table43RefunfFlightreceipt.fromJson(table43[0]);
                    if (table43.isNotEmpty) {
                      for (int i = 0; i < table43.length; i++) {
                        Table43RefunfFlightreceipt t1Data =
                        Table43RefunfFlightreceipt.fromJson(
                            table43[i]);
                        tableData43.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table43.length}, t1Data: $t1Data');
                      }
                    }
                    InvoiceListFlightFareModel m48 =
                        InvoiceListFlightFareModel.fromJson(table48[0]);
                    if (table48.isNotEmpty) {
                      m48 = InvoiceListFlightFareModel.fromJson(table48[0]);
                      print("fjhg" + m48.totalFare);
                    } else {
                      print('The list is empty.');
                    }

                    InvoiceListFlighttaxModel m49 =
                        InvoiceListFlighttaxModel.fromJson(table49[0]);
                    if (table49.isNotEmpty) {
                      m49 = InvoiceListFlighttaxModel.fromJson(table49[0]);
                      print("fjhg" + m49.totalTax);
                    } else {
                      print('The list is empty.');
                    }*/

                    Table5InvoiceFlightlistDub1 m5 =
                    Table5InvoiceFlightlistDub1.fromJson(table5[0]);
                    if (table5.isNotEmpty) {
                      m5 = Table5InvoiceFlightlistDub1.fromJson(
                          table5[0]);
                      print("fjhg" + m5.phone);
                    } else {
                      print('The list is empty.');
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
                                  Text('Invoice',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Image.asset('assets/images/lojolog.png',
                                      width: 200, height: 50),
                                ],
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
                                  padding: const EdgeInsets.only(left: 10, right: 15, top: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          m5.addressLine1 + m5.addressLine2 + m5.addressLine3,
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis, // optional
                                          maxLines: 2, // optional: wrap text to 2 lines
                                        ),
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
                                    child: Text('   Passenger Details:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17)),
                                  ),
                                ),
                                Column(
                                  children: List.generate(
                                    tableData2.length,
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
                                                  "${tableData2[index].passenger}",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight.w500)),
                                              Text(
                                                'Type: ${tableData2[index].type}',
                                                style: (TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'Passenger ID: ${tableData2[index].passengerID}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Age: ${tableData2[index].age}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
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
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  'Phone : ${tableData2[index].tfpPhoneNo}',
                                                  style: (TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15))),
                                              Text(
                                                '	Ticket No : ${tableData2[index].ticketNo}',
                                                style: (TextStyle(
                                                    fontWeight: FontWeight.w500,
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
                                    tabledata26.length,
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
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Depart Date: ${tabledata26[index].tfsDepDatedt}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15),
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 15, top: 4),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Arrival Date: ${tabledata26[index].tfsArrDatedt}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15),
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  maxLines: 1,
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
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Depart: ${tabledata26[index].tfsDepAirport}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'Flight No: ${tabledata26[index].tfsFlightNumber}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.end,
                                                  overflow:
                                                  TextOverflow.ellipsis,
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
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Arrival: ${tabledata26[index].tfsArrAirport}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15),
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'Duration: ${tabledata26[index].tfsDuration}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.end,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                (m0.TripType?.toLowerCase().replaceAll(' ', '') == 'roundway')
                                    ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 3, left: 3),
                                      child: Container(
                                        height: 40,
                                        color: Color(0xFFB0D0DC),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '   Return Segment Details:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: List.generate(
                                        tabledata27.length,
                                            (index) => Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Depart Date: ${tabledata27[index].tfsDepDatedt}',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10, right: 15, top: 4),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Arrival Date: ${tabledata27[index].tfsArrDatedt}',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
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
                                                      'Depart: ${tabledata27[index].tfsDepAirport}',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      'Flight No: ${tabledata27[index].tfsFlightNumber}',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15,
                                                      ),
                                                      textAlign: TextAlign.end,
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
                                                      'Arrival: ${tabledata27[index].tfsArrAirport}',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      'Duration: ${tabledata27[index].tfsDuration}',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                    : SizedBox.shrink(),
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
                                                        '${tableData3[index].passenger}',
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
                                                      'Tax: $Currency ${tableData3[index].inputTax}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15)),
                                                    ),
                                                    Text(
                                                        'Other Charges: $Currency ${tableData3[index].outputTax}',
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
                                                        'Base Fare: $Currency ${tableData3[index].totalSales}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 15))),
                                                    Text(
                                                        'Total: $Currency ${tableData3[index].totalNett}',
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

                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,

                                    color: Color(0xFFADD8E6),
                                    alignment: Alignment.centerLeft,
                                    child: Text('  Remittance:',
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
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(
                                              'Start Date: ${tableData7[0].tfsDepDatedt}',
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
                                              'End Date: ${tableData7[0].tfsArrDatedt}',
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
                                                'Booking Ref:${tableData7[0].bookingId}',
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
                                                'Total: ${tableData7[0].totalNett}',
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
                                    _buildTableRow('Total Net Amount', m23?.currency, m23?.totalFare ?? 0),
                                    _buildTableRow('Total GST ${m23?.gstPercent ?? 0} %',  m23?.currency, m23?.gstAmount ?? 0),
                                    _buildTableRow('Service Charge and Tax',  m23?.currency, m23?.gstAmount ?? 0),
                                    _buildTableRow('Total Discount',  m23?.currency, m23?.discountAmount ?? 0),
                                    _buildTableRow('Total Price',  m23?.currency, m23?.grandTotal ?? 0, isBold: true),

                                  ],
                                ),




                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 3, left: 3, top: 4),
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                    height: 0,
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
                                                    'Date:  ${tableData6[index].createdDate}',
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
