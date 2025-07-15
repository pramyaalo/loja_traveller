import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
 import 'package:xml/xml.dart';
import 'package:xml/xml.dart' as xml;
import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'MarkupAIrlineNameModel.dart';
import 'MarkupAirportNameModel.dart';
import 'MarkupFlightAirline.dart';
import 'MarkupFlightDate.dart';
import 'MarkupFlightDestination.dart';
import 'ViewMarkupFlightAirlineModel.dart';

class EditMarkupAirline extends StatefulWidget {
  final String ID;

  EditMarkupAirline({required this.ID});
  @override
  _MyRechargePageState createState() => _MyRechargePageState();
}

class _MyRechargePageState extends State<EditMarkupAirline> {
  String checkboxStatus = "0";
  String genderValue = "Male";
  String? selectedTitle = 'Mr';
  String OriginPlace = '', SelectionValue = '',Airlinetype='';
  Future<http.Response>? __futureLogin;




  String genderApiValue = "1";




  int selectedTitleValue = 0;
  final TextEditingController MarkupValueController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();



  String selectedStatus = 'Active';
  String apiValue =  "1";
  late List<dynamic> table0, table1, table2, table3, table4, table5, table6;





  static String userTypeID = '';
  static String username = '';
  static String userID = '';
  String? selectedCustomerName;

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
      username = prefs.getString(Prefs.PREFS_USER_NAME) ?? "Nafula";
      print("userTypeID" + userTypeID);
      print("username" + username);
      fetchAssetData();

    });
  }

  List<String> customerNames = [];
  List<String> customertype = [];
  String? selectedCustomertype;


  Future<List<ViewMarkupFlightAirlineModel>?> getLabels() async {
    List<ViewMarkupFlightAirlineModel> labelData = [];

    Future<http.Response>? futureLabels = ResponseHandler.performPost(
      "MarkupFlightAirlineViewEdit",
      "Id=${widget.ID}",
    );
print(widget.ID);
    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];

        for (int i = 0; i < list.length; i++) {
          ViewMarkupFlightAirlineModel lm = ViewMarkupFlightAirlineModel.fromJson(list[i]);
          labelData.add(lm);
        }
      } catch (error) {
        print("Error parsing JSON: $error");
      }
      return labelData;
    });
  }
  final TextEditingController FromdateController=TextEditingController();
  final TextEditingController TodateController=TextEditingController();
  Future<void> fetchAssetData() async {
    List<ViewMarkupFlightAirlineModel>? assets = await getLabels();

    if (assets != null && assets.isNotEmpty) {
      setState(() {
        SelectionValue = assets.first.airlineName ?? ''; // Ensure it is not null
          FinalID=assets.first.airlineId??'';
        selectedApiValue = assets.first.markupTypeId; // Default to "0" if null
        selectedValue = selectedApiValue == "0" ? "Percentage" : "Fixed Value";
        MarkupValueController.text=assets.first.markupValue;
        apiValue =assets.first.status;
        print(SelectionValue);

      });
    }
  }

  String FinalID = '',
      airlinetype='',
      FinalID1 = '',
      Selectionvalue1 = '',
      AirportShortFrom = '',
      AirportShortTo = '';


  Future<List<MarkupAIrlineNameModel>> fetchAutocompleteData(
      String empName)
  async {
    final url =
        'https://traveldemo.org/travelapp/b2c.asmx/MarkupFlightAirlineName?Name=$empName&UID=35510b94-5342-TDemoB2C-a2e3-2e722772';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final xmlDocument = xml.XmlDocument.parse(response.body);
      final responseData = xmlDocument.findAllElements('string').first.text;

      final decodedData = json.decode(responseData);

      // Ensure the expected structure exists
      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey('Table')) {
        final List<dynamic> dataList =
        decodedData['Table']; // Extracting the list

        return dataList
            .map((data) =>
            MarkupAIrlineNameModel.fromJson(data as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Unexpected JSON structure');
      }
    } else {
      throw Exception('Failed to load autocomplete data');
    }
  }
  String selectedValue = "Percentage"; // Default value
  String selectedApiValue = "0";

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
              "Edit Flight Airline",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  fontSize: 19),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/logo.png',
            width: 150,
            height: 50,
          ),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor:Color(0xFF00ADEE),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "   Airline",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Container(
              height: 45, // Updated height
              width: double.infinity, // Full width
              child: Autocomplete<MarkupAIrlineNameModel>(
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<MarkupAIrlineNameModel>.empty();
                  }
                  return await fetchAutocompleteData(textEditingValue.text);
                },
                displayStringForOption: (MarkupAIrlineNameModel option) =>
                '${option.name}',
                onSelected: (MarkupAIrlineNameModel? selectedOption) {
                  if (selectedOption != null) {
                    print('Selected: ${selectedOption.name

                    } (${selectedOption.id})');
                    setState(() {
                      FinalID = selectedOption.id;
                      airlinetype=selectedOption.Airlinetype;
                      SelectionValue = selectedOption.name;
                    });
                  }
                },
                fieldViewBuilder:
                    (context, controller, focusNode, onFieldSubmitted) {
                      controller.text = SelectionValue;
                  return Container(
                    width: double.infinity, // Ensures full width
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Grey border
                      borderRadius: BorderRadius.circular(5), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15), // Padding inside the box
                    child: TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      onFieldSubmitted: (String value) {
                        // Your logic here
                      },
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'From',
                        isDense: true,
                        contentPadding: EdgeInsets.only(top: 10),
                        border: InputBorder.none, // Removes default border
                      ),
                    ),
                  );
                },
              ),
            ),
          ),


          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              // Title

              // First Name
              Text(
                "    Markup Value",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                child: TextField(
                  controller: MarkupValueController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 16.0),


              Text(
                "    Status",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 8),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: Colors.blue,
                            value: "1",
                            groupValue: apiValue,
                            onChanged: (value) {
                              setState(() {
                                apiValue = value!;
                              });
                            },
                          ),
                          Text(
                            'Active',
                            style: TextStyle(
                              color: apiValue == "1" ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: Colors.blue,
                            value: "0",
                            groupValue: apiValue,
                            onChanged: (value) {
                              setState(() {
                                apiValue = value!;
                              });
                            },
                          ),
                          Text(
                            'Inactive',
                            style: TextStyle(
                              color: apiValue == "0" ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),


              SizedBox(height: 16.0),



            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10,left: 10),
            child: SizedBox(
              width: double.infinity, // Full width
              height: 50, // Button height
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                  String apiUrl = "MarkupFlightAirlineSet";
                  Map<String, String> apiParams = {
                    "Id": widget.ID,
                    "UserTypeId": userTypeID,
                    "UserId": userID,
                    "Airline": airlinetype,
                    "AirlineId": FinalID,
                    "AirlineName": SelectionValue,
                    "MarkupTypeId": "0",
                    "MarkupValue": MarkupValueController.text.trim(),
                    "Status": apiValue.toString(),
                  };
                  // ✅ Print all data before calling API
                  print("Form Data to Send:");
                  apiParams.forEach((key, value) {
                    print("$key: $value");
                  });

                  String apiData = apiParams.entries
                      .map((e) => "${e.key}=${Uri.encodeComponent(e.value)}")
                      .join('&');

                  final startTime = DateTime.now();

                  try {
                    final response = await ResponseHandler.performPost(apiUrl, apiData);
                    Navigator.of(context).pop();
                    print('Response body: ${response.body}');
                    final xmlDoc = XmlDocument.parse(response.body);
                    final resultText = xmlDoc.rootElement.text.trim();
                    print(resultText);
                    if (resultText == "Not Allowed") {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Warning"),
                          content: const Text("The Airline already exists"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Close"),
                            ),
                          ],
                        ),
                      );
                      return;
                    }

                    final jsonResponse = json.decode(resultText);

                    if (jsonResponse['Table'] != null &&
                        jsonResponse['Table'] is List &&
                        jsonResponse['Table'].isNotEmpty) {
                      final totalPage = jsonResponse['Table'][0]['totalpage'];

                      if (totalPage != null && totalPage > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Saved Successfully")),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MarkupFlightAirline(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Approval failed. Please try again.")),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Unexpected response format.")),
                      );
                    }
                  } catch (e) {
                    Navigator.of(context).pop(); // Close loading dialog
                    print("Error: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("An error occurred. Please try again.")),
                    );
                  }
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
          ),

        ]),
      ),
    );
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
