import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Finance/Table0InvoiceFlighteceiptModel.dart';
import '../Finance/Table10InvoiceHotelfareBreakdownListModel.dart';

import '../Finance/Table7InvoiceListHotelModel.dart';
import '../Finance/Table9InvoiceListHotelModel.dart';
 import '../Models/HOtelFareModel.dart';
import '../Models/HotelTaxModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'Table0HotelModel.dart';
import 'Table10HotelInvoiceTotalModel.dart';
import 'Table11BusInvoiceTotalModel.dart';
import 'Table11HolidayRemitenceModel.dart';
import 'Table12HotelRemitanceModel.dart';
import 'Table13BusRemitanceModel.dart';
 import 'Table1HotelModel.dart';
import 'Table2HolidayDetailsModel.dart';
 import 'Table3BusDetailsModel.dart';
import 'Table4BusTravellerDetailModel.dart';

import 'Table5HotelPaymentDetailsModel.dart';
import 'Table6HolidayReceiptModel.dart';
 import 'Table9HolidayInvoiceTotalModel.dart';


class HolidayReceipt extends StatefulWidget {
  final String Id;

  HolidayReceipt({required this.Id});
  @override
  State<HolidayReceipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<HolidayReceipt> {
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
      table34,
      table39,
      table50,
      table47,
      table48,
      table49,
      table20,
      table21;


  List<Table7InvoiceListHotelModel> tableData7 = [];
  List<Table9HolidayInvoiceTotalModel> tableData9 = [];

  List<Table11HolidayRemitenceModel>tableData11=[];
  List<Table1HotelModel>tableData1=[];
  List<Table2HolidayDetailsModel>tableData2=[];
  List<Table4BusTravellerDetailModel>tableData4=[];
  List<Table5HotelPaymentDetailsModel>tableData5=[];
  List<Table6HolidayReceiptModel>tableData6=[];
  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "RecHolidayReceipt", "BookId=${widget.Id}");
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
      table5=map["Table5"];
      table6=map['Table6'];
      table7 = map["Table7"];
      table8 = map['Table8'];
      table9 = map["Table9"];
      table10 = map["Table10"];
      table11 = map['Table11'];
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
            backgroundColor:Color(0xFF00ADEE)),
        body: Center(
          child: FutureBuilder<String?>(
              future: getLabels(),
              builder: (context, snapshot) {
                print('object' + snapshot.connectionState.toString());
                if (snapshot.connectionState == ConnectionState.done) {
                  try {
                    Table0HotelModel m0 =
                    Table0HotelModel.fromJson(table0[0]);
                    if (table0.isNotEmpty) {
                      m0 = Table0HotelModel.fromJson(table0[0]);
                      print("fjhg" + m0.corporateAddress2);
                    } else {
                      print('The list is empty.');
                    }


                    //Table1HotelModel
                    tableData1.clear();
                    Table1HotelModel m1 =
                    Table1HotelModel.fromJson(table1[0]);
                    if (table1.isNotEmpty) {
                      for (int i = 0; i < table1.length; i++) {
                        Table1HotelModel t1Data =
                        Table1HotelModel.fromJson(table1[i]);
                        tableData1.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table3
                                .length}, t1Data: $t1Data');
                      }
                    }

                    tableData6.clear();

                    if (table6.isNotEmpty) {
                      Table6HolidayReceiptModel m12 = Table6HolidayReceiptModel.fromJson(table6[0]);

                      for (int i = 0; i < table6.length; i++) {
                        Table6HolidayReceiptModel t6Data = Table6HolidayReceiptModel.fromJson(table6[i]);
                        tableData6.add(t6Data);
                        print('Index: $i, Table4 Length: ${table6.length}, t1Data: $t6Data');
                      }
                    } else {
                      print('table8 is empty. No data to process.');
                    }
                    /*  tableData2.clear();
                    Table2HotelModel m2 =
                    Table2HotelModel.fromJson(table2[0]);
                    if (table2.isNotEmpty) {
                      for (int i = 0; i < table2.length; i++) {
                        Table2HotelModel t1Data =
                        Table2HotelModel.fromJson(table2[i]);
                        tableData2.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table2
                                .length}, t1Data: $t1Data');
                      }
                    }*/
                    //tableData2

                    tableData4.clear();
                    Table4BusTravellerDetailModel m4 =
                    Table4BusTravellerDetailModel.fromJson(table4[0]);
                    if (table4.isNotEmpty) {
                      for (int i = 0; i < table4.length; i++) {
                        Table4BusTravellerDetailModel t1Data =
                        Table4BusTravellerDetailModel.fromJson(table4[i]);
                        tableData4.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table4
                                .length}, t1Data: $t1Data');
                      }
                    }
                    //
                    tableData5.clear();
                    Table5HotelPaymentDetailsModel m5 =
                    Table5HotelPaymentDetailsModel.fromJson(table5[0]);
                    if (table5.isNotEmpty) {
                      for (int i = 0; i < table5.length; i++) {
                        Table5HotelPaymentDetailsModel t1Data =
                        Table5HotelPaymentDetailsModel.fromJson(table5[i]);
                        tableData5.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table5
                                .length}, t1Data: $t1Data');
                      }
                    }
                    //
                    tableData9.clear();
                    Table9HolidayInvoiceTotalModel m9 =
                    Table9HolidayInvoiceTotalModel.fromJson(table9[0]);
                    if (table9.isNotEmpty) {
                      for (int i = 0; i < table9.length; i++) {
                        Table9HolidayInvoiceTotalModel t1Data =
                        Table9HolidayInvoiceTotalModel.fromJson(table9[i]);
                        tableData9.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table9.length}, t1Data: $t1Data');
                      }
                    }


                    /*   Table11InvoiceHotelreceiptModel m11 =
                          Table11InvoiceHotelreceiptModel.fromJson(table11[0]);
                      if (table11.isNotEmpty) {
                        m11 =
                            Table11InvoiceHotelreceiptModel.fromJson(table11[0]);
                        print("fjhg" + m11.phone);
                      } else {
                        print('The list is empty.');
                      }*/
                    tableData2.clear();
                    Table2HolidayDetailsModel m2 =
                    Table2HolidayDetailsModel.fromJson(
                        table2[0]);
                    if (table2.isNotEmpty) {
                      for (int i = 0; i < table2.length; i++) {
                        Table2HolidayDetailsModel t1Data =
                        Table2HolidayDetailsModel.fromJson(
                            table2[i]);
                        tableData2.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table2.length}, t1Data: $t1Data');
                      }
                    }

                    tableData11.clear();
                    Table11HolidayRemitenceModel m11 =
                    Table11HolidayRemitenceModel.fromJson(
                        table11[0]);
                    if (table11.isNotEmpty) {
                      for (int i = 0; i < table11.length; i++) {
                        Table11HolidayRemitenceModel t1Data =
                        Table11HolidayRemitenceModel.fromJson(
                            table11[i]);
                        tableData11.add(t1Data);
                        print(
                            'Index: $i, fsdfssfd ${table11.length}, t1Data: $t1Data');
                      }
                    }



                    /*  InvoiceListHotelFareModel m48 =
                          InvoiceListHotelFareModel.fromJson(table48[0]);
                      if (table48.isNotEmpty) {
                        m48 = InvoiceListHotelFareModel.fromJson(table48[0]);
                        print("fjhg" + m48.totalFare);
                      } else {
                        print('The list is empty.');
                      }

                      Table47InvoiceHotelListModel m47 =
                          Table47InvoiceHotelListModel.fromJson(table47[0]);
                      if (table47.isNotEmpty) {
                        m47 = Table47InvoiceHotelListModel.fromJson(table47[0]);
                        print("fjhg" + m47.cancellationPolicy);
                      } else {
                        print('The list is empty.');
                      }

                      OInvoiceListHoteltaxModel m49 =
                          OInvoiceListHoteltaxModel.fromJson(table49[0]);
                      if (table49.isNotEmpty) {
                        m49 = OInvoiceListHoteltaxModel.fromJson(table49[0]);
                        print("fjhg" + m49.totalTax);
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
                                  Text('Receipt',
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
                                child: Text('Receipt',
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
                                      Text(m0.corporateName,
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
                                        m0.corporateAddress1 +
                                            m0.corporateAddress2 +
                                            m0.addressLine3,
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
                                        'Invoice date: ' + m1.bookedOnDt,
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
                                        'Invoice Number: ' + m1.bookFlightId,
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
                                        'Booking Status: ' + m1.bookingStatus,
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
                                    tableData4.length,
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
                                                  "${tableData4[index].passenger}",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight.w500)),
                                              Text(
                                                'Type: ${tableData4[index].type}',
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
                                                  'PNR: ${tableData4[index].pnr}',
                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              SizedBox(width: 10), // spacing between PNR and Age
                                              Text(
                                                'Age : ${tableData4[index].age}',
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
                                                  'Phone : ${tableData4[index].phoneNo}',
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
                                    child: Text('   Holiday Details:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
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
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      'Holiday Name: ${tableData2[index].hotelName}',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      overflow: TextOverflow.ellipsis, // prevents overflow by truncating
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
                                                  Flexible( // or use Expanded
                                                    child: Text(
                                                      'Bar Code: ${tableData2[index].barcodeData}',
                                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                      overflow: TextOverflow.ellipsis,
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
                                                  Text(
                                                      'Product Id: ${tableData2[index].productId}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text(
                                                      'Days: ${tableData2[index].noOfNights}',
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
                                                      'Start Date: ${tableData2[index].checkInDtt}',
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
                                                      'End Date: ${tableData2[index].checkOutDtt}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15))),

                                                ],
                                              ),
                                            ),

                                          ]),
                                    )),

                                SizedBox(
                                  height: 10,
                                ),
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
                                    tableData5.length,
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
                                                        '${tableData5[index].Passenger}',
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
                                                      'Tax: ${tableData5[index].currency1} ${tableData5[index].inputTax}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15)),
                                                    ),
                                                    Text(
                                                        'Other Charges: ${tableData5[index].currency1} ${tableData5[index].outputTax}',
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
                                                        'Base Fare: ${tableData5[index].currency1} ${tableData5[index].totalSales1}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 15))),
                                                    Text(
                                                        'Total: ${tableData5[index].currency1} ${tableData5[index].totalNett1}',
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
                                    _buildTableRow('Total Net Amount',m5.currency1, m9.totalFare),
                                    _buildTableRow(
                                      '	Service Charge and Tax',
                                      m5.currency1,
                                      (double.tryParse(m9.serviceTaxAmount
                                          .toString()) ??
                                          0) +
                                          (double.tryParse(
                                              m9.gstAmount.toString()) ??
                                              0),
                                    ),

                                    _buildTableRow('Total Price',m5.currency1, m9.grandTotal, isBold: true),
                                  ],
                                ),

                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Color(0xFFADD8E6),
                                    alignment: Alignment.centerLeft,
                                    child: Text(' Receipt:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17)),
                                  ),
                                ),

                                Column(
                                  children: tableData6.isEmpty
                                      ? [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'No Data',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ]
                                      : List.generate(
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
                                              Expanded(
                                                child: Text(
                                                  'Receipt No: ${tableData6[index].receiptNo}',
                                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 15, top: 3),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Allocated Amount: ${tableData6[index].allocatedAmount}',
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
                                        SizedBox(height: 8), // Optional spacing between entries
                                      ],
                                    ),
                                  ),
                                ),

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
