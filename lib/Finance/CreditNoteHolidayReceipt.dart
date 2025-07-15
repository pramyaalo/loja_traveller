import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Booking/Table23CreditNoteHolidayTotalPriceModel.dart';
import '../Booking/Table3HolidayPassengerDetailsModel.dart';
import '../Booking/Table4CreditNoteHolidayPaymentDetailsModel.dart';
import '../Booking/Table5ClientInvoiceHolidayReceiptModel.dart';
import '../Booking/Table6HolidayPaymentCreditedDetailsModel.dart';
import '../Booking/table1CreditNoteHolidayDetailsModel.dart';
import '../utils/response_handler.dart';
import 'CreditNoteFlightTaxModel.dart';
import 'CreditNoteHolidayTaxModel.dart';
import 'Tabe48CreditNoteFareModel.dart';
import 'Table0CreditNoteFlightModsel.dart';
import 'Table0InvoiceFlighteceiptModel.dart';

import 'Table1CreditNoteFlightReceiptModel.dart';
import 'Table20ClientInvoiceHolidayReceiptModel.dart';
import 'Table20CreditNoteHolidayListModel.dart';
import 'Table22ClientInvoiceHolidayReceiptModel.dart';
import 'Table22CrediutNoteHolidayReceiptModel.dart';
import 'Table23ClientInvoiceHlolidayReceiptModel.dart';
import 'Table23CreditNoteHolidayReceiptModel.dart';
import 'Table24ClientInvoiceHolidayReceiptodel.dart';
import 'Table25HolidayModel.dart';

import 'Table48ClientInvoiceHolidayModel.dart';


class CreditNoteHolidayReceipt extends StatefulWidget {
  final String Id;

  CreditNoteHolidayReceipt({required this.Id});

  @override
  State<CreditNoteHolidayReceipt> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState
    extends State<CreditNoteHolidayReceipt> {
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

  List<Table20ClientInvoiceHolidayReceiptModel> tableData20 = [];
  List<Table23CreditNoteHolidayTotalPriceModel> tableData23 = [];
  List<Table25HolidayModel> tableData25 = [];
  List<Table4CreditNoteHolidayPaymentDetailsModel>tableData4=[];
  List<Table6HolidayPaymentCreditedDetailsModel>tableData6=[];
  List<table1CreditNoteHolidayDetailsModel>tableData1=[];
  List<Table3HolidayPassengerDetailsModel>tableData3=[];
  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "CreditNoteViewGet", "BookFlightId=${widget.Id}");
    print('jfghhjghId' + widget.Id);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      print('jfghhjghIjsonResponsed' + jsonResponse);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map['Table1'];
      table2 = map["Table2"];
      table3=map["Table3"];
      table4=map["Table4"];
      table5 = map['Table5'];
      table6 = map['Table6'];
      table7 = map["Table7"];
      table8 = map['Table8'];
      table9 = map["Table9"];
      table10 = map["Table10"];
      table11 = map['Table11'];
      table22 = map["Table22"];
      table20 = map["Table20"];
      table23 = map['Table23'];
      table25 = map['Table25'];
      table24 = map["Table24"];
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
                    "Holiday Receipt",
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
                          m0 = Table0InvoiceFlighteceiptModel.fromJson(
                              table0[0]);
                          print("fjhg" + m0.bookFlightId);
                        } else {
                          print('The list is empty.');
                        }
                        tableData1.clear();

                        table1CreditNoteHolidayDetailsModel? m1;

                        if (table1.isNotEmpty) {
                          m1 = table1CreditNoteHolidayDetailsModel.fromJson(table1[0]);

                          for (int i = 0; i < table1.length; i++) {
                            table1CreditNoteHolidayDetailsModel t1Data =
                            table1CreditNoteHolidayDetailsModel.fromJson(table1[i]);
                            tableData1.add(t1Data);
                            print('Index: $i, Length: ${table1.length}, t1Data: $t1Data');
                          }
                        }

