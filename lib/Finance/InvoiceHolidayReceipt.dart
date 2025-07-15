import 'dart:convert';

import 'package:flutter/material.dart';


import '../Booking/Table1HolidayInvoiceReceiptModel.dart';
 import '../Booking/Table3InvoiceHolidayReceiptModel.dart';
import '../Booking/Table4InvoiceholidayReceiptModel.dart';
import '../Booking/Table5HolidayInvoiceReceiptModel.dart';
import '../Booking/Table7HolidayRemittanceModel.dart';
import '../Models/HOtelFareModel.dart';
import '../Models/HotelTaxModel.dart';
import '../utils/response_handler.dart';
import 'InvoiceListFlightFareModel.dart';
import 'InvoiceListFlighttaxModel.dart';
import 'InvoiceListHolidayTaxModel.dart';
import 'InvoiceListHolidayfareModel.dart';
import 'InvoiceListHotelFareModel.dart';
import 'OInvoiceListHoteltaxModel.dart';
import 'Table0InvoiceFlighteceiptModel.dart';
import 'Table10InvoiceHotelfareBreakdownListModel.dart';
import 'Table11InvoiceHotelreceiptModel.dart';
import 'Table1InvoivceFlightReceiptModel.dart';
import 'Table20InvoiceHolidayReceiptModel.dart';

import 'Table22HolidayInvoicereceiptModel.dart';
import 'Table23InvoiceHolidayReceipt.dart';
import 'Table24InvoiceHolidayReceiptModel.dart';
import 'Table2InvoiceListFlightReceiptModel.dart';
import 'package:http/http.dart' as http;


import 'Table5InvoiceFlightListReceiptModel.dart';
import 'Table7InvoiceListHotelModel.dart';
import 'Table9InvoiceListHotelModel.dart';

class InvoiceHolidayReceipt extends StatefulWidget {
  final String Id;

