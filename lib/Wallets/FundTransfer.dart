import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/DashboardModel.dart';
import '../bookings/flight/TravellerDetailsModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FundTransfer(),
    );
  }
}

class FundTransfer extends StatefulWidget {
  @override
  _MyRechargePageState createState() => _MyRechargePageState();
}

class _MyRechargePageState extends State<FundTransfer> {
  late String userTypeID = '';
  late String userID = '';
  double availableCredit = 0.0;
  String AdultName1 = '', AdultTravellerId1 = '';
  late List<dynamic> table0, table1, table2, table3, table4, table5, table6;
  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      print("userTypeID" + userTypeID);
      print("userID" + userID);
      getData();
    });
  }

  Future<void> callSecondApi(String id) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellerDetails?TravellerId=$id&UID=35510b94-5342-TDemoB2CAPI-a2e3-2e722772';
    print('object' + id);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = response.body;

      // Parse XML and extract JSON string
      final startTag = '<string xmlns="http://tempuri.org/">';
      final endTag = '</string>';
      final startIndex = responseData.indexOf(startTag) + startTag.length;
      final endIndex = responseData.indexOf(endTag);
      final jsonString = responseData.substring(startIndex, endIndex);

      // Parse JSON string
      final jsonData = json.decode(jsonString);

      // Extract data from Table
      final tableData = jsonData['Table'];
      final table1Data = jsonData['Table1'];

      if (tableData != null &&
          tableData.isNotEmpty &&
          table1Data != null &&
          table1Data.isNotEmpty) {
        final traveller = tableData[0];
        final passportInfo =
            table1Data[0]; // Assuming there's only one entry in Table1

        setState(() {
          String _firstNameController = traveller['UDFirstName'];
          /* adultLname_controller.text = traveller['UDLastName'];
          dateControllerAdult1.text = traveller['UDDOB'];
          String inputDate = dateControllerAdult1.text;
          formattedDate = convertDate(inputDate);
          print("formattedDate" + formattedDate);

          print('finDate' + dateControllerAdult1.text.toString());
          if (traveller['GenderId'] == 0) {
            selectedGendarContactDetail = "Male";
          } else if (traveller['GenderId'] == 1) {
            selectedGendarContactDetail = "Female";
          }
          // Get data from Table1
          Documentnumber_controller.text = passportInfo['PDPassportNo'];

          String dateOfBirth = passportInfo['PDDateofBirth'];
          Documentype_controller.text = passportInfo['PDDocument'];
          String issuingCountry = passportInfo['PDIssuingCountry'];
          ExpiryDateController.text = passportInfo['PDDateofExpiry'];
          DateTime checkinDateTime = DateTime.parse(ExpiryDateController.text);
          String finDate = DateFormat('yyyy/MM/dd').format(checkinDateTime);

          ExpiryDateController.text = finDate;
          print('finDate' + ExpiryDateController.text.toString());*/
          // Update other text controllers with relevant fields
        });
      } else {
        throw Exception('Failed to load traveller details');
      }
    }
  }

  void getData() async {
    // Assuming getInvoiceReceiptJSON() returns a String
    String? response = await getInvoiceReceiptJSON();

    // Check if response is not null
    if (response != null) {
      // Parse the JSON string
      Map<String, dynamic> data = json.decode(response);

      // Get the Table data
      List<dynamic> tableData = data['Table'];

      // Extract the first entry in tableData
      Map<String, dynamic> firstEntry =
          tableData.isNotEmpty ? tableData[0] : {};

      // Extract the value of AvailableCredit
      double credit = firstEntry.containsKey('AvailableCredit')
          ? double.parse(firstEntry['AvailableCredit'].toString())
          : 0.0;

      // Update the UI with the available credit
      setState(() {
        availableCredit = credit;
      });

      // Print the available credit
      print('Available Credit: $availableCredit');
    }
  }

  Future<String?> getInvoiceReceiptJSON() async {
    print("userTypeID" + userTypeID);
    print("userID" + userID);
    Future<http.Response>? futureLabels = ResponseHandler.performPost(
        "B2CDashboard", "UserTypeId=${userTypeID}&UserId=${userID}");
    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);

      /*  table0 = map["Table"];
      table1 = map["Table1"];
      table2 = map["Table2"];
      table3 = map["Table3"];
      table4 = map["Table4"];
      table5 = map["Table5"];
      table6 = map["Table6"];*/
      log('Response: $jsonResponse');
      return jsonResponse;
    });
  }

  Future<List<TravellerDetailsModel>> fetchAutocompleteData(
      String empName) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellers?UserId=$userID&UserTypeId=$userTypeID&SearchFilter=$empName&UID=35510b94-5342-TDemoB2CAPI-a2e3-2e722772';
    print('userID' + userID);
    print('userTypeID' + userTypeID);
    print('empName' + empName);

    final response = await http.get(Uri.parse(url));
    print('response: ${response.statusCode}');
    if (response.statusCode == 200) {
      final xmlDocument = xml.XmlDocument.parse(response.body);
      final responseData = xmlDocument.findAllElements('string').first.text;

      final decodedData = json.decode(responseData);
      return decodedData
          .map<TravellerDetailsModel>(
              (data) => TravellerDetailsModel.fromJson(data))
          .toList();
    } else {
      print('Failed to load autocomplete data: ${response.statusCode}');
      throw Exception('Failed to load autocomplete data');
    }
  }

  @override
  void initState() {
    super.initState();
    _retrieveSavedValues();
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
              "Fund Transfer",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Montserrat", fontSize: 19),
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
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      'Please Transfer the Fund here..',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Ewallet Balance (KES): ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                        height: 45,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey, // Set the border color
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              availableCredit.toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight
                                      .bold), // Add your text style here
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Customer Type',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DropdownButton<String>(
                          isExpanded: true, // Set this property to true
                          underline: Container(),
                          value: 'Traveller (TRV)', // Set the initial value
                          items: [
                            'Traveller (TRV)' // Add the option with the desired text
                          ]
                              .map((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            // Handle dropdown change
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Transfer To',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Container(
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right:10),
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        child: Autocomplete<TravellerDetailsModel>(
                          optionsBuilder:
                              (TextEditingValue textEditingValue) async {
                            if (textEditingValue.text.isEmpty) {
                              return const Iterable<
                                  TravellerDetailsModel>.empty();
                            }
                            return await fetchAutocompleteData(
                                textEditingValue.text);
                          },
                          displayStringForOption:
                              (TravellerDetailsModel option) =>
                                  '${option.name}',
                          onSelected: (TravellerDetailsModel? selectedOption) {
                            if (selectedOption != null) {
                              print('Selected: ${selectedOption.name}');
                              setState(() async {
                                await callSecondApi(selectedOption.id.toString());
                                AdultName1 = selectedOption.name;
                                AdultTravellerId1 = selectedOption.id.toString();
                              });
                            }
                          },
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted) {
                            return TextFormField(
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                              controller: textEditingController,
                              focusNode: focusNode,
                              onFieldSubmitted: (value) {
                                onFieldSubmitted();
                              },
                              decoration: InputDecoration(
                                hintText: 'First Name',
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Transaction Amount (KES):',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 45,
                      child: TextField(
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
                          hintText: 'Enter Transaction Amount',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Transaction Password:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 45,
                      child: TextField(
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
                          hintText: 'Enter Transaction Password',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 55, // Set width to full
                          child: ElevatedButton(
                            onPressed: () {
                              // Add your recharge logic here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color(0xFF00ADEE), // Set button color
                            ),
                            child: Text(
                              'Fund Transfer',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),

                        // Other widgets below the button
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NOTE:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(height: 10),
                          Text(
                            style: TextStyle(fontWeight: FontWeight.w500),
                            'You can Transfer the Fund in this EWallet. It will calculate on Transfer Fund Reports by default!.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
