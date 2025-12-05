import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';

import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'CreditBalanceRequest.dart';

class AddCreditBalanceRequest extends StatefulWidget {
  const AddCreditBalanceRequest({Key? key}) : super(key: key);

  @override
  State<AddCreditBalanceRequest> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<AddCreditBalanceRequest> {
  final TextEditingController DepositAmountController = TextEditingController();
  final TextEditingController _TransactionNumber = TextEditingController();
  final TextEditingController AccountNumber = TextEditingController();
  final TextEditingController IssuedBankName = TextEditingController();
  TextEditingController IssuedateController=TextEditingController();
  final TextEditingController IssuedBanchName = TextEditingController();
  final TextEditingController Remarks = TextEditingController();
  static late String userTypeID;
  static late String userID;
  static late String Currency;
  String formattedDate = '';
  @override
  void initState() {
    super.initState();
    _retrieveSavedValues();
  }

  DateTime selectedDate = DateTime.now();


  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
      print("userTypeID" + userTypeID);
      print("userID" + userID);
      print("Curren565cy" + Currency);
      fetchCustomerTypes();

    });
  }
  List<Map<String, dynamic>> customerTypes = [];
  String selectedCustomerTypeName = '';
  String selectedCustomerTypeId = '';

  List<Map<String, dynamic>> dropdownItems = [];
  String selectedDropdownId = '';  // <-- ID to send to API
  String selectedDropdownName = '';
  Future<void> fetchCustomerTypes() async {
    final String apiUrl =
        "https://traveldemo.org/travelapp/traveller.asmx/Wallet_GetUserType";

    final Map<String, dynamic> parameters = {
      "UserTypeId": userTypeID,
      "UserId":userID,
      "UID": "35510b94-5476-TDemoTraveller-a2e3-2e9779",
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      if (response.statusCode == 200) {
        final xmlDoc = XmlDocument.parse(response.body);
        final jsonString = xmlDoc.rootElement.text;
        final data = json.decode(jsonString);

        if (data['Table'] != null) {
          final List<Map<String, dynamic>> fetchedList =
          List<Map<String, dynamic>>.from(data['Table']);

          // Filter out "-- Select --"
          final filteredList = fetchedList.where((item) => item['Id'] != 0).toList();

          if (filteredList.isNotEmpty) {
            // Pick the first item
            final defaultItem = filteredList[0];

            setState(() {
              customerTypes = filteredList;
              selectedCustomerTypeId = defaultItem['Id'].toString();
              selectedCustomerTypeName = defaultItem['Name'].toString();
            });
            selectedCurrencyCode=null;
            selectedCurrencyId=null;
            fetchDropdownData();
            print("Selected ID: $selectedCustomerTypeId");
            print("Selected Name: $selectedCustomerTypeName");
          }
        }
      } else {
        print("Failed to fetcSDASDAh data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> fetchDropdownData() async {
    final String apiUrl =
        "https://traveldemo.org/travelapp/traveller.asmx/Wallet_SearchAutoComplete";

    final Map<String, dynamic> parameters = {
      "SerUserTypeId": selectedCustomerTypeId,
      "UserId": userID,
      "UserTypeId": userTypeID,
      "Name":'',
      "UID": "35510b94-5476-TDemoTraveller-a2e3-2e9779",
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      if (response.statusCode == 200) {
        final xmlDoc = XmlDocument.parse(response.body);
        final jsonString = xmlDoc.rootElement.text;

        final data = json.decode(jsonString);

        if (data['Table'] != null && data['Table'].isNotEmpty) {
          final List<Map<String, dynamic>> fetchedItems =
          List<Map<String, dynamic>>.from(data['Table']);

          setState(() {
            dropdownItems = fetchedItems;

            // ✅ Auto-select the first item
            selectedDropdownId = fetchedItems[0]['Id'].toString();
            selectedDropdownName = fetchedItems[0]['Name'].toString();
            selectedCurrencyId=null;
            selectedCurrencyCode=null;
            fetchCurrencyCodes();
            print("Selected default ID: $selectedDropdownId");
          });

        }
      } else {
        print("Failed to fetch data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  String displayText = 'Customer (CUS)';
  String? PaymentMode;
  String? paymentModeToSend;
  List<String> options = ['Website', 'Bank'];
  // Selected option name
  String? selectedOptionName;
  // Selected option ID to send as String
  String? selectedOptionId;
  String? PaymentType;
  String? paymentTypeToSend;


  Future<http.Response>? __futureLogin;
  DateTime? checkInDate;
  String? selectedCurrencyCode;
  int? selectedCurrencyId;
  List<Map<String, dynamic>> currencyList = [];
  Future<void> fetchCurrencyCodes() async {
    final String apiUrl = "https://traveldemo.org/travelapp/b2c.asmx/GetBalanceCurrency";
    final Map<String, dynamic> parameters = {
      "UserTypeId": selectedCustomerTypeId,
      "UserId": selectedDropdownId,
      "UID": "35510b94-5342-TDemoB2C-a2e3-2e722772",
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      if (response.statusCode == 200) {
        final xmlDoc = XmlDocument.parse(response.body);
        final jsonString = xmlDoc.rootElement.text;
        final data = json.decode(jsonString);

        if (data['Table'] != null) {
          List<Map<String, dynamic>> fetchedCurrencies = List<Map<String, dynamic>>.from(data['Table']);

          setState(() {
            currencyList = fetchedCurrencies;
          });
        }
      } else {
        print("Failed to fetch data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
  Future<void> getFlightTicketOrderQueue() async {
    String SubAgencyId = '';
  }
  /* static Future<List<CreditBalanceApprovaalModel>?> getLabels() async {
      List<CreditBalanceApprovaalModel> labelData = [];
      Future<http.Response>? futureLabels = ResponseHandler.performPost(
          "CreditBalanceApprovalGet", "UserId=0&UserTypeId=2&TransactionNo=0");

      return await futureLabels.then((value) {
        String jsonResponse = ResponseHandler.parseData(value.body);
        log('hjgfhjyfgjhyg' + jsonResponse);
        try {
          Map<String, dynamic> map = json.decode(jsonResponse);
          List<dynamic> list = map["Table"];
          for (int i = 0; i < list.length; i++) {
            CreditBalanceApprovaalModel lm =
                CreditBalanceApprovaalModel.fromJson(list[i]);
            labelData.add(lm);
          }
        } catch (error) {}
        return labelData;
      });
    }*/

  Future<void> saveSubAgencyId(String subAgencyId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('subAgencyId', subAgencyId);
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
              "Add Balance",
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        'Customer Type',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),

                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1), // 👈 Border color and width
                        borderRadius: BorderRadius.circular(8), // 👈 Rounded corners
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCustomerTypeId.isNotEmpty ? selectedCustomerTypeId : null,
                          hint: Text("Select Customer Type"),
                          isExpanded: true,
                          items: customerTypes.map((item) {
                            return DropdownMenuItem<String>(
                              value: item['Id'].toString(),
                              child: Text(item['Name'].toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCustomerTypeId = value!;

                              selectedCustomerTypeName = customerTypes
                                  .firstWhere((item) => item['Id'].toString() == value)['Name']
                                  .toString();

                              print("Selected ID: $selectedCustomerTypeId");
                              print("Selected Name: $selectedCustomerTypeName");
                              selectedCurrencyCode=null;
                              selectedCurrencyId=null;
                              fetchDropdownData();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "    Customer Name",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 48, // ✅ Consistent height
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedDropdownId.isNotEmpty ? selectedDropdownId : null,
                          isExpanded: true,
                          isDense: true, // ✅ Compact layout for consistency
                          style: const TextStyle(fontSize: 16, color: Colors.black), // ✅ Optional: Text styling
                          hint: const Text("Select Option"), // Optional: Set a default hint if needed
                          items: dropdownItems.map((item) {
                            return DropdownMenuItem<String>(
                              value: item['Id'].toString(),
                              child: Text(item['Name'].toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDropdownId = value!;
                              selectedDropdownName = dropdownItems
                                  .firstWhere((item) => item['Id'].toString() == value)['Name']
                                  .toString();
                              selectedCurrencyCode=null;
                              selectedCurrencyId=null;
                              fetchCurrencyCodes();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        'Payment Mode:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      height: 45,
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: Container(),
                        value: PaymentMode,
                        hint: Text('Select Payment Mode'), // Optional hint
                        items: [
                          'All',
                          'Bank',
                          'Online',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            PaymentMode = value;

                            // Map PaymentMode to number for API
                            if (PaymentMode == 'All') {
                              paymentModeToSend = "0";
                            } else if (PaymentMode == 'Bank') {
                              paymentModeToSend = "1";
                            } else if (PaymentMode == 'Online') {
                              paymentModeToSend = "2";
                            }

                            print("Selected Payment Mode: $PaymentMode");
                            print("Payment Mode to Send: $paymentModeToSend");
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        'Payment Type:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      height: 45,
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: Container(),
                        value: PaymentType,
                        hint: Text('Select Payment Type'),
                        items: [
                          'Select Payment Type',
                          'Cash',
                          'Cheque',
                          'Credit Cards',
                          'Debit Cards',
                          'Electronic Bank transfers',
                          'Mobile Payments',
                          'Pix Payment',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            PaymentType = value!;

                            // Map PaymentType to number for API
                            if (PaymentType == 'Select Payment Type') {

                            } else if (PaymentType == 'Cash') {
                              paymentTypeToSend = "1";
                            } else if (PaymentType == 'Cheque') {
                              paymentTypeToSend = "2";
                            } else if (PaymentType == 'Credit Cards') {
                              paymentTypeToSend = "3";
                            } else if (PaymentType == 'Debit Cards') {
                              paymentTypeToSend = "4";
                            } else if (PaymentType == 'Electronic Bank transfers') {
                              paymentTypeToSend = "5";
                            } else if (PaymentType == 'Mobile Payments') {
                              paymentTypeToSend = "6";
                            }
                            else if (PaymentType == 'Pix Payment') {
                              paymentTypeToSend = "7";
                            }

                            print("Selected Payment Type: $PaymentType");
                            print("Payment Type ID to Send: $paymentTypeToSend");
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Currency",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5,
                        right: 5,top: 10
                    ),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedCurrencyCode,
                        hint: Text('Select Currency'), // <-- Show hint
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        items: currencyList.map((currency) {
                          return DropdownMenuItem<String>(
                            value: currency['CurrencyCode'],
                            child: Text(currency['CurrencyCode']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCurrencyCode = value;
                            selectedCurrencyId = currencyList.firstWhere((element) => element['CurrencyCode'] == value)['Id'];
                          });

                          print("Selected Currency Code: $selectedCurrencyCode");
                          print("Selected Currency ID: $selectedCurrencyId");
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        'Deposit Amount:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: DepositAmountController,
                        style: TextStyle(),
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.black, // Set the border color
                              width: 2.0, // Set the border width
                            ),
                          ),
                          hintText: 'Enter Deposit Amount',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        'Authorized By:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 0),
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: Container(),
                        value: selectedOptionName,
                        hint: Text('Select Option'),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedOptionName = newValue!;

                            // Set ID based on selected name
                            if (selectedOptionName == 'Website') {
                              selectedOptionId = "1000";
                            } else if (selectedOptionName == 'Bank') {
                              selectedOptionId = "1001";
                            }

                            print("Selected Option Name: $selectedOptionName");
                            print("Selected Option ID to send: $selectedOptionId"); // You will send this in API
                          });
                        },
                        items: options.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(option),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        'Transaction Number:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: _TransactionNumber,
                        style: TextStyle(),
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.black, // Set the border color
                              width: 2.0, // Set the border width
                            ),
                          ),
                          hintText: 'Enter Transaction Number',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        'Account Number:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: AccountNumber,
                        style: TextStyle(),
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.black, // Set the border color
                              width: 2.0, // Set the border width
                            ),
                          ),
                          hintText: 'Enter Account Number',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        'Issued Bank Name:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: IssuedBankName,
                        style: TextStyle(),
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.black, // Set the border color
                              width: 2.0, // Set the border width
                            ),
                          ),
                          hintText: 'Enter Issued Bank Name',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        'Issued Branch Name:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: IssuedBanchName,
                        style: TextStyle(),
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.black, // Set the border color
                              width: 2.0, // Set the border width
                            ),
                          ),
                          hintText: 'Enter Issued Branch Name',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        'Issue Date:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
                    child: TextFormField(
                      controller: IssuedateController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), // Default to current date
                          firstDate: DateTime(1900), // Allow selection from the year 1900
                          lastDate: DateTime(2100), // Allow selection up to the year 2100 (or any future date)
                        );

                        if (pickedDate != null) {
                          // Format: 25 April, 2025
                          String formattedDate = DateFormat("d MMMM, y").format(pickedDate);
                          IssuedateController.text = formattedDate;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Issue Date',
                        prefixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        'Remarks:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 0),
                    child: Container(
                      height: 160,
                      padding: EdgeInsets.only(left: 0, right: 0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        controller: Remarks,
                        decoration: InputDecoration(
                          hintText: '  Remarks',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity, // Full width
                    height: 50, // Button height
                    child: ElevatedButton(
                      onPressed: () {
                        String apiUrl = "CreditBalanceRequestSet";


                        Map<String, String> apiParams = {
                          "ManageDepositId": "0",
                          "UserId":selectedDropdownId,
                          "UserTypeId": selectedCustomerTypeId,
                          "PaymentModeId": paymentModeToSend.toString(),
                          "PaymentType": paymentTypeToSend.toString(),
                          "CurrencyID": selectedCurrencyId.toString(),
                          "DepositAmount": DepositAmountController.text.trim(),
                          "AuthorizedBy":selectedOptionId.toString(),
                          "TransactionNo": _TransactionNumber.text.trim(),
                          "AccountNo": AccountNumber.text.trim(),
                          "IssuedBankName":IssuedBankName.text.trim(),
                          "IssuedBranchName":IssuedBanchName.text.trim(),
                          "IssueDate": IssuedateController.text.trim(),
                          "Remarks":Remarks.text.trim(),
                          "Extension":'.png',
                          "SlipFile": 'test.png',
                          "OldImageName":'pop.png',
                          "KeyValue":'hfgdsfgjfg6578463785678436ghfgdsgfhdsgfhgds',
                        };

                        // Print each parameter
                        apiParams.forEach((key, value) {
                          print("$key: $value");
                        });

                        // Combine parameters into query string
                        String apiData = apiParams.entries
                            .map((e) =>
                        "${e.key}=${Uri.encodeComponent(e.value)}")
                            .join('&');

                        print("API URL: $apiUrl");
                        print("Full API Data: $apiData");

                        __futureLogin =
                            ResponseHandler.performPost(apiUrl, apiData);

                        __futureLogin?.then((value) {
                          Navigator.of(context)
                              .pop(); // Close the loading dialog
                          print('Response body: ${value.body}');

                          try {
                            // Parse the XML response
                            final xmlDoc = XmlDocument.parse(value.body);

                            // Extract the JSON string from the <string> tag
                            final jsonString = xmlDoc.rootElement.text;

                            // Parse the JSON string
                            final jsonResponse = json.decode(jsonString);



                            if (jsonResponse['Table'] != null &&
                                jsonResponse['Table'] is List &&
                                jsonResponse['Table'].isNotEmpty) {
                              final totalPage = jsonResponse['Table'][0]['totalpage'];

                              if (totalPage != null && totalPage > 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Saved Successfully.")),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreditBalanceRequest(),
                                  ),
                                );
                              } else {
                                // Show failure message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Approval failed. Please try again.")),
                                );
                              }
                            } else {
                              // Show unexpected format message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Unexpected response format.")),
                              );
                            }

                          } catch (e) {
                            print("Error parsing response: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "An error occurred. Please try again.")),
                            );
                          }
                        }).catchError((error) {
                          Navigator.of(context)
                              .pop(); // Close the loading dialog
                          print("Error: $error");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    "An error occurred. Please try again.")),
                          );
                        });
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
