import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/response_handler.dart';
import 'Table0ProfitandLossModel.dart';
import 'Table1ProfitandLossModel.dart';
import 'Table4ProfitandLossModel.dart';

class ProfitandLoss extends StatefulWidget {
  const ProfitandLoss({Key? key}) : super(key: key);

  @override
  State<ProfitandLoss> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<ProfitandLoss> {
  late List<dynamic> table0, table1, table4, table11;
  List<Table0ProfitandLossModel> tableData = [];
  List<Table1ProfitandLossModel> tableData1 = [];
  List<Table1ProfitandLossModel> tableData11 = [];
  List<Table4ProfitandLossModel> tableData4 = [];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels1 = ResponseHandler.performPost(
        "ProfitLossGet",
        "UserTypeId=2&UserId=1107&Period=0&fromdate=&Todate=&AccountingHeadId=3");

    // Wait for the first API call to complete
    await __futureLabels1?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      print('jfghhjghIjsonResponsed' + jsonResponse);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map['Table1'];
      table4 = map['Table4'];

      return jsonResponse;
    });

    // Now make the second API call
    Future<http.Response>? __futureLabels2 = ResponseHandler.performPost(
        "ProfitLossGet",
        "UserTypeId=2&UserId=1107&Period=0&fromdate=&Todate=&AccountingHeadId=4");

    return await __futureLabels2?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      print('jfghhjghIjsonResponsed' + jsonResponse);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];

      table4 = map['Table4'];
      table11 = map['Table1'];
      return jsonResponse;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              titleSpacing: 1,
              title: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 27,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  SizedBox(width: 1), // Set the desired width
                  Text(
                    "Profit And Loss",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontSize: 17),
                  ),
                ],
              ),
              actions: [
                Image.asset(
                  'assets/images/lojolog.png',
                  width: 150,
                  height: 50,
                ),
                SizedBox(
                  width: 10,
                )
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
                        tableData1.clear();
                        Table1ProfitandLossModel m10 =
                            Table1ProfitandLossModel.fromJson(table1[0]);
                        if (table1.isNotEmpty) {
                          for (int i = 0; i < table1.length; i++) {
                            Table1ProfitandLossModel t1Data =
                                Table1ProfitandLossModel.fromJson(table1[i]);
                            tableData1.add(t1Data);
                          }
                        }

                        tableData11.clear();
                        Table1ProfitandLossModel m11 =
                            Table1ProfitandLossModel.fromJson(table11[0]);
                        if (table11.isNotEmpty) {
                          for (int i = 0; i < table11.length; i++) {
                            Table1ProfitandLossModel t1Data =
                                Table1ProfitandLossModel.fromJson(table11[i]);
                            tableData11.add(t1Data);
                          }
                        }

                        Table4ProfitandLossModel m4 =
                            Table4ProfitandLossModel.fromJson(table4[0]);
                        if (table4.isNotEmpty) {
                          m4 = Table4ProfitandLossModel.fromJson(table4[0]);
                          print("ffrtt5jhg" + m4.profit);
                        } else {
                          print('The list is empty.');
                        }

                        Table0ProfitandLossModel m0 =
                            Table0ProfitandLossModel.fromJson(table0[0]);
                        if (table0.isNotEmpty) {
                          m0 = Table0ProfitandLossModel.fromJson(table0[0]);
                          print("ffrtt5jhg" + m0.mainCompanyName);
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
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 5, top: 7),
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: TextField(
                                            onTap: () {
                                              chooseDate();
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'From date',
                                              prefixIcon: GestureDetector(
                                                onTap: () {
                                                  chooseDate();
                                                },
                                                child: Image.asset(
                                                  'assets/images/calendar.png',
                                                  cacheWidth: 25,
                                                  cacheHeight: 25,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 5),
                                            ),
                                            readOnly: true,
                                            controller: dateController,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 10, top: 7),
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: TextField(
                                            onTap: () {
                                              chooseDate();
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'To date',
                                              prefixIcon: GestureDetector(
                                                onTap: () {
                                                  chooseDate();
                                                },
                                                child: Image.asset(
                                                  'assets/images/calendar.png',
                                                  cacheWidth: 25,
                                                  cacheHeight: 25,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 5),
                                            ),
                                            readOnly: true,
                                            controller: dateController,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                          'assets/images/lojolog.png',
                                          width: 200,
                                          height: 50),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 15, top: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 310,
                                            child: Text(
                                              m0.address,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 15, top: 2),
                                      child: Row(
                                        children: [
                                          Center(
                                            child: Container(
                                              width: 310,
                                              child: Text(
                                                  'Telephone:${m0.phone1}, Email: ${m0.email}, Website: ${m0.website}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 3, left: 3),
                                      child: Divider(
                                        color: Colors.black,
                                        height: 2,
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 3, left: 3),
                                      child: Container(
                                        height: 40,
                                        color: Colors.black26,
                                        alignment: Alignment.centerLeft,
                                        child: Text('   PROFIT AND LOSS:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 10),
                                        child: Text('INCOME',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
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
                                          Text('Particulars',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            'Amount',
                                            style: (TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: List.generate(
                                        tableData1.length,
                                        (index) => Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 15, top: 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      '${tableData1[index].name}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text(
                                                      '${tableData1[index].amount}',
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
                                                  Text('TOTAL INCOME',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16))),
                                                  Text(
                                                    '${tableData1[index].amount}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 10),
                                        child: Text('EXPENSE',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
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
                                          Text('Particulars',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            'Amount',
                                            style: (TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: List.generate(
                                        tableData11.length,
                                        (index) => Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 15, top: 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      '${tableData11[index].name}',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15))),
                                                  Text(
                                                      '${tableData11[index].amount}',
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
                                                  Text('TOTAL EXPENSE',
                                                      style: (TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16))),
                                                  Text(
                                                    '${tableData11[index].amount}',
                                                    style: (TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 3,
                                          left: 3,
                                          top: 10,
                                          bottom: 6),
                                      child: Divider(
                                        color: Colors.black,
                                        thickness: 1,
                                        height: 0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 15, top: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('PROFIT & LOSS',
                                              style: (TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17))),
                                          Text(
                                            m4.profit,
                                            style: (TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                          ),
                                        ],
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
                      return CircularProgressIndicator();
                    }
                  }),
            )));
  }
}
