import 'dart:convert';

 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
 import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:xml/xml.dart' as xml;
 import '../../Booking/CommonUtils.dart';
import '../../utils/shared_preferences.dart';
import 'TravellerDetailsModel.dart';

class MultiCityBookFlightNow extends StatefulWidget {
  final flightDetails, resultFlightData, adultCount, childrenCount, infantCount;
  const MultiCityBookFlightNow(
      {super.key,
      required this.flightDetails,
      required this.resultFlightData,
      required this.infantCount,
      required this.childrenCount,
      required this.adultCount});

  @override
  State<MultiCityBookFlightNow> createState() => _OneWayBookingState();
}

class _OneWayBookingState extends State<MultiCityBookFlightNow> {
  bool isLoading = false;
  bool isBookingLoading = false;
  String selectedCountryCode = '+91';
  String selectedTitle = 'Mr';
  String selectedGendar = 'Male';
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
  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  String AdultName1 = '', AdultTravellerId1 = '';
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

  TextEditingController _CountryController = new TextEditingController();
  TextEditingController Documentype_controller = new TextEditingController();
  TextEditingController Documentnumber_controller = new TextEditingController();
  String formattedDate = '';

  String convertDate(String inputDate) {
    // Parse the input date string
    DateTime date = DateFormat('dd MMM yyyy').parse(inputDate);

    // Format the date in the desired format
    formattedDate = DateFormat('yyyy-MM-dd').format(date);

    return formattedDate;
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
  int Status = 2;
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
    setState(() {
      resultFlightData = widget.resultFlightData;
      _retrieveSavedValues();
    });
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

  Future<void> _selectDateInfant4(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerInfant4) {
      setState(() {
        dateControllerInfant4.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateInfant5(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerInfant5) {
      setState(() {
        dateControllerInfant5.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  TextEditingController dateController = TextEditingController();
  void chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1800),
      lastDate: DateTime(2024),
      helpText: 'Select DOB',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter a valid date',
      errorInvalidText: 'Enter a valid date range',
      fieldLabelText: 'DOB',
      fieldHintText: 'Month/Date/Year',
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  var resultFlightData = [];
  Future<void> submitAdivahaFlightBooking() async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaFlightBooking');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    String resultIndex = widget.flightDetails['ResultIndexID'];
    String traceId = widget.flightDetails['ItemId'];

    var reqBody = {
      'ResultIndex': resultIndex,
      'TraceId': traceId,
      'LCC': resultFlightData[0]['IsLCC'].toString(),
      'TripType': 'Multiway',
      'UserId': userID.toString(),
      'AdultCount': widget.adultCount,
      'ChildCount': widget.childrenCount,
      'InfantCount': widget.infantCount,
      'BookingCurrency': resultFlightData[0]['BookingCurrency'].toString(),
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
    try {
      setState(() {
        isBookingLoading = true;
      });
      //developer.log(reqBody.toString());
      final response = await http.post(
        url,
        headers: headers,
        body: reqBody,
      );

      //developer.log(reqBody.toString());

      setState(() {
        isBookingLoading = false;
      });
      if (response.statusCode == 200) {
        //print('Request successful! Response: ${response.body}');
        developer.log(response.body);
        // Handle the response data here
      } else {
        print(
            'Request failed with status: ${response.statusCode} : ${response.body}');
        // Handle the failure scenario
      }
    } catch (error) {
      print('Error sending request: $error');
      // Handle any exceptions or errors that occurred during the request
    }
  }

  List<Map<String, dynamic>> extractJsonFromXml(String xmlString) {
    // Parse the XML string
    var document = xml.XmlDocument.parse(xmlString);

    // Extract the JSON string from the XML string
    String jsonString = document.findAllElements('string').first.text;

    // Decode the JSON string into a list of maps
    List<Map<String, dynamic>> jsonList =
        json.decode(jsonString).cast<Map<String, dynamic>>();

    return jsonList;
  }

  Future<void> getAdivahaFlightDetails() async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaFlightDetailsGet');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    //print(widget.flightDetails['ResultIndexID']);
    //print(widget.flightDetails['ItemId']);

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
    List<String> countryCodes = [
      '+1',
      '+44',
      '+91',
      '+81',
      '+86',
      '+33',
      '+49',
      '+61',
      '+7',
      '+39'
    ];

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
              "Flight Booking",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Montserrat", fontSize: 19),
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
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15),
                color: Color(0xffd9dce1),
                child: Column(
                  children: [
                    resultFlightData.length > 1
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: resultFlightData.length > 1
                                ? resultFlightData.length - 0
                                : 0, //Ipo non stio kuduthu paarunga
                            itemBuilder: (BuildContext context, index) {
                              return Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(20),
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                                'assets/images/img.png'),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              resultFlightData[index]
                                                  ['CarrierName'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  resultFlightData[index]
                                                          ['DepartureDate']
                                                      .toString()
                                                      .substring(0, 10),
                                                ),
                                                Text(
                                                  '${CommonUtils.convertToFormattedTime(resultFlightData[index]['DepartureDate']).toString().toUpperCase()} ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                Text(resultFlightData[index]
                                                    ['DepartCityName']),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Container(
                                                  width: 75,
                                                  child: Text(
                                                    resultFlightData[index]
                                                        ['DepartAirportName'],
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                    'Terminal' +
                                                        " " +
                                                        resultFlightData[index][
                                                            'DepartureTerminal'],
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 12)),
                                              ],
                                            ),
                                            Container(
                                              width: 65,
                                              child: Text(
                                                CommonUtils
                                                    .convertMinutesToHoursMinutes(
                                                        resultFlightData[index]
                                                            ['TravelTime']),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  resultFlightData[index]
                                                          ['ArrivalDate']
                                                      .toString()
                                                      .substring(0, 10),
                                                ),
                                                Text(
                                                  '${CommonUtils.convertToFormattedTime(resultFlightData[index]['ArrivalDate']).toString().toUpperCase()} ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                Text(resultFlightData[index]
                                                    ['ArriveCityName']),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Container(
                                                  width: 75,
                                                  child: Text(
                                                    resultFlightData[index]
                                                        ['ArrivalAirportName'],
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                    'Terminal' +
                                                        " " +
                                                        resultFlightData[index]
                                                            ['ArrivalTerminal'],
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.shopping_bag,
                                                  color: Color(0xFF152238),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  resultFlightData[index]
                                                      ['Baggage'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  'CheckIn\nBaggage',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.shopping_bag,
                                                  color: Color(0xFF152238),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  resultFlightData[index]
                                                      ['CabinBaggage'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  'Cabin Baggage',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.shopping_bag,
                                                  color: Color(0xFF152238),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  'Meal',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                      //empty screen hello varutha?
                                    ),
                                  ), //Oruka stop pannitu run panni one stop varutha nnu confirm pannunga ok run se aagala list load aagathu ine epdi check pana
                                  index + 1 < (resultFlightData.length - 0)
                                      ? Container(
                                          width: double.infinity,
                                          color: Color(0xfff7f7f7),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                CommonUtils
                                                        .convertMinutesToHoursMinutes(
                                                            resultFlightData[
                                                                    index + 1][
                                                                'TravelTime']) +
                                                    " " +
                                                    "Layover",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(), //Run anathum screenshot anupunga ok
                                ],
                              );
                            })
                        : Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/img.png'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      resultFlightData[0]['CarrierName'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          resultFlightData[0]['DepartureDate']
                                              .toString()
                                              .substring(0, 10),
                                        ),
                                        Text(
                                          '${CommonUtils.convertToFormattedTime(resultFlightData[0]['DepartureDate']).toString().toUpperCase()} ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(resultFlightData[0]
                                            ['DepartCityName']),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          resultFlightData[0]
                                              ['DepartAirportName'],
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            'Terminal' +
                                                " " +
                                                resultFlightData[0]
                                                    ['DepartureTerminal'],
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 12)),
                                      ],
                                    ),
                                    Container(
                                      width: 65,
                                      child: Text(
                                        CommonUtils
                                            .convertMinutesToHoursMinutes(
                                                resultFlightData[0]
                                                    ['TravelTime']),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          resultFlightData[0]['ArrivalDate']
                                              .toString()
                                              .substring(0, 10),
                                        ),
                                        Text(
                                          '${CommonUtils.convertToFormattedTime(resultFlightData[0]['ArrivalDate']).toString().toUpperCase()} ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(resultFlightData[0]
                                            ['ArriveCityName']),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          resultFlightData[0]
                                              ['ArrivalAirportName'],
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            'Terminal' +
                                                " " +
                                                resultFlightData[0]
                                                    ['ArrivalTerminal'],
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.shopping_bag,
                                          color: Color(0xFF152238),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          resultFlightData[0]['Baggage'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          'CheckIn\n Baggage',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.shopping_bag,
                                          color: Color(0xFF152238),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          resultFlightData[0]['CabinBaggage'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          'Cabin Baggage',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.shopping_bag,
                                          color: Color(0xFF152238),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          'Meal',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 6,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Adult 1:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Traveller details",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                              ),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      width: 150,
                                      height: 50,
                                      child:
                                          Autocomplete<TravellerDetailsModel>(
                                        optionsBuilder: (TextEditingValue
                                            textEditingValue) async {
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
                                        onSelected: (TravellerDetailsModel?
                                            selectedOption) {
                                          if (selectedOption != null) {
                                            print(
                                                'Selected: ${selectedOption.name}');
                                            setState(() async {
                                              await callSecondApi(
                                                  selectedOption.id);
                                              setState(() {
                                                AdultName1 =
                                                    selectedOption.name;
                                                AdultTravellerId1 =
                                                    selectedOption.id;
                                              });
                                            });
                                          }
                                        },
                                        fieldViewBuilder: (BuildContext context,
                                            TextEditingController
                                                textEditingController,
                                            FocusNode focusNode,
                                            VoidCallback onFieldSubmitted) {
                                          return TextFormField(
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                            controller: textEditingController,
                                            focusNode: focusNode,
                                            onFieldSubmitted: (value) {
                                              onFieldSubmitted();
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('First Name'),
                                              hintText: 'First Name',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      width: 150,
                                      height: 50,
                                      child: TextFormField(
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        controller: adultLname_controller,
                                        decoration: InputDecoration(
                                          label: const Text('SurName'),
                                          hintText: 'SurName',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
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
                              SizedBox(
                                height: 20,
                              ),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
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
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
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
                              Visibility(
                                visible:
                                    Status == 2, // Show or hide based on status
                                child: Column(
                                  children: [
                                    // Fields to show when status is 1
                                    // Modify or add more fields as needed
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextFormField(
                                          controller: Documentype_controller,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                          decoration: InputDecoration(
                                            label: const Text('Document Type'),
                                            hintText: 'Document Type',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                          controller: Documentnumber_controller,
                                          decoration: InputDecoration(
                                            label:
                                                const Text('Document Number'),
                                            hintText: 'Document Number',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectExpiryDate(context);
                                          },
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                          controller: ExpiryDateController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            label: const Text('Expiry Date'),
                                            hintText: 'Expiry Date',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          int.parse(widget.adultCount) > 1
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Adult 2:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Traveller details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Mr',
                                          groupValue: selectedTitleAdult2,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleAdult2 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mr.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Mrs',
                                          groupValue: selectedTitleAdult2,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleAdult2 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mrs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Ms',
                                          groupValue: selectedTitleAdult2,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleAdult2 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Ms.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            width: 135,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('FirstName'),
                                                hintText: 'First Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adjust the space between the text fields

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('SurName'),
                                                hintText: 'SurName',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectDateAdult2(context);
                                          },
                                          controller: dateControllerAdult2,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            label: const Text('DOB'),
                                            hintText: 'DOB',
                                            prefixIcon: GestureDetector(
                                              onTap: () {
                                                _selectDateAdult2(context);
                                              },
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight: 25,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue: selectedGendarAdult2,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarAdult2 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Male.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Radio(
                                              value: 'Female',
                                              groupValue: selectedGendarAdult2,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarAdult2 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Female.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Visibility(
                                      visible: Status ==
                                          2, // Show or hide based on status
                                      child: Column(
                                        children: [
                                          // Fields to show when status is 1
                                          // Modify or add more fields as needed
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: 50,
                                              child: TextFormField(
                                                controller:
                                                    Documentype_controller,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                                decoration: InputDecoration(
                                                  label: const Text(
                                                      'Document Type'),
                                                  hintText: 'Document Type',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red,
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: 50,
                                              child: TextFormField(
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                                controller:
                                                    Documentnumber_controller,
                                                decoration: InputDecoration(
                                                  label: const Text(
                                                      'Document Number'),
                                                  hintText: 'Document Number',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red,
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: 50,
                                              child: TextField(
                                                onTap: () {
                                                  _selectExpiryDate(context);
                                                },
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                                controller:
                                                    ExpiryDateController,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  label:
                                                      const Text('Expiry Date'),
                                                  hintText: 'Expiry Date',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red,
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          int.parse(widget.adultCount) > 2
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Adult 3:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Traveller details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Mr',
                                          groupValue: selectedTitleAdult3,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleAdult3 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mr.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Mrs',
                                          groupValue: selectedTitleAdult3,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleAdult3 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mrs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Ms',
                                          groupValue: selectedTitleAdult3,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleAdult3 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Ms.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            width: 135,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('FirstName'),
                                                hintText: 'First Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adjust the space between the text fields

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('SurName'),
                                                hintText: 'SurName',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectDateAdult3(context);
                                          },
                                          controller: dateControllerAdult3,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            label: const Text('DOB'),
                                            hintText: 'DOB',
                                            prefixIcon: GestureDetector(
                                              onTap: () {
                                                _selectDateAdult3(context);
                                              },
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight: 25,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue: selectedGendarAdult3,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarAdult3 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Male.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Radio(
                                              value: 'Female',
                                              groupValue: selectedGendarAdult3,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarAdult3 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Female.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Visibility(
                                      visible: Status ==
                                          2, // Show or hide based on status
                                      child: Column(
                                        children: [
                                          // Fields to show when status is 1
                                          // Modify or add more fields as needed
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: 50,
                                              child: TextFormField(
                                                controller:
                                                    Documentype_controller,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                                decoration: InputDecoration(
                                                  label: const Text(
                                                      'Document Type'),
                                                  hintText: 'Document Type',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red,
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: 50,
                                              child: TextFormField(
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                                controller:
                                                    Documentnumber_controller,
                                                decoration: InputDecoration(
                                                  label: const Text(
                                                      'Document Number'),
                                                  hintText: 'Document Number',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red,
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: 50,
                                              child: TextField(
                                                onTap: () {
                                                  _selectExpiryDate(context);
                                                },
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                                controller:
                                                    ExpiryDateController,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  label:
                                                      const Text('Expiry Date'),
                                                  hintText: 'Expiry Date',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red,
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          int.parse(widget.adultCount) > 3
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Adult 4:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Traveller details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Mr',
                                          groupValue: selectedTitleAdult4,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleAdult4 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mr.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Mrs',
                                          groupValue: selectedTitleAdult4,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleAdult4 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mrs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Ms',
                                          groupValue: selectedTitleAdult4,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleAdult4 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Ms.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            width: 135,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('FirstName'),
                                                hintText: 'First Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adjust the space between the text fields

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('SurName'),
                                                hintText: 'SurName',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectDateAdult4(context);
                                          },
                                          controller: dateControllerAdult4,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            label: const Text('DOB'),
                                            hintText: 'DOB',
                                            prefixIcon: GestureDetector(
                                              onTap: () {
                                                _selectDateAdult4(context);
                                              },
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight: 25,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue: selectedGendarAdult4,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarAdult4 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Male.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Radio(
                                              value: 'Female',
                                              groupValue: selectedGendarAdult4,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarAdult4 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Female.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Visibility(
                                      visible: Status ==
                                          2, // Show or hide based on status
                                      child: Column(
                                        children: [
                                          // Fields to show when status is 1
                                          // Modify or add more fields as needed
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: 50,
                                              child: TextFormField(
                                                controller:
                                                    Documentype_controller,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                                decoration: InputDecoration(
                                                  label: const Text(
                                                      'Document Type'),
                                                  hintText: 'Document Type',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red,
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: 50,
                                              child: TextFormField(
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                                controller:
                                                    Documentnumber_controller,
                                                decoration: InputDecoration(
                                                  label: const Text(
                                                      'Document Number'),
                                                  hintText: 'Document Number',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red,
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: 50,
                                              child: TextField(
                                                onTap: () {
                                                  _selectExpiryDate(context);
                                                },
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                                controller:
                                                    ExpiryDateController,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  label:
                                                      const Text('Expiry Date'),
                                                  hintText: 'Expiry Date',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red,
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          int.parse(widget.adultCount) > 4
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Adult 5:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Traveller details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Mr',
                                          groupValue: selectedTitleAdult5,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleAdult5 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mr.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Mrs',
                                          groupValue: selectedTitleAdult5,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleAdult5 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mrs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Ms',
                                          groupValue: selectedTitleAdult5,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleAdult5 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Ms.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            width: 135,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('FirstName'),
                                                hintText: 'First Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adjust the space between the text fields

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('SurName'),
                                                hintText: 'SurName',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectDateAdult5(context);
                                          },
                                          controller: dateControllerAdult5,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            label: const Text('DOB'),
                                            hintText: 'DOB',
                                            prefixIcon: GestureDetector(
                                              onTap: () {
                                                _selectDateAdult5(context);
                                              },
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight: 25,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue: selectedGendarAdult5,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarAdult5 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Male.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Radio(
                                              value: 'Female',
                                              groupValue: selectedGendarAdult5,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarAdult5 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Female.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Visibility(
                                      visible: Status ==
                                          2, // Show or hide based on status
                                      child: Column(
                                        children: [
                                          // Fields to show when status is 1
                                          // Modify or add more fields as needed
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: 50,
                                              child: TextFormField(
                                                controller:
                                                    Documentype_controller,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                                decoration: InputDecoration(
                                                  label: const Text(
                                                      'Document Type'),
                                                  hintText: 'Document Type',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red,
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: 50,
                                              child: TextFormField(
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                                controller:
                                                    Documentnumber_controller,
                                                decoration: InputDecoration(
                                                  label: const Text(
                                                      'Document Number'),
                                                  hintText: 'Document Number',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red,
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: 50,
                                              child: TextField(
                                                onTap: () {
                                                  _selectExpiryDate(context);
                                                },
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                                controller:
                                                    ExpiryDateController,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  label:
                                                      const Text('Expiry Date'),
                                                  hintText: 'Expiry Date',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red,
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),

                          //Children

                          int.parse(widget.childrenCount) > 0
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Children 1:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Traveller details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Mr',
                                          groupValue: selectedTitleChildren1,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren1 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mr.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Mrs',
                                          groupValue: selectedTitleChildren1,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren1 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mrs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Ms',
                                          groupValue: selectedTitleChildren1,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren1 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Ms.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            width: 135,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('FirstName'),
                                                hintText: 'First Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adjust the space between the text fields

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('SurName'),
                                                hintText: 'SurName',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectDateChildren1(context);
                                          },
                                          controller: dateControllerChildren1,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            label: const Text('DOB'),
                                            hintText: 'DOB',
                                            prefixIcon: GestureDetector(
                                              onTap: () {
                                                _selectDateChildren1(context);
                                              },
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight: 25,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue:
                                                  selectedGendarChildren1,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarChildren1 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Male.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Radio(
                                              value: 'Female',
                                              groupValue:
                                                  selectedGendarChildren1,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarChildren1 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Female.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : Container(),
                          int.parse(widget.childrenCount) > 1
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Children 2:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Traveller details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Mr',
                                          groupValue: selectedTitleChildren2,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren2 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mr.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Mrs',
                                          groupValue: selectedTitleChildren2,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren2 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mrs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Ms',
                                          groupValue: selectedTitleChildren2,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren2 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Ms.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            width: 135,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('FirstName'),
                                                hintText: 'First Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adjust the space between the text fields

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('SurName'),
                                                hintText: 'SurName',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectDateChildren2(context);
                                          },
                                          controller: dateControllerChildren2,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            label: const Text('DOB'),
                                            hintText: 'DOB',
                                            prefixIcon: GestureDetector(
                                              onTap: () {
                                                _selectDateChildren2(context);
                                              },
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight: 25,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue:
                                                  selectedGendarChildren2,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarChildren2 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Male.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Radio(
                                              value: 'Female',
                                              groupValue:
                                                  selectedGendarChildren2,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarChildren2 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Female.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : Container(),
                          int.parse(widget.childrenCount) > 2
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Children 3:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Traveller details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Mr',
                                          groupValue: selectedTitleChildren3,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren3 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mr.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Mrs',
                                          groupValue: selectedTitleChildren3,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren3 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mrs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Ms',
                                          groupValue: selectedTitleChildren3,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren3 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Ms.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            width: 135,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('FirstName'),
                                                hintText: 'First Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adjust the space between the text fields

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('SurName'),
                                                hintText: 'SurName',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectDateChildren3(context);
                                          },
                                          controller: dateControllerChildren3,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            label: const Text('DOB'),
                                            hintText: 'DOB',
                                            prefixIcon: GestureDetector(
                                              onTap: () {
                                                _selectDateChildren3(context);
                                              },
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight: 25,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue:
                                                  selectedGendarChildren3,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarChildren3 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Male.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Radio(
                                              value: 'Female',
                                              groupValue:
                                                  selectedGendarChildren3,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarChildren3 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Female.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : Container(),
                          int.parse(widget.childrenCount) > 3
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Children 4:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Traveller details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Mr',
                                          groupValue: selectedTitleChildren4,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren4 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mr.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Mrs',
                                          groupValue: selectedTitleChildren4,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren4 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mrs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Ms',
                                          groupValue: selectedTitleChildren4,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren4 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Ms.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            width: 135,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('FirstName'),
                                                hintText: 'First Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adjust the space between the text fields

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('SurName'),
                                                hintText: 'SurName',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectDateChildren4(context);
                                          },
                                          controller: dateControllerChildren4,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            label: const Text('DOB'),
                                            hintText: 'DOB',
                                            prefixIcon: GestureDetector(
                                              onTap: () {
                                                _selectDateChildren4(context);
                                              },
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight: 25,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue:
                                                  selectedGendarChildren4,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarChildren4 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Male.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Radio(
                                              value: 'Female',
                                              groupValue:
                                                  selectedGendarChildren4,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarChildren4 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Female.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : Container(),
                          int.parse(widget.childrenCount) > 4
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Children 5:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Traveller details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Mr',
                                          groupValue: selectedTitleChildren5,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren5 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mr.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Mrs',
                                          groupValue: selectedTitleChildren5,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren5 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mrs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Ms',
                                          groupValue: selectedTitleChildren5,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleChildren5 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Ms.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            width: 135,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('FirstName'),
                                                hintText: 'First Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adjust the space between the text fields

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('SurName'),
                                                hintText: 'SurName',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectDateChildren5(context);
                                          },
                                          controller: dateControllerChildren5,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            label: const Text('DOB'),
                                            hintText: 'DOB',
                                            prefixIcon: GestureDetector(
                                              onTap: () {
                                                _selectDateChildren5(context);
                                              },
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight: 25,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue:
                                                  selectedGendarChildren5,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarChildren5 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Male.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Radio(
                                              value: 'Female',
                                              groupValue:
                                                  selectedGendarChildren5,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarChildren5 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Female.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : Container(),

                          int.parse(widget.infantCount) > 0
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Infant 1:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Traveller details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Mr',
                                          groupValue: selectedTitleInfant1,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant1 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mr.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Mrs',
                                          groupValue: selectedTitleInfant1,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant1 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mrs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Ms',
                                          groupValue: selectedTitleInfant1,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant1 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Ms.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            width: 135,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('FirstName'),
                                                hintText: 'First Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adjust the space between the text fields

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('SurName'),
                                                hintText: 'SurName',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectDateInfant1(context);
                                          },
                                          controller: dateControllerInfant1,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            label: const Text('DOB'),
                                            hintText: 'DOB',
                                            prefixIcon: GestureDetector(
                                              onTap: () {
                                                _selectDateInfant1(context);
                                              },
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight: 25,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue: selectedGendarInfant1,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarInfant1 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Male.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Radio(
                                              value: 'Female',
                                              groupValue: selectedGendarInfant1,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarInfant1 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Female.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : Container(),
                          int.parse(widget.infantCount) > 0
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Infant 2:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Traveller details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Mr',
                                          groupValue: selectedTitleInfant2,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant2 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mr.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Mrs',
                                          groupValue: selectedTitleInfant2,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant2 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mrs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Ms',
                                          groupValue: selectedTitleInfant2,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant2 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Ms.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            width: 135,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('FirstName'),
                                                hintText: 'First Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adjust the space between the text fields

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('SurName'),
                                                hintText: 'SurName',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectDateInfant2(context);
                                          },
                                          controller: dateControllerInfant2,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            label: const Text('DOB'),
                                            hintText: 'DOB',
                                            prefixIcon: GestureDetector(
                                              onTap: () {
                                                _selectDateInfant2(context);
                                              },
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight: 25,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue: selectedGendarInfant2,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarInfant2 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Male.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Radio(
                                              value: 'Female',
                                              groupValue: selectedGendarInfant2,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarInfant2 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Female.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : Container(),
                          int.parse(widget.infantCount) > 0
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Infant 3:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Traveller details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Mr',
                                          groupValue: selectedTitleInfant3,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant3 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mr.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Mrs',
                                          groupValue: selectedTitleInfant3,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant3 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mrs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Ms',
                                          groupValue: selectedTitleInfant3,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant3 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Ms.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            width: 135,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('FirstName'),
                                                hintText: 'First Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adjust the space between the text fields

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('SurName'),
                                                hintText: 'SurName',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectDateInfant3(context);
                                          },
                                          controller: dateControllerInfant3,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            label: const Text('DOB'),
                                            hintText: 'DOB',
                                            prefixIcon: GestureDetector(
                                              onTap: () {
                                                _selectDateInfant3(context);
                                              },
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight: 25,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue: selectedGendarInfant3,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarInfant3 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Male.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Radio(
                                              value: 'Female',
                                              groupValue: selectedGendarInfant3,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarInfant3 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Female.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : Container(),
                          int.parse(widget.infantCount) > 0
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Infant 4:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Traveller details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Mr',
                                          groupValue: selectedTitleInfant4,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant4 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mr.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Mrs',
                                          groupValue: selectedTitleInfant4,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant4 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mrs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Ms',
                                          groupValue: selectedTitleInfant4,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant4 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Ms.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            width: 135,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('FirstName'),
                                                hintText: 'First Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adjust the space between the text fields

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('SurName'),
                                                hintText: 'SurName',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectDateInfant4(context);
                                          },
                                          controller: dateControllerInfant4,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            label: const Text('DOB'),
                                            hintText: 'DOB',
                                            prefixIcon: GestureDetector(
                                              onTap: () {
                                                _selectDateInfant4(context);
                                              },
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight: 25,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue: selectedGendarInfant4,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarInfant4 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Male.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Radio(
                                              value: 'Female',
                                              groupValue: selectedGendarInfant4,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarInfant4 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Female.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : Container(),
                          int.parse(widget.infantCount) > 0
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Infant 5:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Traveller details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Mr',
                                          groupValue: selectedTitleInfant5,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant5 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mr.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Mrs',
                                          groupValue: selectedTitleInfant5,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant5 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Mrs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Radio(
                                          value: 'Ms',
                                          groupValue: selectedTitleInfant5,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedTitleInfant5 =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        Text('Ms.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Container(
                                            width: 135,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('FirstName'),
                                                hintText: 'First Name',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adjust the space between the text fields

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                label: const Text('SurName'),
                                                hintText: 'SurName',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Container(
                                        height: 50,
                                        child: TextField(
                                          onTap: () {
                                            _selectDateInfant5(
                                                context); // Call your function to show the date picker
                                          },
                                          controller: dateControllerInfant5,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: 'DOB',
                                            hintText: 'DOB',
                                            prefixIcon: GestureDetector(
                                              onTap: () {
                                                _selectDateInfant5(
                                                    context); // Call your function to show the date picker
                                              },
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight: 25,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue: selectedGendarInfant5,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarInfant5 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Male.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Radio(
                                              value: 'Female',
                                              groupValue: selectedGendarInfant5,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGendarInfant5 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                            Text('Female.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 6,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Contact details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 310,
                                  height: 50,
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    controller: contactEmailController,
                                    decoration: InputDecoration(
                                      label: const Text('Email'),
                                      hintText: 'EMail Address',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 'Male',
                                    groupValue: selectedGendarContactDetail,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGendarContactDetail =
                                            value.toString();
                                      });
                                    },
                                  ),
                                  Text('Male.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Radio(
                                    value: 'Female',
                                    groupValue: selectedGendarContactDetail,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGendarContactDetail =
                                            value.toString();
                                      });
                                    },
                                  ),
                                  Text('Female.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10), // Adjust left margin as needed
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
                                  // Array list of items
                                  items: countryCodes.map((String code) {
                                    return DropdownMenuItem<String>(
                                      value: code,
                                      child: Text(code),
                                    );
                                  }).toList(),

                                  onChanged: (Object? value) {
                                    setState(() {
                                      selectedCountryCode = value.toString();
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 260,
                                  height: 50,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: contactMobileController,
                                    decoration: InputDecoration(
                                      label: const Text('Mobile Number'),
                                      hintText: 'Mobile Number',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              width: 310,
                              height: 50,
                              child: TextFormField(
                                textCapitalization: TextCapitalization.words,
                                controller: contactAddressController,
                                decoration: InputDecoration(
                                  label: const Text('Address'),
                                  hintText: 'Address',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
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
                              width: 310,
                              height: 50,
                              child: TextFormField(
                                textCapitalization: TextCapitalization.words,
                                controller: contactCityController,
                                decoration: InputDecoration(
                                  label: const Text('City'),
                                  hintText: 'City',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
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
                              width: 310,
                              height: 50,
                              child: TextFormField(
                                controller: _CountryController,
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  label: const Text('Country'),
                                  hintText: 'Country',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 6,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price Summary',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'View Full Breakup',
                                  style: TextStyle(
                                    color: Color(0xFF152238),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 1, color: Colors.grey),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Base Price',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  resultFlightData[0]["BookingBaseFare"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Add other pricing details or components as needed
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tax Price',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  resultFlightData[0]["BookingTax"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Amount To Be Paid',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  resultFlightData[0]["TotalPrice"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  resultFlightData[0]["Currency"] +
                                      " " +
                                      resultFlightData[0]["TotalPrice"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    submitAdivahaFlightBooking();
                                  },
                                  child: Text('Continue'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
