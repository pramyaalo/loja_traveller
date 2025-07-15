import 'dart:convert';
import 'dart:developer';

 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
 import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:xml/xml.dart' as xml;

import 'package:get/get.dart';

import '../AdultDatabaseHelperCass.dart';
import '../DatabseHelper.dart';
import '../utils/shared_preferences.dart';
import 'flight/TravellerDetailsModel.dart';



class AddAdultScreen extends StatefulWidget {
  final flightDetails,
      resultFlightData,
      adultCount,
      childrenCount,
      infantCount,
      departdate,
      userid,
      usertypeid,
      isEdit;
  final int adultIndex;
  final List<dynamic> adultsList;

  const AddAdultScreen({
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
    required this.adultIndex,
    required this.adultsList,
  });

  @override
  State<AddAdultScreen> createState() => _OneWayBookingState();
}

class _OneWayBookingState extends State<AddAdultScreen> {
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
TextEditingController adultMname_controller=new TextEditingController();
  TextEditingController adult1_Fname_controller = new TextEditingController();
  TextEditingController adult1_Lname_controller = new TextEditingController();

  TextEditingController contactEmailController = new TextEditingController();
  TextEditingController contactMobileController = new TextEditingController();
  TextEditingController contactAddressController = new TextEditingController();
  TextEditingController contactCityController = new TextEditingController();
  TextEditingController _CountryController = new TextEditingController();
  TextEditingController Documentype_controller = new TextEditingController();
  TextEditingController Documentnumber_controller = new TextEditingController();
TextEditingController genderController=new TextEditingController();
TextEditingController IssueDateController=new TextEditingController();
  Future<void> _selectIssueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        IssueDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  var selectedDate = DateTime.now().obs;
  TextEditingController ExpiryDateController = TextEditingController();
  TextEditingController dateControllerAdult1 = TextEditingController();
  String? selectedGender = 'Male';
  String? selectedDocumentType = 'Passport'; // Default value

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

