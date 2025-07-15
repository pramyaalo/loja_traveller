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
import 'MarkupHotelrating.dart';
import 'ViedwHotelratingModel.dart';


class EditmarkupHotelrating extends StatefulWidget {
  final String ID;

  EditmarkupHotelrating({required this.ID});
  @override
  _MyRechargePageState createState() => _MyRechargePageState();
}

class _MyRechargePageState extends State<EditmarkupHotelrating> {
  String checkboxStatus = "0";
  String genderValue = "Male";
  String? selectedTitle = 'Mr';
  String OriginPlace = '', SelectionValue = '';
  Future<http.Response>? __futureLogin;




  String genderApiValue = "1";




  int selectedTitleValue = 0;
  final TextEditingController MarkupValueController = TextEditingController();
  final TextEditingController FromfareController = TextEditingController();
  final TextEditingController ToFareController = TextEditingController();


  void _showPopup(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              SizedBox(height: 10),
              Icon(
                title == "Warning" ? Icons.error_outline : Icons.check_circle_outline,
                color: title == "Error" ? Colors.red : Colors.green,
                size: 50,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close popup
              },
              child: Text("Close", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
  String selectedStatus = 'Active';
  String apiValue =  "1";
  late List<dynamic> table0, table1, table2, table3, table4, table5, table6;




  int? selectedStar;
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


  Future<List<ViedwHotelratingModel>?> getLabels() async {
    List<ViedwHotelratingModel> labelData = [];

    Future<http.Response>? futureLabels = ResponseHandler.performPost(
      "MarkupHotelRatingViewEdit",
      "Id=${widget.ID}",
    );

    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];

        for (int i = 0; i < list.length; i++) {
          ViedwHotelratingModel lm = ViedwHotelratingModel.fromJson(list[i]);
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
    List<ViedwHotelratingModel>? assets = await getLabels();

    if (assets != null && assets.isNotEmpty) {
      setState(() {
        selectedStar = int.tryParse(assets.first.hotelRating ?? '') ?? 1;

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
              "Edit Hotel rating",
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "   Hotel Ratings",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 50, // Adjust height as needed
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10), // Reduce padding
                        border: OutlineInputBorder(),
                      ),
                      hint: Text("Select Star"), // Hint text when no value is selected
                      value: selectedStar,
                      items: List.generate(7, (index) {
                        int starValue = index + 1;
                        return DropdownMenuItem<int>(
                          value: starValue,
                          child: Text("$starValue Star"),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          selectedStar = value;
                        });
                      },
                    ),
                  ),
                ),




                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


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

              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10,left: 10,bottom: 10),
            child: SizedBox(
              width: double.infinity, // Full width
              height: 50, // Button height
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedStar == null || selectedStar.toString().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select a Hotel Rating")),
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
                  String apiUrl = "MarkupHotelRatingSet";
                  Map<String, String> apiParams = {
                    "Id": widget.ID,
                    "UserTypeId": userTypeID,
                    "UserId": userID,
                    "HotelRating": selectedStar.toString(),
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
                          content: const Text("The ratings Already exists"),
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
                            builder: (context) => MarkupHotelrating(),
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
        ],
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
