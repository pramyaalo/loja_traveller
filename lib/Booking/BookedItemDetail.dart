import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;


import '../Finance/InvoiceFlightListReceipt.dart';
import '../Finance/InvoiceHotelReceipt.dart';
import '../Finance/VouchersFlightReceipt.dart';
import '../Finance/VouchersHotelReceipt.dart';
import '../Models/BusTermsandConditionsModels.dart';
import '../Models/CarBreakDownModel.dart';
import '../Models/HolidayFareBreakdownModel.dart';
import '../Models/HolidayPassengerModel.dart';
import '../Models/HotelFareBreakDownModel.dart';
import '../Models/HotelPassengerModel.dart';
import '../Receipt/FlightInvoice.dart';
import '../Receipt/InvoiceReceipt.dart';
import '../utils/response_handler.dart';
import 'BookedItemViewModel.dart';
import 'BusBookingModel.dart';
import 'BusFareBreakDown.dart';
import 'BusInvoice.dart';
import 'BusItinerary.dart';
import 'BusPassengerModel.dart';
import 'BusReceipt.dart';
import 'BusVoucher.dart';
import 'CarInvoice.dart';
import 'CarItinerary.dart';
import 'CarReceipt.dart';
import 'CarVoucher.dart';
import 'FlightQuotation.dart';
import 'FlightReceiptScreen.dart';
import 'FlightSegment.dart';
import 'FlightrefundReceipt.dart';
import 'HolidayItinerary.dart';
import 'HolidayQuotation.dart';
import 'HolidayReceipt.dart';
import 'Holidayinvoice.dart';
import 'HotelBookingModel.dart';
import 'HotelInvoice.dart';
import 'HotelInvoiceQuotationScreen.dart';
import 'HotelItineraryScreen.dart';
import 'Table0HotelListModel.dart';
import 'Table10HotelPassengerListModel.dart';
import 'Table13CarDescriptionModel.dart';
import 'Table14CarPassengerDataModel.dart';
import 'Table15CarPricingDetailsModel.dart';
import 'Table16FlightInvoiceModel.dart';
import 'Table17HolidayDescriptionModel.dart';
import 'Table19HolidayPassengerDetailsModel.dart';
import 'Table2FlightModel.dart';
import 'Table3FLightPassengerListModel.dart';
import 'Table42HotelTermsandConditionModel.dart';
import 'Table6FlightPricingDetailsModel.dart';
import 'Table8HotelDetailsModel.dart';





class BookedItemDetail extends StatefulWidget {
  final id;

  BookedItemDetail({super.key, required this.id});

  @override
  State<BookedItemDetail> createState() => _BookedItemDetailState();
}

class _BookedItemDetailState extends State<BookedItemDetail> {
  String selectedAccountType = 'Select Document';

  var accountTypes = ['Select Document'];
  String selectedDocument = 'Select Document';
  late List<dynamic> table0,
      table1,
      table2,
      table42,
      table3,
      table4,
      table5,
      table6,
      table8,
      table9,
      table10,
      table12,
      table13,
      table14,
      table15,
      table17,
      table18,
      table19,
      table22,
      table23,
      table24,
      table39,
      table40,
      table21;
  List<BookedItemViewModel> tableData = [];
  List<FlightSegment> table1Data = [];
  List<Table16FlightInvoiceMode> tableData22 = [];
  List<Table2FlightModel> table2Data = [];
  List<Table3FLightPassengerListModel> table3Data = [];
  List<HotelBooking> table6Data = [];
  List<Table0HotelListModel> tableDataHotel = [];
  List<HotelFareBreakDownModel> table9Data = [];
  List<Table10HotelPassengerListModel> table10Data = [];
  List<Table8HotelDetailsModel> table8Data = [];
  List<Table13CarDescriptionModel> table13Data = [];
  List<Table14CarPassengerDataModel> table14Data = [];
  List<Table15CarPricingDetailsModel>table15Data=[];
  List<Table17HolidayDescriptionModel> table17Data = [];
  List<Table19HolidayPassengerDetailsModel>tableData19=[];

  List<BusBookingModel> table22Data = [];
  List<BusPassengerModel> table23Data = [];
  List<BusFareBreakDown> table24Data = [];
  List<BusTermsandConditionsModels> table39Data = [];
  List<Table42HotelTermsandConditionModel> table42DataHotel = [];
  static String savedId = '';
  String? savedName;

