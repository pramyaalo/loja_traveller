import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Booking/Table0HotelModel.dart';
import '../Booking/Table0HotelReceiptBasicdetailsModel.dart';
import '../Booking/Table10HotelInvoiceTotalModel.dart';
import '../Booking/Table10HotelReceiptTotalModel.dart';
import '../Booking/Table12HotelRemitanceModel.dart';

import '../Booking/Table1HotelReceiptModel.dart';
import '../Booking/Table2HotelReceiptHotelDetailModel.dart';

import '../Booking/Table4HotelReceiptTravellerDetailsModel.dart';
import '../Booking/Table5HotelreceiptPaymentDetailsModel.dart.dart';
import '../Booking/Table6HotelReceiptTermsandConditionModel.dart';
import '../Booking/Table7HotelreceiptHeadModel.dart';
import '../Booking/Tablw22InvoiceHotelModel.dart';
import '../Models/HOtelFareModel.dart';
import '../Models/HotelTaxModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';

import 'Table2InvoiceListFlightReceiptModel.dart';
import 'package:http/http.dart' as http;



import 'Table7InvoiceListHotelModel.dart';
import 'Table9InvoiceListHotelModel.dart';

class InvoiceHotelReceipt extends StatefulWidget {
  final String Id;

  InvoiceHotelReceipt({required this.Id});
  @override
  State<InvoiceHotelReceipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<InvoiceHotelReceipt> {
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
  List<Table10HotelReceiptTotalModel> tableData10 = [];
  List<Tablw22InvoiceHotelModel>tableData22=[];
  List<Table1HotelReceiptModel>tableData1=[];
  List<Table2HotelReceiptHotelDetailModel>tableData2=[];
  List<Table7HotelreceiptHeadModel>tableData7=[];
  List<Table6HotelReceiptTermsandConditionModel>tabledata6=[];
  List<Table4HotelReceiptTravellerDetailsModel>tableData4=[];
  List<Table5HotelReceiptPaymentDetailsModel>tableData5=[];
  List<Table12HotelRemitanceModel>tableData12=[];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "RecHotelReceipt", "BookId=${widget.Id}");
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
      table8 = map['Table8'];
      table9 = map["Table9"];
      table10 = map['Table10'];
      table11 = map['Table11'];
      table12=map['Table12'];
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
                  "Hotel receipt",
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
                    Table0HotelReceiptBasicdetailsModel m0 =
                    Table0HotelReceiptBasicdetailsModel.fromJson(table0[0]);
                    if (table0.isNotEmpty) {
                      m0 = Table0HotelReceiptBasicdetailsModel.fromJson(table0[0]);
                      print("fjhg" + m0.corporateAddress1);
                    } else {
                      print('The list is empty.');
                    }


