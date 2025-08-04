import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Finance/InvoiceListFlightFareModel.dart';
import '../Finance/InvoiceListFlighttaxModel.dart';
import '../Finance/Table0InvoiceFlighteceiptModel.dart';
import '../Finance/Table1InvoivceFlightReceiptModel.dart';
import '../Finance/Table2InvoiceListFlightReceiptModel.dart';
import '../Finance/Table50InvoiceFlightReceiptModel.dart';
import '../Finance/Table5InvoiceFlightListReceiptModel.dart';
import '../Models/HOtelFareModel.dart';
import '../Models/HotelTaxModel.dart';
 import '../utils/response_handler.dart';

import 'package:http/http.dart' as http;

import '../utils/shared_preferences.dart';
import 'Table10FlightReceiptModel.dart';
import 'Table14FlightOnwardSegmentModel.dart';
import 'Table15FlightReturnSegmentModel.dart';
import 'Table16FlightInvoiceModel.dart';
import 'Table13FlightInvoiceModel.dart';
import 'Table43RefunfFlightreceipt.dart';

class FlightReceiptScreen extends StatefulWidget {
  final String Id;

  FlightReceiptScreen({required this.Id});
  @override
  State<FlightReceiptScreen> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<FlightReceiptScreen> {
  late List<dynamic> table0,
      table1,
      table2,
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
      table15,
      table16,
      table18,
      table19,
      table23,
      table34,
      table39,
      table50,
      table43,
      table48,
      table49,
      table20,
      table21;

  List<Table2InvoiceListFlightReceiptModel> tableData2 = [];
  List<Table1InvoivceFlightReceiptModel> tableData1 = [];
  List<Table13FlightInvoiceModel>tableData13=[];
  List<Table50InvoiceFlightReceiptModel> tableData50 = [];
  List<Table43RefunfFlightreceipt> tableData43 = [];
  List<Table16FlightInvoiceMode>tableData22=[];
  List<Table10FlightReceiptModel>tabledata10=[];
  List<Table14FlightOnwardSegmentModel>tableData14=[];
  List<Table15FlightReturnSegmentModel>tableData15=[];
  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "RecFlightReceipt", "BookId=${widget.Id}");
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
      table16=map["Table16"];
      table8 = map['Table8'];
      table5 = map["Table5"];
      table10 = map["Table10"];
      table13 = map["Table13"];


      table14=map["Table14"];
      table15=map["Table15"];
      table18 = map['Table18'];
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
                  "Flight Receipt",
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
                    tabledata10.clear();