  Future<String?> getLabels() async {
    Future<http.Response>? futureLabels = ResponseHandler.performPost(
        "BookingCardViewGet", 'BookFlightId=${widget.id}&StaffId=0');
    print('abi' + widget.id.toString());

    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map["Table1"];
      table2 = map["Table2"];
      table3 = map["Table3"];
      table4 = map["Table4"];
      table5 = map["Table5"];
      table6 = map["Table6"];
      table9 = map["Table9"];
      table10=map["Table10"];
      table8 = map['Table8'];
      table12 = map['Table12'];
      table13 = map['Table13'];
      table14 = map['Table14'];
      table15=map['Table15'];
      table17 = map['Table17'];
      table18 = map['Table18'];
      table19 = map['Table19'];
      table42 = map["Table42"];
      table22 = map['Table22'];
      table23 = map['Table23'];
      table24 = map['Table24'];
      return jsonResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<String?>(
            future: getLabels(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                try {
                  tableData.clear();
                  if (table0.isNotEmpty) {
                    BookedItemViewModel m0 =
                    BookedItemViewModel.fromJson(table0[0]);
                    for (int i = 0; i < table0.length; i++) {
                      BookedItemViewModel t1Data =
                      BookedItemViewModel.fromJson(table0[i]);
                      tableData.add(t1Data);
                      print(
                          'Index: $i, Table4 Length: ${table0.length}, t1Data: $t1Data');
                    }
                  }

                  table2Data.clear();
                  if (table2.isNotEmpty) {
                    Table2FlightModel m2 = Table2FlightModel.fromJson(table2[0]);
                    for (int i = 0; i < table2.length; i++) {
                      Table2FlightModel t2Data = Table2FlightModel.fromJson(table2[i]);
                      table2Data.add(t2Data);
                      print(
                          'Index: $i, Table4 Length: ${table1.length}, t1Data: $t2Data');
                    }
                  }
                  table3Data.clear();
                  if (table3.isNotEmpty) {
                    Table3FLightPassengerListModel m2 = Table3FLightPassengerListModel.fromJson(table3[0]);
                    for (int i = 0; i < table3.length; i++) {
                      Table3FLightPassengerListModel t2Data = Table3FLightPassengerListModel.fromJson(table3[i]);
                      table3Data.add(t2Data);
                      print(
                          'Index: $i, Tablsdfde4 Length: ${table3.length}, t1Data: $t2Data');
                    }
                  }
                  //Table3FLightPassengerListModel
                  table42DataHotel.clear();
                  if (table42.isNotEmpty) {
                    Table42HotelTermsandConditionModel m1 =
                    Table42HotelTermsandConditionModel.fromJson(table42[0]);
                    for (int i = 0; i < table42.length; i++) {
                      Table42HotelTermsandConditionModel t1Data =
                      Table42HotelTermsandConditionModel.fromJson(table42[i]);
                      table42DataHotel.add(t1Data);
                      print(
                          'Index: $i, Tabldsghfdhe4 Length: ${table42.length}, t1Data: $t1Data');
                    }
                  }
                  //
//HotelRoomDetailsModel
                  tableDataHotel.clear();
                  if (table0.isNotEmpty) {
                    Table0HotelListModel m0 =
                    Table0HotelListModel.fromJson(table0[0]);
                    for (int i = 0; i < table0.length; i++) {
                      Table0HotelListModel t1Data =
                      Table0HotelListModel.fromJson(table0[i]);
                      tableDataHotel.add(t1Data);
                      print(
                          'Index: $i, Tablsade4 Length: ${table0.length}, t1Data: $t1Data');
                    }
                  }

                  table8Data.clear();
                  if (table8.isNotEmpty) {
                    Table8HotelDetailsModel m1 =
                    Table8HotelDetailsModel.fromJson(table8[0]);
                    for (int i = 0; i < table8.length; i++) {
                      Table8HotelDetailsModel t1Data =
                      Table8HotelDetailsModel.fromJson(table8[i]);
                      table8Data.add(t1Data);
                      print(
                          'Index: $i, Tablfhfyje4 Length: ${table8.length}, t1Data: $t1Data');
                    }
                  }

                  table10Data.clear();
                  if (table10.isNotEmpty) {
                    Table10HotelPassengerListModel m1 =
                    Table10HotelPassengerListModel.fromJson(table10[0]);
                    for (int i = 0; i < table10.length; i++) {
                      Table10HotelPassengerListModel t1Data =
                      Table10HotelPassengerListModel.fromJson(table10[i]);
                      table10Data.add(t1Data);
                      print(
                          'Index: $i, Tablfhfyjeasdfsaf4 Length: ${table10.length}, t1Data: $t1Data');
                    }
                  }


//

                  Table6FlightPricingDetailsModel m6 =
                  Table6FlightPricingDetailsModel.fromJson(table6[0]);


                  Table15CarPricingDetailsModel? m15;
                  table15Data.clear();
                  if (table15.isNotEmpty) {
                    m15 = Table15CarPricingDetailsModel.fromJson(table15[0]);

                    for (int i = 0; i < table15.length; i++) {
                      Table15CarPricingDetailsModel t8Data =
                      Table15CarPricingDetailsModel.fromJson(table15[i]);
                      table15Data.add(t8Data);
                      print('Index: $i, Table8 Length: ${table15.length}, t1Data: $t8Data');
                    }
                  }

// Now m15 is accessible here if needed
                  if (m15 != null) {
                    print("First entry parsed: ${m15}");
                  }

                  table9Data.clear();
                  if (table9.isNotEmpty) {
                    HotelFareBreakDownModel m9 =
                    HotelFareBreakDownModel.fromJson(table9[0]);

                    for (int i = 0; i < table9.length; i++) {
                      HotelFareBreakDownModel t9Data =
                      HotelFareBreakDownModel.fromJson(table9[i]);
                      table9Data.add(t9Data);
                      print(
                          'Index: $i, Table6 Length: ${table9.length}, t1Data: $t9Data');
                    }
                  }

                  table13Data.clear();
                  if (table13.isNotEmpty) {
                    Table13CarDescriptionModel m16 = Table13CarDescriptionModel.fromJson(table13[0]);

                    for (int i = 0; i < table13.length; i++) {
                      Table13CarDescriptionModel t16Data =
                      Table13CarDescriptionModel.fromJson(table13[i]);
                      table13Data.add(t16Data);
                      print(
                          'Index: $i, Table12 Length: ${table13.length}, t1Data: $t16Data');
                    }
                  }


                  table14Data.clear();
                  if (table14.isNotEmpty) {
                    Table14CarPassengerDataModel m14 =
                    Table14CarPassengerDataModel.fromJson(table14[0]);

                    for (int i = 0; i < table14.length; i++) {
                      Table14CarPassengerDataModel t16Data =
                      Table14CarPassengerDataModel.fromJson(table14[i]);
                      table14Data.add(t16Data);
                      print(
                          'Index: $i, Table16 Length: ${table14.length}, t1Data: $t16Data');
                    }
                  }

                  table17Data.clear();
                  if (table17.isNotEmpty) {
                    Table17HolidayDescriptionModel m16 =
                    Table17HolidayDescriptionModel.fromJson(table17[0]);

                    for (int i = 0; i < table17.length; i++) {
                      Table17HolidayDescriptionModel t16Data =
                      Table17HolidayDescriptionModel.fromJson(table17[i]);
                      table17Data.add(t16Data);
                      print(
                          'Index: $i, Table16 Length: ${table17.length}, t1Data: $t16Data');
                    }
                  }

                  tableData19.clear();
                  if (table19.isNotEmpty) {
                    Table19HolidayPassengerDetailsModel m16 =
                    Table19HolidayPassengerDetailsModel.fromJson(table19[0]);

                    for (int i = 0; i < table19.length; i++) {
                      Table19HolidayPassengerDetailsModel t18Data =
                      Table19HolidayPassengerDetailsModel.fromJson(table19[i]);
                      tableData19.add(t18Data);
                      print(
                          'Index: $i, Table16 Length: ${table19.length}, t1Data: $t18Data');
                    }
                  }

                  table22Data.clear();
                  if (table22.isNotEmpty) {
                    BusBookingModel m16 = BusBookingModel.fromJson(table22[0]);

                    for (int i = 0; i < table22.length; i++) {
                      BusBookingModel t22Data =
                      BusBookingModel.fromJson(table22[i]);
                      table22Data.add(t22Data);
                      print(
                          'Index: $i, Table16 Length: ${table22.length}, t1Data: $t22Data');
                    }
                  }
                  table23Data.clear();
                  if (table23.isNotEmpty) {
                    BusPassengerModel m16 =
                    BusPassengerModel.fromJson(table23[0]);

                    for (int i = 0; i < table23.length; i++) {
                      BusPassengerModel t22Data =
                      BusPassengerModel.fromJson(table23[i]);
                      table23Data.add(t22Data);
                      print(
                          'Index: $i, Table16 Length: ${table23.length}, t1Data: $t22Data');
                    }
                  }
                  /* table24Data.clear();
                  if (table24.isNotEmpty) {
                    BusFareBreakDown m16 =
                        BusFareBreakDown.fromJson(table24[0]);

                    for (int i = 0; i < table24.length; i++) {
                      BusFareBreakDown t24Data =
                          BusFareBreakDown.fromJson(table24[i]);
                      table24Data.add(t24Data);
                      print(
                          'Index: $i, Table16 Length: ${table24.length}, t1Data: $t24Data');
                    }
                  }*/
                  BusFareBreakDown m24 =
                  BusFareBreakDown.fromJson(table24[0]);
                  /*  table39Data.clear();
                  if (table39.isNotEmpty) {
                    BusTermsandConditionsModels m40 =
                        BusTermsandConditionsModels.fromJson(table39[0]);

                    for (int i = 0; i < table39.length; i++) {
                      BusTermsandConditionsModels t39Data =
                          BusTermsandConditionsModels.fromJson(table39[i]);
                      table39Data.add(t39Data);
                      print(
                          'Index: $i, Table6 Length: ${table39.length}, t1Data: $t39Data');
                    }
                  }
                  table20DataHotel.clear();
                  if (table40.isNotEmpty) {
                    HotelRoomDetailsModel m40 =
                        HotelRoomDetailsModel.fromJson(table40[0]);

                    for (int i = 0; i < table40.length; i++) {
                      HotelRoomDetailsModel t40Data =
                          HotelRoomDetailsModel.fromJson(table40[i]);
                      table20DataHotel.add(t40Data);
                      print(
                          'Index: $i, Table6 Length: ${table40.length}, t1Data: $t40Data');
                    }
                  }*/
                  if (tableData[0].bookingType == "Car".toString())
                    accountTypes = [
                      'Select Document',
                      'Car Invoice',
                      'Car Voucher',
                      'Car Receipt',
                      'Car Itinerary',
                    ];
                  if (tableData[0].bookingType == "Flight".toString())
                    accountTypes = [
                      'Select Document',
                      'Flight Invoice',
                      'Flight Refund',
                      'Flight Quotation',
                      'Flight Receipt',
                    ];
                  if (tableData[0].bookingType == "Hotel".toString())
                    accountTypes = [
                      'Select Document',
                      'Hotel Invoice',
                      'Hotel Quotation',
                      'Hotel Receipt',
                      'Hotel Itinerary',
                    ];
                  if (tableData[0].bookingType == "Holiday".toString())
                    accountTypes = [
                      'Select Document',
                      'Holiday Invoice',
                      'Holiday Quotation',
                      'Holiday Receipt',
                      'Holiday Itinerary',
                    ];
                  if (tableData[0].bookingType == "Bus".toString())
                    accountTypes = [
                      'Select Document',
                      'Bus Invoice',
                      'Bus Voucher',
                      'Bus Receipt',
                      'Bus Itinerary',
                    ];
                  /* Tableee2 m2 = Tableee2.fromJson(table2[0]);

                  Tableee3 m3 = Tableee3.fromJson(table3[0]);
                  Tableee4 m4 = Tableee4.fromJson(table4[0]);
                  table1Data.clear();
                  for (int i = 0; i < table4.length; i++) {
                    t1Data = Tableee4.fromJson(table4[i]);

                    table1Data.add(t1Data);
                    print(
                        'Index: $i, Table4 Length: ${table4.length}, t1Data: $t1Data');
                  }
                  Tableee5 m5 = Tableee5.fromJson(table5[0]);
                  table2Data.clear();
                  for (int i = 0; i < table5.length; i++) {
                    Tableee5 t2Data = Tableee5.fromJson(table5[i]);

                    table2Data.add(t2Data);
                    print(
                        'Index: $i, Table4 Length: ${table4.length}, t1Data: $t1Data');
                  }
                  Tableee6 m6 = Tableee6.fromJson(table6[0]);
                  table3Data.clear();
                  for (int i = 0; i < table6.length; i++) {
                    Tableee6 t3Data = Tableee6.fromJson(table6[i]);

                    table3Data.add(t3Data);
                    print(
                        'Index: $i, Table4 Length: ${table4.length}, t1Data: $t1Data');
                  }
                  Tablee7 m7 = Tablee7.fromJson(table7[0]);*/
                  return SingleChildScrollView(
                    child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                            children: List.generate(
                              tableData.length,
                                  (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Booked Item",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Container(
                                      margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                      child: PhysicalModel(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(0),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 5, top: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded( // Makes sure content doesn't overflow
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Booking Id: ",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: "Montserrat",
                                                                fontSize: 17,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                "${tableData[index].bookingId}",
                                                                style: TextStyle(
                                                                  fontFamily: "Montserrat",
                                                                  fontSize: 17,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                                overflow: TextOverflow.ellipsis,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 5),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Type: ${tableData[index].bookingType}",
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets
                                                            .fromLTRB(
                                                            10.0, 5, 10, 5),
                                                        decoration: BoxDecoration(
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .secondary,
                                                          border: Border.all(
                                                              width: 0.1,
                                                              color: Colors.orange),
                                                          //https://stackoverflow.com/a/67395539/16076689
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                        ),
                                                        child: Text(
                                                          getDisplayStatus(tableData[index].bookingStatus),

                                                          //  m0.documentStatus,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                              "Montserrat",
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              color: Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Image(
                                                            image: AssetImage(
                                                                'assets/images/tickiconpng.png'),
                                                            color: Color(0xFF00ADEE),
                                                            width: 16,
                                                            height: 16,
                                                          ),
                                                          Text(
                                                            "${tableData[index].bookedOnDt}",

                                                            //  m0.bookedOnDt,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                "Montserrat",
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                fontSize: 15,
                                                                color: Color(0xFF00ADEE)),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 0,
                                              ),
                                              const Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 225,
                                                    height: 1,
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          color: Color(0xffededed)),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Price(Incl. Tax)",
                                                    style: TextStyle(
                                                        fontFamily: "Montserrat",
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 35,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    if (tableData[index].bookingType == "Flight")
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            height: 45,
                                                            width: 170,
                                                            child: IgnorePointer(
                                                              ignoring: isStatusDisabled(tableData[index].bookingStatus),
                                                              child: DropdownButtonFormField<String>(
                                                                decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor: isStatusDisabled(tableData[index].bookingStatus)
                                                                      ? Colors.grey[200]  // light grey when disabled
                                                                      : Colors.white,     // white when enabled
                                                                  border: const OutlineInputBorder(),
                                                                  hintText: 'Select Document',
                                                                  contentPadding: const EdgeInsets.only(bottom: 5),
                                                                ),
                                                                value: selectedAccountType,
                                                                items: accountTypes.map<DropdownMenuItem<String>>((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text("   $value"),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (String? newValue) {
                                                                  if (newValue != null && newValue.isNotEmpty) {
                                                                    setState(() {
                                                                      selectedAccountType = newValue;
                                                                    });

                                                                    if (newValue == 'Flight Invoice') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => FlightInvoice(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Flight Receipt') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => FlightReceiptScreen(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Flight Refund') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => FlightrefundReceipt(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Flight Quotation') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => FlightQuotation(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 5),
                                                        ],
                                                      ),



                                                    if (tableData[0].bookingType == "Hotel")
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            height: 45,
                                                            width: 170,
                                                            child: IgnorePointer(
                                                              ignoring: isStatusDisabled(tableData[index].bookingStatus),
                                                              child: DropdownButtonFormField<String>(
                                                                decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor: isStatusDisabled(tableData[index].bookingStatus)
                                                                      ? Colors.grey[200]  // light grey if disabled
                                                                      : Colors.white,
                                                                  border: const OutlineInputBorder(),
                                                                  hintText: 'Select Document',
                                                                  contentPadding: const EdgeInsets.only(bottom: 5),
                                                                ),
                                                                value: selectedAccountType,
                                                                items: accountTypes.map<DropdownMenuItem<String>>((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text("   $value"),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (String? newValue) {
                                                                  if (newValue != null && newValue.isNotEmpty) {
                                                                    setState(() {
                                                                      selectedAccountType = newValue;
                                                                    });

                                                                    if (newValue == 'Hotel Invoice') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => HotelInvoice(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Hotel Receipt') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => InvoiceHotelReceipt(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Hotel Itinerary') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => HotelItineraryScreen(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Hotel Quotation') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => HotelInvoiceQuotationScreen(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 5),
                                                        ],
                                                      ),


                                                    if (tableData[0].bookingType == "Bus")
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            height: 45,
                                                            width: 170,
                                                            child: IgnorePointer(
                                                              ignoring: isStatusDisabled(tableData[index].bookingStatus),
                                                              child: DropdownButtonFormField<String>(
                                                                decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor: isStatusDisabled(tableData[index].bookingStatus)
                                                                      ? Colors.grey[200] // Light grey when disabled
                                                                      : Colors.white,
                                                                  border: const OutlineInputBorder(),
                                                                  hintText: 'Select Document',
                                                                  contentPadding: const EdgeInsets.only(bottom: 5),
                                                                ),
                                                                value: selectedAccountType,
                                                                items: accountTypes.map<DropdownMenuItem<String>>((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text("   $value"),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (String? newValue) {
                                                                  if (newValue != null && newValue.isNotEmpty) {
                                                                    setState(() {
                                                                      selectedAccountType = newValue;
                                                                    });

                                                                    if (newValue == 'Bus Invoice') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => BusInvoice(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Bus Receipt') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => BusReceipt(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Bus Voucher') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => BusVoucher(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Bus Itinerary') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => BusItinerary(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 5),
                                                        ],
                                                      ),

                                                    if (tableData[0].bookingType == "Holiday")
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            height: 45,
                                                            width: 175,
                                                            child: IgnorePointer(
                                                              ignoring: isStatusDisabled(tableData[index].bookingStatus),
                                                              child: DropdownButtonFormField<String>(
                                                                decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor: isStatusDisabled(tableData[index].bookingStatus)
                                                                      ? Colors.grey[200] // Light grey when disabled
                                                                      : Colors.white,
                                                                  border: const OutlineInputBorder(),
                                                                  hintText: 'Select Document',
                                                                  contentPadding: const EdgeInsets.only(bottom: 5),
                                                                ),
                                                                value: selectedAccountType,
                                                                items: accountTypes.map<DropdownMenuItem<String>>((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text("   $value"),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (String? newValue) {
                                                                  if (newValue != null && newValue.isNotEmpty) {
                                                                    setState(() {
                                                                      selectedAccountType = newValue;
                                                                    });

                                                                    if (newValue == 'Holiday Invoice') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => Holidayinvoice(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Holiday Receipt') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => HolidayReceipt(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Holiday Quotation') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => HolidayQuotation(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Holiday Itinerary') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => HolidayItinerary(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 5),
                                                        ],
                                                      ),

                                                    if (tableData[0].bookingType == "Car")
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            height: 45,
                                                            width: 170,
                                                            child: IgnorePointer(
                                                              ignoring: isStatusDisabled(tableData[index].bookingStatus),
                                                              child: DropdownButtonFormField<String>(
                                                                decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor: isStatusDisabled(tableData[index].bookingStatus)
                                                                      ? Colors.grey[200] // Light grey when disabled
                                                                      : Colors.white,
                                                                  border: const OutlineInputBorder(),
                                                                  hintText: 'Select Document',
                                                                  contentPadding: const EdgeInsets.only(bottom: 5),
                                                                ),
                                                                value: selectedAccountType,
                                                                items: accountTypes.map<DropdownMenuItem<String>>((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text("   $value"),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (String? newValue) {
                                                                  if (newValue != null && newValue.isNotEmpty) {
                                                                    setState(() {
                                                                      selectedAccountType = newValue;
                                                                    });

                                                                    if (newValue == 'Car Invoice') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => CarInvoice(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Car Receipt') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => CarReceipt(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Car Voucher') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => CarVoucher(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (newValue == 'Car Itinerary') {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => CarItinerary(
                                                                            Id: tableData[index].bookFlightId,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 5),
                                                        ],
                                                      ),


                                                    Text(
                                                      "${tableData[index].bookingTotalAmount}",
                                                      //m0.bookingTotalAmount,
                                                      style: const TextStyle(
                                                          fontFamily: "Montserrat",
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width - 30,
                                      height: 0.2,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if (tableData[index].bookingType == "Flight")
                                      Text(
                                        tableData[index].bookingType +
                                            " " +
                                            "Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    if (tableData[index].bookingType == "Hotel")
                                      Text(
                                        tableData[index].bookingType +
                                            " " +
                                            "Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    if (tableData[index].bookingType == "Car")
                                      Text(
                                        tableData[index].bookingType +
                                            " " +
                                            "Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    if (tableData[index].bookingType == "Holiday")
                                      Text(
                                        tableData[index].bookingType +
                                            " " +
                                            "Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    if (tableData[index].bookingType == "Bus")
                                      Text(
                                        tableData[index].bookingType +
                                            " " +
                                            "Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    if (tableData[index].bookingType == "Flight")
                                      Container(
                                        child: Column(
                                          children: List.generate(
                                              table2Data.length,
                                                  (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: 270,
                                                          child: Text(
                                                              'Itinerary: ' +
                                                                  "${table2Data[index].tfsDepAirport + "-" + table2Data[index].tfsArrAirport}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'GDS/LCC PNR: ' +
                                                                "${table2Data[index].pnr}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Flight No: ' +
                                                                "${table2Data[index].tfsFlightNumber + " " + "(" + table2Data[index].tfsAirline + ")"}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Departure Time: ' +
                                                                "${table2Data[index].tfsDepDatedt + " " + "(" + table2Data[index].tfsDepTime + ")"}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Terminal: ' +
                                                                "${table2Data[index].tfsDepTerminal}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Arrival Time: ' +
                                                                "${table2Data[index].tfsArrDatedt + " " + "(" + table2Data[index].tfsArrTime + ")"}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Terminal: ' +
                                                                "${table2Data[index].tfsArrTerminal}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Class Name: ' +
                                                                "${table2Data[index].tfsClassName}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Duration: ' +
                                                                "${table2Data[index].tfsDuration}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    if (tableData[index].bookingType ==
                                        "Hotel".toString())
                                      Container(
                                        child: Column(
                                          children: List.generate(
                                              table8Data.length,
                                                  (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                            'Itinerary: ' +
                                                                "${table8Data[index].Count}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 290,
                                                          child: Text(
                                                              'Hotel Name: ' +
                                                                  "${table8Data[index].hotelName}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 300,
                                                          child: Text(
                                                              'Room Type: ' +
                                                                  "${table8Data[index].roomType}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'CheckIn: ' +
                                                                "${table8Data[index].checkInDt}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Voucher Number: ' +
                                                                "${table8Data[index].thhBookFlightId}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Check Out: ' +
                                                                "${table8Data[index].checkOutDt}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Confirmation No: ' +
                                                                "${table8Data[index].confirmationNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),

                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    if (tableData[index].bookingType ==
                                        "Car".toString())
                                      Container(
                                        child: Column(
                                          children: List.generate(
                                              table13Data.length,
                                                  (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                            'Itinerary: ' +
                                                                "${table13Data[index].nos}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 290,
                                                          child: Text(
                                                              'Company : ' +
                                                                  "${table13Data[index].carName}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 300,
                                                          child: Text(
                                                              'PickUp : ' +
                                                                  "${table13Data[index].pickupDate}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Pickup Location: ' +
                                                                "${table13Data[index].pickupLocation}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'DropOff: ' +
                                                                "${table13Data[index].dropoffDate}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Dropoff Location: ' +
                                                                "${table13Data[index].dropoffLocation}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Car Type: ' +
                                                                "${table13Data[index].cartype}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Car Group: ' +
                                                                "${table13Data[index].carGroup}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Car Status: ' +
                                                                "${table13Data[index].carStatus}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Luggage : ' +
                                                                "${table13Data[index].luggage}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Confirmation No : ' +
                                                                "${table13Data[index].confirmationNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Voucher No : ' +
                                                                "${table13Data[index].bookingRefNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    if (tableData[index].bookingType ==
                                        "Holiday".toString())
                                      Container(
                                        child: Column(
                                          children: List.generate(
                                              table17Data.length,
                                                  (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                            'Itinerary: ' +
                                                                "${table17Data[index].nos}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 290,
                                                          child: Text(
                                                              'Holiday Name  : ' +
                                                                  "${table17Data[index].hotelName}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 300,
                                                          child: Text(
                                                              'Product ID : ' +
                                                                  "${table17Data[index].productId}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Product Code: ' +
                                                                "${table17Data[index].roomType}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Start Date: ' +
                                                                "${table17Data[index].checkInDt}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'End Date: ' +
                                                                "${table17Data[index].checkOutDt}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Voucher No: ' +
                                                                "${table17Data[index].bookFlightId}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Confirmation No: ' +
                                                                "${table17Data[index].ticketNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),

                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    if (tableData[index].bookingType ==
                                        "Bus".toString())
                                      Container(
                                        child: Column(
                                          children: List.generate(
                                              table22Data.length,
                                                  (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                            'Itinerary: ' +
                                                                "${table22Data[index].Nos}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 290,
                                                          child: Text(
                                                              'Travel Name   : ' +
                                                                  "${table22Data[index].travelName}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'PickUp : ' +
                                                                "${table22Data[index].originCityTime}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Pickup Location: ' +
                                                                "${table22Data[index].originCityLocation}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'DropOff: ' +
                                                                "${table22Data[index].destinationCityTime}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Dropoff Location: ' +
                                                                "${table22Data[index].destinationCityLocation}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Bus Type: ' +
                                                                "${table22Data[index].busType}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Total Amount: ' +
                                                                "${table22Data[index].TotalAmount}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    /*Container(
                                  width: MediaQuery.of(context).size.width - 30,
                                  height: 0.2,
                                  color: Colors.black,
                                ),*/
                                    Container(
                                      width: MediaQuery.of(context).size.width - 30,
                                      height: 0.2,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Pricing Details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if (tableData[index].bookingType == "Flight")
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
                                              m6.currency, m6.totalFare),
                                          _buildTableRow(
                                              'Total GST ${m6.gstPercent} %',
                                              m6.currency,
                                              m6.gstAmount),
                                          _buildTableRow(
                                              'Total Service Tax ${m6.serviceTaxPercent} %',
                                              m6.currency,
                                              m6.serviceTaxAmount),
                                          _buildTableRow('Total Discount',
                                              m6.currency, m6.discountAmount),
                                          _buildTableRow('Total Price', m6.currency,
                                              m6.grandTotal,
                                              isBold: true),
                                        ],
                                      ),
                                    if (tableData[index].bookingType ==
                                        "Hotel".toString())
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
                                          _buildTableRow('Total Fare', m6.currency,
                                              m6.totalFare),
                                          _buildTableRow('GST Tax Charge',
                                              m6.currency, m6.gstAmount),
                                          _buildTableRow('Service Tax Charge',
                                              m6.currency, m6.serviceTaxAmount),
                                          _buildTableRow('Grand Total', m6.currency,
                                              m6.grandTotal,
                                              isBold: true),
                                        ],
                                      ),
                                    if (tableData[index].bookingType ==
                                        "Car".toString())
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
                                          _buildTableRow('Total Fare', m15?.currency,
                                              m15?.totalProfit),
                                          _buildTableRow('GST Tax Charge',
                                              m15?.currency, m15?.inputTax),
                                          _buildTableRow('Service Tax Charge',
                                              m15?.currency, m15?.outputTax),
                                          _buildTableRow('Grand Total', m15?.currency,
                                              m15?.grandTotal,
                                              isBold: true),
                                        ],
                                      ),
                                    if (tableData[index].bookingType ==
                                        "Holiday".toString())
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
                                          _buildTableRow('Total Fare',
                                              m6.currency, m6.totalFare),
                                          _buildTableRow(
                                              'GST Tax Charge',
                                              m6.currency,
                                              m6.inputTax),
                                          _buildTableRow(
                                              'Service Tax Charge',
                                              m6.currency,
                                              m6.outputTax),

                                          _buildTableRow('Total Price', m6.currency,
                                              m6.grandTotal,
                                              isBold: true),
                                        ],
                                      ),
                                    if (tableData[index].bookingType ==
                                        "Bus".toString())
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
                                          _buildTableRow('Total Fare', m24.currency,
                                              m24.totalNett),
                                          _buildTableRow('GST Tax Charge',
                                              m24.currency, m24.gstAmount),
                                          _buildTableRow('Service Tax Charge',
                                              m24.currency, m24.serviceTaxAmount),
                                          _buildTableRow('Grand Total', m24.currency,
                                              m24.grandTotal,
                                              isBold: true),
                                        ],
                                      ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width - 30,
                                      height: 0.2,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Passengers Data",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 0,
                                    ),
                                    if (tableData[index].bookingType == "Flight")
                                      Container(
                                        child: Column(
                                          children: List.generate(
                                              table3Data.length,
                                                  (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                            'Passenger Name: ' +
                                                                "${table3Data[index].passenger}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Type: ' +
                                                                "${table3Data[index].type}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Birth Date: ' +
                                                                "${table3Data[index].tfpDOB}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            '	Identity No: ' +
                                                                "${table3Data[index].tfpIdentityNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Phone Number: ' +
                                                                "${table3Data[index].custPhone}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),


                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    if (tableData[index].bookingType ==
                                        "Hotel".toString())
                                      Container(
                                        child: Column(
                                          children: List.generate(
                                              table10Data.length,
                                                  (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                            'Passenger Name: ' +
                                                                "${table10Data[index].passenger}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Type: ' +
                                                                "${table10Data[index].type}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Birth Date: ' +
                                                                "${table10Data[index].tfpDOB}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            '	Identity No: ' +
                                                                "${table10Data[index].tfpIdentityNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Phone Number: ' +
                                                                "${table10Data[index].tfpPhoneNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Email: ' +
                                                                "${table10Data[index].tfpEmail}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    if (tableData[index].bookingType ==
                                        "Car".toString())
                                      Container(
                                        child: Column(
                                          children: List.generate(
                                              table14Data.length,
                                                  (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                            'Passenger Name: ' +
                                                                "${table14Data[index].passenger}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Type: ' +
                                                                "${table14Data[index].type}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Birth Date: ' +
                                                                "${table14Data[index].tfpDOB}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            '	Identity No: ' +
                                                                "${table14Data[index].tfpIdentityNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Phone Number: ' +
                                                                "${table14Data[index].tfpPhoneNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Email: ' +
                                                                "${table14Data[index].tfpEmail}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    if (tableData[index].bookingType ==
                                        "Holiday".toString())
                                      Container(
                                        child: Column(
                                          children: List.generate(
                                              tableData19.length,
                                                  (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                            'Passenger Name: ' +
                                                                "${tableData19[index].passenger}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Type: ' +
                                                                "${tableData19[index].type}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Birth Date: ' +
                                                                "${tableData19[index].dob}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            '	Identity No: ' +
                                                                "${tableData19[index].tfpIdentityNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Phone Number: ' +
                                                                "${tableData19[index].phoneNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Email: ' +
                                                                "${tableData19[index].email}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    if (tableData[index].bookingType ==
                                        "Bus".toString())
                                      Container(
                                        child: Column(
                                          children: List.generate(
                                              table23Data.length,
                                                  (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                            'Passenger Name: ' +
                                                                "${table23Data[index].passenger}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Type: ' +
                                                                "${table23Data[index].type}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Birth Date: ' +
                                                                "${table23Data[index].dob}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 0,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Identity No: ' +
                                                                "${table23Data[index].idNumber}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Phone Number: ' +
                                                                "${table23Data[index].phoneNo}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 5,
                                                        top: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            'Email: ' +
                                                                "${table23Data[index].email}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    Container(
                                      width: MediaQuery.of(context).size.width - 30,
                                      height: 0.2,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Terms and Conditions",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    if (tableData[index].bookingType == "Flight")
                                      Text('No Data'),
                                    if (tableData[index].bookingType ==
                                        "Hotel".toString())
                                      Column(
                                        children: List.generate(
                                          table42DataHotel.length,
                                              (index) => Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 5, top: 0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 290,
                                                      child: Text(
                                                          'Room Description: ' +
                                                              "${table42DataHotel[index].roomDescription}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 5, top: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 290,
                                                      child: Text(
                                                          'Amenity: ' +
                                                              "${table42DataHotel[index].amenity}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 5, top: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 290,
                                                      child: Text(
                                                          'Inclusion: ' +
                                                              "${table42DataHotel[index].inclusion}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(top: 10),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 0, horizontal: 0),
                                                  alignment: Alignment.topLeft,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "Hotel Policy:",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "      " +
                                                              "${table42DataHotel[index].hotelPolicyDetail}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 0, horizontal: 0),
                                                alignment: Alignment.topLeft,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Cancellation Policy:",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.w500),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "      " +
                                                            "${table42DataHotel[index].cancellationPolicy}",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (tableData[index].bookingType ==
                                        "Bus".toString())
                                      Column(
                                        children: List.generate(
                                          table39Data.length,
                                              (index) => Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 5, top: 5),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 290,
                                                      child: Text(
                                                          'Cancellation Charges: ' +
                                                              "${table39Data[index].cancellationCharge}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 5, top: 5),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 290,
                                                      child: Text(
                                                          'From Date: ' +
                                                              "${table39Data[index].fromDate}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 5, top: 5),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                          'To Date: ' +
                                                              "${table39Data[index].toDate}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 5, top: 5),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 290,
                                                      child: Text(
                                                          'Policy: ' +
                                                              "${table39Data[index].policyString}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w500)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ]),
                            ))),
                  );
                } catch (error) {
                  print('Unexpected error: $error');
                  return Text('An unexpected error occurred.');
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
  String getDisplayStatus(String? status) {
    if (status == "Processing") {
      return "Cancelling";
    } else if (status == null ||
        status.trim().isEmpty ||
        status.trim().toLowerCase() == "null" ||
        status == "Unconfirmed") {
      return "Unconfirmed";
    } else if (status == "Cancelled") {
      return "Cancelled";
    } else {
      return status;
    }
  }

  bool isStatusDisabled(String? status) {
    return
      status == "Unconfirmed" ||
          status == "Cancelled" ||
          status == null ||
          status.trim().isEmpty ||
          status.trim().toLowerCase() == "null";
  }

  TableRow _buildTableRow(String label, dynamic currency, dynamic value,
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
              '$currency $value',
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