  InvoiceHolidayReceipt({required this.Id});
  @override
  State<InvoiceHolidayReceipt> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<InvoiceHolidayReceipt> {
  late List<dynamic> table0,
      table1,
      table2,
      table3,
      table4,
      table5,
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
      table34,
      table39,
      table50,
      table47,
      table48,
      table49,
      table20,
      table21;

  List<Table22HolidayInvoicereceiptModel> tableData22 = [];
  List<Table20InvoiceHolidayReceiptModel> tableData20 = [];
  List<Table23InvoiceHolidayReceipt> tableData23 = [];
  List<Table5HolidayInvoiceReceiptModel>tableData5=[];
  List<Table1HolidayInvoiceReceiptModel>tableData1=[];
  List<Table4InvoiceholidayReceiptModel>tableData4=[];
  List<Table7HolidayRemittanceModel>tableData7=[];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "InvoiceListViewGet", "BookFlightId=${widget.Id}");
    print('jfghhjghId' + widget.Id);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);

      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map['Table'];
      table1=map["Table1"];
      table3=map["Table3"];
      table4=map["Table4"];
      table5=map["Table5"];
      table7=map['Table7'];
      table20 = map['Table20'];
      table21 = map['Table21'];
      table22 = map['Table22'];
      table23=map["Table23"];
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
                  color: Colors.black,
                  size: 27,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              SizedBox(width: 1), // Set the desired width
              Text(
                "Holiday Invoice",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: 19),
              ),
            ],
          ),
          actions: [
            Image.asset(
              'assets/images/lojologo.png',
              width: 150,
              height: 50,
            ),
            SizedBox(
              width: 10,
            )
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

                    Table3InvoiceHolidayReceiptModel? m3;  // Make nullable

                    if (table3.isNotEmpty) {
                      m3 = Table3InvoiceHolidayReceiptModel.fromJson(table3[0]);
                      print("Email: " + m3.email);
                    } else {
                      print('The list is empty.');
                    }

                    Table5HolidayInvoiceReceiptModel m5 =
                    Table5HolidayInvoiceReceiptModel.fromJson(table5[0]);
                    if (table5.isNotEmpty) {
                      m5 = Table5HolidayInvoiceReceiptModel.fromJson(table5[0]);
                      print("fjhg" + m5.email);
                    } else {
                      print('The list is empty.');
                    }

                    tableData22.clear();

                    if (table22.isNotEmpty) {
                      Table22HolidayInvoicereceiptModel m22 =
                      Table22HolidayInvoicereceiptModel.fromJson(table22[0]);

                      for (int i = 0; i < table22.length; i++) {
                        Table22HolidayInvoicereceiptModel t1Data =
                        Table22HolidayInvoicereceiptModel.fromJson(table22[i]);
                        tableData22.add(t1Data);
                        print('Indexsd: $i, Tablert4 Length: ${table22.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table22 is empty. No data to process.');
                    }

                    tableData4.clear();

                    if (table4.isNotEmpty) {
                      Table4InvoiceholidayReceiptModel m22 =
                      Table4InvoiceholidayReceiptModel.fromJson(table4[0]);

                      for (int i = 0; i < table4.length; i++) {
                        Table4InvoiceholidayReceiptModel t1Data =
                        Table4InvoiceholidayReceiptModel.fromJson(table4[i]);
                        tableData4.add(t1Data);
                        print('Indexsd: $i, Tablert4 Length: ${table4.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table22 is empty. No data to process.');
                    }

                    tableData7.clear();

                    if (table7.isNotEmpty) {
                      Table7HolidayRemittanceModel m22 =
                      Table7HolidayRemittanceModel.fromJson(table7[0]);

                      for (int i = 0; i < table7.length; i++) {
                        Table7HolidayRemittanceModel t1Data =
                        Table7HolidayRemittanceModel.fromJson(table7[i]);
                        tableData7.add(t1Data);
                        print('Indexsd: $i, Tablert4 Length: ${table7.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table22 is empty. No data to process.');
                    }

                    Table4InvoiceholidayReceiptModel? m4;  // Declare nullable variable outside

                    if (table4.isNotEmpty) {
                      m4 = Table4InvoiceholidayReceiptModel.fromJson(table4[0]);
                      print("Email: ${m4.Passenger}");
                    } else {
                      print('The list table4 is empty.');
                    }

// Now you can safely use m4 **after** this block, but check for null:
                    if (m4 != null) {
                      // use m4 here
                    }


                    tableData1.clear();
                    Table1HolidayInvoiceReceiptModel m1 =
                    Table1HolidayInvoiceReceiptModel.fromJson(table1[0]);
                    if (table1.isNotEmpty) {
                      for (int i = 0; i < table1.length; i++) {
                        Table1HolidayInvoiceReceiptModel t1Data =
                        Table1HolidayInvoiceReceiptModel.fromJson(
                            table1[i]);
                        tableData1.add(t1Data);
                        print(
                            'Indexsd: $i, Tablert4 Length: ${table1.length}, t1Data: $t1Data');
                      }
                    }
//Table4InvoiceholidayReceiptModel


                    /* Table11InvoiceHotelreceiptModel m11 =
                        Table11InvoiceHotelreceiptModel.fromJson(table11[0]);
                    if (table11.isNotEmpty) {
                      m11 =
                          Table11InvoiceHotelreceiptModel.fromJson(table11[0]);
                      print("fjhdsfcg" + m11.phone);
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

                    tableData23.clear();
                    Table23InvoiceHolidayReceipt m23 =
                    Table23InvoiceHolidayReceipt.fromJson(table23[0]);
                    if (table23.isNotEmpty) {
                      for (int i = 0; i < table23.length; i++) {
                        Table23InvoiceHolidayReceipt t1Data =
                        Table23InvoiceHolidayReceipt.fromJson(table23[i]);
                        tableData23.add(t1Data);
                        print(
                            'Index: $i, Table23 Length: ${table23.length}, t1Data: $t1Data');
                      }
                    }
                    /*InvoiceListHolidayfareModel m48 =
                        InvoiceListHolidayfareModel.fromJson(table48[0]);
                    if (table48.isNotEmpty) {
                      m48 = InvoiceListHolidayfareModel.fromJson(table48[0]);
                      print("ffrtt5jhg" + m48.totalFare);
                    } else {
                      print('The list is empty.');
                    }

                    InvoiceListHolidayTaxModel m49 =
                        InvoiceListHolidayTaxModel.fromJson(table49[0]);
                    if (table49.isNotEmpty) {
                      m49 = InvoiceListHolidayTaxModel.fromJson(table49[0]);
                      print("fj657u567hg" + m49.totalTax);
                    } else {
                      print('The list is empty.');
                    }
*/
                    /*   Table24InvoiceHolidayReceiptModel m24 =
                        Table24InvoiceHolidayReceiptModel.fromJson(table24[0]);
                    if (table24.isNotEmpty) {
                      m24 = Table24InvoiceHolidayReceiptModel.fromJson(
                          table24[0]);
                      print("fjhp;l.ug" + m24.corporateName);
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
                                  Text('Invoice',
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
                                child: Text('Invoice',
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
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            m3?.passenger ?? '',
                                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "Type: ${m3?.type ?? ''}",
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
                                          Text(
                                            "PNR: ${m3?.pnr ?? ''}",
                                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                          ),
                                          Text(
                                            "Age: ${m3?.age ?? ''}",
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
                                          Text(
                                            'Phone: ${m3?.phoneNo ?? ''}',
                                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                                    child: Text('   Holiday Details:',
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
                                              padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Holiday Name: ${tableData1[index].hotelName}',
                                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
                                                      'Bar Code: ${tableData1[index].barcodeData}',
                                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                      overflow: TextOverflow.ellipsis, // Optional: shows "..." if too long
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10, right: 15, top: 4),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,  // changed here
                                                children: [
                                                  Expanded(  // allows wrapping and prevents overflow
                                                    child: Text(
                                                      'Product Code: ${tableData1[index].roomType}',
                                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                      overflow: TextOverflow.ellipsis,  // optional: shows "..." if too long
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
                                                      'Start Date: ${tableData1[index].checkInDtt}',
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
                                                  Text(
                                                    'End Date: ${tableData1[index].checkOutDtt}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'No of Nights: ${tableData1[index].noOfNights}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
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
                                  children: List.generate(
                                    tableData4.length,
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
                                                        '${tableData4[index].Passenger}',
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
                                                      'Tax: ${tableData4[index].currency} ${tableData4[index].inputTax}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15)),
                                                    ),
                                                    Text(
                                                        'Other Charges: ${tableData4[index].currency} ${tableData4[index].outputTax}',
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
                                                        'Base Fare: ${tableData4[index].currency} ${tableData4[index].totalSales}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 15))),
                                                    Text(
                                                        'Total: ${tableData4[index].currency} ${tableData4[index].totalNett}',
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
                                            left: 10, right: 15, top: 3),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(
                                                'Consultant: ${tableData7[0].name}',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 15, top: 3),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(
                                                'Booking Ref: ${tableData7[0].bookingNumber}',
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
                                                'Date: ${tableData7[0].checkOutDtt}',
                                                style: (TextStyle(
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    fontSize: 15))),
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
                                    child: Text('  Invoice Total:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17)),
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                  width: 6,
                                ),
                                Table(
                                  columnWidths: {
                                    0: IntrinsicColumnWidth(), // Label Column
                                    1: FixedColumnWidth(20),   // Colon Column
                                    2: IntrinsicColumnWidth(), // Value Column
                                  },
                                  children: [
                                    _buildTableRow(
                                      'Total Net Amount',
                                      m23?.currency ?? '',
                                      m23?.totalFare?.toString() ?? '0',
                                    ),
                                    _buildTableRow(
                                      'Total GST ${m23?.gstPercent?.toString() ?? '0'} %',
                                      m23?.currency ?? '',
                                      m23?.gstAmount?.toString() ?? '0',
                                    ),
                                    _buildTableRow(
                                      '	Service Charge and Tax',
                                      m23?.currency ?? '',
                                      m23?.gstAmount?.toString() ?? '0',
                                    ),
                                    _buildTableRow(
                                      'Total Discount',
                                      m23?.currency ?? '',
                                      m23?.discountAmount?.toString() ?? '0',
                                    ),
                                    _buildTableRow(
                                      'Total Price',
                                      m23?.currency ?? '',
                                      m23?.grandTotal?.toString() ?? '0',
                                      isBold: true,
                                    ),
                                  ],
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