    if (picked != null) {
      setState(() {
        ExpiryDateController.text = DateFormat('yyyy-MM-dd').format(picked); // Correct format
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
   /* AdultDatabaseHelper.instance.deleteDatabaseFile();
    print("Database deleted successfully");*/
    _retrieveSavedValues();
    mutableAdultsList = List.from(widget.adultsList);

    adultFname_controller = TextEditingController();

    adultLname_controller = TextEditingController();
    dateControllerAdult1 = TextEditingController();
    Documentype_controller = TextEditingController();
    Documentnumber_controller = TextEditingController();
    ExpiryDateController = TextEditingController();

    if (widget.adultIndex >= 0 &&
        widget.adultIndex < widget.adultsList.length) {
      var adult = widget.adultsList[widget.adultIndex];

      adultFname_controller.text = adult['firstName'];
      print('object' + adultFname_controller.text);
      adultMname_controller.text=adult['middleName'];
      adultLname_controller.text = adult['surname'];
      dateControllerAdult1.text = adult['dob']; // Keep DOB as is
      selectedDocumentType =
          adult['documentType'] ?? ''; // Handle null va  lues
      Documentnumber_controller.text = adult['documentNumber'] ?? '';
      ExpiryDateController.text = adult['expiryDate'] ?? '';
      selectedTitleAdult1 = adult['title'] ?? '';
      selectedGender = adult['gender'] ?? '';
    }
  }

  void _saveAdult() async {
    final dbHelper = AdultDatabaseHelper.instance;

    // Ensure the DB is open before continuing
    final db = await dbHelper.database;
    if (!db.isOpen) {
      print("DB was closed. Reopening...");
      await dbHelper.reopenDatabase();
    }

    try {
      final dbCheck = await dbHelper.database;
      print("After reopen, DB open? ${dbCheck.isOpen}");

      // Step 1: Retrieve input values
      String title = selectedTitleAdult1?.toString() ?? '';
      String firstName = adultFname_controller.text.trim();
      String middleName = adultMname_controller.text.trim();
      String surname = adultLname_controller.text.trim();
      String dob = dateControllerAdult1.text.trim();
      String gender = selectedGender ?? '';
      String documentType = selectedDocumentType ?? '';
      String documentNumber = Documentnumber_controller.text.trim();
      String issueDate = IssueDateController.text.trim();
      String expiryDate = ExpiryDateController.text.trim();

      // Step 2: Validate required fields
      if ([title, firstName, surname, dob, gender, documentType, documentNumber, issueDate, expiryDate]
          .any((e) => e.isEmpty)) {
        Fluttertoast.showToast(
          msg: "Please fill all required fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }

      // Step 3: Prepare data
      Map<String, dynamic> adultData = {
        'title': title,
        'firstName': firstName,
        'middleName': middleName,
        'surname': surname,
        'dob': dob,
        'gender': gender,
        'documentType': documentType,
        'documentNumber': documentNumber,
        'issueDate': issueDate,
        'expiryDate': expiryDate,
      };

      // Step 4: Check for duplicate name
      bool nameExists = mutableAdultsList.any((adult) {
        return adult['firstName'] == firstName &&
            adult['surname'] == surname &&
            (widget.isEdit == 'Add' ||
                (adult['id'] != mutableAdultsList[widget.adultIndex]['id']));
      });

      if (nameExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Name Already Exists. Please select another name"),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // Step 5: Save (Add or Edit)
      if (widget.isEdit == 'Edit' &&
          widget.adultIndex >= 0 &&
          widget.adultIndex < mutableAdultsList.length) {
        int? adultId = mutableAdultsList[widget.adultIndex]['id'];
        if (adultId != null) {
          await dbHelper.updateAdults(adultId, adultData);
          Map<String, dynamic>? updatedAdult = await dbHelper.fetchAdultData(adultId);

          if (updatedAdult != null) {
            setState(() {
              mutableAdultsList[widget.adultIndex] = updatedAdult;
            });
            Fluttertoast.showToast(
              msg: "Adult data updated successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
          }
        }
      } else if (widget.isEdit == 'Add') {
        await dbHelper.insertAdults(adultData);
        Fluttertoast.showToast(
          msg: "Adult added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }

      // Step 6: Return to previous screen
      Navigator.pop(context, mutableAdultsList);
    } catch (e) {
      print("Error saving adult data: $e");
      Fluttertoast.showToast(
        msg: "Error saving adult data: $e",
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
      print('userIDuserID: $userID');
    });
  }

  Future<List<TravellerDetailsModel>> fetchAutocompleteData(
      String empName) async
  {
    final url =
        'https://boqoltravel.com/app/b2badminapi.asmx/BookingSearchTravellers?UserId=1108&UserTypeId=2&SearchFilter=$empName&UID=35510b94-5342-TDemoB2B-a2e3-2e722772';
    print('usssderID' + userID);
    print('userTyfdfpeID' + userTypeID);
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







  Future<void> callSecondApi(String id) async {
    final url =
        'https://boqoltravel.com/app/b2badminapi.asmx/BookingSearchTravellerDetails?TravellerId=$id&UID=35510b94-5342-TDemoB2B-a2e3-2e722772';
    print('objasdfaffect' + id);

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
          adultFname_controller.text = traveller['UDFirstName'] ?? '';

          adultMname_controller.text=traveller['UDMiddName'];
          adultLname_controller.text = traveller['UDLastName'];
          dateControllerAdult1.text = traveller['UDDOB'];
          String inputDate = dateControllerAdult1.text;
          String cleanedDate = inputDate.split("at").first.trim(); // Gets "13 January 1983"
          formattedDate = convertDate(cleanedDate);

          print('formattedDate' + formattedDate);
          if (traveller['GenderId'] == 1) {
            selectedGender = "Male";
            Gendar = '1';
          } else if (traveller['GenderId'] == 2) {
            selectedGender = "Female";
            Gendar = "2";
          } else {
            selectedGender = "Other";
            Gendar = "3";
          }

          // Get data from Table1
          Documentnumber_controller.text = passportInfo['PDPassportNo'];

          String dateOfBirth = passportInfo['PDDateofBirth'];
          selectedDocumentType = table1Data['PDDocument'] ?? 'Passport';
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
  String convertDate(String inputDate) {
    try {
      // Match the format: 13 January 1983
      DateFormat inputFormat = DateFormat("d MMMM yyyy");
      DateTime parsedDate = inputFormat.parse(inputDate);

      // Output format: 1983-01-13 (or whatever you want)
      DateFormat outputFormat = DateFormat("yyyy-MM-dd");
      return outputFormat.format(parsedDate);
    } catch (e) {
      print("Date parsing error: $e");
      return inputDate; // fallback in case parsing fails
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

  Future<void> _selectDateAdult3(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult3) {
      setState(() {
        dateControllerAdult3.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateAdult4(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult4) {
      setState(() {
        dateControllerAdult4.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateAdult5(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult5) {
      setState(() {
        dateControllerAdult5.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateChildren1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren1) {
      setState(() {
        dateControllerChildren1.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateChildren2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren2) {
      setState(() {
        dateControllerChildren2.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }







  List<Map<String, dynamic>> extractJsonFromXml(String xmlString) {
    var document = xml.XmlDocument.parse(xmlString);

    String jsonString = document.findAllElements('string').first.text;

    List<Map<String, dynamic>> jsonList =
        json.decode(jsonString).cast<Map<String, dynamic>>();

    return jsonList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 1,
        backgroundColor:Color(0xFF00ADEE), // Custom dark color
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 27),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 1),
            Text(
              "Add Adult",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontSize: 19,
              ),
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
      ),
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
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
                                  style: TextStyle(fontWeight: FontWeight.bold)),
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
                                  style: TextStyle(fontWeight: FontWeight.bold)),
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
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7,right: 10,left: 10),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              child: Autocomplete<TravellerDetailsModel>(
                                optionsBuilder:
                                    (TextEditingValue textEditingValue) async {
                                  // Prevent suggestions from displaying in edit mode
                                  if (widget.isEdit == 'Edit') {
                                    return const Iterable<
                                        TravellerDetailsModel>.empty();
                                  }
                                  // Show suggestions only if there is input
                                  if (textEditingValue.text.isEmpty ||
                                      textEditingValue.text.length < 1) {
                                    return const Iterable<
                                        TravellerDetailsModel>.empty();
                                  }
                                  return await fetchAutocompleteData(textEditingValue
                                      .text); // Fetch autocomplete data
                                },
                                displayStringForOption:
                                    (TravellerDetailsModel option) => option.name,
                                onSelected: (TravellerDetailsModel? selectedOption) {
                                  if (selectedOption != null) {
                                    setState(() {
                                      adultFname_controller.text =
                                          selectedOption.name;
                                      AdultName1 = selectedOption.name;
                                      AdultTravellerId1 = selectedOption.id.toString();

                                      print('Selected name: ' + AdultName1);
                                      callSecondApi(selectedOption.id.toString());
                                    });
                                  }
                                },
                                fieldViewBuilder: (BuildContext context,
                                    TextEditingController textEditingController,
                                    FocusNode focusNode,
                                    VoidCallback onFieldSubmitted) {
                                  // If in edit mode, set the initial value
                                  if (widget.adultIndex >= 0 &&
                                      widget.adultIndex < widget.adultsList.length) {
                                    // Prepopulate the first name if it exists
                                    textEditingController.text =
                                        widget.adultsList[widget.adultIndex]
                                                ['firstName'] ??
                                            '';
                                  }

                                  // Assign the controller for consistent use
                                  adultFname_controller = textEditingController;

                                  return TextFormField(
                                    controller: adultFname_controller,
                                    focusNode: focusNode,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500, fontSize: 14),
                                    onFieldSubmitted: (value) {
                                      onFieldSubmitted();
                                    },
                                    readOnly: widget.isEdit == 'Edit',
                                    decoration: InputDecoration(
                                      label: const Text('First Name'),
                                      hintText: 'Enter First Name',
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
                                      labelStyle: const TextStyle(
                                          fontWeight: FontWeight.bold),
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
                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              child: TextFormField(
                                style: TextStyle(fontWeight: FontWeight.w500),
                                controller: adultMname_controller, // ✅ Your middle name controller
                                readOnly: widget.isEdit == 'Edit',
                                decoration: InputDecoration(
                                  label: const Text('Middle Name'),
                                  hintText: 'Middle Name',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.red, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              width:   double.infinity,
                              height: 50,                              child: TextFormField(
                                style: TextStyle(fontWeight: FontWeight.w500),
                                controller: adultLname_controller,
                                readOnly: widget.isEdit == 'Edit',
                                decoration: InputDecoration(
                                  label: const Text('Last Name'),
                                  hintText: 'Last Name',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              height: 50,
                              child: TextField(
                                onTap: () {
                                  _selectDateAdult1(context);
                                },
                                controller: dateControllerAdult1,
                                style: TextStyle(fontWeight: FontWeight.w500),
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
                                    borderSide: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              height: 50, // Set height here
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Gender',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                ),
                                value: selectedGender,
                                items: ['Male', 'Female', 'Other'].map((gender) {
                                  return DropdownMenuItem<String>(
                                    value: gender,
                                    child: Text(gender),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                            ),
                          ),


                          SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: Status == 2, // Show or hide based on status
                            child: Column(
                              children: [
                                // Fields to show when status is 1
                                // Modify or add more fields as needed
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    height: 50, // 🔹 Set the height here
                                    child: DropdownButtonFormField<String>(
                                      value: selectedDocumentType ?? 'Passport', // Default to Passport
                                      decoration: InputDecoration(
                                        label: const Text('Document Type'),
                                        hintText: 'Select Document Type',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0), // 🔹 Adjust vertical padding to fit in 50 height
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.black, width: 1.5),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.red, width: 2),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      items: ['Passport', 'Iqama', 'National ID'].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedDocumentType = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),


                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    height: 50,
                                    child: TextFormField(
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                      controller: Documentnumber_controller,
                                      decoration: InputDecoration(
                                        label: const Text('Document Number'),
                                        hintText: 'Document Number',
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
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 2),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    height: 50,
                                    child: TextField(
                                      onTap: () {
                                        _selectIssueDate(context);
                                      },
                                      controller: IssueDateController,
                                      readOnly: true,
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                      decoration: inputDecoration('Issue Date', 'Issue Date').copyWith(
                                        prefixIcon: GestureDetector(
                                          onTap: () {
                                            _selectIssueDate(context);
                                          },
                                          child: Icon(Icons.calendar_today),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    height: 50,
                                    child: TextField(
                                      onTap: () {
                                        _selectExpiryDate(context);
                                      },
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                      controller: ExpiryDateController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        label: const Text('Expiry Date'),
                                        hintText: 'Expiry Date',
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
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 2),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                        color: Colors.grey.shade200,
                        // Light grey color for the starting horizontal line
                        width: 2, // Thickness of the line
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            // Makes the button take full width
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:Color(0xFF00ADEE),
                                // Button background color
                                fixedSize: const Size.fromHeight(47),
                                // Set button height to 45
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                              ),
                              onPressed: () {
                                _saveAdult(); // Action when button is pressed
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    fontSize: 18), // Button text with font size
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
    );
  }
  InputDecoration inputDecoration(String label, String hint) {
    return InputDecoration(
      label: Text(label),
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

}
