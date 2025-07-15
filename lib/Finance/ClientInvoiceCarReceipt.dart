import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import '../Models/HOtelFareModel.dart';
import '../Models/HotelTaxModel.dart';
import '../utils/response_handler.dart';
import 'Flight_VouchersListModel.dart';
import 'Table0HotelBookingModel.dart';
import 'Table10hotelReceiptModel.dart';
import 'Table13CarReceipt.dart';
import 'Table14CarRecept.dart';
import 'Table15CarReceipt.dart';
import 'Table1FLightModel.dart';
import 'Table22ClentInvoiceCarReceiptModel.dart';
import 'Table22VouchercarReceiptModel.dart';
import 'Table2ClientInvoicecarReceiptModel.dart';
 import 'Table2VouchersCarreceiptModel.dart';
import 'Table3ClientInvoiceCarReceiptModel.dart';
import 'Table3FareBreakDoenFlightModel.dart';
import 'Table3VouchersCarReceiptModel.dart';
import 'Table47HotelDetailsModel.dart';
import 'Table4ClientInvoiceCarReceiptModel.dart';
import 'Table4VouchersCarReceiptModel.dart';
import 'Table6ClientInvoiceCarReceiptModel.dart';
import 'Table7ClientInvoicecarReceiptModel.dart';
import 'Table7HotelReceiptModel.dart';
import 'Table7InvoiceListCarreceiptModel.dart';
import 'VoucherHotelReceiptModel.dart';

class ClientInvoiceCarReceipt extends StatefulWidget {
  final String Id;

  ClientInvoiceCarReceipt({required this.Id});
  @override
  State<ClientInvoiceCarReceipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<ClientInvoiceCarReceipt> {
  late List<dynamic> table0,
      table2,
      table7,
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
  List<Table2VouchersCarreceiptModel>tableData2=[];
  List<Table3VouchersCarReceiptModel>tabledata3=[];
  List<Table4VouchersCarReceiptModel>tableData4=[];
  List<Table47HotelDetailsModel> tableData47 = [];
  List<Table22VouchercarReceiptModel>tabledata22=[];
  List<Table7InvoiceListCarreceiptModel>tableData7=[];
  List<Table6ClientInvoiceCarReceiptModel>tableData6=[];

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
      table22=map["Table22"];
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
                        color: Colors.black,
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
                          color: Colors.black,
                          fontFamily: "Montserrat",
                          fontSize: 17.5),
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

                        Table2ClientInvoicecarReceiptModel m2 =
                        Table2ClientInvoicecarReceiptModel.fromJson(table2[0]);
                        if (table2.isNotEmpty) {
                          m2 = Table2ClientInvoicecarReceiptModel.fromJson(table2[0]);
                          print("fjhg" + m2.additionalReffNo);
                        } else {
                          print('The list is empty.');
                        }
                        tableData6.clear();

                        if (table6.isNotEmpty) {
                          for (int i = 0; i < table6.length; i++) {
                            Table6ClientInvoiceCarReceiptModel t6Data =
                            Table6ClientInvoiceCarReceiptModel.fromJson(
                                table6[i]);
                            tableData6.add(t6Data);
                            print(
                                'Index: $i, Table4 Length: ${table6.length}, t1Data: $t6Data');
                          }
                        }
                        Table22ClentInvoiceCarReceiptModel m22 =
                        Table22ClentInvoiceCarReceiptModel.fromJson(table22[0]);
                        if (table22.isNotEmpty) {
                          m22 = Table22ClentInvoiceCarReceiptModel.fromJson(table22[0]);
                          print("fjhg" + m22.serviceTaxAmount);
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
                                                  fontWeight: FontWeight.w600)),
                                          Text(
                                            "Type:" + m3.type,
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
                                          Text("PNR: "+m3.pnr,
                                              style: (TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15))),
                                          Text("Age: "+m3.age,
                                              style: (TextStyle(
                                                  fontWeight: FontWeight.w500,
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
                                          Text('Phone:  ' + m3.tfpPhoneNo,
                                              style: (TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15))),
                                        ],
                                      ),
                                    ),
                                  ]),
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
                                              Container(
                                                width: 280,
                                                child: Text(
                                                    'Car Company:' +
                                                        m2.carGroup,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.w600)),
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
                                                width: 280,
                                                child: Text(
                                                    'Car Type: ' + m2.carType,
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
                                              SizedBox(width:270,
                                                child: Text(
                                                    'PickUp:' + m2.pickupAddress,
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
                                                  'Pickup Date:' +
                                                      m2.pickupDate,
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
                                              SizedBox(width:270,
                                                child: Text(
                                                    'Drop Off: ' +
                                                        m2.dropoffAddress,
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
                                                  'Drop Off Date:' +
                                                      m2.dropoffDate,
                                                  style: (TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15))),
                                            ],
                                          ),
                                        ),
                                      ]),
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
                                      crossAxisAlignment: CrossAxisAlignment.end,
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
                                              Text(m3.passenger,
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
                                                'Tax: ' +m4.currency+" "+ m4.inputTax,
                                                style: (TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15)),
                                              ),
                                              Text('Other Charges: ' +m4.currency+" "+ m4.outputTax,
                                                  style: (TextStyle(
                                                      fontWeight: FontWeight.w500,
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
                                              Text('Base Fare: '+m4.currency+" "+m4.totalNett,
                                                  style: (TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15))),
                                              Text(
                                                  '	Total: ' +m4.currency+" "+
                                                      m4.totalNett,
                                                  style: (TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15))),

                                            ],
                                          ),
                                        ),

                                      ]),
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
                                      _buildTableRow('Total Net Amount',m4.currency, m22.totalFare),
                                      _buildTableRow('Total GST ${m22.gstPercent} %',m4.currency, m22.gstAmount),
                                      _buildTableRow('Total Service Tax ${m22.serviceTaxPercent} %', m4.currency,m22.serviceTaxAmount),

                                      _buildTableRow('Total Price',m4.currency, m22.grandTotal, isBold: true),
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
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(
                                                  left: 10, top: 4),
                                              child: Text(
                                                'Lead Passenger:',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                            SizedBox(width: 7),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(top: 4),
                                              child: Text(m3.passenger,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.w500)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(
                                                  left: 10, top: 4),
                                              child: Text(
                                                'Booking Ref: ' +
                                                    m0.bookingNumber,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(
                                                  left: 10, top: 4),
                                              child: Text(
                                                'Consultant:' + m7.corporateName,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(
                                                  left: 10, top: 4),
                                              child: Text(
                                                'DropOff Date: ' + m2.dropoffDate,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(
                                                  left: 10, top: 4),
                                              child: Text(
                                                'Total: '+m4.currency+m22.grandTotal,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ],
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
