import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Models/HolidayPassengerModel.dart';
import '../utils/response_handler.dart';
import 'BookedItemViewModel.dart';
import 'BookingCancelScreen.dart';
import 'CancelBookingListModel.dart';
import 'PassengerModel.dart';
import 'PaymentModel.dart';
import 'Table28FlightCancellationModel.dart';

class CancellationRequestDetails extends StatefulWidget {
  final id;
  CancellationRequestDetails({super.key, required this.id});
  @override
  State<CancellationRequestDetails> createState() =>
      _CancellationRequestDetailsState();
}

class _CancellationRequestDetailsState
    extends State<CancellationRequestDetails> {
  String _userImage = '';
  String selectedAccountType = 'Select Payment Mode';

  var accountTypes = [
    'Select Payment Mode',
    'Cash',
    'Cheque',
    'Credit Cards',
    'Debit Cards',
    'Electronic Bank Transfers',
    'Mobile Payments'
  ];

  static String savedId = '';

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
      table16,
      table18,
      table19,
      table22,
      table23,
      table24,
      table34,
      table39,
      table40,
      table20,
      table21,
      table28;
  //table28
  List<BookedItemViewModel> tableData = [];
  List<PaymentModel> table34Data = [];
  List<Table28FlightCancellationModel> table28Data = [];
  List<HolidayPassengerModel> table18Data = [];
  var selectedDate = DateTime.now().obs;
  TextEditingController dateController = TextEditingController();
  void chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1800),
      lastDate: DateTime(2024),
      helpText: 'Select DOB',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter a valid date',
      errorInvalidText: 'Enter a valid date range',
      fieldLabelText: 'DOB',
      fieldHintText: 'Month/Date/Year',
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }




  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "BookingCardViewGet", "BookFlightId=${widget.id}&StaffId=0");
    print('jfghhjgh' + savedId);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);

      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table2 = map["Table2"];
      table8 = map['Table8'];
      table5 = map["Table5"];
      table10 = map["Table10"];
      table13 = map["Table13"];
      table20 = map["Table20"];
      table18 = map['Table18'];
      table28=map["Table28"];
      return jsonResponse;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(alignment: Alignment.topLeft,
        child: FutureBuilder<String?>(
            future: getLabels(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                try {
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
                  table28Data.clear();
                  if (table28.isNotEmpty) {
                    Table28FlightCancellationModel m2 = Table28FlightCancellationModel.fromJson(table28[0]);
                    for (int i = 0; i < table28.length; i++) {
                      Table28FlightCancellationModel t2Data =
                      Table28FlightCancellationModel.fromJson(table28[i]);
                      table28Data.add(t2Data);
                      print(
                          'Index: $i, Table4 Length: ${table28.length}, t1Data: $t2Data');
                    }
                  }


                  table18Data.clear();
                  if (table18.isNotEmpty) {
                    HolidayPassengerModel m16 =
                    HolidayPassengerModel.fromJson(table18[0]);

                    for (int i = 0; i < table18.length; i++) {
                      HolidayPassengerModel t18Data =
                      HolidayPassengerModel.fromJson(table18[i]);
                      table18Data.add(t18Data);
                      print(
                          'Index: $i, Table16 Length: ${table18.length}, t1Data: $t18Data');
                    }
                  }

                  /* table32Data.clear();
                  if (table32.isNotEmpty) {
                    ReceivedPaymentModel m16 =
                        ReceivedPaymentModel.fromJson(table32[0]);

                    for (int i = 0; i < table32.length; i++) {
                      ReceivedPaymentModel t20Data =
                          ReceivedPaymentModel.fromJson(table32[i]);
                      table32Data.add(t20Data);
                    }
                    print('Table32 Length: ${table32.length} ');
                  }
                  table33Data.clear();
                  if (table33.isNotEmpty) {
                    PartPaymentTransactionModel m16 =
                        PartPaymentTransactionModel.fromJson(table33[0]);

                    for (int i = 0; i < table33.length; i++) {
                      PartPaymentTransactionModel t20Data =
                          PartPaymentTransactionModel.fromJson(table33[i]);
                      table33Data.add(t20Data);
                    }
                    print('Table32 Length: ${table33.length} ');
                  }
                  table34Data.clear();
                  if (table34.isNotEmpty) {
                    BalancePaymentTransactionModel m16 =
                        BalancePaymentTransactionModel.fromJson(table34[0]);

                    for (int i = 0; i < table34.length; i++) {
                      BalancePaymentTransactionModel t20Data =
                          BalancePaymentTransactionModel.fromJson(table34[i]);
                      table34Data.add(t20Data);
                    }
                    print('Table32 Length: ${table34.length} ');
                  }
                  table35Data.clear();
                  if (table35.isNotEmpty) {
                    RefundPaymentModel m16 =
                        RefundPaymentModel.fromJson(table35[0]);

                    for (int i = 0; i < table35.length; i++) {
                      RefundPaymentModel t20Data =
                          RefundPaymentModel.fromJson(table35[i]);
                      table35Data.add(t20Data);
                    }
                    print('Table32 Length: ${table35.length} ');
                  }*/
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /*      ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AllocatePaymentScreen(id: widget.id,),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black, backgroundColor: Colors.yellow,
                                    side: BorderSide(
                                        color: Colors.yellow, width: 1),
                                    minimumSize: Size(150, 40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            4)) // Adjust the size as needed
                                ),
                                child: Text('Allocate Payment',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),*/
                              ElevatedButton(
                                onPressed: () {
                                  // Add your onPressed logic here
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black, backgroundColor: Colors.yellow,
                                    side: BorderSide(
                                        color: Colors.yellow, width: 1),
                                    minimumSize: Size(150, 40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            4)) // Adjust the size as needed
                                ),
                                child: Text('Cancellation Details',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Column(
                              children: List.generate(
                                  table28Data.length,
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
                                            Text(
                                                'Request Number: ' +
                                                    "${table28Data[index].requestNumber}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 5, top: 4),
                                        child: Row(
                                          children: [
                                            Text(
                                                'Request: ' +
                                                    "${table28Data[index].request}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 5, top: 4),
                                        child: Row(
                                          children: [
                                            Text(
                                                'Status: ' +
                                                    "${table28Data[index].requestStatus}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w500)),
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
                            width: MediaQuery.of(context).size.width - 5,
                            height: 0.2,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 5,
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
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
