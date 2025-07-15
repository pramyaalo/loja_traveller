import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


 import '../Finance/Table0InvoiceFlighteceiptModel.dart';
import '../Finance/Table10InvoiceHotelfareBreakdownListModel.dart';

import '../Finance/Table3InvoiceHotelreceiptModel.dart';
import '../Finance/Table7HotelReceiptModel.dart';
import '../Finance/Table7InvoiceListHotelModel.dart';
import '../Finance/Table9InvoiceListHotelModel.dart';
 import '../Finance/Tablw22InvoiceHotelModel.dart';
import '../Models/HOtelFareModel.dart';
import '../Models/HotelTaxModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'Table0HotelModel.dart';
 import 'Table10HotelInvoiceTotalModel.dart';
import 'Table12HotelRemitanceModel.dart';
import 'Table12hotelRemitanceModeldub.dart';
import 'Table1HotelModel.dart';
import 'Table2HotelModel.dart';
import 'Table4HotelModel.dart';
import 'Table5HotelPaymentDetailsModel.dart';
import 'Table6HotemModel.dart';



class HotelItineraryScreen extends StatefulWidget {
  final String Id;

  HotelItineraryScreen({required this.Id});
  @override
  State<HotelItineraryScreen> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<HotelItineraryScreen> {
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
  List<Tablw22InvoiceHotelModel>tableData22=[];
  List<Table1HotelModel>tableData1=[];
  List<Table2HotelModel>tableData2=[];
  List<Table7HotelReceiptModel>tableData7=[];
  List<Table3InvoiceHotelreceiptModel>tableData3=[];
  List<Table4HotelModel>tableData4=[];
  List<Table5HotelPaymentDetailsModel>tableData5=[];
  List<Table12hotelRemitanceModeldub>tableData12=[];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "RecHotelItinerary", "BookId=${widget.Id}");
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
                  "Hotel Itinerary",
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
                    Table3InvoiceHotelreceiptModel m3 =
                    Table3InvoiceHotelreceiptModel.fromJson(table3[0]);
                    if (table3.isNotEmpty) {
                      for (int i = 0; i < table3.length; i++) {
                        Table3InvoiceHotelreceiptModel t1Data =
                        Table3InvoiceHotelreceiptModel.fromJson(table3[i]);
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

                    tableData7.clear();
                    Table7HotelReceiptModel? m7;
                    if (table7.isNotEmpty) {
                      m7 = Table7HotelReceiptModel.fromJson(table7[0]);
                      for (int i = 0; i < table7.length; i++) {
                        Table7HotelReceiptModel t1Data = Table7HotelReceiptModel.fromJson(table7[i]);
                        tableData7.add(t1Data);
                        print('Index: $i, Table7 Length: ${table7.length}, t1Data: $t1Data');
                      }
                    }

                    tableData10.clear();
                    Table10HotelInvoiceTotalModel? m10;
                    if (table10.isNotEmpty) {
                      m10 = Table10HotelInvoiceTotalModel.fromJson(table10[0]);
                      for (int i = 0; i < table10.length; i++) {
                        Table10HotelInvoiceTotalModel t1Data = Table10HotelInvoiceTotalModel.fromJson(table10[i]);
                        tableData10.add(t1Data);
                        print('Index: $i, Table10 Length: ${table10.length}, t1Data: $t1Data');
                      }
                    }

                    Table6HotemModel? m6;
                    if (table6.isNotEmpty) {
                      m6 = Table6HotemModel.fromJson(table6[0]);
                    }

                    tableData12.clear();
                    Table12hotelRemitanceModeldub? m12;
                    if (table12.isNotEmpty) {
                      m12 = Table12hotelRemitanceModeldub.fromJson(table12[0]);
                      for (int i = 0; i < table12.length; i++) {
                        Table12hotelRemitanceModeldub t6Data = Table12hotelRemitanceModeldub.fromJson(table12[i]);
                        tableData12.add(t6Data);
                        print('Index: $i, Table12 Length: ${table12.length}, t1Data: $t6Data');
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
                                  Text('Itinerary',
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
                                child: Text('Itinerary',
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
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 15, top: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                      'Hotel Name: ${tableData2[index].hotelName}',
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
                                                      'Room Type: ${tableData2[index].roomType}',
                                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                      overflow: TextOverflow.ellipsis, // or .fade or .clip
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
                                                    'Nights:  ${tableData2[index].noofNights}',
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
                                          MainAxisAlignment
                                              .spaceBetween,
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
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(
                                                'Consultant: ${tableData12[0].name}',
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
                                              'Booking Ref: ${tableData12[0].bookingNumber}',
                                              style: (TextStyle(
                                                  fontWeight:
                                                  FontWeight.w500,
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
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [

                                            Text(
                                                'Date: ${tableData12[0].checkOutDt}',
                                                style: (TextStyle(
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    fontSize: 15))),
                                            Text(
                                                'Total: ${tableData12[0].grandTotal}',
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
                                                m6!

                                                    .roomDescription,
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
                                      Text('Inclusion: ' + m6.inclusion,
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
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
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
