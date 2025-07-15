import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:developer' as developer;
import '../Booking/Table1HolidaydetailsModel.dart';
 import '../Booking/Table3HolidayVoucherModel.dart';
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
import 'Table20HolidayReceipt.dart';
import 'Table21HolidayReceipt.dart';
import 'Table22HolidayReceipt.dart';
 import 'Table23VoucherHolidayPaymentInformationModel.dart';
import 'Table3FareBreakDoenFlightModel.dart';
import 'Table47HotelDetailsModel.dart';
import 'Table7HotelReceiptModel.dart';
import 'VoucherHotelReceiptModel.dart';

class VouchersHolidayReceipt extends StatefulWidget {
  final String Id;

  VouchersHolidayReceipt({required this.Id});
  @override
  State<VouchersHolidayReceipt> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<VouchersHolidayReceipt> {
  late List<dynamic> table0,
      table1,
      table7,
      table9,
      table10,
      table12,
      table3,
      table14,
      table16,
      table20,
      table21,
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
  List<Table1HolidaydetailsModel> tableData1 = [];
  List<Table47HotelDetailsModel> tableData2 = [];
  List<Table23VoucherHolidayPaymentInformationModel>tableData23=[];
  List<Table3HolidayVoucherModel>tableData3=[];
  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "VoucherViewGet", "BookFlightId=${widget.Id}");
    print('jfghhjghId' + widget.Id);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      developer.log('jfghhjghId ' + jsonResponse,
          name: 'travel_app_17112023_b2b');
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map['Table'];
      table1=map['Table1'];
      table3=map['Table3'];
      table20 = map['Table20'];
      table21 = map['Table21'];
      table22=map['Table22'];
      table23 = map['Table23'];
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
                    color: Colors.white,
                    size: 27,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                SizedBox(width: 1), // Set the desired width
                Text(
                  "holiday Vouchers",
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
                    Table0HotelBookingModel m0 =
                    Table0HotelBookingModel.fromJson(table0[0]);
                    if (table0.isNotEmpty) {
                      m0 = Table0HotelBookingModel.fromJson(table0[0]);
                      print("fjhg" + m0.bookFlightId);
                    } else {
                      print('The list is empty.');
                    }

                    Table1HolidaydetailsModel? m1;

                    tableData1.clear();

                    if (table23.isNotEmpty) {
                      m1 = Table1HolidaydetailsModel.fromJson(table1[0]);

                      for (int i = 0; i < table1.length; i++) {
                        Table1HolidaydetailsModel t1Data =
                        Table1HolidaydetailsModel.fromJson(table1[i]);
                        tableData1.add(t1Data);
                        print('Index: $i, Length: ${table1.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table23 is empty. No data to process.');
                    }
                    //
                    Table23VoucherHolidayPaymentInformationModel? m23;

                    tableData23.clear();

                    if (table23.isNotEmpty) {
                      m23 = Table23VoucherHolidayPaymentInformationModel.fromJson(table23[0]);

                      for (int i = 0; i < table23.length; i++) {
                        Table23VoucherHolidayPaymentInformationModel t1Data =
                        Table23VoucherHolidayPaymentInformationModel.fromJson(table23[i]);
                        tableData23.add(t1Data);
                        print('Index: $i, Length: ${table23.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table23 is empty. No data to process.');
                    }

                    tableData3.clear();

                    Table3HolidayVoucherModel? m3; // Declare outside the if block

                    if (table3.isNotEmpty) {
                      m3 = Table3HolidayVoucherModel.fromJson(table3[0]);
                      for (int i = 0; i < table3.length; i++) {
                        Table3HolidayVoucherModel t1Data = Table3HolidayVoucherModel.fromJson(table3[i]);
                        tableData3.add(t1Data);
                        print('Index: $i, Table3 Length: ${table3.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table3 is empty');
                    }



                    Table21HolidayReceipt? m21; // Nullable to avoid initialization before check

                    if (table21.isNotEmpty) {
                      m21 = Table21HolidayReceipt.fromJson(table21[0]);
                      print("Mode: ${m21.mode}");
                    } else {
                      print('The list is empty.');
                    }

                    Table22HolidayReceipt? m22;
                    if (table22.isNotEmpty) {
                      m22 = Table22HolidayReceipt.fromJson(table22[0]);
                      print("Age: ${m22.age}");
                    } else {
                      print('table22 is empty.');
                    }

                    Table20HolidayReceipt? m20;
                    if (table20.isNotEmpty) {
                      m20 = Table20HolidayReceipt.fromJson(table20[0]);
                      print("Checkout Date: ${m20.checkOutDt}");
                    } else {
                      print('table20 is empty.');
                    }


                    return SingleChildScrollView(
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            margin: EdgeInsets.all(10),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Voucher',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Image.asset('assets/images/lojologo.png',
                                        width: 200, height: 50),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Date and Thank you message
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text("Date: " + m0.bookedOnDt,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(fontSize: 16.0, color: Colors.black),
                                            children: [
                                              const TextSpan(text: 'Dear '),
                                              TextSpan(
                                                text: m3!.passenger, // e.g., 'AdhitiSSD'
                                                style: const TextStyle(color: Colors.blue,),
                                              ),
                                              const TextSpan(text: ',\n\nThank you for booking with Travel Demo. Your booking has been accepted. On Approval/Clearance of your payment, we will send you another email with your e-ticket. Reference number: '),
                                              TextSpan(
                                                text: m3!.pnr, // e.g., '355D17'
                                                style: const TextStyle(color: Colors.blue),
                                              ),
                                              const TextSpan(text: '.\n\nFor any concerns / queries pertaining to this booking, We request you to quote this reference number in all your future communications with us.\n\nBooking Status: '),
                                              TextSpan(
                                                text: m0!.bookingStatus, // e.g., '355D17'
                                                style: const TextStyle(color: Colors.blue),
                                              ),
                                            ],
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(right: 3, left: 3,top: 10,),
                                child: Container(
                                  height: 40,
                                  color: Color(0xFFB0D0DC),
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
                                padding:
                                const EdgeInsets.only(right: 3, left: 3,top: 10),
                                child: Container(
                                  height: 40,
                                  color: Color(0xFFB0D0DC),
                                  alignment: Alignment.centerLeft,
                                  child: Text('    Holiday Information:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
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
                                                    'Holiday Name: ${tableData1[index].hotelName}',
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
                                                    'Bar Code: ${tableData1[index].barcodeData}',
                                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                    overflow: TextOverflow.ellipsis,  // optional: shows "..." if too long
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
                                                    'Product Id: ${tableData1[index].roomType}',
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
                                                      'Start Date: ${tableData1[index].checkInDtt}',
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
                                                    'End Date: ${tableData1[index].checkOutDtt}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 15))),
                                                Text(
                                                  'Day:  ${tableData1[index].noOfNights}',
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
                                const EdgeInsets.only(right: 3, left: 3,top: 10,),
                                child: Container(
                                  height: 40,
                                  color: Color(0xFFB0D0DC),
                                  alignment: Alignment.centerLeft,
                                  child: Text("   Payment Information",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17)),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                                width: 6,
                              ),
                              m23 != null
                                  ? Table(
                                columnWidths: {
                                  0: IntrinsicColumnWidth(),
                                  1: FixedColumnWidth(20),
                                  2: IntrinsicColumnWidth(),
                                },
                                children: [
                                  _buildTableRow('Total Net Amount', m23.currency, m23.totalFare),
                                  _buildTableRow('Total GST ${m23.gstPercent} %', m23.currency, m23.gstAmount),
                                  _buildTableRow(
                                    '	Service Charge and Tax',
                                    m23?.currency??'0',
                                    (double.tryParse(m23?.serviceTaxAmount??'0'
                                        .toString()) ??
                                        0) +
                                        (double.tryParse(
                                            m23?.gstAmount??'0'.toString()) ??
                                            0),

                                  ),
                                  _buildTableRow('Total Discounts', m23.currency, m23.discountAmount),

                                  _buildTableRow('Total Price', m23.currency, m23.grandTotal, isBold: true),
                                ],
                              )
                                  : const Text("No invoice data available."),

                              SizedBox(
                                height: 6,
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
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 0),
                                      width: 280,
                                      child: Text(
                                        '*  Preferences and special requests cannot be guaranteed. Special requests are subject to availability upon check-in and may incur additional charges.',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
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
        ));
  }
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
