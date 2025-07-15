import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:developer' as developer;
import '../Finance/Table0HotelBookingModel.dart';
import '../Finance/Table23VouchercarReceiptModel.dart';
import '../Finance/Table47HotelDetailsModel.dart';
import '../Finance/Table7HotelReceiptModel.dart';
import '../Finance/VoucherHotelReceiptModel.dart';
import '../Models/HOtelFareModel.dart';
import '../Models/HotelTaxModel.dart';
import '../utils/response_handler.dart';

 import 'Table24CreditNoteTotalPriceModel.dart';
import 'Table2ClientInvoicecarReceiptModel.dart';
import 'Table2VouchersCarreceiptModel.dart';
import 'Table3ClientInvoiceCarReceiptModel.dart';
import 'Table3VouchersCarReceiptModel.dart';
import 'Table4ClientInvoiceCarReceiptModel.dart';
import 'Table4CreditNotePaymentDetailsModel.dart';
import 'Table4VouchersCarReceiptModel.dart';
import 'Table6ClientInvoiceCarReceiptModel.dart';
import 'Table6PaymentCreditedDetailsModel.dart';
import 'Table7ClientInvoicecarReceiptModel.dart';


class CreditNoteCarReceipt extends StatefulWidget {
  final String Id;

  CreditNoteCarReceipt({required this.Id});
  @override
  State<CreditNoteCarReceipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<CreditNoteCarReceipt> {
  late List<dynamic> table0,
      table2,
      table7,
      table6,
      table8,
      table3,
      table4,
      table9,
      table10,
      table12,
      table13,
      table14,
      table16,
      table15,
      table19,
      table22,
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
  List<Table2ClientInvoicecarReceiptModel>tableData2=[];
  List<Table3VouchersCarReceiptModel>tableData3=[];
  List<Table47HotelDetailsModel> tableData47 = [];
  List<Table23VouchercarReceiptModel>tabledata22=[];
  List<Table6PaymentCreditedDetailsModel>tableData6=[];
  List<Table4CreditNotePaymentDetailsModel>tableData4=[];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "CreditNoteViewGet", "BookFlightId=${widget.Id}");
    print('jfghhjghId' + widget.Id);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      developer.log('jfghhjghId ' + jsonResponse,
          name: 'travel_app_17112023_b2b');
      Map<String, dynamic> map = json.decode(jsonResponse);
      table7 = map['Table7'];
      table6=map["Table6"];
      table9 = map["Table9"];
      table0 = map['Table'];
      table2=map["Table2"];
      table3=map["Table3"];
      table4=map["Table4"];
      table8=map["Table8"];
      table10 = map["Table10"];
      table13 = map["Table13"];
      table15 = map['Table15'];
      table14 = map['Table14'];
      table22=map["Table22"];
      table24=map['Table23'];
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


                        tableData2.clear();

                        if (table2.isNotEmpty) {
                          for (int i = 0; i < table2.length; i++) {
                            try {
                              Table2ClientInvoicecarReceiptModel t6Data =
                              Table2ClientInvoicecarReceiptModel.fromJson(table2[i]);
                              tableData2.add(t6Data);
                              print('Index: $i, Table8 Length: ${table2.length}, t6Data: $t6Data');
                            } catch (e) {
                              print('Error parsing table8[$i]: $e');
                            }
                          }
                        } else {
                          print('table8 is empty');
                        }
                        tableData3.clear();

                        if (table3.isNotEmpty) {
                          for (int i = 0; i < table3.length; i++) {
                            try {
                              Table3VouchersCarReceiptModel t6Data =
                              Table3VouchersCarReceiptModel.fromJson(table3[i]);
                              tableData3.add(t6Data);
                              print('Index: $i, Table8 Length: ${table3.length}, t6Data: $t6Data');
                            } catch (e) {
                              print('Error parsing table8[$i]: $e');
                            }
                          }
                        } else {
                          print('table8 is empty');
                        }
//
                        tableData4.clear();

                        if (table4.isNotEmpty) {
                          for (int i = 0; i < table4.length; i++) {
                            try {
                              Table4CreditNotePaymentDetailsModel t6Data =
                              Table4CreditNotePaymentDetailsModel.fromJson(table4[i]);
                              tableData4.add(t6Data);
                              print('Index: $i, Table8 Length: ${table4.length}, t6Data: $t6Data');
                            } catch (e) {
                              print('Error parsing table8[$i]: $e');
                            }
                          }
                        } else {
                          print('table8 is empty');
                        }


                        tableData6.clear();

