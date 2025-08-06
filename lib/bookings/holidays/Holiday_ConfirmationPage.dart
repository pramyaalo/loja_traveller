import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Booking/Table0HotelModel.dart';
import '../../Booking/Table10HotelInvoiceTotalModel.dart';
import '../../Booking/Table12hotelRemitanceModeldub.dart';
import '../../Booking/Table1HotelModel.dart';
import '../../Booking/Table2HotelModel.dart';
import '../../Booking/Table3InvoiceHotelreceiptModel.dart';
import '../../Booking/Table4HotelModel.dart';
import '../../Booking/Table5HotelPaymentDetailsModel.dart';
import '../../Booking/Table6HotemModel.dart';
import '../../Booking/Table7InvoiceListHotelModel.dart';
import '../../Booking/Table9InvoiceListHotelModel.dart';
import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';
import '../flight/flight_screen.dart';
import '../hotels/Table2HotelDetailsModel.dart';
import '../hotels/Table6HotelModel.dart';
import '../hotels/hotels_screen.dart';
 

class Holiday_ConfirmationPage extends StatefulWidget {
  final String bookingId;

  const Holiday_ConfirmationPage(
      {super.key,
        required this.bookingId, });

  @override
  State<Holiday_ConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<Holiday_ConfirmationPage> {

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
  List<Table6HotelModel>tableData6=[];

  List<Table12hotelRemitanceModeldub>tableData12=[];
  List<Table1HotelModel>tableData1=[];
  List<Table2HotelModel>tableData2=[];
  List<Table3InvoiceHotelreceiptModel>tableData3=[];
  List<Table4HotelModel>tableData4=[];
  List<Table5HotelPaymentDetailsModel>tableData5=[];
  List<Table10HotelInvoiceTotalModel>tableData10=[];
  List<Table2HotelDetailsModel> table2Data = [];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "RecHolidayInvoice", "BookId=${widget.bookingId}");
    print('jfghhjghId' + widget.bookingId);
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
                "Holiday Confirmation",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Montserrat",
                    fontSize: 18),
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
                            'Index: $i, Tabledgfeyt4 Length: ${table4
                                .length}, t1Data: $t1Data');
                      }
                    }
                    table2Data.clear();
                    if (table2.isNotEmpty) {
                      Table2HotelDetailsModel m1 =
                      Table2HotelDetailsModel.fromJson(table2[0]);
                      for (int i = 0; i < table2.length; i++) {
                        Table2HotelDetailsModel t1Data =
                        Table2HotelDetailsModel.fromJson(table2[i]);
                        table2Data.add(t1Data);
                        print(
                            'Index: $i, Tablfhfyje4 Length: ${table2.length}, t1Data: $t1Data');
                      }
                    }

                    tableData5.clear();
                    Table5HotelPaymentDetailsModel m5 =
                    Table5HotelPaymentDetailsModel.fromJson(table5[0]);
                    if (table5.isNotEmpty) {
                      for (int i = 0; i < table5.length; i++) {
                        Table5HotelPaymentDetailsModel t1Data =
                        Table5HotelPaymentDetailsModel.fromJson(table5[i]);
                        tableData5.add(t1Data);
                        print(
                            'Index: $i, Tablsdde4 Length: ${table5
                                .length}, t1Data: $t1Data');
                      }
                    }
                    //
                    tableData6.clear();
                    Table6HotelModel m9 =
                    Table6HotelModel.fromJson(table6[0]);
                    if (table6.isNotEmpty) {
                      for (int i = 0; i < table6.length; i++) {
                        Table6HotelModel t1Data =
                        Table6HotelModel.fromJson(table6[i]);
                        tableData6.add(t1Data);
                        print(
                            'Index: $i, Table4 Length: ${table6.length}, t1Data: $t1Data');
                      }
                    }
                    tableData7.clear();

                    if (table7.isNotEmpty) {
                      Table7InvoiceListHotelModel m7 = Table7InvoiceListHotelModel.fromJson(table7[0]);

                      for (int i = 0; i < table7.length; i++) {
                        Table7InvoiceListHotelModel t1Data =
                        Table7InvoiceListHotelModel.fromJson(table7[i]);
                        tableData7.add(t1Data);
                        print('Index: $i, Table7 Length: ${table7.length}, t1Data: $t1Data');
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

                    tableData10.clear();
                    Table10HotelInvoiceTotalModel m10 =
                    Table10HotelInvoiceTotalModel.fromJson(
                        table10[0]);
                    if (table10.isNotEmpty) {
                      for (int i = 0; i < table10.length; i++) {
                        Table10HotelInvoiceTotalModel t1Data =
                        Table10HotelInvoiceTotalModel.fromJson(
                            table10[i]);
                        tableData10.add(t1Data);
                        print(
                            'Index: $i, fsdfssfd ${table10.length}, t1Data: $t1Data');
                      }
                    }
                    Table6HotemModel m6 =
                    Table6HotemModel.fromJson(table6[0]);

                    tableData12.clear();
                    Table12hotelRemitanceModeldub m12 =
                    Table12hotelRemitanceModeldub.fromJson(table12[0]);
                    if (table12.isNotEmpty) {
                      for (int i = 0; i < table12.length; i++) {
                        Table12hotelRemitanceModeldub t6Data =
                        Table12hotelRemitanceModeldub.fromJson(
                            table12[i]);
                        tableData12.add(t6Data);
                        print(
                            'Index: $i, Table4 Length: ${table12.length}, t1Data: $t6Data');
                      }
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
                                mainAxisAlignment: MainAxisAlignment.start, // Aligns tick + text to the start
                                children: [
                                  Image.asset(
                                    'assets/images/tick.png', // ✅ Make sure this path matches your assets
                                    width: 50,
                                    height: 50,
                                  ),
                                  const SizedBox(width: 2), // spacing between icon and text
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        const TextSpan(text: 'Thanks, '),
                                        TextSpan(
                                          text: '${m1.passenger}' ?? '',
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
                                        m1.passenger ?? ''),
                                    _buildColonAlignedRow('Booking Ref No',
                                        m1.bookingNumber ?? ''),
                                    _buildColonAlignedRow(
                                        'Age', m4.age),
                                    _buildColonAlignedRow(
                                        'Email', m4.tfpEmail ?? ''),
                                    _buildColonAlignedRow(
                                        'Type', m4.type ?? ''),
                                    _buildColonAlignedRow(
                                        'Gender', m4.gender ?? ''),
                                    _buildColonAlignedRow('Passenger Phone',
                                        m4.tfpPhoneNo?? ''),
                                    _buildColonAlignedRow('Address',
                                        m4.address ?? ''),
                                    _buildColonAlignedRow('State',
                                        m4.state ?? ''),
                                    _buildColonAlignedRow(
                                        'City', m4.city ?? ''),
                                    _buildColonAlignedRow('Country',
                                        m4.countryName ?? ''),
                                    _buildColonAlignedRow(
                                        'Status', m1.confirmStatus ?? ''),

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
                                      'Hotel Details',
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
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: List.generate(
                                      table2Data.length,
                                          (index) => Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Column(
                                          children: [
                                            _buildColonAlignedRow("Hotel Name", table2Data[index].hotelName),
                                            _buildColonAlignedRow("Room Type", table2Data[index].roomType),
                                            _buildColonAlignedRow("CheckIn", table2Data[index].checkInDt),
                                            _buildColonAlignedRow("Voucher Number", table2Data[index].thhBookFlightId.toString()),
                                            _buildColonAlignedRow("Check Out", table2Data[index].checkOutDt),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Divider(),
                                Table(
                                  columnWidths: {
                                    0: IntrinsicColumnWidth(), // Label Column
                                    1: FixedColumnWidth(20), // Colon Column
                                    2: IntrinsicColumnWidth(), // Value Column
                                  },
                                  children: [
                                    _buildTableRow('Total Net Amount',
                                        m10.currency, m10.totalFare),
                                    _buildTableRow(
                                        'Total GST' +
                                            " " +
                                            m10.gstPercent +
                                            "%",
                                        m10.currency,
                                        m10.serviceTaxAmount),
                                    _buildTableRow(
                                        'Total Service Tax' +
                                            m10.serviceTaxPercent +
                                            "%",
                                        m10.currency,
                                        m10.serviceTaxAmount),

                                    _buildTableRow('Total Price',
                                        m10.currency, m10.grandTotal,
                                        isBold: true),
                                  ],
                                ),
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
                                              Icon(item['icon'], size: 40, color: Colors.blue),
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
                                                        builder: (context) =>   HotelsScreen(

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

                                        ],
                                      );
                                    }),
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Terms and Conditions',
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
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    m6.hotelNorms,
                                    style: const TextStyle(fontSize: 12),
                                  ),
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
                    color: Color(0xFF1C5870), // your custom color
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
    textColor = Color(0xFF1C5870); // Total Price row → Custom color
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
Widget _buildAlignedRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Align(
            alignment: Alignment.centerLeft, // 👈 Right-align label
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8), // 👈 Space between colon and value
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
  );
}

