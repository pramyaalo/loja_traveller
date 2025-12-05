import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Booking/Table10FlightReceiptModel.dart';
import '../../Booking/Table13FlightInvoiceModel.dart';
import '../../Booking/Table14FlightOnwardSegmentModel.dart';
import '../../Booking/Table15FlightReturnSegmentModel.dart';
import '../../Booking/Table16FlightInvoiceModel.dart';
import '../../Booking/Table18FlightInvoiceModel.dart';
import '../../Booking/Table1InvoivceFlightReceiptModel.dart';
import '../../Booking/Table2InvoiceListFlightReceiptModel.dart';
import '../../Booking/Table5InvoiceFlightListReceiptModel.dart';
import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';
import '../hotels/hotels_screen.dart';
import 'Table0InvoiceFlighteceiptModel1.dart';
import 'flight_screen.dart';


class Oneway_ConfirmationScreen extends StatefulWidget {
  final String bookingId, PassengerName, Gender;

  const Oneway_ConfirmationScreen(
      {super.key,
        required this.bookingId,
        required this.PassengerName,
        required this.Gender});

  @override
  State<Oneway_ConfirmationScreen> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<Oneway_ConfirmationScreen> {
  late List<dynamic> table0,
      table1,
      table2,
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
      table16,
      table18,
      table19,
      table23,
      table24,
      table34,
      table39,
      table50,
      table43,
      table48,
      table49,
      table20,
      table21;

  List<Table2InvoiceListFlightReceiptModel> tableData2 = [];
  List<Table1InvoivceFlightReceiptModel> tableData1 = [];
  List<Table14FlightOnwardSegmentModel> tableData14 = [];
  List<Table15FlightReturnSegmentModel> tableData15 = [];
  List<Table18FlightInvoiceModel> tableData18 = [];
  List<Table16FlightInvoiceMode> tableData16 = [];
  List<Table10FlightReceiptModel> tabledata10 = [];
  List<Table13FlightInvoiceModel> tableData13 = [];
  final List<Map<String, dynamic>> items = [
    {
      'icon': Icons.flight,
      'title': 'Find things to do',
      'subtitle': 'Compare thousands of flights, all with no hidden fees',
      'type': 'flight',
    },
    {
      'icon': Icons.hotel,
      'title': 'Book a Stay at Hotel',
      'subtitle': 'Compare thousands of hotels, all with no hidden fees',
      'type': 'hotel',
    },
  ];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "RecFlightInvoice", "BookId=${widget.bookingId}");
    print('jfghhjghId' + widget.bookingId);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      print('jfghhjghIjsonResponsed' + jsonResponse);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map['Table1'];
      table2 = map["Table2"];
      table3 = map["Table3"];
      table6 = map["Table6"];
      table8 = map['Table8'];
      table5 = map["Table5"];
      table10 = map["Table10"];
      table13 = map["Table13"];
      table14 = map["Table14"];
      table15 = map["Table15"];
      table16 = map["Table16"];
      table18 = map['Table18'];
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
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
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
          backgroundColor: Color(0xFF00ADEE),
          // Custom dark color
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 27),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 1),
              Text(
                "Booking Confirmation",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontSize: 19,
                ),
              ),
            ],
          ),
          actions: [
            Image.asset(
              'assets/images/lojologg.png',
              width: 100,
              height: 50,
            ),
          ],
        ),
        body: Center(
          child: FutureBuilder<String?>(
              future: getLabels(),
              builder: (context, snapshot) {
                print('object' + snapshot.connectionState.toString());
                if (snapshot.connectionState == ConnectionState.done) {
                  try {
                    Table0InvoiceFlighteceiptModel1 m0 =
                    Table0InvoiceFlighteceiptModel1.fromJson(table0[0]);
                    if (table0.isNotEmpty) {
                      m0 = Table0InvoiceFlighteceiptModel1.fromJson(table0[0]);
                      print("fjhg" + m0.bookFlightId);
                    } else {
                      print('The list is empty.');
                    }
                    tableData1.clear();

                    if (table1 != null && table1.isNotEmpty) {
                      try {
                        for (int i = 0; i < table1.length; i++) {
                          final t1Data = Table1InvoivceFlightReceiptModel.fromJson(table1[i]);
                          tableData1.add(t1Data);
                          print(
                              'Index: $i, Table1 Length: ${table1.length}, t1Data: $t1Data');
                        }
                      } catch (e) {
                        print('❌ Error while parsing table1 data: $e');
                      }
                    } else {
                      print('⚠️ table1 is empty or null');
                    }

                    tabledata10.clear();

                    if (table10.isNotEmpty) {
                      Table10FlightReceiptModel m10 =
                      Table10FlightReceiptModel.fromJson(table10[0]);

                      for (int i = 0; i < table10.length; i++) {
                        Table10FlightReceiptModel t1Data =
                        Table10FlightReceiptModel.fromJson(table10[i]);
                        tabledata10.add(t1Data);
                        print(
                            'Index: $i, Table10 Length: ${table10.length}, t1Data: $t1Data');
                      }
                    } else {
                      print("table10 is empty");
                    }
                    tableData14.clear();

                    if (table14 != null && table14.isNotEmpty) {
                      try {
                        for (int i = 0; i < table14.length; i++) {
                          final t1Data = Table14FlightOnwardSegmentModel.fromJson(table14[i]);
                          tableData14.add(t1Data);
                          print(
                              'Index: $i, Table14 Length: ${table14.length}, t1Data: $t1Data');
                        }
                      } catch (e) {
                        print('❌ Error parsing table14 data: $e');
                      }
                    } else {
                      print('⚠️ table14 is empty or null');
                    }


                    tableData15.clear();

                    if (table15.isNotEmpty) {
                      Table15FlightReturnSegmentModel m15 =
                      Table15FlightReturnSegmentModel.fromJson(table15[0]);

                      for (int i = 0; i < table15.length; i++) {
                        Table15FlightReturnSegmentModel t1Data =
                        Table15FlightReturnSegmentModel.fromJson(
                            table15[i]);
                        tableData15.add(t1Data);
                        print(
                            'Index: $i, TabDSleads4 Length: ${table15.length}, t1Data: $t1Data');
                      }
                    } else {
                      print('table15 is empty');
                    }

                    tableData16.clear();
                    Table16FlightInvoiceMode? m16;

                    if (table16 != null && table16.isNotEmpty) {
                      try {
                        for (int i = 0; i < table16.length; i++) {
                          final t6Data = Table16FlightInvoiceMode.fromJson(table16[i]);
                          tableData16.add(t6Data);
                          print(
                              'Index: $i, Table16 Length: ${table16.length}, t6Data: $t6Data');
                        }
                      } catch (e) {
                        print('❌ Error parsing table16 data: $e');
                      }
                    } else {
                      print('⚠️ table16 is empty or null');
                    }

                    tableData2.clear();

                    if (table2.isNotEmpty) {
                      Table2InvoiceListFlightReceiptModel m2 =
                      Table2InvoiceListFlightReceiptModel.fromJson(
                          table2[0]);

                      for (int i = 0; i < table2.length; i++) {
                        Table2InvoiceListFlightReceiptModel t1Data =
                        Table2InvoiceListFlightReceiptModel.fromJson(
                            table2[i]);
                        tableData2.add(t1Data);
                        print(
                            'Index: $i, Table2 Length: ${table2.length}, t1Data: $t1Data');
                      }
                    } else {
                      print("table2 is empty");
                    }

                    tableData18.clear();

                    if (table18.isNotEmpty) {
                      Table18FlightInvoiceModel m24 =
                      Table18FlightInvoiceModel.fromJson(table18[0]);

                      for (int i = 0; i < table18.length; i++) {
                        Table18FlightInvoiceModel t6Data =
                        Table18FlightInvoiceModel.fromJson(table18[i]);
                        tableData18.add(t6Data);
                        print(
                            'Index: $i, Table18 Length: ${table18.length}, t1Data: $t6Data');
                      }
                    } else {
                      print("table18 is empty");
                    }

                    tableData13.clear();

                    if (table13.isNotEmpty) {
                      Table13FlightInvoiceModel m13 =
                      Table13FlightInvoiceModel.fromJson(table13[0]);

                      for (int i = 0; i < table13.length; i++) {
                        Table13FlightInvoiceModel t6Data =
                        Table13FlightInvoiceModel.fromJson(table13[i]);
                        tableData13.add(t6Data);
                        print(
                            'Index: $i, Table13 Length: ${table13.length}, t6Data: $t6Data');
                      }
                    } else {
                      print("table13 is empty");
                    }

                    Table5InvoiceFlightListReceiptModel m5 =
                    Table5InvoiceFlightListReceiptModel.fromJson(table5[0]);
                    if (table5.isNotEmpty) {
                      m5 = Table5InvoiceFlightListReceiptModel.fromJson(
                          table5[0]);
                      print("fjhg" + m5.phone);
                    } else {
                      print('The list is empty.');
                    }

                    return SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          alignment: PlaceholderAlignment.middle,
                                          child: Image.asset(
                                            'assets/images/tick.png',
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                        const WidgetSpan(child: SizedBox(width: 6)),
                                        const TextSpan(
                                          text: 'Thanks, ',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: tableData2[0].passenger ?? '',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Your booking is Confirmed.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    '• We have sent your confirmation details to email address\n'
                                        '• You can now modify or cancel your booking\n'
                                        '• Get paperless confirmation when you download the app',
                                    style: TextStyle(height: 1.5),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Check Your Details',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.indigo),
                                ),
                              ),
                            ),
                            const Divider(),
                            Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  children: [
                                    _buildColonAlignedRow('Passenger',
                                        tableData2[0].passenger ?? ''),
                                    _buildColonAlignedRow('Booking Ref No',
                                        m0.bookingNumber ?? ''),
                                    _buildColonAlignedRow(
                                        'Age', tableData2[0].age.toString()),
                                    _buildColonAlignedRow(
                                        'Email', tableData2[0].tfpEmail ?? ''),
                                    _buildColonAlignedRow(
                                        'Type', tableData2[0].type ?? ''),
                                    _buildColonAlignedRow(
                                        'Gender', tableData2[0].gender ?? ''),
                                    _buildColonAlignedRow('Passenger Phone',
                                        tableData2[0].tfpPhoneNo ?? ''),
                                    _buildColonAlignedRow('Address Line1',
                                        tableData2[0].addressLine1 ?? ''),
                                    _buildColonAlignedRow('Address Line2',
                                        tableData2[0].addressLine2 ?? ''),
                                    _buildColonAlignedRow(
                                        'City', tableData2[0].city ?? ''),
                                    _buildColonAlignedRow('Country',
                                        tableData2[0].countryName ?? ''),
                                    _buildColonAlignedRow(
                                        'Status', m0.confirmStatus ?? ''),
                                    _buildColonAlignedRow('Identity',
                                        tableData2[0].tfpIdentityType ?? ''),
                                    _buildColonAlignedRow(
                                        'Is Refundable', m0.isRefundable ?? ''),
                                    _buildColonAlignedRow(
                                        'Deadline', m0.deadline ?? ''),
                                    _buildColonAlignedRow(
                                        'Trip Type', m0.tripType ?? ''),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                const Divider(),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Flight Details',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Column(
                                      children: List.generate(
                                        tableData1.length,
                                            (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                _buildAlignedInfoRow(
                                                    'GDS/LCC PNR',
                                                    tableData1[index]
                                                        .BookingNumber ??
                                                        ''),
                                                _buildAlignedInfoRow(
                                                    'Itinerary',
                                                    '${tableData1[index].tfsDepAirport} - ${tableData1[index].tfsArrAirport}'),
                                                _buildAlignedInfoRow(
                                                    'Flight No',
                                                    '${tableData1[index].tfsFlightNumber} (${tableData1[index].tfsAirline})'),
                                                _buildAlignedInfoRow(
                                                    'Segment',
                                                    tableData1[index]
                                                        .tfsFlight ??
                                                        ''),
                                                _buildAlignedInfoRow(
                                                    'Departure Time',
                                                    '${tableData1[index].tfsDepDatedt} (${tableData1[index].tfsDepTime})'),
                                                _buildAlignedInfoRow(
                                                    'Arrival Time',
                                                    '${tableData1[index].tfsArrDatedt} (${tableData1[index].tfsArrTime})'),
                                                _buildAlignedInfoRow(
                                                    'Terminal',
                                                    tableData1[index]
                                                        .tfsDepTerminal ??
                                                        ''),
                                                _buildAlignedInfoRow(
                                                    'PNR',
                                                    tableData1[index]
                                                        .BookingNumber ??
                                                        ''),
                                                _buildAlignedInfoRow(
                                                    'Class Name',
                                                    tableData1[index]
                                                        .tfsClassName ??
                                                        ''),
                                                _buildAlignedInfoRow(
                                                    'Duration',
                                                    tableData1[index]
                                                        .tfsDuration ??
                                                        ''),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(),
                                m16 != null
                                    ? Table(
                                  columnWidths: {
                                    0: IntrinsicColumnWidth(),
                                    1: FixedColumnWidth(20),
                                    2: IntrinsicColumnWidth(),
                                  },
                                  children: [
                                    _buildTableRow('Total Net Amount', m16!.currency, m16!.totalFare),
                                    _buildTableRow('Total GST ${m16!.gstPercent}%', m16!.currency, m16!.gstAmount),
                                    _buildTableRow('Total Service Tax ${m16!.serviceTaxPercent}%', m16!.currency, m16!.serviceTaxAmount),
                                    _buildTableRow('Total Discount (-)', '(-) ${m16!.currency}', m16!.discountAmount),
                                    _buildTableRow('Total Price', m16!.currency, m16!.grandTotal, isBold: true),
                                  ],
                                )
                                    : Container(), // Show nothing or an error widget

                                Divider(),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Everything Your Trips Needs,all in one place',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.indigo),
                                    ),
                                  ),
                                ),
                                const Divider(),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: List.generate(items.length, (index) {
                                      final item = items[index];
                                      return Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Icon(item['icon'], size: 40, color: Color(0xFF00ADEE)),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item['title'],
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      item['subtitle'],
                                                      style: const TextStyle(fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (item['type'] == 'flight') {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>  FlightScreen(

                                                        ),
                                                      ),
                                                    );
                                                  } else if (item['type'] == 'hotel') {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>  HotelsScreen(

                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.orange,
                                                ),
                                                child: const Text('Book Now'),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          const Divider(),
                                        ],
                                      );
                                    }),
                                  ),
                                ),

                                const Text(
                                  'This is a computer-generated Invoice and Digitally signed.',
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
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
                  return CircularProgressIndicator(
                    color: Color(0xFF00ADEE), // your custom color
                  );
                }
              }),
        ));
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              ':',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TableRow _buildTableRow(String label, dynamic Currency, dynamic value,
    {bool isBold = false}) {
  Color textColor = Colors.black;

  // ✅ Apply color based on label
  if (label.toLowerCase().contains('discount')) {
    textColor = Colors.red; // Discount row → Red
  } else if (label.toLowerCase().contains('total price')) {
    textColor = Color(0xFF00ADEE); // Total Price row → Custom color
  }

  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: isBold ? 18 : 14,
              color: textColor, // ✅ Dynamic color
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
              color: textColor, // ✅ Dynamic color
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 4, top: 6, bottom: 6),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            '$Currency $value',
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              fontSize: isBold ? 18 : 14,
              color: textColor, // ✅ Dynamic color
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _infoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(left: 0, right: 5, top: 4),
    child: Row(
      children: [
        Expanded(
          child: Text(
            '$label $value',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAlignedInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const Text(
          ":",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 6),
        Expanded(
          flex: 5,
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}

Widget _buildColonAlignedRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 15, top: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 120, maxWidth: 150),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        const Text(
          ' : ',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    ),
  );
}
