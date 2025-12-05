import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Booking/BookingCard.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'CreditBalanceApproval.dart';
import 'CreditBalanceRequest.dart';
import 'CreditRequestReceipt.dart';
import 'CreditUsageModel.dart';
import 'FundReceivedHistory.dart';
import 'FundTransfer.dart';
import 'FundTransferHistory.dart';

class CreditUsage extends StatefulWidget {
  const CreditUsage({Key? key}) : super(key: key);

  @override
  State<CreditUsage> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<CreditUsage> {
  static late String userTypeID;
  static late String userID;
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
      print("userTypeID" + userTypeID);
      print("userID" + userID);
    });
  }

  late List<dynamic> table0, table1, table4, table11;
  /* List<Table0ProfitandLossModel> tableData = [];
  List<Table1ProfitandLossModel> tableData1 = [];
  List<Table1ProfitandLossModel> tableData11 = [];
  List<Table4ProfitandLossModel> tableData4 = [];*/
  Future<String?> getInvoiceReceiptJSON() async {
    Future<http.Response>? futureLabels = ResponseHandler.performPost(
        "CreditUsageGet", "UserId=$userID&UserTypeId=$userTypeID");
    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map["Table1"];

      table4 = map["Table4"];

      log('Response: $jsonResponse');
      return jsonResponse;
    });
  }
  /* Future<String?> getLabels() async {
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
  }*/

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
              "Credit Usage",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontSize: 19),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/lojolog.png',
            width: 100,
            height: 50,
          ),

        ],
        backgroundColor:Color(0xFF00ADEE),
      ),
      body: Container(
        child: FutureBuilder<String?>(
            future: getInvoiceReceiptJSON(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                try {
                  CreditUsageModel m0 = CreditUsageModel.fromJson(table0[0]);
                  if (table0.isNotEmpty) {
                    m0 = CreditUsageModel.fromJson(table0[0]);
                    print("ffrtt5jhg" + m0.totalCredit);
                  } else {
                    print('The list is empty.');
                  }
                  log('Datagfggg: :${snapshot.data}');

                  return SingleChildScrollView(
                      child: Center(
                          child: InkWell(
                              child: PhysicalModel(
                                color: Colors.white,
                                elevation: 8,
                                shadowColor: Color(0xff9a9ce3),
                                borderRadius: BorderRadius.circular(4),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 15, left: 15),
                                        child: Text('Credit Usage',
                                            style: TextStyle(
                                                fontSize: 18, fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 15),
                                        child: Text(
                                            style: TextStyle(
                                                fontSize: 16, fontWeight: FontWeight.w500),
                                            'Status related to your Available Wallet Balance,Today Usage, Used Wallet & Total Credits'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Card(
                                              color: Color(0xff41d1d1),
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  //walletn

                                                  child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          m0.totalCredit,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 23,
                                                              fontWeight: FontWeight.w700),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Total Credit',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w500),
                                                        )
                                                      ]),

                                                  height: 120,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            child: Card(
                                              color: Color(0xff3050af),
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              child: Container(
                                                height: 120,
                                                child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        m0.creditLeft,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 23,
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Wallet Balance',
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Card(
                                              color: Color(0xffeb8899),
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  //walletn

                                                  child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          m0.usedCredit,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 23,
                                                              fontWeight: FontWeight.w700),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Used Wallet',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w500),
                                                        )
                                                      ]),

                                                  height: 120,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            child: Card(
                                              color: Color(0xffe7a236),
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              child: Container(
                                                height: 120,
                                                child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        m0.todayUsage,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 23,
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Today Usage',
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10, left: 10),
                                        child: Text('Booking Activity',
                                            style: TextStyle(
                                                fontSize: 18, fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: Text(
                                            style: TextStyle(
                                                fontSize: 16, fontWeight: FontWeight.w500),
                                            'Status related to your Available Wallet Balance,Today Usage, Used Wallet & Total Credits'),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              height: 40,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookingCard()),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  fixedSize: Size.fromHeight(55),
                                                  backgroundColor: Color(
                                                      0xFF1d5e72), // Set background color to blue
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        13.0), // Set circular shape
                                                  ),
                                                  elevation: 9.0, // Set elevation radius
                                                ),
                                                child: Text('All Bookings',
                                                    style: TextStyle(fontSize: 15)),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              height: 44,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            FundReceivedHistory()),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  fixedSize: Size.fromHeight(55),
                                                  backgroundColor: Color(
                                                      0xFF1d5e72), // Set background color to blue
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        13.0), // Set circular shape
                                                  ),
                                                  elevation: 9.0, // Set elevation radius
                                                ),
                                                child: Text('Transfer Received',
                                                    style: TextStyle(fontSize: 15)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16), // Add space between buttons
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                            Container(
                                              alignment: Alignment.topLeft,
                                              height: 44,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CreditBalanceRequest()),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  fixedSize: Size.fromHeight(55),
                                                  backgroundColor: Color(
                                                      0xFF1d5e72), // Set background color to blue
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        13.0), // Set circular shape
                                                  ),
                                                  elevation: 9.0, // Set elevation radius
                                                ),
                                                child: Text('Credit Balance Request',
                                                    style: TextStyle(fontSize: 15)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16), // Add space between buttons
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Container(
                                              alignment: Alignment.topLeft,
                                              height: 44,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CreditBalanceApproval()),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  fixedSize: Size.fromHeight(55),
                                                  backgroundColor: Color(
                                                      0xFF1d5e72), // Set background color to blue
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        13.0), // Set circular shape
                                                  ),
                                                  elevation: 9.0, // Set elevation radius
                                                ),
                                                child: Text('Balance Approval',
                                                    style: TextStyle(fontSize: 15)),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              height: 44,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BalanceReceipt()),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  fixedSize: Size.fromHeight(55),
                                                  backgroundColor: Color(
                                                      0xFF1d5e72), // Set background color to blue
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        13.0), // Set circular shape
                                                  ),
                                                  elevation: 9.0, // Set elevation radius
                                                ),
                                                child: Text('Balance Receipt',
                                                    style: TextStyle(fontSize: 15)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ))));
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
