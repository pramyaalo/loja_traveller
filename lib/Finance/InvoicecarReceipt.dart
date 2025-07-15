import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:developer' as developer;

import '../Booking/Table24grandTotalcarReceiptModel.dart';
import '../Booking/Tablr8InvoiceListCarReceiptModel.dart';
import '../Finance/Table0HotelBookingModel.dart';
import '../Finance/Table47HotelDetailsModel.dart';
import '../Finance/Table7HotelReceiptModel.dart';
import '../Finance/VoucherHotelReceiptModel.dart';
import '../Models/HOtelFareModel.dart';
import '../Models/HotelTaxModel.dart';
import '../utils/response_handler.dart';
import 'Table23VouchercarReceiptModel.dart';
 import 'Table2VouchersCarreceiptModel.dart';
import 'Table3VouchersCarReceiptModel.dart';
import 'Table4VouchersCarReceiptModel.dart';
import 'Table7InvoiceListCarreceiptModel.dart';



class InvoicecarReceipt extends StatefulWidget {
  final String Id;

  InvoicecarReceipt({required this.Id});
  @override
  State<InvoicecarReceipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<InvoicecarReceipt> {
  late List<dynamic> table0,
      table2,
      table7,
      table3,
      table4,
      table8,
      table9,
      table10,
      table12,
      table13,
      table14,
      table16,
      table15,
      table19,
      table23,
    
      table24,
      table34,
      table39,
      table47,
      table48,
      table49;
  List<Table0HotelBookingModel> tableData0 = [];
  List<VoucherHotelReceiptModel> tableData9 = [];
  List<Table7HotelReceiptModel> tableData1 = [];
  List<Table2VouchersCarreceiptModel>tableData2=[];
  List<Table3VouchersCarReceiptModel>tableData3=[];
  List<Table4VouchersCarReceiptModel>tableData4=[];
  List<Table47HotelDetailsModel> tableData47 = [];
  List<Table23VouchercarReceiptModel>tabledata22=[];
  List<Table7InvoiceListCarreceiptModel>tableData7=[];
  List<Tablr8InvoiceListCarReceiptModel>tableData8=[];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "InvoiceListViewGet", "BookFlightId=${widget.Id}");
    print('jfghhjghId' + widget.Id);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      developer.log('jfghhjghId ' + jsonResponse,
          name: 'travel_app_17112023_b2b');
      Map<String, dynamic> map = json.decode(jsonResponse);
      table7 = map['Table7'];
      table9 = map["Table9"];
      table0 = map['Table'];
      table2=map["Table2"];
      table3=map["Table3"];
      table4=map["Table4"];
      table8=map['Table8'];
      table10 = map["Table10"];
      table13 = map["Table13"];
      table15 = map['Table15'];
      table14 = map['Table14'];
      table23=map["Table23"];
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
                      "Car Receipt",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontSize: 17.5),
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
                        Table0HotelBookingModel m0 =
                        Table0HotelBookingModel.fromJson(table0[0]);
                        if (table0.isNotEmpty) {
                          m0 = Table0HotelBookingModel.fromJson(table0[0]);
                          print("fjhg" + m0.bookFlightId);
                        } else {
                          print('The list is empty.');
                        }



                        Table24grandTotalcarReceiptModel? m23;

                        if (table23.isNotEmpty) {
                          m23 = Table24grandTotalcarReceiptModel.fromJson(table23[0]);
                          print("fjhg" + m23.serviceTaxAmount);
                        } else {
                          print('The list is empty.');
                        }

// Use m22 after checking it's not null
                        if (m23 != null) {
                          print("Total Fare: ${m23.totalFare}");
                        }

                        tableData8.clear();
                        Tablr8InvoiceListCarReceiptModel m12 =
                        Tablr8InvoiceListCarReceiptModel.fromJson(table8[0]);
                        if (table8.isNotEmpty) {
                          for (int i = 0; i < table8.length; i++) {
                            Tablr8InvoiceListCarReceiptModel t6Data =
                            Tablr8InvoiceListCarReceiptModel.fromJson(
                                table8[i]);
                            tableData8.add(t6Data);
                            print(
                                'Index: $i,TablZSDadfe4 Length: ${table8.length}, t1Data: $t6Data');
                          }
                        }

                        tableData3.clear();
                        Table3VouchersCarReceiptModel m3 =
                        Table3VouchersCarReceiptModel.fromJson(table3[0]);
                        if (table3.isNotEmpty) {
                          for (int i = 0; i < table3.length; i++) {
                            Table3VouchersCarReceiptModel t6Data =
                            Table3VouchersCarReceiptModel.fromJson(
                                table3[i]);
                            tableData3.add(t6Data);
                            print(
                                'Index: $i,TablZSDadfe4 Length: ${table8.length}, t1Data: $t6Data');
                          }
                        }
