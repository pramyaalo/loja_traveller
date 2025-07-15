import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Booking/Table0HotelModel.dart';
import '../Booking/Table11CarInvoiceTotalModel.dart';
import '../Booking/Table13CarRemittenceModel.dart';

import '../Booking/Table1HotelModel.dart';
 import '../Booking/Table2CarDetailsModel.dart';
import '../Booking/Table3CarDetailsInvoiceModel.dart';
import '../Booking/Table3TravelerInformationHolidayModel.dart';
import '../Booking/Table4BusTravellerDetailModel.dart';
import '../Booking/Table5CarPaymentDetailsModel.dart';


import '../Booking/Table6HotemModel.dart';
import '../Finance/Table7InvoiceListHotelModel.dart';
import '../Finance/Table9InvoiceListHotelModel.dart';

import '../Models/HOtelFareModel.dart';
import '../Models/HotelTaxModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'Table24PaymentInformationCarModel.dart';





class VouchersCarReceipt extends StatefulWidget {
  final String Id;

  VouchersCarReceipt({required this.Id});
  @override
  State<VouchersCarReceipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<VouchersCarReceipt> {
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
  List<Table9InvoiceListHotelModel> tableData9 = [];

  List<Table13CarRemittenceModel>tableData13=[];
  List<Table1HotelModel>tableData1=[];
  List<Table2CarDetailsModel>tableData2=[];
  List<Table3TravelerInformationHolidayModel>tableData3=[];
  List<Table5CarPaymentDetailsModel>tableData5=[];
  List<Table24PaymentInformationCarModel>tableData24=[];

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
      table3=map["Table3"];
      table4=map["Table4"];
      table5=map["Table5"];
      table6=map['Table6'];
      table7 = map["Table7"];
      table8 = map['Table8'];
      table9 = map["Table9"];
      table10 = map["Table10"];
      table11 = map['Table11'];
      table12=map['Table12'];
      table13=map['Table13'];
      table24=map['Table23'];
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
                  "Car Voucher",
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
                    /* tableData3.clear();
                    Table3CarDetailsInvoiceModel m3 =
                    Table3CarDetailsInvoiceModel.fromJson(table3[0]);
                    if (table3.isNotEmpty) {
                      for (int i = 0; i < table3.length; i++) {
                        Table3CarDetailsInvoiceModel t1Data =
                        Table3CarDetailsInvoiceModel.fromJson(table3[i]);
                        tableData3.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table3
                                .length}, t1Data: $t1Data');
                      }
                    }*/
                    tableData3.clear();
                    Table3TravelerInformationHolidayModel m4 =
                    Table3TravelerInformationHolidayModel.fromJson(table3[0]);
                    if (table3.isNotEmpty) {
                      for (int i = 0; i < table3.length; i++) {
                        Table3TravelerInformationHolidayModel t1Data =
                        Table3TravelerInformationHolidayModel.fromJson(table3[i]);
                        tableData3.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table4
                                .length}, t1Data: $t1Data');
                      }
                    }
                    //
                    tableData5.clear();
                    Table5CarPaymentDetailsModel m5 =
                    Table5CarPaymentDetailsModel.fromJson(table5[0]);
                    if (table5.isNotEmpty) {
                      for (int i = 0; i < table5.length; i++) {
                        Table5CarPaymentDetailsModel t1Data =
                        Table5CarPaymentDetailsModel.fromJson(table5[i]);
                        tableData5.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table5
                                .length}, t1Data: $t1Data');
                      }
                    }

                    tableData2.clear();
                    Table2CarDetailsModel m2 =
                    Table2CarDetailsModel.fromJson(table2[0]);
                    if (table2.isNotEmpty) {
                      for (int i = 0; i < table2.length; i++) {
                        Table2CarDetailsModel t1Data =
                        Table2CarDetailsModel.fromJson(table2[i]);
                        tableData2.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table2
                                .length}, t1Data: $t1Data');
                      }
                    }
                    //
                    /*tableData9.clear();
                      Table9InvoiceListHotelModel m9 =
                          Table9InvoiceListHotelModel.fromJson(table9[0]);
                      if (table9.isNotEmpty) {
                        for (int i = 0; i < table9.length; i++) {
                          Table9InvoiceListHotelModel t1Data =
                              Table9InvoiceListHotelModel.fromJson(table9[i]);
                          tableData9.add(t1Data);
                          print(
                              'Index: $i, Table4 Length: ${table9.length}, t1Data: $t1Data');
                        }
                      }*/


                    /*   Table11InvoiceHotelreceiptModel m11 =
                          Table11InvoiceHotelreceiptModel.fromJson(table11[0]);
                      if (table11.isNotEmpty) {
                        m11 =
                            Table11InvoiceHotelreceiptModel.fromJson(table11[0]);
                        print("fjhg" + m11.phone);
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
                    tableData24.clear();

                    Table24PaymentInformationCarModel? m24;  // Declare here, nullable in case no data

                    if (table24.isNotEmpty) {
                      m24 = Table24PaymentInformationCarModel.fromJson(table24[0]);

                      for (int i = 0; i < table24.length; i++) {
                        Table24PaymentInformationCarModel t1Data = Table24PaymentInformationCarModel.fromJson(table24[i]);
                        tableData24.add(t1Data);
                        print('Index: $i, Length: ${table24.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table11 is empty. No data to process.');
                    }

// Now you can use m11 outside the if block, but it may be null!
                    if (m24 != null) {
                      print("Phone: ${m24.currency}");
                    }


                    Table6HotemModel? m6;

                    if (table6.isNotEmpty) {
                      m6 = Table6HotemModel.fromJson(table6[0]);
                      print('m6: $m6');
                    } else {
                      print('table6 is empty.');
                    }

// You can now safely use m6 with null checks


                    tableData13.clear();

                    if (table13.isNotEmpty) {
                      Table13CarRemittenceModel m12 = Table13CarRemittenceModel.fromJson(table13[0]);

                      for (int i = 0; i < table13.length; i++) {
                        Table13CarRemittenceModel t6Data = Table13CarRemittenceModel.fromJson(table13[i]);
                        tableData13.add(t6Data);
                        print('Index: $i, Table13 Length: ${table13.length}, t6Data: $t6Data');
                      }
                    } else {
                      print('table13 is empty. No data to process.');
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
                                  Text('VOUCHER',
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
                                child: Text('VOUCHER',
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
                                      Text("Date: "+m1.bookedOnDt,
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
                                      Text("Dear ${m1.passenger},",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Thank you for booking with Travel Demo. Your booking has been accepted. On Approval/Clearance of your payment, we will send you another email with your e-ticket.\n"
                                        "Reference Number: ${m1.bookingId}.\n"
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
                                            m1.bookingStatus,
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
                                  padding:
                                  const EdgeInsets.only(right: 3, left: 3),
                                  child: Container(
                                    height: 40,
                                    color: Color(0xFFADD8E6),
                                    alignment: Alignment.centerLeft,
                                    child: Text('   Car Details:',
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
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 15, top: 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(

                                                    child: Text(
                                                        'Car Type: ${tableData2[index].cartype}',
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
                                    _buildTableRow('Total Net Amount',m24!.currency, m24.totalFare),
                                    _buildTableRow('Total GST ${m24.gstPercent}%',m24.currency, m24.gstAmount),
                                    _buildTableRow(
                                      '	Service Charge and Tax',
                                      m24?.currency??'0',
                                      (double.tryParse(m24?.serviceTaxAmount??'0'
                                          .toString()) ??
                                          0) +
                                          (double.tryParse(
                                              m24?.gstAmount??'0'.toString()) ??
                                              0),
                                    ),
                                    _buildTableRow('Total Discount',m24.currency, m24.discountAmount),

                                    _buildTableRow('Total Price',m24.currency, m24.grandTotal, isBold: true),
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

                                SizedBox(height: 5,),

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



