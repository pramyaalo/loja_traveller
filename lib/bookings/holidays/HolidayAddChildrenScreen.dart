import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Booking/HolidayDatabaseHelper.dart';
import '../../utils/commonutils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:xml/xml.dart' as xml;
import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';

import 'package:get/get.dart';

import '../flight/TravellerDetailsModel.dart';
import 'HolidayChildrenDatabaseHelper.dart';



class HolidayAddChildrenScreen extends StatefulWidget {
  final flightDetails,
      resultFlightData,
      adultCount,
      childrenCount,
      infantCount,
      departdate,
      userid,
      usertypeid,
      isEdit;
  final int childIndex;
  final List<dynamic> childrenList;

  const HolidayAddChildrenScreen({
    super.key,
    required this.flightDetails,
    required this.resultFlightData,
    required this.infantCount,
    required this.childrenCount,
    required this.adultCount,
    required this.departdate,
    required this.userid,
    required this.usertypeid,
    required this.isEdit,
    required this.childIndex,
    required this.childrenList,
  });

  @override
  State<HolidayAddChildrenScreen> createState() => _OneWayBookingState();
}

class _OneWayBookingState extends State<HolidayAddChildrenScreen> {
  bool isLoading = false;
  int Status = 2;
  late List<Map<String, dynamic>> mutableAdultsList;
  String formattedDate = '';
  String AdultName1 = '', AdultTravellerId1 = '';
  bool isBookingLoading = false;
  String selectedCountryCode = '+91';
  String selectedTitleAdult1 = 'Mr';
  String selectedTitleAdult2 = 'Mr';
  String selectedTitleAdult3 = 'Mr';
  String selectedTitleAdult4 = 'Mr';
  String selectedTitleAdult5 = 'Mr';

  String selectedTitleChildren1 = 'Mr';
  String selectedTitleChildren2 = 'Mr';
  String selectedTitleChildren3 = 'Mr';
  String selectedTitleChildren4 = 'Mr';
  String selectedTitleChildren5 = 'Mr';

  String selectedTitleInfant1 = 'Mr';
  String selectedTitleInfant2 = 'Mr';
  String selectedTitleInfant3 = 'Mr';
  String selectedTitleInfant4 = 'Mr';
  String selectedTitleInfant5 = 'Mr';

  String selectedGendarAdult1 = 'Male';
  String selectedGendarAdult2 = 'Male';
  String selectedGendarAdult3 = 'Male';
  String selectedGendarAdult4 = 'Male';
  String selectedGendarAdult5 = 'Male';

  String selectedGendarChildren1 = 'Male';
  String selectedGendarChildren2 = 'Male';
  String selectedGendarChildren3 = 'Male';
  String selectedGendarChildren4 = 'Male';
  String selectedGendarChildren5 = 'Male';

  String selectedGendarInfant1 = 'Male';
  String selectedGendarInfant2 = 'Male';
  String selectedGendarInfant3 = 'Male';
  String selectedGendarInfant4 = 'Male';
  String selectedGendarInfant5 = 'Male';

  String selectedGendarContactDetail = 'Male';
  String Gendar = '';
  final FocusNode _focusNode = FocusNode();
  FocusNode _firstNameFocusNode = FocusNode();
  FocusNode _lastNameFocusNode = FocusNode();

  TextEditingController adultFname_controller = new TextEditingController();
  TextEditingController adultLname_controller = new TextEditingController();

  TextEditingController adult1_Fname_controller = new TextEditingController();
  TextEditingController adult1_Lname_controller = new TextEditingController();

  TextEditingController contactEmailController = new TextEditingController();
  TextEditingController contactMobileController = new TextEditingController();
  TextEditingController contactAddressController = new TextEditingController();
  TextEditingController contactCityController = new TextEditingController();
  TextEditingController _CountryController = new TextEditingController();
  TextEditingController Documentype_controller = new TextEditingController();
  TextEditingController Documentnumber_controller = new TextEditingController();

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  var selectedDate = DateTime.now().obs;
  TextEditingController ExpiryDateController = TextEditingController();
  TextEditingController dateControllerAdult1 = TextEditingController();
  TextEditingController dateControllerAdult2 = TextEditingController();
  TextEditingController dateControllerAdult3 = TextEditingController();
  TextEditingController dateControllerAdult4 = TextEditingController();
  TextEditingController dateControllerAdult5 = TextEditingController();
  TextEditingController passengerNameController = new TextEditingController();

