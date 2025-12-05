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
import 'Table22ClentInvoiceCarReceiptModel.dart';
 import 'Table2BusDetailModel.dart';
import 'Table3ClientInvoiceBusReceiptModel.dart';
import 'Table4CarPaymentInformationModel.dart';
import 'Table4ClientInvoiceCarReceiptModel.dart';
import 'Table6ClientInvoiceCarReceiptModel.dart';
import 'Table7ClientInvoiceBusReceiptModel.dart';
import 'Table7ClientInvoicecarReceiptModel.dart';
import 'Table8CLientInvoiceBusRemittanceModel.dart';

class ClientInvoiceBusReceipt extends StatefulWidget {
  final String Id;

  ClientInvoiceBusReceipt({required this.Id});
  @override
  State<ClientInvoiceBusReceipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<ClientInvoiceBusReceipt> {
  late List<dynamic> table0,
      table2,
      table7,
      table8,
      table6,
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
  List<Table2BusDetailModel>tableData2=[];
  List<Table3ClientInvoiceBusReceiptModel>tabledata3=[];
  List<Table4CarPaymentInformationModel>tableData4=[];
  List<Table47HotelDetailsModel> tableData47 = [];
  List<Table23VouchercarReceiptModel>tabledata22=[];
  List<Table8CLientInvoiceBusRemittanceModel>tableData8=[];
  List<Table6ClientInvoiceCarReceiptModel>tableData6=[];
  List<Table7ClientInvoicecarReceiptModel>tabledata7=[];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "ClientInvoiceViewGet", "BookFlightId=${widget.Id}");
    print('jfghhjghId' + widget.Id);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      developer.log('jfghhjghId ' + jsonResponse,
          name: 'travel_app_17112023_b2b');
      Map<String, dynamic> map = json.decode(jsonResponse);
      table7 = map['Table7'];
      table8=map['Table8'];
      table6=map["Table6"];
      table9 = map["Table9"];
      table0 = map['Table'];
      table2=map["Table2"];
      table3=map["Table3"];
      table4=map["Table4"];
      table10 = map["Table10"];
      table13 = map["Table13"];
      table15 = map['Table15'];
      table14 = map['Table14'];
      table22=map["Table24"];
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
                      "Bus Receipt",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontSize: 17.5),
                    ),
                  ],
                ),
                actions: [
                  Image.asset(
                    'assets/images/lojologg.png',
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

                        if (table2 != null && table2 is List && table2.isNotEmpty) {
                          for (int i = 0; i < table2.length; i++) {
                            Table2BusDetailModel t6Data =
                            Table2BusDetailModel.fromJson(table2[i]);
                            tableData2.add(t6Data);
                            print('Index: $i, Table6 Length: ${table2.length}, t1Data: $t6Data');
                          }
                        } else {
                          print('table6 is empty or invalid');
                        }
                        //
                        tableData6.clear();

                        if (table6 != null && table6 is List && table6.isNotEmpty) {
                          for (int i = 0; i < table6.length; i++) {
                            Table6ClientInvoiceCarReceiptModel t6Data =
                            Table6ClientInvoiceCarReceiptModel.fromJson(table6[i]);
                            tableData6.add(t6Data);
                            print('Index: $i, Table6 Length: ${table6.length}, t1Data: $t6Data');
                          }
                        } else {
                          print('table6 is empty or invalid');
                        }

                        tableData4.clear();

                        if (table4 != null && table4 is List && table4.isNotEmpty) {
                          for (int i = 0; i < table4.length; i++) {
                            Table4CarPaymentInformationModel t6Data =
                            Table4CarPaymentInformationModel.fromJson(table4[i]);
                            tableData4.add(t6Data);
                            print('Index: $i, Table6 Length: ${table4.length}, t1Data: $t6Data');
                          }
                        } else {
                          print('table6 is empty or invalid');
                        }
                        Table22ClentInvoiceCarReceiptModel? m22;

                        if (table22.isNotEmpty) {
                          m22 = Table22ClentInvoiceCarReceiptModel.fromJson(table22[0]);
                          print("Inside if: ${m22.serviceTaxAmount}");
                        } else {
                          print('The list is empty.');
                        }

// ✅ Now you can safely check and use m22
                        if (m22 != null) {
                          print("Outside if: ${m22.totalFare}");
                        }


                        tabledata3.clear();

                        if (table3 != null && table3 is List && table3.isNotEmpty) {
                          for (int i = 0; i < table3.length; i++) {
                            Table3ClientInvoiceBusReceiptModel t3Data =
                            Table3ClientInvoiceBusReceiptModel.fromJson(table3[i]);
                            tabledata3.add(t3Data);
                            print('Index: $i, Table3 Length: ${table3.length}, Data: $t3Data');
                          }
                        } else {
                          print('table3 is empty or invalid');
                        }

                        Table4ClientInvoiceCarReceiptModel m4 =
                        Table4ClientInvoiceCarReceiptModel.fromJson(table4[0]);
                        if (table4.isNotEmpty) {
                          m4 = Table4ClientInvoiceCarReceiptModel.fromJson(table4[0]);
                          print("fjhg" + m4.balanceDueDt);
                        } else {
                          print('The list is empty.');
                        }
                        Table7ClientInvoiceBusReceiptModel m7 =
                        Table7ClientInvoiceBusReceiptModel.fromJson(table7[0]);
                        if (table7.isNotEmpty) {
                          m7 = Table7ClientInvoiceBusReceiptModel.fromJson(table7[0]);
                          print("fjhg" + m7.phone);
                        } else {
                          print('The list is empty.');
                        }
                        tableData8.clear();

                        if (table8 != null && table8 is List && table8.isNotEmpty) {
                          for (int i = 0; i < table8.length; i++) {
                            Table8CLientInvoiceBusRemittanceModel t6Data =
                            Table8CLientInvoiceBusRemittanceModel.fromJson(table8[i]);
                            tableData8.add(t6Data);
                            print('Index: $i, Table6 Length: ${table8.length}, t1Data: $t6Data');
                          }
                        } else {
                          print('table6 is empty or invalid');
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
                                        Text('Client Invoice',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Image.asset(
                                            'assets/images/lojologg.png',
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
                                      tabledata3.length,
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
                                                    "${tabledata3[index].passenger}",
                                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),

                                                Text(
                                                  'Type: ${tabledata3[index].type}',
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
                                                    'PNR: ${tabledata3[index].pnr}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                    overflow: TextOverflow.ellipsis, // Prevents overflow
                                                  ),
                                                ),
                                                SizedBox(width: 10), // Optional spacing
                                                Text(
                                                  'Age : ${tabledata3[index].age}',
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
                                                left: 10, right: 15, top: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                    'Phone : ${tabledata3[index].tfpPhoneNo}',
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
                                      child: Text('    Bus Information:',
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
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 15, top: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                        'Bus Company: ${tableData2[index].travelName}',
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded( // or Flexible
                                                      child: Text(
                                                        'Bus Type: ${tableData2[index].busType}',
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
                                                        'Pickup Location: ${tableData2[index].originCityLocation}',
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
                                                      'Pickup Date:${tableData2[index].originCityDate}',
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
                                                      'DropOff Location:  ${tableData2[index].originCityLocation}',
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
                                                      'DropOff Date:  ${tableData2[index].destinationCityDate}',
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
                                      _buildTableRow('Total Net Amount',m22!.Currency, m22!.totalFare),
                                      _buildTableRow('Total GST ${m22.gstPercent} %',m22.Currency, m22.gstAmount),
                                      _buildTableRow('Service Charge and Tax', m22.Currency,m22.gstAmount),
                                      _buildTableRow('Total Discounts', m22.Currency,m22.discountAmount),
                                      _buildTableRow('Total Price',m22.Currency, m22.grandTotal, isBold: true),
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
                                                  'Lead Passenger: ${tableData8[0].passenger}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.w500)),
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
                                                  'Booking Ref: ${tableData8[0].bookingId}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                  overflow: TextOverflow.ellipsis, // Adds '...' if text is too long
                                                  softWrap: false, // Prevents wrapping to new line
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
                                              Container(

                                                child: Text(
                                                    'Drop Off: ${tableData8[0].dropoffDate}',
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
                                                  'Consultant: ${tableData8[0].name}',
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
                                                  'Total: ${tableData8[0].totalNett}',
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
                                  tableData6.isEmpty
                                      ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        'No Data',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                      : Column(
                                    children: List.generate(
                                      tableData6.length,
                                          (index) => Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Receipt No: ${tableData6[index].receiptNo}',
                                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
                                                  'Allocated Amount: ${tableData6[index].allocatedAmount}',
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
                                                  'Status: ${tableData6[index].status}',
                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                ),
                                                Text(
                                                  'Date: ${tableData6[index].createdDatedt}',
                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                ),
                                              ],
                                            ),
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