// Now you can use m22 here, just check if it's null
                        if (m1 != null) {
                          print('Using m22 outside: $m1');
                        }

                        tableData3.clear();

                        Table3HolidayPassengerDetailsModel? m3;

                        if (table3.isNotEmpty) {
                          m3 = Table3HolidayPassengerDetailsModel.fromJson(table3[0]);

                          for (int i = 0; i < table3.length; i++) {
                            Table3HolidayPassengerDetailsModel t1Data =
                            Table3HolidayPassengerDetailsModel.fromJson(table3[i]);
                            tableData3.add(t1Data);
                            print('Index: $i, Length: ${table3.length}, t1Data: $t1Data');
                          }
                        }

                        if (m3 != null) {
                          print('Using m22 outside: $m3');
                        }


                        Table5ClientInvoiceHolidayReceiptModel m5 =
                        Table5ClientInvoiceHolidayReceiptModel.fromJson(
                            table5[0]);
                        if (table5.isNotEmpty) {
                          m5 = Table5ClientInvoiceHolidayReceiptModel.fromJson(
                              table5[0]);
                          print("fjhg" + m5.email);
                        } else {
                          print('The list is empty.');
                        }

                        tableData6.clear();

                        if (table6.isNotEmpty) {
                          for (int i = 0; i < table6.length; i++) {
                            Table6HolidayPaymentCreditedDetailsModel t6Data =
                            Table6HolidayPaymentCreditedDetailsModel.fromJson(
                                table6[i]);
                            tableData6.add(t6Data);
                            print(
                                'Index: $i, Table4 Length: ${table6.length}, t1Data: $t6Data');
                          }
                        }
                        tableData23.clear();

                        Table23CreditNoteHolidayTotalPriceModel? m23;

                        if (table23.isNotEmpty) {
                          m23 = Table23CreditNoteHolidayTotalPriceModel.fromJson(table23[0]);

                          for (int i = 0; i < table23.length; i++) {
                            Table23CreditNoteHolidayTotalPriceModel t1Data =
                            Table23CreditNoteHolidayTotalPriceModel.fromJson(table23[i]);
                            tableData23.add(t1Data);
                            print('Index: $i, Length: ${table23.length}, t1Data: $t1Data');
                          }
                        }

// Now you can use m22 here, just check if it's null
                        if (m23 != null) {
                          print('Using m22 outside: $m23');
                        }


                        tableData4.clear();
                        Table4CreditNoteHolidayPaymentDetailsModel m4 =
                        Table4CreditNoteHolidayPaymentDetailsModel.fromJson(
                            table4[0]);
                        if (table4.isNotEmpty) {
                          for (int i = 0; i < table4.length; i++) {
                            Table4CreditNoteHolidayPaymentDetailsModel t1Data =
                            Table4CreditNoteHolidayPaymentDetailsModel.fromJson(
                                table4[i]);
                            tableData4.add(t1Data);
                            print(
                                'Indexsd: $i, Tablert4 Length: ${table4.length}, t1Data: $t1Data');
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
                                      Text('Credit Note',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Image.asset('assets/images/lojologo.png',
                                          width: 200, height: 50),
                                    ],
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
                                            "Pin Code: "+m5.postCode,
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
                                          Text('Phone:' + m5.phone,
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
                                            m3!.passenger,
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
                                            'Email: ' +
                                                m3.email,
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
                                            'Phone: ' +
                                                m3.phoneNo,
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
                                                      'Phone : ${tableData3[index].phoneNo}',
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
                                          right: 3, left: 3),
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
                                                      Flexible( // or use Expanded
                                                        child: Text(
                                                          'Holiday Name: ${tableData1[index].hotelName}',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          overflow: TextOverflow.visible,
                                                          softWrap: true,
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
                                                          'Bar Code: ${tableData1[index].barcodeData}',
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
                                                          'Product Code: ${tableData1[index].productId}',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                      Text(
                                                          'Days: ${tableData1[index].noOfNights}',
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
                                                        'Start Date:${tableData1[index].checkInDtt}',
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
                                                        'End Date:  ${tableData1[index].checkOutDtt}',
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

                                    SizedBox(height: 3,),
                                    Divider(),
                                    SizedBox(height: 3,),

                                    Table(
                                      columnWidths: {
                                        0: IntrinsicColumnWidth(),
                                        // Label Column
                                        1: FixedColumnWidth(20),
                                        // Colon Column
                                        2: IntrinsicColumnWidth(),
                                        // Value Column
                                      },
                                      children: [
                                        _buildTableRow('Total Net Amount',
                                            m23!.currency, m23!.totalFare),
                                        _buildTableRow('Total GST ${m23.gstPercent} %',
                                            m23.currency, m23.gstAmount),
                                        _buildTableRow(
                                            'Service Charge and Tax',
                                            m23.currency,
                                            m23.gstAmount),
                                        _buildTableRow('Total Discount',
                                            m23.currency, m23.discountAmount),
                                        _buildTableRow('Total Price',
                                            m23.currency, m23.grandTotal,
                                            isBold: true),
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
                                                    'Date: ${tableData6[index].createdDateDt}',
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

  TableRow _buildTableRow(String label, dynamic Currency, dynamic value,
      {bool isBold = false}) {
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
