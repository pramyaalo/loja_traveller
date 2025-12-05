import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../Booking/Table12HotelRemitanceModel.dart';

import '../Booking/Table23HotelInvoiceTotalModel.dart';
import '../Booking/Table2HotelModel.dart';


import '../Booking/Table3InvoiceHotelreceiptModel.dart';
import '../Booking/Table4HotelPaymentDetailsModel.dart';
import '../Booking/Table5HotelInvoiceModel.dart';
import '../Booking/Table6HotemModel.dart';

import '../Booking/Tablw22InvoiceHotelModel.dart';

import '../Finance/Table7HotelReceiptModel.dart';
import '../Finance/Table9InvoiceListHotelModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'Table0HotelDetailsModel.dart';
import 'Table1HotelDetailsModel.dart';
import 'Table22HotelTermsandCondiitonModel.dart';




class InvoiceListHotel extends StatefulWidget {
  final String Id;

  InvoiceListHotel({required this.Id});
  @override
  State<InvoiceListHotel> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<InvoiceListHotel> {
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


  List<Table9InvoiceListHotelModel> tableData9 = [];
  List<Table23HotelInvoiceTotalModel> tableData23 = [];
  List<Table22HotelTermsandCondiitonModel>tableData22=[];
  List<Table1HotelDetailsModel>tableData1=[];
  List<Table2HotelModel>tableData2=[];
  List<Table7HotelReceiptModel>tableData7=[];
  List<Table3InvoiceHotelreceiptModel>tableData3=[];
  List<Table4HotelPaymentDetailsModel>tableData4=[];
  List<Table5HotelInvoiceModel>tableData5=[];
  List<Table12HotelRemitanceModel>tableData12=[];

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
      table3=map["Table3"];
      table4=map["Table4"];
      table5=map["Table5"];
      table22=map['Table22'];
      table7 = map["Table7"];
      table8 = map['Table8'];
      table9 = map["Table9"];
      table10 = map["Table10"];
      table11 = map['Table11'];
      table12=map['Table12'];
      table23=map['Table23'];
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
                "Hotel Invoice",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Montserrat",
                    fontSize: 19),
              ),
            ],
          ),
          actions: [
            Image.asset(
              'assets/images/lojolog.png',
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
                    late Table0HotelDetailsModel m0;

                    if (table0.isNotEmpty) {
                      m0 = Table0HotelDetailsModel.fromJson(table0[0]);
                    }


// Table1HotelDetailsModel
                    tableData1.clear();
                    if (table1.isNotEmpty) {
                      for (int i = 0; i < table1.length; i++) {
                        Table1HotelDetailsModel t1Data = Table1HotelDetailsModel.fromJson(table1[i]);
                        tableData1.add(t1Data);
                        print('Index: $i, Table1 Length: ${table1.length}, t1Data: $t1Data');
                      }
                    }

// Table5HotelInvoiceModel
                    // Declare at the top of the function or widget (before using it anywhere)
                    Table5HotelInvoiceModel? m5;

                    tableData5.clear();

                    if (table5.isNotEmpty) {
                      m5 = Table5HotelInvoiceModel.fromJson(table5[0]);
                      for (int i = 0; i < table5.length; i++) {
                        Table5HotelInvoiceModel t1Data = Table5HotelInvoiceModel.fromJson(table5[i]);
                        tableData5.add(t1Data);
                      }
                    } else {
                      print("table5 is empty");
                    }
                    tableData22.clear();

                    if (table22.isNotEmpty) {
                      Table22HotelTermsandCondiitonModel m22 =
                      Table22HotelTermsandCondiitonModel.fromJson(table22[0]);

                      for (int i = 0; i < table22.length; i++) {
                        Table22HotelTermsandCondiitonModel t6Data =
                        Table22HotelTermsandCondiitonModel.fromJson(table22[i]);
                        tableData22.add(t6Data);
                        print('Index: $i, Table Length: ${table22.length}, t1Data: $t6Data');
                      }
                    } else {
                      print("table12 is empty. Skipping data parsing.");
                    }


// Table2HotelModel
                    tableData2.clear();
                    if (table2.isNotEmpty) {
                      for (int i = 0; i < table2.length; i++) {
                        Table2HotelModel t1Data = Table2HotelModel.fromJson(table2[i]);
                        tableData2.add(t1Data);
                        print('Index: $i, Table2 Length: ${table2.length}, t1Data: $t1Data');
                      }
                    }


                    //tableData2
                    tableData3.clear();
                    if (table3.isNotEmpty) {
                      Table3InvoiceHotelreceiptModel m3 = Table3InvoiceHotelreceiptModel.fromJson(table3[0]);
                      for (int i = 0; i < table3.length; i++) {
                        Table3InvoiceHotelreceiptModel t1Data = Table3InvoiceHotelreceiptModel.fromJson(table3[i]);
                        tableData3.add(t1Data);
                        print('Index: $i, Table3 Length: ${table3.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table3 is empty');
                    }

                    tableData4.clear();
                    if (table4.isNotEmpty) {
                      Table4HotelPaymentDetailsModel m4 = Table4HotelPaymentDetailsModel.fromJson(table4[0]);
                      for (int i = 0; i < table4.length; i++) {
                        Table4HotelPaymentDetailsModel t1Data = Table4HotelPaymentDetailsModel.fromJson(table4[i]);
                        tableData4.add(t1Data);
                        print('Index: $i, Table4 Length: ${table4.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table4 is empty');
                    }

                    tableData7.clear();
                    if (table7.isNotEmpty) {
                      Table7HotelReceiptModel m7 = Table7HotelReceiptModel.fromJson(table7[0]);
                      for (int i = 0; i < table7.length; i++) {
                        Table7HotelReceiptModel t1Data = Table7HotelReceiptModel.fromJson(table7[i]);
                        tableData7.add(t1Data);
                        print('Index: $i, Table7 Length: ${table7.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table7 is empty');
                    }

                    Table23HotelInvoiceTotalModel? m23;

                    if (table23.isNotEmpty) {
                      m23 = Table23HotelInvoiceTotalModel.fromJson(table23[0]);
                      for (int i = 0; i < table23.length; i++) {
                        Table23HotelInvoiceTotalModel t1Data = Table23HotelInvoiceTotalModel.fromJson(table23[i]);
                        tableData23.add(t1Data);
                        print('Index: $i, Table23 Length: ${table23.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table23 is empty');
                    }

                    if (m23 != null) {
                      print(m23!.grandTotal); // example usage
                    } else {
                      print('m23 data not available');
                    }


                    Table6HotemModel? m22;  // Nullable because table6 might be empty

                    if (table22.isNotEmpty) {
                      m22 = Table6HotemModel.fromJson(table22[0]);
                    }

// Now you can safely use m6 outside the if block, but check if it is not null:
                    if (m22 != null) {
                      print(m22.roomDescription);  // example property
                    }


                    tableData12.clear();

                    if (table7.isNotEmpty) {
                      Table12HotelRemitanceModel m12 = Table12HotelRemitanceModel.fromJson(table7[0]);
                      for (int i = 0; i < table7.length; i++) {
                        Table12HotelRemitanceModel t6Data = Table12HotelRemitanceModel.fromJson(table7[i]);
                        tableData12.add(t6Data);
                        print('Index: $i, TablSDASDFe4 Length: ${table7.length}, t1Data: $t6Data');
                      }
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
                                      Text(m5?.corporateName??'N/A',
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
                (m5?.corporateAddress1 ?? '') +
                (m5?.corporateAddress2 ?? '') +
                (m5?.addressLine3 ?? ''),
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                "Post Code & Phone: " +
                (m5?.PostCode ?? '') +
                " | " +
                (m5?.phone ?? ''),

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
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Email: "+ (m5?.email??'') ,
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
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 15, top: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  'PNR: ${tableData3[index].pnr}',
                                                  style: (TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15))),
                                              Text(
                                                  'Age : ${tableData3[index].age}',
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
                                  padding:
                                  const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Color(0xFFADD8E6),
                                    alignment: Alignment.centerLeft,
                                    child: Text('   Hotel Details:',
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
                                                mainAxisAlignment: MainAxisAlignment.start, // or MainAxisAlignment.center
                                                children: [
                                                  Expanded(  // optional to prevent overflow, wraps text to next line if needed
                                                    child: Text(
                                                      'Hotel Name: ${tableData1[index].hotelName}',
                                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                                      overflow: TextOverflow.ellipsis, // adds '...' if text is too long
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
                                                      'Room Type: ${tableData1[index].roomType}',
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
                                                  Container(

                                                    child: Text(
                                                        'Check In: ${tableData1[index].checkInDtt}',
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
                                                      'Check Out: ${tableData1[index].checkOutDtt}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text(
                                                    'Nights:  ${tableData1[index].noofNights}',
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
                                  const EdgeInsets.only(right: 3, left: 3,top: 10),
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
                                                        '${tableData4[0].passenger}',
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
                                                      'Tax: ${tableData4[0].currency} ${tableData4[0].inputTax}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15)),
                                                    ),
                                                    Text(
                                                        'Other Charges: ${tableData4[0].currency} ${tableData4[0].outputTax}',
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
                                                        'Base Fare: ${tableData4[0].currency} ${tableData4[0].totalSales}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 15))),
                                                    Text(
                                                        'Total: ${tableData4[0].currency} ${tableData4[0].totalNett}',
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
                                    _buildTableRow('Total Net Amount', m23?.currency??"", m23?.totalFare ?? 0),
                                    _buildTableRow('Total GST ${m23?.gstPercent ?? 0} %', Currency, m23?.gstAmount ?? 0),
                                    _buildTableRow(
                                      '	Service Charge and Tax',
                                      m23?.currency??'0',
                                      (double.tryParse(m23?.serviceTaxAmount??'0'
                                          .toString()) ??
                                          0) +
                                          (double.tryParse(
                                              m23?.gstAmount??'0'.toString()) ??
                                              0),
                                    ),                                         _buildTableRow('Total Discounts', m23?.currency??"", m23?.discountAmount ?? 0),
                                    _buildTableRow('Total Price', m23?.currency??"", m23?.grandTotal ?? 0, isBold: true),
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
                                                      'Lead Passenger: ${tableData12[0].passenger}',
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
                                                  Container(

                                                    child: Text(
                                                        '	Booking Ref: ${tableData12[0].bookingNumber}',
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
                                                  Container(

                                                    child: Text(
                                                        'CheckOut Date: ${tableData12[0].checkOutDt}',
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
                                                      'Consultant: ${tableData12[0].name}',
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
                                                      'Total: ${tableData12[0].grandTotal}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15))),

                                                ],
                                              ),
                                            ),
                                          ]),


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
                                    child: Text('  Terms And Conditions:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17)),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Heading only once
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                          child: Text(
                                            'Room Description',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                        ),

                                        // List of all room descriptions
                                        ...tableData22.map((data) => Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                          child: Text(data.roomDescription ?? ''),
                                        )),
                                      ],
                                    ),
                                    const Divider(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                          child: Text(
                                            'Room Promotion',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                        ),

                                        // Only non-empty roomPromotion values
                                        ...tableData22
                                            .where((data) => (data.roomPromotion ?? '').trim().isNotEmpty)
                                            .map((data) => Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                          child: Text(data.roomPromotion!),
                                        ))
                                            .toList(),
                                      ],
                                    ),

                                    // Smoking Preference Section
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                          child: Text(
                                            'Smoking Preference',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                        ),
                                        ...tableData22
                                            .where((data) => (data.smokingPreference ?? '').trim().isNotEmpty)
                                            .map((data) => Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                          child: Text(data.smokingPreference!),
                                        ))
                                            .toList(),
                                      ],
                                    ),

// Amenity Section
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                          child: Text(
                                            'Amenity',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                        ),
                                        ...tableData22
                                            .where((data) => (data.amenities ?? '').trim().isNotEmpty)
                                            .map((data) => Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                          child: Text(data.amenities!),
                                        ))
                                            .toList(),
                                      ],
                                    ),


                                    const Divider(),

                                    // Inclusion Section
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      child: Text('Inclusion:', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                    ...tableData22.map((data) => Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                      child: Text(data.inclusion ?? ''),
                                    )),


                                    const Divider(),

                                    // Hotel Policy Section
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                          child: Text('Hotel Policy:', style: TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                        ...tableData22
                                            .where((data) => (data.hotelPolicyDetail ?? '').trim().isNotEmpty)
                                            .map((data) => Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                          child: Text(data.hotelPolicyDetail!),
                                        ))
                                            .toList(),
                                      ],
                                    ),



                                    const Divider(),

                                    // Cancellation Policy Section
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      child: Text('Cancellation Policy:', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                    ...tableData22.map((data) => Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                      child: Text(data.cancellationPolicy ?? ''),
                                    )),

                                    const SizedBox(height: 10),
                                  ],
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
