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
    mutableAdultsList = List.from(widget.adultsList);
    _retrieveSavedValues();
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
      adultLname_controller.text = adult['surname'];
      dateControllerAdult1.text = adult['dob']; // Keep DOB as is
      Documentype_controller.text =
          adult['documentType'] ?? ''; // Handle null values
      Documentnumber_controller.text = adult['documentNumber'] ?? '';
      ExpiryDateController.text = adult['expiryDate'] ?? '';
      selectedTitleAdult1 = adult['title'] ?? '';
    }
  }

  void _saveAdult() async {
    try {
      // Retrieve input values and trim whitespace
      String title = selectedTitleAdult1.toString();
      String firstName = adultFname_controller.text.trim();
      String surname = adultLname_controller.text.trim();
      String dob = dateControllerAdult1.text.trim();
      String documentType = Documentype_controller.text.trim();
      String documentNumber = Documentnumber_controller.text.trim();
      String expiryDate = ExpiryDateController.text.trim();

      // Check if any of the fields are empty
      if (title.isEmpty ||
          firstName.isEmpty ||
          surname.isEmpty ||
          dob.isEmpty
        ) {
        // Display an error message
        Fluttertoast.showToast(
          msg: "Please add Adult",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return; // Exit the function early if any field is empty
      }

      Map<String, dynamic> adultData = {
        'title': title,
        'firstName': firstName,
        'surname': surname,
        'dob': dob,
        'documentType': documentType,
        'documentNumber': documentNumber,
        'expiryDate': expiryDate,
      };
      final dbHelper = DatabaseHelper.instance;

      // Check if the name already exists in the list
      bool nameExists = mutableAdultsList.any((adult) {
        return adult['firstName'] == firstName &&
            adult['surname'] == surname &&
            (widget.isEdit == 'Add' ||
                (adult['id'] != mutableAdultsList[widget.adultIndex]['id']));
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
      if (widget.isEdit == 'Edit' &&
          widget.adultIndex >= 0 &&
          widget.adultIndex < mutableAdultsList.length) {
        // Retrieve the ID of the adult we are updating
        int? adultId = mutableAdultsList[widget.adultIndex]['id'];
        if (adultId != null) {
          // Update existing adult using the correct ID
          await dbHelper.updateAdults(adultId, adultData);
          print("Updated adult data for ID: $adultId");

          // Fetch updated data after the update
          Map<String, dynamic>? updatedAdult =
          await dbHelper.fetchAdultData(adultId);
          print("Updated adult: $updatedAdult");

          if (updatedAdult != null) {
            setState(() {
              // Update the specific child in the mutable list
              mutableAdultsList[widget.adultIndex] = updatedAdult;
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
        await dbHelper.insertAdults(adultData);
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

  Future<void> _selectDateChildren3(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren3) {
      setState(() {
        dateControllerChildren3.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateChildren4(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren4) {
      setState(() {
        dateControllerChildren4.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateChildren5(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren5) {
      setState(() {
        dateControllerChildren5.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateInfant1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerInfant1) {
      setState(() {
        dateControllerInfant1.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateInfant2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerInfant2) {
      setState(() {
        dateControllerInfant2.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateInfant3(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerInfant3) {
      setState(() {
        dateControllerInfant3.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  var resultFlightData = [];

  Future<void> submitAdivahaFlightBooking() async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaFlightBooking');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    String resultIndex = widget.flightDetails['ResultIndexID'];
    String traceId = widget.flightDetails['ItemId'];

    DateTime date = DateFormat('yyyy/MM/dd').parse(widget.departdate);

    // Format the date string with dashes
    formattedFromDate = DateFormat('yyyy-MM-dd').format(date);

    print(formattedFromDate);
    var reqBody = {
      'ResultIndex': resultFlightData[0]['ResultIndexID'].toString(),
      'TraceId': resultFlightData[0]['ItemId'].toString(),
      'LCC': resultFlightData[0]['IsLCC'].toString(),
      'TripType': 'OneWay',
      'UserId': userID.toString(),
      'UserTypeId': userTypeID.toString(),
      'DefaultCurrency': resultFlightData[0]['BookingCurrency'].toString(),
      'FromDate': formattedFromDate.toString(),
      'AdultCount': widget.adultCount.toString(),
      'ChildCount': widget.childrenCount.toString(),
      'InfantCount': widget.infantCount.toString(),
      'BookingCurrency': Currency.toString(),
      'BookingBaseFare': resultFlightData[0]['BookingBaseFare'].toString(),
      'BookingTax': resultFlightData[0]['BookingTax'].toString(),
      'BookingYQTax': resultFlightData[0]['BookingYQTax'].toString(),
      'BookingAdditionalTxnFeePub':
          resultFlightData[0]['BookingAdditionalTxnFeePub'].toString(),
      'BookingAdditionalTxnFeeOfrd':
          resultFlightData[0]['BookingAdditionalTxnFeeOfrd'].toString(),
      'BookingOtherCharges':
          resultFlightData[0]['BookingOtherCharges'].toString(),
      'BookingDiscount': resultFlightData[0]['BookingDiscount'].toString(),
      'BookingPublishedFare':
          resultFlightData[0]['BookingPublishedFare'].toString(),
      'BookingOfferedFare':
          resultFlightData[0]['BookingOfferedFare'].toString(),
      'BookingTdsOnCommission':
          resultFlightData[0]['BookingTdsOnCommission'].toString(),
      'BookingTdsOnPLB': resultFlightData[0]['BookingTdsOnPLB'].toString(),
      'BookingTdsOnIncentive':
          resultFlightData[0]['BookingTdsOnIncentive'].toString(),
      'BookingServiceFee': resultFlightData[0]['BookingServiceFee'].toString(),
      'GSTCompanyAddress': '',
      'GSTCompanyContactNumber': '',
      'GSTCompanyName': '',
      'GSTNumber': '',
      'GSTCompanyEmail': '',
      'TitleAdult1': selectedTitleAdult1.toString(),
      'FNameAdult1': AdultName1.toString(),
      'LNameAdult1': adultLname_controller.text.toString(),
      'LDOBAdult1': formattedDate.toString(),
      'GenderAdult1': Gendar.toString(),
      'DocNumAdult1': Documentnumber_controller.text.toString(),
      'ExpDateAdult1': ExpiryDateController.text.toString(),
      'TitleAdult2': '',
      'FNameAdult2': '',
      'LNameAdult2': '',
      'LDOBAdult2': '',
      'GenderAdult2': '',
      'DocNumAdult2': '',
      'ExpDateAdult2': '',
      'TitleAdult3': '',
      'FNameAdult3': '',
      'LNameAdult3': '',
      'LDOBAdult3': '',
      'GenderAdult3': '',
      'DocNumAdult3': '',
      'ExpDateAdult3': '',
      'TitleAdult4': '',
      'FNameAdult4': '',
      'LNameAdult4': '',
      'LDOBAdult4': '',
      'GenderAdult4': '',
      'DocNumAdult4': '',
      'ExpDateAdult4': '',
      'TitleAdult5': '',
      'FNameAdult5': '',
      'LNameAdult5': '',
      'LDOBAdult5': '',
      'GenderAdult5': '',
      'DocNumAdult5': '',
      'ExpDateAdult5': '',
      'TitleAdult6': '',
      'FNameAdult6': '',
      'LNameAdult6': '',
      'LDOBAdult6': '',
      'GenderAdult6': '',
      'DocNumAdult6': '',
      'ExpDateAdult6': '',
      'TitleAdult7': '',
      'FNameAdult7': '',
      'LNameAdult7': '',
      'LDOBAdult7': '',
      'GenderAdult7': '',
      'DocNumAdult7': '',
      'ExpDateAdult7': '',
      'TitleAdult8': '',
      'FNameAdult8': '',
      'LNameAdult8': '',
      'LDOBAdult8': '',
      'GenderAdult8': '',
      'DocNumAdult8': '',
      'ExpDateAdult8': '',
      'TitleAdult9': '',
      'FNameAdult9': '',
      'LNameAdult9': '',
      'LDOBAdult9': '',
      'GenderAdult9': '',
      'DocNumAdult9': '',
      'ExpDateAdult9': '',
      'TitleAdult10': '',
      'FNameAdult10': '',
      'LNameAdult10': '',
      'LDOBAdult10': '',
      'GenderAdult10': '',
      'DocNumAdult10': '',
      'ExpDateAdult10': '',
      'TitleChild1': '',
      'FNameChild1': '',
      'LNameChild1': '',
      'LDOBChild1': '',
      'GenderChild1': '',
      'DocNumChild1': '',
      'ExpDateChild1': '',
      'TitleChild2': '',
      'FNameChild2': '',
      'LNameChild2': '',
      'LDOBChild2': '',
      'GenderChild2': '',
      'DocNumChild2': '',
      'ExpDateChild2': '',
      'TitleChild3': '',
      'FNameChild3': '',
      'LNameChild3': '',
      'LDOBChild3': '',
      'GenderChild3': '',
      'DocNumChild3': '',
      'ExpDateChild3': '',
      'TitleChild4': '',
      'FNameChild4': '',
      'LNameChild4': '',
      'LDOBChild4': '',
      'GenderChild4': '',
      'DocNumChild4': '',
      'ExpDateChild4': '',
      'TitleChild5': '',
      'FNameChild5': '',
      'LNameChild5': '',
      'LDOBChild5': '',
      'GenderChild5': '',
      'DocNumChild5': '',
      'ExpDateChild5': '',
      'TitleInfant1': '',
      'FNameInfant1': '',
      'LNameInfant1': '',
      'LDOBInfant1': '',
      'GenderInfant1': '',
      'DocNumInfant1': '',
      'ExpDateInfant1': '',
      'TitleInfant2': '',
      'FNameInfant2': '',
      'LNameInfant2': '',
      'LDOBInfant2': '',
      'GenderInfant2': '',
      'DocNumInfant2': '',
      'ExpDateInfant2': '',
      'TitleInfant3': '',
      'FNameInfant3': '',
      'LNameInfant3': '',
      'LDOBInfant3': '',
      'GenderInfant3': '',
      'DocNumInfant3': '',
      'ExpDateInfant3': '',
      'TitleInfant4': '',
      'FNameInfant4': '',
      'LNameInfant4': '',
      'LDOBInfant4': '',
      'GenderInfant4': '',
      'DocNumInfant4': '',
      'ExpDateInfant4': '',
      'TitleInfant5': '',
      'FNameInfant5': '',
      'LNameInfant5': '',
      'LDOBInfant5': '',
      'GenderInfant5': '',
      'DocNumInfant5': '',
      'ExpDateInfant5': '',
      'Address': contactAddressController.text.toString(),
      'City': contactCityController.text.toString(),
      'CountryCode': 'IN',
      'CountryName': _CountryController.text.toString(),
      'MobileNumber': contactMobileController.text.toString(),
      'Email': contactEmailController.text.toString(),
      'IsPassportRequired': 'True',
      'AdultTravellerID1': AdultTravellerId1.toString(),
      'AdultTravellerID2': '',
      'AdultTravellerID3': '',
      'AdultTravellerID4': '',
      'AdultTravellerID5': '',
      'AdultTravellerID6': '',
      'AdultTravellerID7': '',
      'AdultTravellerID8': '',
      'AdultTravellerID9': '',
      'AdultTravellerID10': ''
    };
    developer.log('ResultIndex: $resultIndex');
    print('TraceId: $traceId');
    print('LCC: True');
    print('TripType: OneWay');
    print('UserId: $userID');
    print('UserTypeId: $userTypeID');
    print('DefaultCurrency: $Currency');
    print('FromDate: ${formattedFromDate.toString()}');
    print('AdultCount: ${widget.adultCount}');
    print('ChildCount: ${widget.childrenCount}');
    print('InfantCount: ${widget.infantCount}');
    print('BookingCurrency: ${resultFlightData[0]['BookingCurrency']}');
    print('BookingBaseFare: ${resultFlightData[0]['BookingBaseFare']}');
    print('BookingTax: ${resultFlightData[0]['BookingTax']}');
    print('BookingYQTax: ${resultFlightData[0]['BookingYQTax']}');
    print(
        'BookingAdditionalTxnFeePub: ${resultFlightData[0]['BookingAdditionalTxnFeePub']}');
    print(
        'BookingAdditionalTxnFeeOfrd: ${resultFlightData[0]['BookingAdditionalTxnFeeOfrd']}');
    print('BookingOtherCharges: ${resultFlightData[0]['BookingOtherCharges']}');
    print('BookingDiscount: ${resultFlightData[0]['BookingDiscount']}');
    print(
        'BookingPublishedFare: ${resultFlightData[0]['BookingPublishedFare']}');
    print('BookingOfferedFare: ${resultFlightData[0]['BookingOfferedFare']}');
    print(
        'BookingTdsOnCommission: ${resultFlightData[0]['BookingTdsOnCommission']}');
    print('BookingTdsOnPLB: ${resultFlightData[0]['BookingTdsOnPLB']}');
    print(
        'BookingTdsOnIncentive: ${resultFlightData[0]['BookingTdsOnIncentive']}');
    print('BookingServiceFee: ${resultFlightData[0]['BookingServiceFee']}');
    print('GSTCompanyAddress: ');
    print('GSTCompanyContactNumber: ');
    print('GSTCompanyName: ');
    print('GSTNumber: ');
    print('GSTCompanyEmail: ');
    print('TitleAdult1: $selectedTitleAdult1');
    print('FNameAdult1: $AdultName1');
    print(
        'LNameAdult1: ${adultLname_controller.text.isEmpty ? 'A' : adultLname_controller.text}');
    print('LDOBAdult1: ${formattedDate.toString()}');
    print('GenderAdult1: $Gendar');
    print('DocNumAdult1: ${Documentnumber_controller.text}');
    print('ExpDateAdult1: ${ExpiryDateController.text}');
// Repeat this pattern for all other fields

    print('Address: ${contactAddressController.text}');
    print('City: ${contactCityController.text}');
    print('CountryCode: IN');
    print('CountryName: India');
    print('MobileNumber: ${contactMobileController.text}');
    print('Email: ${contactEmailController.text}');
    print('AdultTravellerID1:${AdultTravellerId1}');

    try {
      setState(() {
        isBookingLoading = true;
      });

      final response = await http.post(
        url,
        headers: headers,
        body: reqBody,
      );

      setState(() {
        isBookingLoading = false;
      });
      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Request failed with status: ${response.statusCode}');

        // Handle the failure scenario
      }
    } catch (error) {
      print('Error sending request: $error');
    }
  }

  List<Map<String, dynamic>> extractJsonFromXml(String xmlString) {
    var document = xml.XmlDocument.parse(xmlString);

    String jsonString = document.findAllElements('string').first.text;

    List<Map<String, dynamic>> jsonList =
        json.decode(jsonString).cast<Map<String, dynamic>>();

    return jsonList;
  }

  Future<void> getAdivahaFlightDetails() async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaFlightDetailsGet');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    String resultIndex = widget.flightDetails['ResultIndexID'].toString();
    String traceId = widget.flightDetails['ItemId'].toString();

    print(resultIndex);
    print(traceId);
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        url,
        headers: headers,
        body: {
          'ResultIndex': resultIndex.toString(),
          'TraceId': traceId.toString(),
          'TripType': 'OneWay'
        },
      );
      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        //var jsonresp = ResponseHandler.parseData(response.body);
        //var tmp_resultFlightData = json.decode(extractJsonFromXml(response.body).toString());

        print('newww - jsonResulttt:');
        developer.log(extractJsonFromXml(response.body).toString());
        //developer.log(tmp_resultFlightData);
        setState(() {
          resultFlightData = extractJsonFromXml(response.body).toList();
          print('DepartCode : ${resultFlightData[0]['DepartCityCode']}');
        });

        //print('Request successful! Response: ${response.body}');
        // Handle the response data here
      } else {
        print('Request failed with status: ${response.statusCode}');
        // Handle the failure scenario
      }
    } catch (error) {
      print('Error sending request: $error');
      // Handle any exceptions or errors that occurred during the request
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
                                      label: const Text('First & Middle Name'),
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
                              width:   double.infinity,
                              height: 50,                              child: TextFormField(
                                style: TextStyle(fontWeight: FontWeight.w500),
                                controller: adultLname_controller,
                                readOnly: widget.isEdit == 'Edit',
                                decoration: InputDecoration(
                                  label: const Text('SurName'),
                                  hintText: 'SurName',
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
                          Visibility(
                            visible: Status == 2, // Show or hide based on status
                            child: Column(
                              children: [
                                // Fields to show when status is 1
                                // Modify or add more fields as needed
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    height: 50,
                                    child: TextFormField(
                                      controller: Documentype_controller,
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                      decoration: InputDecoration(
                                        label: const Text('Document Type'),
                                        hintText: 'Document Type',
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
                                backgroundColor: Color(0xFF152238),
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
}