                        if (table6.isNotEmpty) {
                          for (int i = 0; i < table6.length; i++) {
                            try {
                              Table6PaymentCreditedDetailsModel t6Data =
                              Table6PaymentCreditedDetailsModel.fromJson(table6[i]);
                              tableData6.add(t6Data);
                              print('Index: $i, Table8 Length: ${table6.length}, t6Data: $t6Data');
                            } catch (e) {
                              print('Error parsing table8[$i]: $e');
                            }
                          }
                        } else {
                          print('table8 is empty');
                        }

                        Table24CreditNoteTotalPriceModel? m24; // Nullable so you can assign later

                        if (table24.isNotEmpty) {
                          m24 = Table24CreditNoteTotalPriceModel.fromJson(table24[0]);
                          print("fjhg" + m24.serviceTaxAmount);
                        } else {
                          print('The list is empty.');
                        }




                        Table3ClientInvoiceCarReceiptModel m3 =
                        Table3ClientInvoiceCarReceiptModel.fromJson(table3[0]);
                        if (table3.isNotEmpty) {
                          m3 = Table3ClientInvoiceCarReceiptModel.fromJson(table3[0]);
                          print("fjhg" + m3.tfpEmail);
                        } else {
                          print('The list is empty.');
                        }
                        Table4ClientInvoiceCarReceiptModel m4 =
                        Table4ClientInvoiceCarReceiptModel.fromJson(table4[0]);
                        if (table4.isNotEmpty) {
                          m4 = Table4ClientInvoiceCarReceiptModel.fromJson(table4[0]);
                          print("fjhg" + m4.balanceDueDt);
                        } else {
                          print('The list is empty.');
                        }

                        Table7ClientInvoicecarReceiptModel m7 =
                        Table7ClientInvoicecarReceiptModel.fromJson(table7[0]);
                        if (table7.isNotEmpty) {
                          m7 = Table7ClientInvoicecarReceiptModel.fromJson(table7[0]);
                          print("fjhsrtgerg" + m7.addressLine2);
                        } else {
                          print('The list is empty.');
                        }


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
                                        Text('Credit Note',
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
                                            padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                /// Passenger name (wraps into two lines if long)
                                                Expanded(
                                                  child: Text(
                                                    "${tableData3[index].passenger}",
                                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),

                                                Text(
                                                  'Type: ${tableData3[index].type}',
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
                                                    'PNR: ${tableData3[index].pnr}',
                                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                    overflow: TextOverflow.ellipsis, // Optional: add ellipsis if too long
                                                  ),
                                                ),
                                                SizedBox(width: 10), // spacing between the two texts
                                                Text(
                                                  'Age: ${tableData3[index].age}',
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
                                            CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start, // can change to start since only one child
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'Car Company: ${tableData2[index].carGroup}',
                                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                        overflow: TextOverflow.ellipsis, // wrap by default
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 15, top: 4),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded( // or Flexible
                                                      child: Text(
                                                        'Car Type: ${tableData2[index].carType}',
                                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                        overflow: TextOverflow.ellipsis, // optional
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
                                                        'Pickup Location: ${tableData2[index].pickupLocation}',
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
                                                      'Pickup Date:${tableData2[index].pickupDtt}',
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
                                                      'DropOff Location:  ${tableData2[index].dropoffLocation}',
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
                                                      'DropOff Date:  ${tableData2[index].dropoffDtt}',
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
                                    padding:
                                    const EdgeInsets.only(right: 3, left: 3),
                                    child: Container(
                                      height: 40,
                                      color: Color(0xFFADD8E6),
                                      alignment: Alignment.centerLeft,
                                      child: Text('  Invoice Total ${m4.currency}:',
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
                                      _buildTableRow('Total Net Amount',m24?.currency, m24!.totalFare),
                                      _buildTableRow('Total GST ${m24.gstPercent} %',m24?.currency, m24.gstAmount),
                                      _buildTableRow('Service Charge and Tax', m24?.currency,m24.gstAmount),
                                      _buildTableRow('Total Discounts', m24?.currency,m24.discountAmount),
                                      _buildTableRow('Total Price',m24?.currency, m24.grandTotal, isBold: true),
                                    ],
                                  ),


                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 3, left: 3),
                                    child: Container(
                                      height: 40,
                                      color: Color(0xFFADD8E6),
                                      alignment: Alignment.centerLeft,
                                      child: Text('  Payment Credited Details:',
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
                                  Text(
                                    'This is a computer-generated Invoice and Digitally signed.',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
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
