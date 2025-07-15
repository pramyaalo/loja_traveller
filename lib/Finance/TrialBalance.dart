import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/response_handler.dart';
import 'TrailBalanceTable2model.dart';
import 'TrailbalanceTabl1Modewl.dart';

class TrialBalance extends StatefulWidget {
  const TrialBalance({Key? key}) : super(key: key);

  @override
  State<TrialBalance> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<TrialBalance> {
  late List<dynamic> table0, table1, table2;

  List<TrailbalanceTabl1Modewl> tableData = [];
  List<TrailBalanceTable2model> tableData1 = [];

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "TrialBalanceGet",
        "UserTypeId=2&UserId=1107&Period=0&fromdate=&Todate=");
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      print('jfghhjghIjsonResponsed' + jsonResponse);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map['Table1'];

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
                    "Trial Balance",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontSize: 18),
                  ),
                ],
              ),
              actions: [
                Image.asset(
                  'assets/images/lojologo.png',
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
                        TrailBalanceTable2model m10 =
                            TrailBalanceTable2model.fromJson(table1[0]);
                        if (table1.isNotEmpty) {
                          for (int i = 0; i < table1.length; i++) {
                            TrailBalanceTable2model t1Data =
                                TrailBalanceTable2model.fromJson(table1[i]);
                            tableData1.add(t1Data);
                          }
                        }

                        TrailbalanceTabl1Modewl m0 =
                            TrailbalanceTabl1Modewl.fromJson(table0[0]);
                        if (table0.isNotEmpty) {
                          m0 = TrailbalanceTabl1Modewl.fromJson(table0[0]);
                          print("ffrtt5jhg" + m0.address);
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
                                          'assets/images/lojologo.png',
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
                                          left: 10, right: 15, top: 4),
                                      child: Row(
                                        children: [
                                          Center(
                                            child: Container(
                                              width: 310,
                                              child: Text(
                                                  'Telephone:${m0.phone1}Email: ${m0.email} Website: ${m0.website}',
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
                                        child: Text('  TRIAL BALANCE:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 5, top: 10),
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
                                          Center(
                                            child: Text(
                                              '   Debit',
                                              style: (TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'Credit',
                                              style: (TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                            ),
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
                                                  Container(
                                                    width: 90,
                                                    child: Text(
                                                        '${tableData1[index].name}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15))),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                        '${tableData1[index].debit}',
                                                        style: (TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15))),
                                                  ),
                                                  Text(
                                                      '${tableData1[index].credit}',
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