                    if (table10.isNotEmpty) {
                      Table10FlightReceiptModel m10 = Table10FlightReceiptModel.fromJson(table10[0]);

                      for (int i = 0; i < table10.length; i++) {
                        Table10FlightReceiptModel t1Data =
                        Table10FlightReceiptModel.fromJson(table10[i]);
                        tabledata10.add(t1Data);
                        print('Index: $i, Table10 Length: ${table10.length}, t1Data: $t1Data');
                      }
                    } else {
                      print("table10 is empty");
                    }
                    tableData14.clear();
                    Table14FlightOnwardSegmentModel m14 =
                    Table14FlightOnwardSegmentModel.fromJson(table14[0]);
                    if (table14.isNotEmpty) {
                      for (int i = 0; i < table14.length; i++) {
                        Table14FlightOnwardSegmentModel t1Data =
                        Table14FlightOnwardSegmentModel.fromJson(
                            table14[i]);
                        tableData14.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table14.length}, t1Data: $t1Data');
                      }
                    }

                    tableData15.clear();
                    Table15FlightReturnSegmentModel m15 =
                    Table15FlightReturnSegmentModel.fromJson(table15[0]);
                    if (table15.isNotEmpty) {
                      for (int i = 0; i < table15.length; i++) {
                        Table15FlightReturnSegmentModel t1Data =
                        Table15FlightReturnSegmentModel.fromJson(
                            table15[i]);
                        tableData15.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table15.length}, t1Data: $t1Data');
                      }
                    }
                    tableData22.clear();
                    Table16FlightInvoiceMode m16 =
                    Table16FlightInvoiceMode.fromJson(table16[0]);
                    if (table16.isNotEmpty) {
                      for (int i = 0; i < table16.length; i++) {
                        Table16FlightInvoiceMode t6Data =
                        Table16FlightInvoiceMode.fromJson(
                            table16[i]);
                        tableData22.add(t6Data);
                        print(
                            'Index: $i, Table4 Length: ${table6.length}, t1Data: $t6Data');
                      }
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
                            'Index: $i, Table4 Length: ${table2.length}, t1Data: $t1Data');
                      }
                    }
                    tableData13.clear();
                    Table13FlightInvoiceModel m13 =
                    Table13FlightInvoiceModel.fromJson(table13[0]);
                    if (table13.isNotEmpty) {
                      for (int i = 0; i < table13.length; i++) {
                        Table13FlightInvoiceModel t6Data =
                        Table13FlightInvoiceModel.fromJson(
                            table13[i]);
                        tableData13.add(t6Data);
                        print(
                            'Index: $i, Table4 Length: ${table6.length}, t1Data: $t6Data');
                      }
                    }
                    /*tableData50.clear();
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
                    /* InvoiceListFlightFareModel m48 =
                    InvoiceListFlightFareModel.fromJson(table48[0]);
                    if (table48.isNotEmpty) {
                      m48 = InvoiceListFlightFareModel.fromJson(table48[0]);
                      print("fjhg" + m48.totalFare);
                    } else {
                      print('The list is empty.');
                    }
                    Table43RefunfFlightreceipt m43 =
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
                    InvoiceListFlighttaxModel m49 =
                    InvoiceListFlighttaxModel.fromJson(table49[0]);
                    if (table49.isNotEmpty) {
                      m49 = InvoiceListFlighttaxModel.fromJson(table49[0]);
                      print("fjhg" + m49.totalTax);
                    } else {
                      print('The list is empty.');
                    }*/

                    Table5InvoiceFlightListReceiptModel m5 =
                    Table5InvoiceFlightListReceiptModel.fromJson(table5[0]);
                    if (table5.isNotEmpty) {
                      m5 = Table5InvoiceFlightListReceiptModel.fromJson(
                          table5[0]);
                      print("fjhg" + m5.phone);
                    } else {
                      print('The list is empty.');
                    }
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
                                  Text('Receipt',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Image.asset('assets/images/lojologo.png',
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
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15, top: 4),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Phone: ' +
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15, top: 4),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Trip Type: ' + m0.TripType,
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
                                    color: Color(0xFFB0D0DC),
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
                                          padding: const EdgeInsets.only(left: 10, right: 15, top: 4),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Passenger ID: ${tableData2[index].passengerID}',
                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Age: ${tableData2[index].age}',
                                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
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
                                    color: Color(0xFFB0D0DC),
                                    alignment: Alignment.centerLeft,
                                    child: Text('   OnWard Segment:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17)),
                                  ),
                                ),
                                Column(
                                  children: List.generate(
                                    tableData14.length,
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
                                                  'Depart Date: ${tableData14[index].tfsDepDatedt}',
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
                                                  'Arrival Date: ${tableData14[index].tfsArrDatedt}',
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
                                                  'Depart: ${tableData14[index].tfsDepAirport}',
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
                                                  'Flight No: ${tableData14[index].tfsFlightNumber}',
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
                                                  'Arrival: ${tableData14[index].tfsArrAirport}',
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
                                                  'Duration: ${tableData14[index].tfsDuration}',
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

                               m0.TripType?.toLowerCase().replaceAll(" ", "") == "roundway"
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
                                        tableData15.length,
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
                                                      'Depart Date: ${tableData15[index].tfsDepDatedt}',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w500, fontSize: 15),
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
                                                      'Arrival Date: ${tableData15[index].tfsArrDatedt}',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w500, fontSize: 15),
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
                                                      'Depart: ${tableData15[index].tfsDepAirport}',
                                                      style: TextStyle(
                                                          fontSize: 15, fontWeight: FontWeight.w500),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      'Flight No: ${tableData15[index].tfsFlightNumber}',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w500, fontSize: 15),
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
                                                      'Arrival: ${tableData15[index].tfsArrAirport}',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w500, fontSize: 15),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      'Duration: ${tableData15[index].tfsDuration}',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w500, fontSize: 15),
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
                                    color: Color(0xFFB0D0DC),
                                    alignment: Alignment.centerLeft,
                                    child: Text('   Payment Details:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17)),
                                  ),
                                ),
                                Column(
                                  children: List.generate(
                                    tableData13.length,
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
                                                        '${tableData13[index].Name}',
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
                                                      'Tax: ${tableData13[index].Currency} ${tableData13[index].inputTax}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15)),
                                                    ),
                                                    Text(
                                                        'Other Charges: ${tableData13[index].Currency} ${tableData13[index].outputTax}',
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
                                                        'Base Fare: ${tableData13[index].Currency} ${tableData13[index].totalSales}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 15))),
                                                    Text(
                                                        'Total: ${tableData13[index].Currency} ${tableData13[index].totalNett}',
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
                                    _buildTableRow('Total Net Amount',m16.currency, m16.totalFare),
                                    _buildTableRow(
                                      '	Service Charge and Tax',
                                      m16.currency,
                                      (double.tryParse(m16.serviceTaxAmount
                                          .toString()) ??
                                          0) +
                                          (double.tryParse(
                                              m16.gstAmount.toString()) ??
                                              0),
                                    ),
                                    _buildTableRow('Total Discount',m16.currency, m16.discountAmount),

                                    _buildTableRow('Total Price',m16.currency, m16.grandTotal, isBold: true),
                                  ],
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Color(0xFFADD8E6),
                                    alignment: Alignment.centerLeft,
                                    child: Text('  Receipt Details:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17)),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: tabledata10.isNotEmpty
                                      ? Column(
                                    children: List.generate(
                                      tabledata10.length,
                                          (index) => Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Receipt No: ${tabledata10[index].receiptNo}',
                                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Allocated Amount: ${tabledata10[index].allocatedAmount}',
                                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Status: ${tabledata10[index].status}',
                                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0, right: 5, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Date: ${tabledata10[index].createdDatedt}',
                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 9),
                                        ],
                                      ),
                                    ),
                                  )
                                      : Center(
                                    child: Text(
                                      'No Data',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Color(0xFFB0D0DC),
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
                fontWeight: FontWeight.w600,
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
                fontWeight: FontWeight.w600,
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
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
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