  TextEditingController dateControllerChildren1 = TextEditingController();
  TextEditingController dateControllerChildren2 = TextEditingController();
  TextEditingController dateControllerChildren3 = TextEditingController();
  TextEditingController dateControllerChildren4 = TextEditingController();
  TextEditingController dateControllerChildren5 = TextEditingController();

  TextEditingController dateControllerInfant1 = TextEditingController();
  TextEditingController dateControllerInfant2 = TextEditingController();
  TextEditingController dateControllerInfant3 = TextEditingController();
  TextEditingController dateControllerInfant4 = TextEditingController();
  TextEditingController dateControllerInfant5 = TextEditingController();

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != ExpiryDateController) {
      setState(() {
        ExpiryDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateAdult1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult1) {
      setState(() {
        dateControllerAdult1.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';
  String formattedFromDate = '';

  @override
  void initState() {
    super.initState();
    mutableAdultsList = List.from(widget.childrenList);
    _retrieveSavedValues();
    adultFname_controller = TextEditingController();
    adultLname_controller = TextEditingController();
    dateControllerAdult1 = TextEditingController();
    Documentype_controller = TextEditingController();
    Documentnumber_controller = TextEditingController();
    ExpiryDateController = TextEditingController();

    if (widget.childIndex >= 0 &&
        widget.childIndex < widget.childrenList.length) {
      var adult = widget.childrenList[widget.childIndex];

      adultFname_controller.text = adult['firstName'];
      print('object' + adultFname_controller.text);
      adultLname_controller.text = adult['surname'];
      dateControllerAdult1.text = adult['dob']; // Keep DOB as is

      contactMobileController.text = adult['mobileNumber'] ?? '';
      _CountryController.text = adult['country'] ?? '';
      selectedTitleAdult1 = adult['title'] ?? '';
    }
  }

  void _saveAdult() async {
    try {
      String title = selectedTitleAdult1.toString();
      String firstName = adultFname_controller.text.trim();
      String surname = adultLname_controller.text.trim();
      String dob = dateControllerAdult1.text.trim();
      String mobilenumber = contactMobileController.text.trim();
      String country = _CountryController.text.trim(); // Fixed casing to match the column

      // Create the map to insert or update
      Map<String, dynamic> adultData = {
        'title': title,
        'firstName': firstName,
        'surname': surname,
        'dob': dob,
        'mobileNumber': mobilenumber, // Fixed key here
        'country': country, // Ensure this matches the column name too
      };

      final dbHelper = HolidayChildrenDatabaseHelper.instance;

      // Check if the name already exists in the list
      bool nameExists = mutableAdultsList.any((adult) {
        return adult['firstName'] == firstName && adult['surname'] == surname &&
            (widget.isEdit == 'Add' || (adult['id'] != mutableAdultsList[widget.childIndex]['id']));
      });

      if (nameExists) {
        // Show a snackbar to inform the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Name Already Exists. Please Select another Name"),
            duration: Duration(seconds: 2), // Duration the snackbar is shown
          ),
        );
        return; // Exit the function early
      }

      // Check if we are editing an existing entry
      if (widget.isEdit == 'Edit' && widget.childIndex >= 0 && widget.childIndex < mutableAdultsList.length) {
        // Retrieve the ID of the adult we are updating
        int? adultId = mutableAdultsList[widget.childIndex]['id'];
        if (adultId != null) {
          // Update existing adult using the correct ID
          await dbHelper.updateholidayChildrens(adultId, adultData);
          print("Updated adult data for ID: $adultId");

          // Fetch updated data after the update
          Map<String, dynamic>? updatedAdult = await dbHelper.fetchholidayAdultData(adultId);
          print("Updated adult: $updatedAdult");

          if (updatedAdult != null) {
            setState(() {
              // Update the specific child in the mutable list
              mutableAdultsList[widget.childIndex] = updatedAdult;
            });
            // Show a success message
            Fluttertoast.showToast(
              msg: "Child data updated successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            print("Updated data: $updatedAdult");
          }
        }
      } else if (widget.isEdit == 'Add') {
        // Handle the case for adding new children
        await dbHelper.insertholidayChildrens(adultData);
        Fluttertoast.showToast(
          msg: "Child added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }

      // Navigate back and pass the updated list back to the previous page
      Navigator.pop(context, mutableAdultsList); // Pass the updated list back
    } catch (e) {
      // Log or display the error for debugging
      print("Error saving child data: $e");
      // Optionally show an error message
      Fluttertoast.showToast(
        msg: "Error saving child data: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }



  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
      print('Currency: $Currency');
    });
  }

  Future<List<TravellerDetailsModel>> fetchAutocompleteData(
      String empName) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellers?UserId=2611&UserTypeId=8&SearchFilter=$empName&UID=35510b94-5342-TDemoB2CAPI-a2e3-2e722772';
    print('userID' + widget.userid);
    print('userTypeID' + widget.usertypeid);
    print('empName' + empName);
    print(widget.departdate);

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

  String convertDate(String inputDate) {
    // Parse the input date string
    DateTime date = DateFormat('dd MMM yyyy').parse(inputDate);

    // Format the date in the desired format
    formattedDate = DateFormat('yyyy-MM-dd').format(date);

    return formattedDate;
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
          adultLname_controller.text = traveller['UDLastName'];
          dateControllerAdult1.text = traveller['UDDOB'];
          String inputDate = dateControllerAdult1.text;
          formattedDate = convertDate(inputDate);
          print("formattedDate" + formattedDate);

          print('finDate' + dateControllerAdult1.text.toString());
          if (traveller['GenderId'] == 0) {
            selectedGendarContactDetail = "Male";
            Gendar = '0';
          } else if (traveller['GenderId'] == 1) {
            selectedGendarContactDetail = "Female";
            Gendar = "1";
          }
          print("Gendar" + Gendar);
          // Get data from Table1
          Documentnumber_controller.text = passportInfo['PDPassportNo'];

          String dateOfBirth = passportInfo['PDDateofBirth'];
          Documentype_controller.text = passportInfo['PDDocument'];
          String issuingCountry = passportInfo['PDIssuingCountry'];
          ExpiryDateController.text = passportInfo['PDDateofExpiry'];
          DateTime checkinDateTime = DateTime.parse(ExpiryDateController.text);
          String finDate = DateFormat('yyyy/MM/dd').format(checkinDateTime);

          ExpiryDateController.text = finDate;
          print('finDate' + ExpiryDateController.text.toString());
          // Update other text controllers with relevant fields
        });
      } else {
        throw Exception('Failed to load traveller details');
      }
    }
  }

  Future<void> _selectDateAdult2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult2) {
      setState(() {
        dateControllerAdult2.text = DateFormat('yyyy-MM-dd').format(picked);
      });
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
                color: Colors.black,
                size: 27,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(width: 1), // Set the desired width
            Text(
              "Add Adult",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Montserrat", fontSize: 19),
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
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: 'Mr',
                            groupValue: selectedTitleAdult1,
                            onChanged: (value) {
                              setState(() {
                                selectedTitleAdult1 = value.toString();
                              });
                            },
                          ),
                          Text('Mr.',
                              style:
                              TextStyle(fontWeight: FontWeight.bold)),
                          Radio(
                            value: 'Mrs',
                            groupValue: selectedTitleAdult1,
                            onChanged: (value) {
                              setState(() {
                                selectedTitleAdult1 = value.toString();
                              });
                            },
                          ),
                          Text('Mrs.',
                              style:
                              TextStyle(fontWeight: FontWeight.bold)),
                          Radio(
                            value: 'Ms',
                            groupValue: selectedTitleAdult1,
                            onChanged: (value) {
                              setState(() {
                                selectedTitleAdult1 = value.toString();
                              });
                            },
                          ),
                          Text('Ms.',
                              style:
                              TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Container(
                          width: 340,
                          height: 50,
                          child: Autocomplete<TravellerDetailsModel>(
                            optionsBuilder: (TextEditingValue textEditingValue) async {
                              // Prevent suggestions from displaying in edit mode
                              if (widget.isEdit == 'Edit') {
                                return const Iterable<TravellerDetailsModel>.empty();
                              }
                              // Show suggestions only if there is input
                              if (textEditingValue.text.isEmpty || textEditingValue.text.length < 1) {
                                return const Iterable<TravellerDetailsModel>.empty();
                              }
                              return await fetchAutocompleteData(textEditingValue.text); // Fetch autocomplete data
                            },
                            displayStringForOption: (TravellerDetailsModel option) => option.name,
                            onSelected: (TravellerDetailsModel? selectedOption) {
                              if (selectedOption != null) {
                                setState(() {
                                  adultFname_controller.text = selectedOption.name;
                                  AdultName1 = selectedOption.name;
                                  AdultTravellerId1 = selectedOption.id;
                                  print('Selected name: ' + AdultName1);
                                  callSecondApi(selectedOption.id);
                                });
                              }
                            },
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController textEditingController,
                                FocusNode focusNode,
                                VoidCallback onFieldSubmitted) {

                              // If in edit mode, set the initial value
                              if (widget.childIndex >= 0 && widget.childIndex < widget.childrenList.length) {
                                // Prepopulate the first name if it exists
                                textEditingController.text = widget.childrenList[widget.childIndex]['firstName'] ?? '';
                              }

                              // Assign the controller for consistent use
                              adultFname_controller = textEditingController;

                              return TextFormField(
                                controller: adultFname_controller,
                                focusNode: focusNode,
                                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                                onFieldSubmitted: (value) {
                                  onFieldSubmitted();
                                },
                                readOnly: widget.isEdit == 'Edit',
                                decoration: InputDecoration(
                                  label: const Text('First & Middle Name'),
                                  hintText: 'Enter First Name',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.red, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 10, left: 10),
                        child: Container(
                          width: 350,
                          height: 50,
                          child: TextFormField(
                            controller: adultLname_controller,
                            decoration: InputDecoration(
                              label: const Text('SurName'),
                              hintText: 'SurName',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 10, left: 10),
                        child: Container(
                          height: 50,
                          child: TextField(
                            onTap: () {
                              _selectDateAdult1(context);
                            },
                            controller: dateControllerAdult1,
                            readOnly: true,
                            decoration: InputDecoration(
                              label: const Text('DOB'),
                              hintText: 'DOB',
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  _selectDateAdult1(context);
                                },
                                child: Image.asset(
                                  'assets/images/calendar.png',
                                  cacheWidth: 25,
                                  cacheHeight: 25,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: .1),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: DropdownButton(
                              dropdownColor: Colors.white,
                              underline: SizedBox(),
                              value: selectedCountryCode,
                              iconSize: 0.0,
                              items:
                              ['+91', '+1', '+44'].map((String code) {
                                return DropdownMenuItem<String>(
                                  value: code,
                                  child: Text(code),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedCountryCode = value.toString();
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              height: 50,
                              width: 290,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: contactMobileController,
                                decoration: InputDecoration(
                                  label: const Text('Mobile Number'),
                                  hintText: 'Mobile Number',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey),
                                    borderRadius:
                                    BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1.5),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: Container(
                          height: 50,
                          child: TextFormField(
                            controller: _CountryController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              label: const Text('Nationality'),
                              hintText: 'Nationality',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(

                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade200, // Light grey color for the starting horizontal line
                    width: 2, // Thickness of the line
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity, // Makes the button take full width
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF152238), // Button background color
                            fixedSize: const Size.fromHeight(47), // Set button height to 45
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          onPressed: () {
                            _saveAdult(); // Action when button is pressed
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(fontSize: 18), // Button text with font size
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),





        ],
      ),
    );
  }
}
