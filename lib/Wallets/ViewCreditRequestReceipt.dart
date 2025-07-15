import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Finance/CorporateInformationTable5.dart';
import '../Finance/CorporateTable4.dart';
import '../Finance/PaymentMethodTable7.dart';
import '../Finance/ProductAccessTble2.dart';
import '../Models/ViewSubAgencyModel.dart';
import '../utils/response_handler.dart';
import 'ViewCreditBalanceRequestModel.dart';
import 'ViewCreditRequestReceiptModel.dart';

class ViewCreditRequestReceipt extends StatefulWidget {
  final String Id;

  ViewCreditRequestReceipt({required this.Id});
  @override
  _MyRechargePageState createState() => _MyRechargePageState();
}

class _MyRechargePageState extends State<ViewCreditRequestReceipt> {
  String checkboxStatus = "0";
  String checkboxStatus1 = "0";
  String productAccessBusName = "",
      productAccessCarName = "",
      productAccessFlightName = "",
      productAccessHolidayName = "",
      productAccessHotelName = "";
  List<ProductAccess> table1Data = [];
  List<CorporateLogo> table2Data = [];
  List<CorporateInformation> table3Data = [];
  List<PaymentMethod> table4Data = [];

  bool isIssueTicketChecked = false;
  bool isCancelBookingChecked = false;
  late List<dynamic> table0, table1, table2, table4, table6, table7;

  String datePart = '';
  String? subAgencyId;

  @override
  void initState() {
    super.initState();
    loadSubAgencyId();
  }

  Future<String?> getSubAgencyId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('subAgencyId');
  }

  Future<void> loadSubAgencyId() async {
    String? id = await getSubAgencyId();
    setState(() {
      subAgencyId = id;
      print('subid' + subAgencyId!);
    });
  }

  Future<List<ViewCreditRequestReceiptModel>?>
  getFlightTicketOrderQueue() async {
    String SubAgencyId = '';
    List<ViewCreditRequestReceiptModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "CreditBalanceReceiptViewGet", "ManageDepositId=${widget.Id}");
    log("iddddddffg" + widget.Id);
    return await __futureLabels?.then((value) async {
      String jsonResponse = ResponseHandler.parseData(value.body);

      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          ViewCreditRequestReceiptModel lm =
          ViewCreditRequestReceiptModel.fromJson(list[i]);
          bookingCardData.add(lm);
        }
      } catch (error) {
        // Fluttertoast.showToast(msg: error.toString());
      }
      return bookingCardData;
    });
  }

  late Tableee2 t1Data;
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
                "View Receipt",
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
          child: FutureBuilder<List<ViewCreditRequestReceiptModel>?>(
              future: getFlightTicketOrderQueue(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(left: 9, right: 9, top: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 1.0, // Border width
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  8.0)), // Optional: Add rounded corners
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: <Widget>[
                                        Align(
                                          alignment:
                                          AlignmentDirectional.topStart,
                                          child: Text(
                                            "    Customer Type",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.topEnd,
                                          child: Center(
                                            child: Text("     : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                            AlignmentDirectional.topStart,
                                            child: Text(
                                              snapshot.data![index].userType,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Align(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          child: Text(
                                            "    Customer Name",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.center,
                                          child: Center(
                                            child: Text("  : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              snapshot.data![index].name,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Align(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          child: Text(
                                            "    Payment Mode",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.center,
                                          child: Center(
                                            child: Text("    : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              snapshot.data![index].paymentMode,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Align(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          child: Text(
                                            "    Payment Date",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.center,
                                          child: Center(
                                            child: Text("       : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              snapshot.data![index].dateCreated,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Align(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          child: Text(
                                            "    AddressLine1",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.center,
                                          child: Center(
                                            child: Text("       : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              snapshot.data![index].add1,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Align(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          child: Text(
                                            "    AddressLine2",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.center,
                                          child: Center(
                                            child: Text("       : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              snapshot.data![index].add2,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Align(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          child: Text(
                                            "    Authorized By",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.center,
                                          child: Center(
                                            child: Text("      : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              snapshot
                                                  .data![index].authorizedName,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Align(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          child: Text(
                                            "    City",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(
                                                "                          : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              snapshot.data![index].city,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Align(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          child: Text(
                                            "    Phone Number",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.center,
                                          child: Center(
                                            child: Text("    : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              snapshot.data![index].phone,
                                              /*  m0.status == "1"
                                                  ? "Active"
                                                  : "InActive",*/
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Align(
                                      alignment:
                                      AlignmentDirectional.centerStart,
                                      child: Text(
                                        "    Booking Ref",
                                        style: const TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional.center,
                                      child: Center(
                                        child: Text("           : "),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment:
                                        AlignmentDirectional.centerStart,
                                        child: Text(
                                          snapshot.data![index].manageDepositId,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  children: <Widget>[
                                    Align(
                                      alignment:
                                      AlignmentDirectional.centerStart,
                                      child: Text(
                                        "    Deposit Amount",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional.center,
                                      child: Center(
                                        child: Text(" : "),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment:
                                        AlignmentDirectional.centerStart,
                                        child: Text(snapshot.data![index].currencyCode+
                                            snapshot.data![index].depositAmount,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}

Widget buildCheckbox(String label, bool value, Function(bool?) onChanged) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3.0), // Adjust the bottom padding
    child: Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(label),
      ],
    ),
  );
}
