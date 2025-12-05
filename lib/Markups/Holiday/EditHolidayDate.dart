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

import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';
import 'MarkupHolidaydate.dart';
import 'ViewMrkupHolidayDateModel.dart';
 

class EditHolidayDate extends StatefulWidget {
  final String ID;

  EditHolidayDate({required this.ID});
  @override
  _MyRechargePageState createState() => _MyRechargePageState();
}

class _MyRechargePageState extends State<EditHolidayDate> {
  String checkboxStatus = "0";
  String genderValue = "Male";
  String? selectedTitle = 'Mr';
  String OriginPlace = '', SelectionValue = '';
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


  Future<List<ViewMrkupHolidayDateModel>?> getLabels() async {
    List<ViewMrkupHolidayDateModel> labelData = [];

    Future<http.Response>? futureLabels = ResponseHandler.performPost(
      "MarkupHolidayDateViewEdit",
      "Id=${widget.ID}",
    );

    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];

        for (int i = 0; i < list.length; i++) {
          ViewMrkupHolidayDateModel lm = ViewMrkupHolidayDateModel.fromJson(list[i]);
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
    List<ViewMrkupHolidayDateModel>? assets = await getLabels();

    if (assets != null && assets.isNotEmpty) {
      setState(() {
        FromdateController.text = assets.first.fromDate ?? ''; // Ensure it is not null
        TodateController.text = assets.first.toDate ?? '';
        selectedApiValue = assets.first.markupTypeId; // Default to "0" if null
        selectedValue = selectedApiValue == "0" ? "Percentage" : "Fixed Value";
        MarkupValueController.text=assets.first.markupValue;
        apiValue = assets.first.status;

      });
    }
  }

  String FinalID = '',

      FinalID1 = '',
      Selectionvalue1 = '',
      AirportShortFrom = '',
      AirportShortTo = '';





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
                color: Colors.white,
                size: 27,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(width: 1), // Set the desired width
            Text(
              "Edit Date",
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "   From Date",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding:
            const EdgeInsets.only(left: 13, right: 13, top: 10),
            child: TextFormField(
              controller: FromdateController,
              readOnly: true,
              // Make the field non-editable
              onTap: () async {
                // Open the date picker when the field is tapped
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(), // Default to current date
                  firstDate: DateTime(1900), // Allow selection from the year 1900
                  lastDate: DateTime(2100), // Allow selection up to the year 2100 (or any future date)
                );

                if (pickedDate != null) {
                  // Format: 25 April, 2025
                  String formattedDate = DateFormat("d MMMM, y").format(pickedDate);
                  FromdateController.text = formattedDate;
                }
              },

              decoration: InputDecoration(
                hintText: 'From Date',
                prefixIcon:
                Icon(Icons.calendar_today, color: Colors.grey),
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
            padding: const EdgeInsets.only(top: 0),
            child: Text(
              "   To Date",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding:
            const EdgeInsets.only(left: 13, right: 13, top: 0),
            child: TextFormField(
              controller: TodateController,
              readOnly: true,
              // Make the field non-editable
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
                  TodateController.text = formattedDate;
                }
              },


              decoration: InputDecoration(
                hintText: 'To Date',
                prefixIcon:
                Icon(Icons.calendar_today, color: Colors.grey),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Title
              Text(
                "    Markup Type",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonFormField<String>(
                  value: selectedValue.isNotEmpty ? selectedValue : null, // Ensures no null error
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
                        selectedApiValue = newValue == "Percentage" ? "0" : "1";
                      });
                    }
                  },
                ),

              ),

              SizedBox(height: 16.0),
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
                            activeColor: Color(0xFF00ADEE),
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
                              color: apiValue == "1" ? Color(0xFF00ADEE) : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: Color(0xFF00ADEE),
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
                              color: apiValue == "0" ? Color(0xFF00ADEE) : Colors.grey,
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
            padding: const EdgeInsets.only(right: 10,left: 10,bottom: 10),
            child: SizedBox(
              width: double.infinity, // Full width
              height: 50, // Button height
              child: ElevatedButton(
                onPressed: () async {
                  if (FromdateController.text.trim().isEmpty ||
                      TodateController.text.trim().isEmpty ||
                      MarkupValueController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill in all fields.")),
                    );
                    return;
                  }

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                  String apiUrl = "MarkupHolidayDateSet";
                  Map<String, String> apiParams = {
                    "Id": widget.ID,
                    "UserTypeId": userTypeID,
                    "UserId": userID,
                    "FromDate": FromdateController.text.trim(),
                    "ToDate": TodateController.text.trim(),
                    "MarkupTypeId": selectedApiValue.toString(),
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
                          content: const Text("The Date Already exists"),
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
                            builder: (context) => MarkupHolidaydate(),
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