//tableData2

                        tableData2.clear();
                        Table2VouchersCarreceiptModel m2 =
                        Table2VouchersCarreceiptModel.fromJson(table2[0]);
                        if (table2.isNotEmpty) {
                          for (int i = 0; i < table2.length; i++) {
                            Table2VouchersCarreceiptModel t6Data =
                            Table2VouchersCarreceiptModel.fromJson(
                                table2[i]);
                            tableData2.add(t6Data);
                            print(
                                'Index: $i,TablZSDadfe4 Length: ${table8.length}, t1Data: $t6Data');
                          }
                        }
                        tableData4.clear();
                        Table4VouchersCarReceiptModel m4 =
                        Table4VouchersCarReceiptModel.fromJson(table4[0]);
                        if (table4.isNotEmpty) {
                          for (int i = 0; i < table4.length; i++) {
                            Table4VouchersCarReceiptModel t6Data =
                            Table4VouchersCarReceiptModel.fromJson(
                                table4[i]);
                            tableData4.add(t6Data);
                            print(
                                'Index: $i,TablZSDadfe4 Length: ${table4.length}, t1Data: $t6Data');
                          }
                        }



                        Table7InvoiceListCarreceiptModel m7 =
                        Table7InvoiceListCarreceiptModel.fromJson(table7[0]);
                        if (table7.isNotEmpty) {
                          m7 = Table7InvoiceListCarreceiptModel.fromJson(table7[0]);
                          print("fjhg" + m7.addressLine2);
                        } else {
                          print('The list is empty.');
                        }
                        //
                        /*   HOtelFareModel m48 =
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

                        /*   Table13CarReceipt m13 =
                            Table13CarReceipt.fromJson(table13[0]);
                        if (table13.isNotEmpty) {
                          m13 = Table13CarReceipt.fromJson(table13[0]);
                          print("fjhg" + m13.passenger);
                        } else {
                          print('The list is empty.');
                        }
                        Table14CarRecept m14 =
                            Table14CarRecept.fromJson(table14[0]);
                        if (table14.isNotEmpty) {
                          m14 = Table14CarRecept.fromJson(table14[0]);
                          print("fjhg" + m14.CarStatus);
                        } else {
                          print('The list is empty.');
                        }

                        Table15CarReceipt m3 =
                            Table15CarReceipt.fromJson(table15[0]);
                        if (table15.isNotEmpty) {
                          m3 = Table15CarReceipt.fromJson(table15[0]);
                          print("fjhg" + m3.passenger);
                        } else {
                          print('The list is empty.');
                        }*/

                        return SingleChildScrollView(
                            child: Container(
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.black, width: 1),
                                ),
                                margin: EdgeInsets.all(10),
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Invoice',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Image.asset(
                                            'assets/images/lojologo.png',
                                            width: 150,
                                            height: 50),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
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
                                            Text(m7.corporateName,
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
                                              m7.addressLine1 +
                                                  m7.addressLine2 +
                                                  m7.addressLine3,
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
                                            Text('City:' + m7.city,
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
                                                  m7.postCode +
                                                  "|" +
                                                  m7.phone,
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
                                              'Email: ' + m7.email,
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
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 3, left: 3),
                                    child: Container(
                                      height: 40,
                                      color:  Color(0xFFADD8E6),
                                      alignment: Alignment.centerLeft,
                                      child: Text('   Traveller Information',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
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
                                                  'Type: ${tableData3[index].type}',
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
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'PNR: ${tableData3[index].pnr}',
                                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                SizedBox(width: 10), // spacing between PNR and Age
                                                Text(
                                                  'Age : ${tableData3[index].age}',
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
                                      color:  Color(0xFFADD8E6),
                                      alignment: Alignment.centerLeft,
                                      child: Text('    Car Information:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17)),
                                    ),
                                  ),
                                  Column(
                                      children: List.generate(
                                        tableData2.length,
                                            (index) => Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
                                                child: Text(
                                                  'Car Company: ${tableData2[index].carGroup}',
                                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1, // Limits to one line and adds ellipsis if too long
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
                                                          'Car Type: ${tableData2[index].carType}',
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
                                                        'Pickup Location: ${tableData2[index].pickupLocation}',
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
                                                        'DropOff Location: ${tableData2[index].dropoffLocation}',
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
                                                        'Pickup Date: ${tableData2[index].pickupDtt}',
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
                                                        'DropOff Date: ${tableData2[index].dropoffDtt}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 15))),

                                                  ],
                                                ),
                                              ),
                                            ]),
                                      )),
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
                                      color:  Color(0xFFADD8E6),
                                      alignment: Alignment.centerLeft,
                                      child: Text("   Payment Information",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
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
                                                          '${tableData4[index].passenger}',
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
                                  SizedBox(height: 6,),
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
                                      child: Text('  Invoice Total:',
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
                                      _buildTableRow('Total Net Amount', m4.currency, m23?.totalFare ?? '0'),
                                      _buildTableRow('Total GST ${m23?.gstPercent ?? '0'} %', m4.currency, m23?.gstAmount ?? '0'),
                                      _buildTableRow('Service Charge and Tax', m4.currency, m23?.gstAmount ?? '0'),
                                      _buildTableRow('Total Price', m4.currency, m23?.grandTotal ?? '0', isBold: true),

                                    ],
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
                                      child: Text(' Remittance:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17)),
                                    ),
                                  ),

                                  Column(
                                    children: List.generate(
                                      tableData8.length,
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
                                                          'Lead Passenger: ${tableData8[index].passenger}',
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
                                                          'Consultant: ${tableData8[index].name}',
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
                                                          'Booking Ref: ${tableData8[index].bookingId}',
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
                                                          'Date: ${tableData8[index].dropoffDate}',
                                                          style: (TextStyle(
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 15))),
                                                      Text(
                                                          'Total: ${tableData8[index].totalNett}',
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
                                      color:  Color(0xFFADD8E6),
                                      alignment: Alignment.centerLeft,
                                      child: Text('   Terms And Conditions:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'This is a computer-generated Invoice and Digitally signed.',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                ])));
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