                    //Table1HotelModel
                    tableData1.clear();
                    Table1HotelReceiptModel m1 =
                    Table1HotelReceiptModel.fromJson(table1[0]);
                    if (table1.isNotEmpty) {
                      for (int i = 0; i < table1.length; i++) {
                        Table1HotelReceiptModel t1Data =
                        Table1HotelReceiptModel.fromJson(table1[i]);
                        tableData1.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table1
                                .length}, t1Data: $t1Data');
                      }
                    }

                    tableData2.clear();
                    Table2HotelReceiptHotelDetailModel m2 =
                    Table2HotelReceiptHotelDetailModel.fromJson(table2[0]);
                    if (table2.isNotEmpty) {
                      for (int i = 0; i < table2.length; i++) {
                        Table2HotelReceiptHotelDetailModel t1Data =
                        Table2HotelReceiptHotelDetailModel.fromJson(table2[i]);
                        tableData2.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table2
                                .length}, t1Data: $t1Data');
                      }
                    }


                    tableData5.clear();
                    Table5HotelReceiptPaymentDetailsModel m5 =
                    Table5HotelReceiptPaymentDetailsModel.fromJson(table5[0]);
                    if (table5.isNotEmpty) {
                      for (int i = 0; i < table5.length; i++) {
                        Table5HotelReceiptPaymentDetailsModel t1Data =
                        Table5HotelReceiptPaymentDetailsModel.fromJson(table5[i]);
                        tableData5.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table5
                                .length}, t1Data: $t1Data');
                      }
                    }


                    /*  tableData2.clear();

                    if (table2.isNotEmpty) {
                      Table2HotelModel m2 = Table2HotelModel.fromJson(table2[0]);

                      for (int i = 0; i < table2.length; i++) {
                        Table2HotelModel t1Data = Table2HotelModel.fromJson(table2[i]);
                        tableData2.add(t1Data);
                        print('Index: $i, Table2 Length: ${table2.length}, t1Data: $t1Data');
                      }
                    }*/

                    //tableData2
                    tableData4.clear();
                    if (table4.isNotEmpty) {
                      Table4HotelReceiptTravellerDetailsModel m3 = Table4HotelReceiptTravellerDetailsModel.fromJson(table4[0]);
                      for (int i = 0; i < table4.length; i++) {
                        Table4HotelReceiptTravellerDetailsModel t1Data = Table4HotelReceiptTravellerDetailsModel.fromJson(table4[i]);
                        tableData4.add(t1Data);
                        print('Index: $i, Table3 Length: ${table4.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table3 is empty');


                      tableData7.clear();
                      if (table7.isNotEmpty) {
                        Table7HotelreceiptHeadModel m3 = Table7HotelreceiptHeadModel
                            .fromJson(table7[0]);
                        for (int i = 0; i < table7.length; i++) {
                          Table7HotelreceiptHeadModel t1Data = Table7HotelreceiptHeadModel
                              .fromJson(table7[i]);
                          tableData7.add(t1Data);
                          print('Index: $i, Table3 Length: ${table7
                              .length}, t1Data: $t1Data');
                        }
                      } else {
                        print('table3 is empty');
                      }
                    }


                    Table10HotelReceiptTotalModel? m10;  // Nullable because table6 might be empty

                    if (table10.isNotEmpty) {
                      m10 = Table10HotelReceiptTotalModel.fromJson(table10[0]);
                    }

// Now you can safely use m6 outside the if block, but check if it is not null:
                    if (m10 != null) {
                      print(m10.gstPercent);  // example property
                    }
//tabledata6
                    Table6HotelReceiptTermsandConditionModel? m6;  // Nullable because table6 might be empty

                    if (table6.isNotEmpty) {
                      m6 = Table6HotelReceiptTermsandConditionModel.fromJson(table6[0]);
                    }

// Now you can safely use m6 outside the if block, but check if it is not null:
                    if (m6 != null) {
                      print(m6.roomDescription);  // example property
                    }

                    tableData12.clear();

                    if (table12.isNotEmpty) {
                      Table12HotelRemitanceModel m12 = Table12HotelRemitanceModel.fromJson(table12[0]);
                      for (int i = 0; i < table12.length; i++) {
                        Table12HotelRemitanceModel t6Data = Table12HotelRemitanceModel.fromJson(table12[i]);
                        tableData12.add(t6Data);
                        print('Index: $i, TablSDASDFe4 Length: ${table12.length}, t1Data: $t6Data');
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
                                      Text("Invoice Number: "+m1.bookFlightId,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
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
                                          "Invoice Date: "+m1.bookedOnDt,
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1, // Optional: limits to 1 line
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
                                      Text(
                                        'Booking Status: ' + m1.bookingStatus,
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
                                        m0.corporateName,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 15, top: 4),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          m0.corporateAddress1 + m0.corporateAddress2 + m0.addressLine3,
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis, // Optional: Adds "..."
                                        ),
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
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 15, top: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  'PNR: ${tableData4[index].pnr}',
                                                  style: (TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15))),
                                              Text(
                                                  'Age : ${tableData4[index].age}',
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
                                                  'Phone : ${tableData4[index].tfpPhoneNo}',
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
                                      tableData2.length,
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
                                                      'Hotel Name: ${tableData2[index].hotelName}',
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
                                                      'Room Type: ${tableData2[index].roomType}',
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
                                                        'Check In: ${tableData2[index].checkInDtt}',
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
                                                      'Check Out: ${tableData2[index].checkOutDtt}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text(
                                                    'Nights:  ${tableData2[index].noOfNights}',
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
                                                        '${tableData5[0].passenger}',
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
                                                      'Tax: $Currency ${tableData5[0].inputTax}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15)),
                                                    ),
                                                    Text(
                                                        'Other Charges: $Currency ${tableData5[0].outputTax}',
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
                                                        'Base Fare: $Currency ${tableData5[0].totalSales}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 15))),
                                                    Text(
                                                        'Total: $Currency ${tableData5[0].totalNett}',
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
                                    _buildTableRow('Total Net Amount', m10?.Currency??'', m10?.totalFare??'0'),
                                    _buildTableRow(
                                      '	Service Charge and Tax',
                                      m10?.Currency??'',
                                      (double.tryParse(m10?.serviceTaxAmount??'0'
                                          .toString()) ??
                                          0) +
                                          (double.tryParse(
                                              m10?.gstAmount??'0'.toString()) ??
                                              0),
                                    ),

                                    _buildTableRow('Total Price', m10?.Currency??'', m10?.grandTotal??'0', isBold: true),
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
                                  children: tableData7.isEmpty
                                      ? [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "No data available",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ]
                                      : List.generate(
                                    tableData7.length,
                                        (index) => Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Receipt No: ${tableData7[index].receiptNo}',
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
                                                'Allocated Amount: ${tableData7[index].allocatedAmount}',
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
                                                'Status: ${tableData7[index].status}',
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
                                                'Date: ${tableData7[index].createdDatedt}',
                                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),


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
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 280,
                                        child: Text(
                                            'Room Description: ' +
                                                m6!.roomDescription ?? 'No description available',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        m6.roomPromotion.isNotEmpty
                                            ? 'Room Promotion: ${m6
                                            .roomPromotion}'
                                            : 'No Promotion Available',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),

                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        m6.smokingPreference.isNotEmpty
                                            ? 'Smoking Preference: ${m6
                                            .smokingPreference}'
                                            : 'No',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),

                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        m6.amenity.isNotEmpty
                                            ? 'Amenity: ${m6.amenity}'
                                            : 'No',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text('Inclusion: ' +m6.inclusion,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text('Hotel Policy:     ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(m6.hotelNorms,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text('Cancellation Policy:     ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          m6.cancellationPolicy,
                                          style: TextStyle(fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis, // Add ellipsis if too long
                                          maxLines: 2, // Optional: keep to one line
                                        ),
                                      ),
                                    ],
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
