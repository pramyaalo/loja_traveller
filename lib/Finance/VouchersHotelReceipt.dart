import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loja_traveller/Finance/table23HotelPaymentInmformationModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Booking/Table0HotelModel.dart';
import '../Booking/Table0HotelVoucherModel.dart';
import '../Booking/Table10HotelInvoiceTotalModel.dart';
import '../Booking/Table12HotelRemitanceModel.dart';

  import '../Booking/Table1HotelInformationModel.dart';
import '../Booking/Table2HotelModel.dart';
import '../Booking/Table3TravelleInformationHotelModel.dart';
import '../Booking/Table4HotelModel.dart';
import '../Booking/Table5HotelPaymentDetailsModel.dart';
import '../Booking/Tablw22InvoiceHotelModel.dart';
 import '../Models/HOtelFareModel.dart';
import '../Models/HotelTaxModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';

import 'package:http/http.dart' as http;


import 'Table22HotelTermsandCondiitonModel.dart';
import 'Table7HotelReceiptModel.dart';
import 'Table9InvoiceListHotelModel.dart';


class VouchersHotelReceipt extends StatefulWidget {
  final String Id;

  VouchersHotelReceipt({required this.Id});
  @override
  State<VouchersHotelReceipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<VouchersHotelReceipt> {
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
  List<Table10HotelInvoiceTotalModel> tableData10 = [];
  List<Table1HotelInformationModel>tableData1=[];
  List<Table2HotelModel>tableData2=[];
  List<Table7HotelReceiptModel>tableData7=[];
  List<table23HotelPaymentInmformationModel>tableData23=[];
  List<Table3TravelleInformationHotelModel>tableData3=[];
  List<Table4HotelModel>tableData4=[];
  List<Table5HotelPaymentDetailsModel>tableData5=[];
  List<Table12HotelRemitanceModel>tableData12=[];
  List<Table22HotelTermsandCondiitonModel>tableData22=[];

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
      table22=map['Table22'];
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
                "Hotel Voucher",
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
                    Table0HotelVoucherModel m0 =
                    Table0HotelVoucherModel.fromJson(table0[0]);
                    if (table0.isNotEmpty) {
                      m0 = Table0HotelVoucherModel.fromJson(table0[0]);
                      print("fjhg" + m0.bookingStatus);
                    } else {
                      print('The list is empty.');
                    }


                    //Table1HotelModel
                    tableData1.clear();
                    Table1HotelInformationModel m1 =
                    Table1HotelInformationModel.fromJson(table1[0]);
                    if (table1.isNotEmpty) {
                      for (int i = 0; i < table1.length; i++) {
                        Table1HotelInformationModel t1Data =
                        Table1HotelInformationModel.fromJson(table1[i]);
                        tableData1.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table3
                                .length}, t1Data: $t1Data');
                      }
                    }

                    tableData2.clear();
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
                    }
                    //tableData2
                    tableData3.clear();
                    Table3TravelleInformationHotelModel m3 =
                    Table3TravelleInformationHotelModel.fromJson(table3[0]);
                    if (table3.isNotEmpty) {
                      for (int i = 0; i < table3.length; i++) {
                        Table3TravelleInformationHotelModel t1Data =
                        Table3TravelleInformationHotelModel.fromJson(table3[i]);
                        tableData3.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table3
                                .length}, t1Data: $t1Data');
                      }
                    }
                    tableData4.clear();
                    Table4HotelModel m4 =
                    Table4HotelModel.fromJson(table4[0]);
                    if (table4.isNotEmpty) {
                      for (int i = 0; i < table4.length; i++) {
                        Table4HotelModel t1Data =
                        Table4HotelModel.fromJson(table4[i]);
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
                    tableData7.clear();
                    Table7HotelReceiptModel m7 =
                    Table7HotelReceiptModel.fromJson(table7[0]);
                    if (table7.isNotEmpty) {
                      for (int i = 0; i < table7.length; i++) {
                        Table7HotelReceiptModel t1Data =
                        Table7HotelReceiptModel.fromJson(table7[i]);
                        tableData7.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table1.length}, t1Data: $t1Data');
                      }
                    }



                    tableData23.clear();
                    table23HotelPaymentInmformationModel m23 =
                    table23HotelPaymentInmformationModel.fromJson(
                        table23[0]);
                    if (table23.isNotEmpty) {
                      for (int i = 0; i < table23.length; i++) {
                        table23HotelPaymentInmformationModel t1Data =
                        table23HotelPaymentInmformationModel.fromJson(
                            table23[i]);
                        tableData23.add(t1Data);
                        print(
                            'Index: $i, fsdfssfd ${table10.length}, t1Data: $t1Data');
                      }
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





                    tableData12.clear();

                    if (table12.isNotEmpty) {
                      Table12HotelRemitanceModel m12 =
                      Table12HotelRemitanceModel.fromJson(table12[0]);

                      for (int i = 0; i < table12.length; i++) {
                        Table12HotelRemitanceModel t6Data =
                        Table12HotelRemitanceModel.fromJson(table12[i]);
                        tableData12.add(t6Data);
                        print('Index: $i, Table Length: ${table12.length}, t1Data: $t6Data');
                      }
                    } else {
                      print("table12 is empty. Skipping data parsing.");
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
                                  Text('Voucher',
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
                                child: Text('Voucher',
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
                                      Text("Date: "+m0.bookedOnDt,
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
                                      Text("Dear ${m0.Passenger},",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Thank you for booking with Travel Demo. Our preferred partner would like to invite you to join a paid subscription service for access to discount offers.\n"
                                        "Reference Number: ${m0.bookingId}.\n"
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
                                            m0.bookingStatus,
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
                                    child: Text('   Traveller Information:',
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
                                    child: Text('   Hotel Information:',
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
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 15, top: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                      'Hotel Name: ${tableData1[index].hotelName}',
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
                                                  Expanded( // Ensures text doesn't overflow
                                                    child: Text(
                                                      'Room Type: ${tableData1[index].roomType}',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15,
                                                      ),
                                                      overflow: TextOverflow.ellipsis, // Optional: adds '...'
                                                      maxLines: 1, // Optional: restricts to single line
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
                                    _buildTableRow('Total Net Amount',m23.currency, m23.totalFare),
                                    _buildTableRow('Total GST ${m23.gstPercent} %',m23.currency, m23.gstAmount),
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
                                    _buildTableRow('Total Discount',m23.currency, m23.discountAmount),

                                    _buildTableRow('Total Price',m23.currency, m23.grandTotal,isBold: true),
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
                                            fontWeight: FontWeight.normal,
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
