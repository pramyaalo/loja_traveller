import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

 import '../Booking/Table13FlightInvoiceModel.dart';
import '../Booking/Table18FlightInvoiceModel.dart';
import '../Booking/Table26FlightOnwardRoundWayModel.dart';
import '../Booking/Table27FlightReturnRoundWayModel.dart';
import '../Finance/InvoiceListFlightFareModel.dart';
import '../Finance/InvoiceListFlighttaxModel.dart';
import '../Finance/Table0InvoiceFlighteceiptModel.dart';
import '../Finance/Table1InvoivceFlightReceiptModel.dart';
import '../Finance/Table2InvoiceListFlightReceiptModel.dart';
import '../Finance/Table50InvoiceFlightReceiptModel.dart';
import '../Finance/Table5InvoiceFlightListReceiptModel.dart';
import '../Models/HOtelFareModel.dart';

import '../utils/response_handler.dart';

import 'package:http/http.dart' as http;

import '../utils/shared_preferences.dart';
import 'Tablw23FlightPaymentInformationModel.dart';


class VouchersReceipt extends StatefulWidget {
  final String Id;

  VouchersReceipt({required this.Id});
  @override
  State<VouchersReceipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<VouchersReceipt> {
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
      table16,
      table18,
      table19,
      table23,
      table26,
      table34,
      table39,
      table50,
      table27,
      table48,
      table49,
      table20,
      table21;

  List<Table2InvoiceListFlightReceiptModel> tableData2 = [];
  List<Table1InvoivceFlightReceiptModel> tableData1 = [];
  List<Table18FlightInvoiceModel>tableData18=[];
  List<Tablw23FlightPaymentInformationModel>tableData23=[];
  List<Table26FlightOnwardRoundWayModel>tabledata26=[];
  List<Table27FlightReturnRoundWayModel>tabledata27=[];
  List<Table13FlightInvoiceModel>tableData13=[];
  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "VoucherViewGet", "BookFlightId=${widget.Id}");
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
      table8 = map['Table8'];
      table5 = map["Table5"];
      table10 = map["Table10"];
      table13 = map["Table13"];
      table16=map['Table16'];
      table18 = map['Table18'];
      table23=map['Table23'];
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
                  "Flight Voucher",
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

                    tableData23.clear();

                    Tablw23FlightPaymentInformationModel? m23; // Declare outside

                    if (table23.isNotEmpty) {
                      m23 = Tablw23FlightPaymentInformationModel.fromJson(table23[0]);

                      for (int i = 0; i < table23.length; i++) {
                        Tablw23FlightPaymentInformationModel t1Data =
                        Tablw23FlightPaymentInformationModel.fromJson(table23[i]);
                        tableData23.add(t1Data);
                        print('Index: $i, Table23 Length: ${table23.length}, t1Data: $t1Data');
                      }
                    } else {
                      print("table23 is empty");
                    }


                    tableData2.clear();

                    if (table2.isNotEmpty) {
                      Table2InvoiceListFlightReceiptModel m2 =
                      Table2InvoiceListFlightReceiptModel.fromJson(table2[0]);

                      for (int i = 0; i < table2.length; i++) {
                        Table2InvoiceListFlightReceiptModel t1Data =
                        Table2InvoiceListFlightReceiptModel.fromJson(table2[i]);
                        tableData2.add(t1Data);
                        print('Index: $i, Table2 Length: ${table2.length}, t1Data: $t1Data');
                      }
                    } else {
                      print("table2 is empty");
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

                    tableData18.clear();

                    if (table18.isNotEmpty) {
                      Table18FlightInvoiceModel m24 =
                      Table18FlightInvoiceModel.fromJson(table18[0]);

                      for (int i = 0; i < table18.length; i++) {
                        Table18FlightInvoiceModel t6Data =
                        Table18FlightInvoiceModel.fromJson(table18[i]);
                        tableData18.add(t6Data);
                        print('Index: $i, Table18 Length: ${table18.length}, t1Data: $t6Data');
                      }
                    } else {
                      print("table18 is empty");
                    }

                    tableData13.clear();

                    if (table13.isNotEmpty) {
                      Table13FlightInvoiceModel m13 = Table13FlightInvoiceModel.fromJson(table13[0]);

                      for (int i = 0; i < table13.length; i++) {
                        Table13FlightInvoiceModel t6Data =
                        Table13FlightInvoiceModel.fromJson(table13[i]);
                        tableData13.add(t6Data);
                        print(
                            'Index: $i, Table13 Length: ${table13.length}, t6Data: $t6Data');
                      }
                    } else {
                      print("table13 is empty");
                    }
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
                                  Text('Voucher',
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
                                      Text("Date: "+m0.bookedOnDt,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15, top: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Dear "+m0.passenger+" ,",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Thank you for booking with Travel Demo. Our preferred partner would like to invite you to join a paid subscription service for access to discount offers.\n"
                                        "Reference Number: ${m0.bookingId}."
                                        "Trip Type: ${m0.TripType}.\n"
                                        "Booking Number: ${m0.bookingNumber}.\n"
                                        "Please print and take this booking receipt with you to the airport. It may speed up your check-in experience.\n"
                                        "For any concerns / queries related to this booking, please mention this reference number in all your future communications with us.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1.5,
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15, top: 4),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Booking Status: '
                                            +
                                            m0.bookingStatus,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
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
                                          padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${tableData2[index].passenger}",
                                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                'Type: ${tableData2[index].type}',
                                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
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
                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                'Age : ${tableData2[index].age}',
                                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
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
                                                  'Phone : ${tableData2[index].tfpPhoneNo}',
                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Ticket No : ${tableData2[index].pnr}',
                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.end,
                                                ),
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
                                    child: Text('  Payment Information:',
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
                                    _buildTableRow('Total Net Amount',m23?.currency??'', m23?.totalFare??'0'),
                                    _buildTableRow('Total GST ${m23?.gstPercent} %',m23?.currency??'0', m23?.gstAmount??'0'),
                                    _buildTableRow(
                                      '	Service Charge and Tax',
                                      m23?.currency??'0',
                                      (double.tryParse(m23?.serviceTaxAmount??'0'
                                          .toString()) ??
                                          0) +
                                          (double.tryParse(
                                              m23?.gstAmount??'0'.toString()) ??
                                              0),
                                    ),                                    _buildTableRow('Total Discount',m23?.currency??'0', m23?.discountAmount??'0'),

                                    _buildTableRow('Total Price',m23?.currency??'0', m23?.grandTotal??'0', isBold: true),
                                  ],
                                ),
                                Divider(thickness: 1,),

                                Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "* BAGGAGE DISCOUNTS MAY APPLY BASED ON FREQUENT FLYER STATUS/ONLINE CHECKIN/FORM OF PAYMENT/MILITARY/ETC.",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Montserrat",
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "* REMAINING PAYMENT HAS TO BE DONE WHEN PICKING BUS.",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "Montserrat",
                                        ),
                                      ),
                                    ],
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
