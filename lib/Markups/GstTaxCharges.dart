import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';
import '../bookings/flight/TravellerDetailsModel.dart';
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;

import 'GSTTaxChanrgesModel.dart';


class GstTaxCharges extends StatefulWidget {
  @override
  _MyRechargePageState createState() => _MyRechargePageState();

}

class _MyRechargePageState extends State<GstTaxCharges> {
  late String userTypeID = '';
  Future<http.Response>? __futureLogin;
  late String userID = '';
  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      print("userTypeID" + userTypeID);
      print("userID" + userID);
      fetchCustomerTypes();
      fetchCurrencyCodes();
      callSecondApi();
      fetchGSTBalance();

    });
  }
  @override
  void initState() {
    super.initState();
    _retrieveSavedValues();

  }
  TextEditingController fixedAmountController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  final TextEditingController TranssactionPasswordController =
  TextEditingController();
  bool _isPasswordVisible = false;
  String apiPassword = ''; // Replace with API password
  String _errorText = '';
  String selectedValue = "Fixed Value"; // Default value
  String selectedApiValue = "2"; // Default API value
  GSTTaxChanrgesModel? gstBalance;
  Future<void> fetchGSTBalance() async {
    final String apiUrl =
        "https://traveldemo.org/travelapp/traveller.asmx/GetGSTBalance";
    final Map<String, dynamic> parameters = {
      "UserTypeId": userTypeID,
      "UserId": userID,
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

        if (data["Table"] != null && data["Table"].isNotEmpty) {
          final parsed = GSTTaxChanrgesModel.fromJson(data["Table"][0]);

          setState(() {
            gstBalance = parsed;
            selectedValue =
            parsed.gstType == "Fixed" ? "Fixed Value" : parsed.gstType;

            if (selectedValue == "Fixed Value") {
              fixedAmountController.text = parsed.gstAmount.toString();
              percentageController.clear();
            } else {
              percentageController.text = parsed.gstPercent.toString();
              fixedAmountController.clear();
            }
          });
        }
      } else {
        print("Failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  Future<List<TravellerDetailsModel>> fetchAutocompleteData(
      String empName)
  async {
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
  List<Map<String, dynamic>> currencyList = [];
  String? selectedCurrencyName;
  int flag=0;
  List<Map<String, dynamic>> currencyList1 = [];
  String? selectedCurrencyName1;
  Future<void> fetchCurrencyCodes() async {
    final String apiUrl = "https://traveldemo.org/travelapp/traveller.asmx/GetBalanceCurrency";
    final Map<String, dynamic> parameters = {
      "UserTypeId": userTypeID,
      "UserId": userID,
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
          List<Map<String, dynamic>> fetchedCurrencies = List<Map<String, dynamic>>.from(data['Table']);

          setState(() {
            currencyList = fetchedCurrencies;


            if (currencyList.isNotEmpty) {
              selectedCurrencyName = currencyList[0]['CurrencyCode'];

            }
            print("Selected Cusdsdghyuuyurrency Name: $flag");
            if(flag==0)
            {
              selectedCurrencyName = currencyList[0]['CurrencyCode'];
              selectedCurrencyName1 = currencyList[0]['CurrencyCode'];
              print("Selected Cusdsdrrency Name: $selectedCurrencyName");
            }
            else
            {
              selectedCurrencyName = currencyList[0]['CurrencyCode'];
            }
          });
        }
      } else {
        print("JHUTJGHH ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
  Future<void> callSecondApi() async {
    final url =
        'https://traveldemo.org/travelapp/traveller.asmx/Gstpassword?UserId=$userID&UID=35510b94-5476-TDemoTraveller-a2e3-2e9779';

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

      if (tableData != null && tableData.isNotEmpty) {
        final traveller = tableData[0];

        setState(() {

          apiPassword = traveller['TransactionPassword'];
          //TranssactionPasswordController.text=traveller['Password'];
          print("lkefjkhjk" + apiPassword);

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
  final TextEditingController customerTypeController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();
  List<String> customerNames = [];
  String? selectedCustomerName;

  List<Map<String, dynamic>> userTypes = [];
  String? selectedUserType;
  int? selectedUserTypeId;
  Future<void> fetchUserTypes() async {
    final String apiUrl =
        "https://traveldemo.org/travelapp/traveller.asmx/ddl_MarkUpUserType";
    final Map<String, dynamic> parameters = {
      "UserTypeId": userTypeID,
      "UserId": userID,
      "UID": "35510b94-5476-TDemoTraveller-a2e3-2e9779"
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
          setState(() {
            userTypes = List<Map<String, dynamic>>.from(data['Table']);
            selectedUserType = userTypes.first['Name']; // 👈 auto-select first
            selectedUserTypeId = userTypes.first['Id'];
            print("selectedUserTypeId"+selectedUserTypeId.toString());
          });
        }
      } else {
        print("FailedSDASDF to fetch data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
  Future<void> fetchCustomerNames() async {
    final String apiUrl =
        "https://traveldemo.org/travelapp/traveller.asmx/Traveller_ddlUserName"; // Replace with your API URL
    final Map<String, dynamic> parameters = {
      "SerUserTypeId": userTypeID,
      "UserId": userID,
      "UserTypeId": userTypeID,
      "UID": '35510b94-5476-TDemoTraveller-a2e3-2e9779'
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          // Ensure the correct content type
        },
      );

      if (response.statusCode == 200) {
        // Parse XML response
        final xmlDoc = XmlDocument.parse(response.body);
        final jsonString = xmlDoc.rootElement.text;

        // Decode JSON
        final data = json.decode(jsonString);

        if (data['Table'] != null) {
          // Extract names from the response
          final List<String> fetchedNames = data['Table']
              .map<String>((item) => item['Name'] as String)
              .toList();

          // Remove duplicates
          final uniqueNames = <String>{...customerNames, ...fetchedNames};

          setState(() {
            customerNames = uniqueNames.toList(); // Convert Set back to List
          });
        }
      } else {
        print("Failed to fetch data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  String AdultName1 = '', AdultTravellerId1 = '';
  List<Map<String, dynamic>> customerTypes = [];
  String selectedCustomerTypeName = '';
  String selectedCustomerTypeId = '';
  Future<void> fetchCustomerTypes() async {
    final String apiUrl =
        "https://traveldemo.org/travelapp/traveller.asmx/ddlStaffUserType";

    final Map<String, dynamic> parameters = {
      "UserTypeId": userTypeID,
      "UserId": userID,
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
            selectedDropdownId=null;
            selectedDropdownName=null;
            fetchDropdownData();
            print("Selected ID: $selectedCustomerTypeId");
            print("Selected Name: $selectedCustomerTypeName");
          }
        }
      } else {
        print("Failed to fetch data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
  List<Map<String, dynamic>> dropdownItems = [];
  String? selectedDropdownId = '';  // <-- ID to send to API
  String? selectedDropdownName = '';
  Future<void> fetchDropdownData() async {
    final String apiUrl =
        "https://traveldemo.org/travelapp/traveller.asmx/Staff_ddlUserName";

    final Map<String, dynamic> parameters = {
      "SerUserTypeId": selectedCustomerTypeId,
      "UserId": userID,
      "UserTypeId": userTypeID,
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
  TextEditingController autocompleteController = TextEditingController();
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
                  color: Colors.black,
                  size: 27,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              SizedBox(width: 1), // Set the desired width
              Text(
                "Gst Tax Details",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: 17),
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
          backgroundColor:Color(0xFF00ADEE)),
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
                    padding: const EdgeInsets.only(left: 0, top: 0),
                    child: Text(
                      'Please Enter the GST Tax here...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        'Customer Type: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 8),
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
                              fetchDropdownData();
                              print("Selected ID: $selectedCustomerTypeId");
                              print("Selected Name: $selectedCustomerTypeName");
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
                        'Customer Name: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 48,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: (selectedDropdownId != null && selectedDropdownId!.isNotEmpty) ? selectedDropdownId : null,
                          isExpanded: true,
                          isDense: true,
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                          hint: const Text("Select Option"),
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
                        'GST Type: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: DropdownButtonFormField<String>(
                      value: selectedValue,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      items: ["Percentage", "Fixed Value"]
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      ))
                          .toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedValue = newValue;
                            selectedApiValue =
                            newValue == "Percentage" ? "1" : "2";

                            // Update controllers based on new dropdown value
                            if (selectedValue == "Fixed Value") {
                              fixedAmountController.text =
                                  gstBalance?.gstAmount.toString() ?? '';
                              percentageController.clear();
                            } else {
                              percentageController.text =
                                  gstBalance?.gstPercent.toString() ?? '';
                              fixedAmountController.clear();
                            }
                          });
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      selectedValue == "Fixed Value"
                          ? 'GST Fixed Amount (\$)*'
                          : 'GST Percentage (%)*',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),

                  SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: selectedValue == "Fixed Value"
                        ? SizedBox(
                      height: 45,
                      child: TextField(
                        controller: fixedAmountController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter fixed amount",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    )
                        : SizedBox(
                      height: 45,
                      child: TextField(
                        controller: percentageController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter percentage",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        'Transaction Password:  ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          child: TextField(
                            controller: TranssactionPasswordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              hintText: 'Enter Transaction Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  _errorText =
                                  'Please enter transaction password';
                                } else if (value != apiPassword) {
                                  _errorText = 'Wrong password';
                                } else {
                                  _errorText = ''; // no error
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      if (_errorText.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            _errorText,
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity, // Full width
                          height: 50, // Button height
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Dark blue color
                            ),
                            onPressed: () {
                              final String gstAmount =
                              fixedAmountController.text.trim().isEmpty
                                  ? gstBalance!.gstAmount.toString()
                                  : fixedAmountController.text.trim();
                              print("gstAmount" + gstAmount);
                              final String gstPercent =
                              percentageController.text.trim().isEmpty
                                  ? gstBalance!.gstPercent.toString()
                                  : percentageController.text.trim();
                              print("gstPercent" + gstPercent);
                              String gstType = selectedValue == "Fixed Value"
                                  ? "Fixed"
                                  : "Percentage";

                              String apiUrl = "GSTaxSet";

                              Map<String, String> apiParams = {
                                "ID": "0",
                                "GSTType": gstType,
                                "GSTAmount": gstAmount,
                                "GSTPercent": gstPercent,
                                "UserTypeId": userTypeID,
                                "UserId": userID,
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

                              __futureLogin = ResponseHandler.performPost(
                                  apiUrl, apiData);

                              __futureLogin?.then((value) {
                                // Close the loading dialog
                                print('Response body: ${value.body}');

                                try {
                                  // Parse the XML response
                                  final xmlDoc = XmlDocument.parse(value.body);
                                  final responseText =
                                  xmlDoc.rootElement.text.trim();

                                  print("Parsed Response: $responseText");

                                  // Convert JSON String to Map
                                  final Map<String, dynamic> jsonResponse =
                                  json.decode(responseText);

                                  // Check if "Table" exists and is not null
                                  if (jsonResponse.containsKey("Table") &&
                                      jsonResponse["Table"] is List &&
                                      jsonResponse["Table"].isNotEmpty) {
                                    int totalPage =
                                    jsonResponse["Table"][0]["totalpage"];

                                    if (totalPage > 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "GST added successfully!")),
                                      );
                                      Navigator.of(context).pop();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Approval failed. Please try again.")),
                                      );
                                    }
                                  } else {
                                    throw Exception("Invalid response format.");
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

                        // Other widgets below the button
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 80,
                      width: 320,
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
                            'You can update the Password in this Form.',
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


