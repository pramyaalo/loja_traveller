import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

import '../../Booking/CommonUtils.dart';
import '../../DatabseHelper.dart';
import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';
import '../AddAdultScreen.dart';
import 'AddChildScreen.dart';
import 'AddInfantScreen.dart';
import 'Children_DatabaseHelper.dart';
import 'InfantDatabaseHelper.dart';
import 'RoundTripBookNowFlight.dart';
import 'RoundTripDoesticBookNowFlight.dart';

class TwoWayBookingViewDetails extends StatefulWidget {
  final dynamic departflightDetails,
      resultIndex,
      arriavlresultindex,
      departItemId,
      arriavlItemId,
      arrivalflightDetails,
      adultCount,
      childrenCount,
      infantCount,
      departdate,
      stopCount,
      arrivalStopCount,
      TotalPrice;
  const TwoWayBookingViewDetails({
    super.key,
    required this.departflightDetails,
    required this.resultIndex,
    required this.arriavlresultindex,
    required this.departItemId,
    required this.arriavlItemId,
    required this.arrivalflightDetails,
    required this.infantCount,
    required this.childrenCount,
    required this.adultCount,
    required this.departdate,
    required this.stopCount,
    required this.arrivalStopCount,
    required this.TotalPrice,
  });

  @override
  State<TwoWayBookingViewDetails> createState() => _TwoWayBookingState();
}

class _TwoWayBookingState extends State<TwoWayBookingViewDetails> {
  var resultFlightData = [];
  var resultFlightData1 = [];
  bool isBookingLoading = false;
  bool isLoading = false;
  bool isEditAdult = false;
  bool isEditChild = false;
  bool isEditInfant = false;
  bool isExpanded = false;
  bool isExpanded1 = false;
  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';
  List<Map<String, dynamic>> _adultsList = [];
  List<Map<String, dynamic>> _childrenList = [];
  List<Map<String, dynamic>> _infantList = [];
  @override
  void initState() {
    super.initState();
    _retrieveSavedValues();
  }
  Future<void> _deleteInfant(int index) async {
    final dbHelper = InfantDatabaseHelper
        .instance; // Ensure you have a database helper instance
    if (_childrenList.length > index) {
      await dbHelper.deleteInfant(_childrenList[index]
      ['id']); // Use the appropriate method to delete from your database
      _fetchInfant(); // Refresh the list of adults after deletion
    }
  } Future<void> _fetchInfant() async {
    final dbHelper = InfantDatabaseHelper.instance;
    final adults = await dbHelper.getInfant(); // Fetch adults from the database
    setState(() {
      _infantList = adults;
      // Update the list to refresh UI
    });
  }
  Future<void> _fetchChildren() async {
    final dbHelper = ChildrenDatabaseHelper.instance;
    final adults =
    await dbHelper.getChildrens(); // Fetch adults from the database
    setState(() {
      _childrenList = adults;
      // Update the list to refresh UI
    });
  }
  String formattedFromDate = '';
  Future<void> _deleteAdult(int index) async {
    final dbHelper =
        DatabaseHelper.instance; // Ensure you have a database helper instance
    if (_adultsList.length > index) {
      await dbHelper.deleteAdults(_adultsList[index]
      ['id']); // Use the appropriate method to delete from your database
      _fetchAdults(); // Refresh the list of adults after deletion
    }
  } Future<void> _fetchAdults() async {
    final dbHelper = DatabaseHelper.instance;
    final adults = await dbHelper.getAdults(); // Fetch adults from the database
    setState(() {
      _adultsList = adults;
      // Update the list to refresh UI
    });
  }
  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
      print('Currency: ${widget.arrivalStopCount}');

      // Call sendFlightSearchRequest() here after SharedPreferences values are retrieved
      getAdivahaFlightDetails();
    });
  }
  String formatDepartureDate(String departureDate) {
    // Parse the date string into a DateTime object
    DateTime date = DateTime.parse(departureDate);

    // Format the date to get the day of the week and month
    String formattedDate = DateFormat('EEE, d MMM').format(date);
    print('formatedadate' + formattedDate.toString());

    // Get the day of the month to add the ordinal suffix (st, nd, rd, th)
    String dayWithSuffix = _addOrdinalSuffix(date.day);

    // Replace the day in the formatted string with the day + suffix
    return formattedDate.replaceFirst(RegExp(r'\d+'), dayWithSuffix);
  }
  String _addOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '$day'; // Special case for 11th, 12th, 13th
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }
  Future<void> getAdivahaFlightDetails() async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaFlightDetailsGet');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    String resultIndex = widget.resultIndex;
    String traceId = widget.departItemId;
    print("resultIndex: $resultIndex");
    print("traceId: $traceId");

    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.post(
        url,
        headers: headers,
        body: {
          'ResultIndex': resultIndex,
          'TraceId': traceId,
          'TripType': 'RoundTrip',
          'UserID': '2611',
          'DefaultCurrency': 'KES'
        },
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        dynamic tmpResultFlightData =
        json.decode(ResponseHandler.parseData(response.body));

        List<dynamic> filteredFlightData;

        if (int.parse(widget.stopCount.toString()) == 0) {
          // Display only MainRow if stopCount is 0
          filteredFlightData = tmpResultFlightData

              .where((flight) => flight['RowType'] == 'MainRow')
              .toList();
          resultFlightData = filteredFlightData;
        }
        else if (int.parse(widget.stopCount.toString()) == 1) {
          // Display only SubRow if stopCount is 1
          filteredFlightData = tmpResultFlightData
              .where((flight) => flight['RowType'] == 'SubRow')
              .toList();
          resultFlightData = filteredFlightData;
        }

        setState(() {

          getAdivahaFlightDetails1(); // Call next function if necessary
        });

        print('Filtered Flight Data: $resultFlightData');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending request: $error');
    }
  }

  Future<void> submitAdivahaFlightBooking() async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaFlightBooking');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    String resultIndex = resultFlightData[0]['ResultIndexID'].toString();
    String traceId = resultFlightData[0]['ItemId'].toString();

    String formattedDateTime = widget.departdate.toString();

    // Extract the date part using substring
    formattedFromDate = formattedDateTime.substring(0, 10);

    // Print the formatted date
    print(formattedFromDate); // Output: 2024-04-17

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
      /*'TitleAdult1': selectedTitleAdult1.toString(),
      'FNameAdult1': AdultName1.toString(),
      'LNameAdult1': adultLname_controller.text.toString(),
      'LDOBAdult1': formattedDate.toString(),
      'GenderAdult1': Gendar.toString(),
      'DocNumAdult1': Documentnumber_controller.text.toString(),
      'ExpDateAdult1': ExpiryDateController.text.toString(),*/
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
      /*'Address': contactAddressController.text.toString(),
      'City': contactCityController.text.toString(),
      'CountryCode': 'IN',
      'CountryName': _CountryController.text.toString(),
      'MobileNumber': contactMobileController.text.toString(),
      'Email': contactEmailController.text.toString(),
      'IsPassportRequired': 'True',
      'AdultTravellerID1': AdultTravellerId1.toString(),*/
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
   /* print('TitleAdult1: $selectedTitleAdult1');
    print('FNameAdult1: $AdultName1');
    print(
        'LNameAdult1: ${adultLname_controller.text.isEmpty ? 'A' : adultLname_controller.text}');
    print('LDOBAdult1: ${formattedDate.toString()}');
    print('GenderAdult1: $Gendar');
    print('DocNumAdult1: ${Documentnumber_controller.text}');
    print('ExpDateAdult1: ${ExpiryDateController.text}');*/
// Repeat this pattern for all other fields

   /* print('Address: ${contactAddressController.text}');
    print('City: ${contactCityController.text}');
    print('CountryCode: IN');
    print('CountryName: India');
    print('MobileNumber: ${contactMobileController.text}');
    print('Email: ${contactEmailController.text}');
    print('AdultTravellerID1:${AdultTravellerId1}');*/

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
      // Handle any exceptions or errors that occurred during the request
    }
  }

  Future<void> getAdivahaFlightDetails1() async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaFlightDetailsGet');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    String resultIndex = widget.arriavlresultindex;
    String traceId = widget.arriavlItemId;
    print("arrivalresultIndex: $resultIndex");
    print("arrivaltraceId: $traceId");

    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        url,
        headers: headers,
        body: {
          'ResultIndex': resultIndex,
          'TraceId': traceId,
          'TripType': 'RoundTrip',
          'UserID': '2611',
          'DefaultCurrency': 'KES'
        },
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        dynamic tmpResultFlightData =
        json.decode(ResponseHandler.parseData(response.body));

        List<dynamic> filteredFlightData1;

        if (int.parse(widget.arrivalStopCount.toString()) == 0) {
          // Display only MainRow if arrivalStopCount is 0

          filteredFlightData1 = tmpResultFlightData
              .where((flight) => flight['RowType'] == 'MainRow')
              .toList();
          resultFlightData1 = filteredFlightData1;
        } else if (int.parse(widget.arrivalStopCount.toString()) == 1) {
          // Display only SubRow if arrivalStopCount is 1
          filteredFlightData1 = tmpResultFlightData
              .where((flight) => flight['RowType'] == 'SubRow')
              .toList();
          resultFlightData1 = filteredFlightData1;
        }



      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending request: $error');
    }
  }

  Future<void> _deleteChild(int index) async {
    final dbHelper = ChildrenDatabaseHelper
        .instance; // Ensure you have a database helper instance
    if (_childrenList.length > index) {
      await dbHelper.deleteChildrens(_childrenList[index]
      ['id']); // Use the appropriate method to delete from your database
      _fetchChildren(); // Refresh the list of adults after deletion
    }
  }
  @override
  Widget build(BuildContext context) {
    int adultCountInt = int.parse(widget.adultCount);
    int childrenCount = int.parse(widget.childrenCount);
    int InfantCount = int.parse(widget.infantCount);
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: Container(


                      child: Column(
                        children: [
                          resultFlightData.length > 1
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: resultFlightData.length > 1
                                      ? resultFlightData.length - 1
                                      : 0, //Ipo non stio kuduthu paarunga
                                  itemBuilder: (BuildContext context, index) {
                                    return Column(
                                      children: [
                                        // Flight Details Container
                                        Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          // Adjust padding for better spacing
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            // Align content to the start
                                            children: [
                                              // Airline Row
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                // Space between image and text
                                                children: [
                                                  Image.asset(
                                                      'assets/images/img.png',
                                                      width: 40),
                                                  // Adjust image size
                                                  SizedBox(width: 10),
                                                  // Add space between image and text
                                                  Expanded(
                                                    // Ensure text doesn't overflow
                                                    child: Text(
                                                      resultFlightData[index]
                                                      ['CarrierName'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height:
                                                  20), // Space between rows

                                              // Flight Details Row
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  // Departure Info
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(formatDepartureDate(
                                                          resultFlightData[
                                                          index][
                                                          'DepartureDate']
                                                              .toString()
                                                              .substring(
                                                              0, 10))),

                                                      Text(
                                                        CommonUtils
                                                            .convertToFormattedTime(
                                                            resultFlightData[
                                                            index][
                                                            'DepartureDate']),
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      Text(resultFlightData[
                                                      index]
                                                      ['DepartCityName']),
                                                      SizedBox(height: 2),
                                                      Container(
                                                        width: 70,
                                                        child: Text(
                                                          resultFlightData[index][
                                                          'DepartAirportName'],
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      SizedBox(height: 2),
                                                      Text(
                                                        'Terminal ' +
                                                            resultFlightData[
                                                            index][
                                                            'DepartureTerminal'],
                                                        style: TextStyle(
                                                            color:
                                                            Colors.orange,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),

                                                  // Travel Time
                                                  Container(
                                                    width: 65,
                                                    child: Text(
                                                      CommonUtils
                                                          .convertMinutesToHoursMinutes(
                                                          resultFlightData[
                                                          index][
                                                          'TravelTime']),
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 16),
                                                      textAlign: TextAlign
                                                          .center, // Center align the text
                                                    ),
                                                  ),

                                                  // Arrival Info
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Text(formatDepartureDate(
                                                          resultFlightData[
                                                          index][
                                                          'ArrivalDate']
                                                              .toString()
                                                              .substring(
                                                              0, 10))),

                                                      Text(
                                                        CommonUtils
                                                            .convertToFormattedTime(
                                                            resultFlightData[
                                                            index][
                                                            'ArrivalDate']),
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      Text(resultFlightData[
                                                      index]
                                                      ['ArriveCityName']),
                                                      SizedBox(height: 2),
                                                      Container(
                                                        width: 70,
                                                        child: Text(
                                                          resultFlightData[index]['ArrivalAirportName'],
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                          textAlign: TextAlign.end, // Aligns the text to the end (right)
                                                        ),
                                                      ),

                                                      SizedBox(height: 2),
                                                      Text(
                                                        'Terminal ' +
                                                            resultFlightData[
                                                            index][
                                                            'ArrivalTerminal'],
                                                        style: TextStyle(
                                                            color:
                                                            Colors.orange,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (index + 1 < resultFlightData.length && index == 0)
                                          Container(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 0),
                                              child: Column(
                                                children: [
                                                  if (index <
                                                      (resultFlightData
                                                          .length)) ...[
                                                    // First row: Cabin Baggage details
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.shopping_bag,
                                                          size: 16,
                                                          color: Colors
                                                              .grey.shade500,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Cabin Baggage: ',
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          resultFlightData[
                                                          index]
                                                          ['CabinBaggage'],
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4),

                                                    // Second row: Check-In baggage details
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.shopping_bag,
                                                          size: 16,
                                                          color: Colors
                                                              .grey.shade500,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Check-In: ',
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          resultFlightData[
                                                          index]['Baggage'],
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(),

                                                    // Row with A30 and View More/View Less button
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        // Left side: A30 text
                                                        Text(
                                                          'A30',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                        ),

                                                        // Right side: View More/View Less text with orange color
                                                        TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              isExpanded =
                                                              !isExpanded;
                                                            });
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                isExpanded
                                                                    ? 'View Less'
                                                                    : 'View More',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .orange),
                                                              ),
                                                              Icon(
                                                                isExpanded
                                                                    ? Icons
                                                                    .keyboard_arrow_up
                                                                    : Icons
                                                                    .keyboard_arrow_down,
                                                                color: Colors
                                                                    .orange, // Arrow icon color
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    // Expanded content if isExpanded is true
                                                    if (isExpanded)
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .signal_cellular_off,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('Narrow'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .wifi_off,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('No WiFi'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .fastfood,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                  'Fresh Food'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(Icons.power,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('Outlet'),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ),
                                        if (index + 1 < resultFlightData.length && index == 0)
                                          Container(
                                            color: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                border: Border.all(
                                                  color: Colors.transparent,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              width: double.infinity,
                                              height: 35,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 7),
                                                child: Text(
                                                  "Change of Planes ${CommonUtils.convertMinutesToHoursMinutes(resultFlightData[index + 1]['TravelTime'])}Layover in\n",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                  textAlign: TextAlign
                                                      .center, // Center the text
                                                ),
                                              ),
                                            ),
                                          ),

                                        if (index  < resultFlightData.length && index == 1)
                                          Container(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 0),
                                              child: Column(
                                                children: [
                                                  if (index <
                                                      (resultFlightData
                                                          .length)) ...[
                                                    // First row: Cabin Baggage details
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.shopping_bag,
                                                          size: 16,
                                                          color: Colors
                                                              .grey.shade500,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Cabin Baggage: ',
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          resultFlightData[
                                                          index]
                                                          ['CabinBaggage'],
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4),

                                                    // Second row: Check-In baggage details
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.shopping_bag,
                                                          size: 16,
                                                          color: Colors
                                                              .grey.shade500,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Check-In: ',
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          resultFlightData[
                                                          index]['Baggage'],
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(),

                                                    // Row with A30 and View More/View Less button
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        // Left side: A30 text
                                                        Text(
                                                          'A30',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                        ),

                                                        // Right side: View More/View Less text with orange color
                                                        TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              isExpanded =
                                                              !isExpanded;
                                                            });
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                isExpanded
                                                                    ? 'View Less'
                                                                    : 'View More',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .orange),
                                                              ),
                                                              Icon(
                                                                isExpanded
                                                                    ? Icons
                                                                    .keyboard_arrow_up
                                                                    : Icons
                                                                    .keyboard_arrow_down,
                                                                color: Colors
                                                                    .orange, // Arrow icon color
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    // Expanded content if isExpanded is true
                                                    if (isExpanded)
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .signal_cellular_off,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('Narrow'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .wifi_off,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('No WiFi'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .fastfood,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                  'Fresh Food'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(Icons.power,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('Outlet'),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ),

                                        if (index + 1 < resultFlightData.length && index == 2)
                                          Container(
                                            color: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                border: Border.all(
                                                  color: Colors.transparent,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              width: double.infinity,
                                              height: 35,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 7),
                                                child: Text(
                                                  "Change of Planes ${CommonUtils.convertMinutesToHoursMinutes(resultFlightData[index + 1]['TravelTime'])}Layover in\n",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                  textAlign: TextAlign
                                                      .center, // Center the text
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (index < resultFlightData.length && index == 3)
                                          Container(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 0),
                                              child: Column(
                                                children: [
                                                  if (index <
                                                      (resultFlightData
                                                          .length)) ...[
                                                    // First row: Cabin Baggage details
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.shopping_bag,
                                                          size: 16,
                                                          color: Colors
                                                              .grey.shade500,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Cabin Baggage: ',
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          resultFlightData[
                                                          index]
                                                          ['CabinBaggage'],
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4),

                                                    // Second row: Check-In baggage details
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.shopping_bag,
                                                          size: 16,
                                                          color: Colors
                                                              .grey.shade500,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Check-In: ',
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          resultFlightData[
                                                          index]['Baggage'],
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(),

                                                    // Row with A30 and View More/View Less button
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        // Left side: A30 text
                                                        Text(
                                                          'A30',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                        ),

                                                        // Right side: View More/View Less text with orange color
                                                        TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              isExpanded =
                                                              !isExpanded;
                                                            });
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                isExpanded
                                                                    ? 'View Less'
                                                                    : 'View More',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .orange),
                                                              ),
                                                              Icon(
                                                                isExpanded
                                                                    ? Icons
                                                                    .keyboard_arrow_up
                                                                    : Icons
                                                                    .keyboard_arrow_down,
                                                                color: Colors
                                                                    .orange, // Arrow icon color
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    // Expanded content if isExpanded is true
                                                    if (isExpanded)
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .signal_cellular_off,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('Narrow'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .wifi_off,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('No WiFi'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .fastfood,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                  'Fresh Food'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(Icons.power,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('Outlet'),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ),
                                        if (index+1 < resultFlightData.length && index == 3)
                                          Container(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 0),
                                              child: Column(
                                                children: [
                                                  if (index <
                                                      (resultFlightData
                                                          .length)) ...[
                                                    // First row: Cabin Baggage details
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.shopping_bag,
                                                          size: 16,
                                                          color: Colors
                                                              .grey.shade500,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Cabin Baggage: ',
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          resultFlightData[
                                                          index]
                                                          ['CabinBaggage'],
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4),

                                                    // Second row: Check-In baggage details
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.shopping_bag,
                                                          size: 16,
                                                          color: Colors
                                                              .grey.shade500,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Check-In: ',
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          resultFlightData[
                                                          index]['Baggage'],
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(),

                                                    // Row with A30 and View More/View Less button
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        // Left side: A30 text
                                                        Text(
                                                          'A30',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                        ),

                                                        // Right side: View More/View Less text with orange color
                                                        TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              isExpanded =
                                                              !isExpanded;
                                                            });
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                isExpanded
                                                                    ? 'View Less'
                                                                    : 'View More',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .orange),
                                                              ),
                                                              Icon(
                                                                isExpanded
                                                                    ? Icons
                                                                    .keyboard_arrow_up
                                                                    : Icons
                                                                    .keyboard_arrow_down,
                                                                color: Colors
                                                                    .orange, // Arrow icon color
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    // Expanded content if isExpanded is true
                                                    if (isExpanded)
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .signal_cellular_off,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('Narrow'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .wifi_off,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('No WiFi'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .fastfood,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                  'Fresh Food'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(Icons.power,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('Outlet'),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ),

                                        Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          // Adjust padding for better spacing
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            // Align content to the start
                                            children: [
                                              // Airline Row
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                // Space between image and text
                                                children: [
                                                  Image.asset(
                                                      'assets/images/img.png',
                                                      width: 40),
                                                  // Adjust image size
                                                  SizedBox(width: 10),
                                                  // Add space between image and text
                                                  Expanded(
                                                    // Ensure text doesn't overflow
                                                    child: Text(
                                                      resultFlightData[index+1]
                                                      ['CarrierName'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height:
                                                  20), // Space between rows

                                              // Flight Details Row
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  // Departure Info
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(formatDepartureDate(
                                                          resultFlightData[
                                                          index+1][
                                                          'DepartureDate']
                                                              .toString()
                                                              .substring(
                                                              0, 10))),

                                                      Text(
                                                        CommonUtils
                                                            .convertToFormattedTime(
                                                            resultFlightData[
                                                            index+1][
                                                            'DepartureDate']),
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      Text(resultFlightData[
                                                      index+1]
                                                      ['DepartCityName']),
                                                      SizedBox(height: 2),
                                                      Container(
                                                        width: 70,
                                                        child: Text(
                                                          resultFlightData[index+1][
                                                          'DepartAirportName'],
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      SizedBox(height: 2),
                                                      Text(
                                                        'Terminal ' +
                                                            resultFlightData[
                                                            index+1][
                                                            'DepartureTerminal'],
                                                        style: TextStyle(
                                                            color:
                                                            Colors.orange,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),

                                                  // Travel Time
                                                  Container(
                                                    width: 65,
                                                    child: Text(
                                                      CommonUtils
                                                          .convertMinutesToHoursMinutes(
                                                          resultFlightData[
                                                          index+1][
                                                          'TravelTime']),
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 16),
                                                      textAlign: TextAlign
                                                          .center, // Center align the text
                                                    ),
                                                  ),

                                                  // Arrival Info
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Text(formatDepartureDate(
                                                          resultFlightData[
                                                          index+1][
                                                          'ArrivalDate']
                                                              .toString()
                                                              .substring(
                                                              0, 10))),

                                                      Text(
                                                        CommonUtils
                                                            .convertToFormattedTime(
                                                            resultFlightData[
                                                            index+1][
                                                            'ArrivalDate']),
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      Text(resultFlightData[
                                                      index+1]
                                                      ['ArriveCityName']),
                                                      SizedBox(height: 2),
                                                      Container(
                                                        width: 70,
                                                        child: Text(
                                                          resultFlightData[index+1]['ArrivalAirportName'],
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                          textAlign: TextAlign.end, // Aligns the text to the end (right)
                                                        ),
                                                      ),

                                                      SizedBox(height: 2),
                                                      Text(
                                                        'Terminal ' +
                                                            resultFlightData[
                                                            index+1][
                                                            'ArrivalTerminal'],
                                                        style: TextStyle(
                                                            color:
                                                            Colors.orange,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                          Container(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 0),
                                              child: Column(
                                                children: [
                                                  if (index <
                                                      (resultFlightData
                                                          .length)) ...[
                                                    // First row: Cabin Baggage details
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.shopping_bag,
                                                          size: 16,
                                                          color: Colors
                                                              .grey.shade500,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Cabin Baggage: ',
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          resultFlightData[
                                                          index]
                                                          ['CabinBaggage'],
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4),

                                                    // Second row: Check-In baggage details
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.shopping_bag,
                                                          size: 16,
                                                          color: Colors
                                                              .grey.shade500,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Check-In: ',
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          resultFlightData[
                                                          index]['Baggage'],
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black54,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(),

                                                    // Row with A30 and View More/View Less button
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        // Left side: A30 text
                                                        Text(
                                                          'A30',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                        ),

                                                        // Right side: View More/View Less text with orange color
                                                        TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              isExpanded =
                                                              !isExpanded;
                                                            });
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                isExpanded
                                                                    ? 'View Less'
                                                                    : 'View More',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .orange),
                                                              ),
                                                              Icon(
                                                                isExpanded
                                                                    ? Icons
                                                                    .keyboard_arrow_up
                                                                    : Icons
                                                                    .keyboard_arrow_down,
                                                                color: Colors
                                                                    .orange, // Arrow icon color
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    // Expanded content if isExpanded is true
                                                    if (isExpanded)
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .signal_cellular_off,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('Narrow'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .wifi_off,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('No WiFi'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .fastfood,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                  'Fresh Food'),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(Icons.power,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text('Outlet'),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ),

                                      ],
                                    );
                                  })
                              : Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(right: 10,left: 10,top: 5),
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
                                    /* Text(
                                            'Air Asia',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),*/
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
                                          resultFlightData[0]
                                          ['DepartureDate']
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
                                        Container( width: 70,
                                          child: Text(
                                            resultFlightData[0]
                                            ['DepartAirportName'],
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
                                          resultFlightData[0]
                                          ['ArrivalDate']
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
                                        Container( width: 70,
                                          child: Text(
                                            resultFlightData[0]
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
                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.shopping_bag,
                                              size: 16,
                                              color: Colors
                                                  .grey.shade500,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Cabin Baggage: ',
                                              style: TextStyle(
                                                color:
                                                Colors.black54,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Text(
                                              resultFlightData[0]
                                              ['CabinBaggage'],
                                              style: TextStyle(
                                                color:
                                                Colors.black54,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),

                                        // Second row: Check-In baggage details
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.shopping_bag,
                                              size: 16,
                                              color: Colors
                                                  .grey.shade500,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Check-In: ',
                                              style: TextStyle(
                                                color:
                                                Colors.black54,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Text(
                                              resultFlightData[0]
                                              ['Baggage'],
                                              style: TextStyle(
                                                color:
                                                Colors.black54,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),

                                        // Row with A30 and View More/View Less button
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            // Left side: A30 text
                                            Text(
                                              'A30',
                                              style: TextStyle(
                                                  color: Colors
                                                      .black54),
                                            ),

                                            // Right side: View More/View Less text with orange color
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  isExpanded =
                                                  !isExpanded;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    isExpanded
                                                        ? 'View Less'
                                                        : 'View More',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .orange),
                                                  ),
                                                  Icon(
                                                    isExpanded
                                                        ? Icons
                                                        .keyboard_arrow_up
                                                        : Icons
                                                        .keyboard_arrow_down,
                                                    color: Colors
                                                        .orange, // Arrow icon color
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        // Expanded content if isExpanded is true
                                        if (isExpanded)
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .signal_cellular_off,
                                                      size: 16),
                                                  SizedBox(
                                                      width: 5),
                                                  Text('Narrow'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .wifi_off,
                                                      size: 16),
                                                  SizedBox(
                                                      width: 5),
                                                  Text('No WiFi'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .fastfood,
                                                      size: 16),
                                                  SizedBox(
                                                      width: 5),
                                                  Text(
                                                      'Fresh Food'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.power,
                                                      size: 16),
                                                  SizedBox(
                                                      width: 5),
                                                  Text('Outlet'),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          resultFlightData1.length > 1
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: resultFlightData1.length > 1
                                      ? resultFlightData1.length - 1
                                      : 0, //Ipo non stio kuduthu paarunga
                              itemBuilder: (BuildContext context, index) {
                                return Column(
                                  children: [
                                    // Flight Details Container
                                    Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10),
                                      // Adjust padding for better spacing
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        // Align content to the start
                                        children: [
                                          // Airline Row
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            // Space between image and text
                                            children: [
                                              Image.asset(
                                                  'assets/images/img.png',
                                                  width: 40),
                                              // Adjust image size
                                              SizedBox(width: 10),
                                              // Add space between image and text
                                              Expanded(
                                                // Ensure text doesn't overflow
                                                child: Text(
                                                  resultFlightData1[index]
                                                  ['CarrierName'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height:
                                              20), // Space between rows

                                          // Flight Details Row
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              // Departure Info
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(formatDepartureDate(
                                                      resultFlightData1[
                                                      index][
                                                      'DepartureDate']
                                                          .toString()
                                                          .substring(
                                                          0, 10))),

                                                  Text(
                                                    CommonUtils
                                                        .convertToFormattedTime(
                                                        resultFlightData1[
                                                        index][
                                                        'DepartureDate']),
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  Text(resultFlightData1[
                                                  index]
                                                  ['DepartCityName']),
                                                  SizedBox(height: 2),
                                                  Container(
                                                    width: 70,
                                                    child: Text(
                                                      resultFlightData1[index][
                                                      'DepartAirportName'],
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    'Terminal ' +
                                                        resultFlightData1[
                                                        index][
                                                        'DepartureTerminal'],
                                                    style: TextStyle(
                                                        color:
                                                        Colors.orange,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),

                                              // Travel Time
                                              Container(
                                                width: 65,
                                                child: Text(
                                                  CommonUtils
                                                      .convertMinutesToHoursMinutes(
                                                      resultFlightData1[
                                                      index][
                                                      'TravelTime']),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 16),
                                                  textAlign: TextAlign
                                                      .center, // Center align the text
                                                ),
                                              ),

                                              // Arrival Info
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .end,
                                                children: [
                                                  Text(formatDepartureDate(
                                                      resultFlightData1[
                                                      index][
                                                      'ArrivalDate']
                                                          .toString()
                                                          .substring(
                                                          0, 10))),

                                                  Text(
                                                    CommonUtils
                                                        .convertToFormattedTime(
                                                        resultFlightData1[
                                                        index][
                                                        'ArrivalDate']),
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  Text(resultFlightData1[
                                                  index]
                                                  ['ArriveCityName']),
                                                  SizedBox(height: 2),
                                                  Container(
                                                    width: 70,
                                                    child: Text(
                                                      resultFlightData1[index]['ArrivalAirportName'],
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                      ),
                                                      textAlign: TextAlign.end, // Aligns the text to the end (right)
                                                    ),
                                                  ),

                                                  SizedBox(height: 2),
                                                  Text(
                                                    'Terminal ' +
                                                        resultFlightData1[
                                                        index][
                                                        'ArrivalTerminal'],
                                                    style: TextStyle(
                                                        color:
                                                        Colors.orange,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (index + 1 < resultFlightData1.length && index == 0)
                                      Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 0),
                                          child: Column(
                                            children: [
                                              if (index <
                                                  (resultFlightData1
                                                      .length)) ...[
                                                // First row: Cabin Baggage details
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.shopping_bag,
                                                      size: 16,
                                                      color: Colors
                                                          .grey.shade500,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      'Cabin Baggage: ',
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Text(
                                                      resultFlightData1[
                                                      index]
                                                      ['CabinBaggage'],
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 4),

                                                // Second row: Check-In baggage details
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.shopping_bag,
                                                      size: 16,
                                                      color: Colors
                                                          .grey.shade500,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      'Check-In: ',
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Text(
                                                      resultFlightData1[
                                                      index]['Baggage'],
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(),

                                                // Row with A30 and View More/View Less button
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    // Left side: A30 text
                                                    Text(
                                                      'A30',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black54),
                                                    ),

                                                    // Right side: View More/View Less text with orange color
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          isExpanded =
                                                          !isExpanded;
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            isExpanded
                                                                ? 'View Less'
                                                                : 'View More',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .orange),
                                                          ),
                                                          Icon(
                                                            isExpanded
                                                                ? Icons
                                                                .keyboard_arrow_up
                                                                : Icons
                                                                .keyboard_arrow_down,
                                                            color: Colors
                                                                .orange, // Arrow icon color
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                // Expanded content if isExpanded is true
                                                if (isExpanded)
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .signal_cellular_off,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text('Narrow'),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .wifi_off,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text('No WiFi'),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .fastfood,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text(
                                                              'Fresh Food'),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.power,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text('Outlet'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (index + 1 < resultFlightData1.length && index == 0)
                                      Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            border: Border.all(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                          width: double.infinity,
                                          height: 35,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 7),
                                            child: Text(
                                              "Change of Planes ${CommonUtils.convertMinutesToHoursMinutes(resultFlightData1[index + 1]['TravelTime'])}Layover in\n",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  color: Colors.black,
                                                  fontSize: 13),
                                              textAlign: TextAlign
                                                  .center, // Center the text
                                            ),
                                          ),
                                        ),
                                      ),

                                    if (index  < resultFlightData1.length && index == 1)
                                      Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 0),
                                          child: Column(
                                            children: [
                                              if (index <
                                                  (resultFlightData1
                                                      .length)) ...[
                                                // First row: Cabin Baggage details
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.shopping_bag,
                                                      size: 16,
                                                      color: Colors
                                                          .grey.shade500,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      'Cabin Baggage: ',
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Text(
                                                      resultFlightData1[
                                                      index]
                                                      ['CabinBaggage'],
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 4),

                                                // Second row: Check-In baggage details
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.shopping_bag,
                                                      size: 16,
                                                      color: Colors
                                                          .grey.shade500,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      'Check-In: ',
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Text(
                                                      resultFlightData1[
                                                      index]['Baggage'],
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(),

                                                // Row with A30 and View More/View Less button
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    // Left side: A30 text
                                                    Text(
                                                      'A30',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black54),
                                                    ),

                                                    // Right side: View More/View Less text with orange color
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          isExpanded =
                                                          !isExpanded;
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            isExpanded
                                                                ? 'View Less'
                                                                : 'View More',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .orange),
                                                          ),
                                                          Icon(
                                                            isExpanded
                                                                ? Icons
                                                                .keyboard_arrow_up
                                                                : Icons
                                                                .keyboard_arrow_down,
                                                            color: Colors
                                                                .orange, // Arrow icon color
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                // Expanded content if isExpanded is true
                                                if (isExpanded)
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .signal_cellular_off,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text('Narrow'),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .wifi_off,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text('No WiFi'),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .fastfood,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text(
                                                              'Fresh Food'),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.power,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text('Outlet'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),

                                    if (index + 1 < resultFlightData1.length && index == 2)
                                      Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            border: Border.all(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                          width: double.infinity,
                                          height: 35,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 7),
                                            child: Text(
                                              "Change of Planes ${CommonUtils.convertMinutesToHoursMinutes(resultFlightData1[index + 1]['TravelTime'])}Layover in\n",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  color: Colors.black,
                                                  fontSize: 13),
                                              textAlign: TextAlign
                                                  .center, // Center the text
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (index < resultFlightData1.length && index == 3)
                                      Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 0),
                                          child: Column(
                                            children: [
                                              if (index <
                                                  (resultFlightData1
                                                      .length)) ...[
                                                // First row: Cabin Baggage details
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.shopping_bag,
                                                      size: 16,
                                                      color: Colors
                                                          .grey.shade500,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      'Cabin Baggage: ',
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Text(
                                                      resultFlightData1[
                                                      index]
                                                      ['CabinBaggage'],
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 4),

                                                // Second row: Check-In baggage details
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.shopping_bag,
                                                      size: 16,
                                                      color: Colors
                                                          .grey.shade500,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      'Check-In: ',
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Text(
                                                      resultFlightData1[
                                                      index]['Baggage'],
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(),

                                                // Row with A30 and View More/View Less button
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    // Left side: A30 text
                                                    Text(
                                                      'A30',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black54),
                                                    ),

                                                    // Right side: View More/View Less text with orange color
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          isExpanded =
                                                          !isExpanded;
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            isExpanded
                                                                ? 'View Less'
                                                                : 'View More',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .orange),
                                                          ),
                                                          Icon(
                                                            isExpanded
                                                                ? Icons
                                                                .keyboard_arrow_up
                                                                : Icons
                                                                .keyboard_arrow_down,
                                                            color: Colors
                                                                .orange, // Arrow icon color
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                // Expanded content if isExpanded is true
                                                if (isExpanded)
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .signal_cellular_off,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text('Narrow'),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .wifi_off,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text('No WiFi'),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .fastfood,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text(
                                                              'Fresh Food'),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.power,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text('Outlet'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (index+1 < resultFlightData1.length && index == 3)
                                      Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 0),
                                          child: Column(
                                            children: [
                                              if (index <
                                                  (resultFlightData1
                                                      .length)) ...[
                                                // First row: Cabin Baggage details
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.shopping_bag,
                                                      size: 16,
                                                      color: Colors
                                                          .grey.shade500,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      'Cabin Baggage: ',
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Text(
                                                      resultFlightData1[
                                                      index]
                                                      ['CabinBaggage'],
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 4),

                                                // Second row: Check-In baggage details
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.shopping_bag,
                                                      size: 16,
                                                      color: Colors
                                                          .grey.shade500,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      'Check-In: ',
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Text(
                                                      resultFlightData1[
                                                      index]['Baggage'],
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(),

                                                // Row with A30 and View More/View Less button
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    // Left side: A30 text
                                                    Text(
                                                      'A30',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black54),
                                                    ),

                                                    // Right side: View More/View Less text with orange color
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          isExpanded =
                                                          !isExpanded;
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            isExpanded
                                                                ? 'View Less'
                                                                : 'View More',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .orange),
                                                          ),
                                                          Icon(
                                                            isExpanded
                                                                ? Icons
                                                                .keyboard_arrow_up
                                                                : Icons
                                                                .keyboard_arrow_down,
                                                            color: Colors
                                                                .orange, // Arrow icon color
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                // Expanded content if isExpanded is true
                                                if (isExpanded)
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .signal_cellular_off,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text('Narrow'),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .wifi_off,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text('No WiFi'),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .fastfood,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text(
                                                              'Fresh Food'),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.power,
                                                              size: 16),
                                                          SizedBox(
                                                              width: 5),
                                                          Text('Outlet'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),

                                    Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10),
                                      // Adjust padding for better spacing
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        // Align content to the start
                                        children: [
                                          // Airline Row
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            // Space between image and text
                                            children: [
                                              Image.asset(
                                                  'assets/images/img.png',
                                                  width: 40),
                                              // Adjust image size
                                              SizedBox(width: 10),
                                              // Add space between image and text
                                              Expanded(
                                                // Ensure text doesn't overflow
                                                child: Text(
                                                  resultFlightData1[index+1]
                                                  ['CarrierName'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height:
                                              20), // Space between rows

                                          // Flight Details Row
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              // Departure Info
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(formatDepartureDate(
                                                      resultFlightData1[
                                                      index+1][
                                                      'DepartureDate']
                                                          .toString()
                                                          .substring(
                                                          0, 10))),

                                                  Text(
                                                    CommonUtils
                                                        .convertToFormattedTime(
                                                        resultFlightData1[
                                                        index+1][
                                                        'DepartureDate']),
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  Text(resultFlightData1[
                                                  index+1]
                                                  ['DepartCityName']),
                                                  SizedBox(height: 2),
                                                  Container(
                                                    width: 70,
                                                    child: Text(
                                                      resultFlightData1[index+1][
                                                      'DepartAirportName'],
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    'Terminal ' +
                                                        resultFlightData1[
                                                        index+1][
                                                        'DepartureTerminal'],
                                                    style: TextStyle(
                                                        color:
                                                        Colors.orange,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),

                                              // Travel Time
                                              Container(
                                                width: 65,
                                                child: Text(
                                                  CommonUtils
                                                      .convertMinutesToHoursMinutes(
                                                      resultFlightData1[
                                                      index+1][
                                                      'TravelTime']),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 16),
                                                  textAlign: TextAlign
                                                      .center, // Center align the text
                                                ),
                                              ),

                                              // Arrival Info
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .end,
                                                children: [
                                                  Text(formatDepartureDate(
                                                      resultFlightData1[
                                                      index+1][
                                                      'ArrivalDate']
                                                          .toString()
                                                          .substring(
                                                          0, 10))),

                                                  Text(
                                                    CommonUtils
                                                        .convertToFormattedTime(
                                                        resultFlightData1[
                                                        index+1][
                                                        'ArrivalDate']),
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  Text(resultFlightData1[
                                                  index+1]
                                                  ['ArriveCityName']),
                                                  SizedBox(height: 2),
                                                  Container(
                                                    width: 70,
                                                    child: Text(
                                                      resultFlightData1[index+1]['ArrivalAirportName'],
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                      ),
                                                      textAlign: TextAlign.end, // Aligns the text to the end (right)
                                                    ),
                                                  ),

                                                  SizedBox(height: 2),
                                                  Text(
                                                    'Terminal ' +
                                                        resultFlightData1[
                                                        index+1][
                                                        'ArrivalTerminal'],
                                                    style: TextStyle(
                                                        color:
                                                        Colors.orange,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 0),
                                        child: Column(
                                          children: [
                                            if (index <
                                                (resultFlightData1
                                                    .length)) ...[
                                              // First row: Cabin Baggage details
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.shopping_bag,
                                                    size: 16,
                                                    color: Colors
                                                        .grey.shade500,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'Cabin Baggage: ',
                                                    style: TextStyle(
                                                      color:
                                                      Colors.black54,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Text(
                                                    resultFlightData1[
                                                    index]
                                                    ['CabinBaggage'],
                                                    style: TextStyle(
                                                      color:
                                                      Colors.black54,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),

                                              // Second row: Check-In baggage details
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.shopping_bag,
                                                    size: 16,
                                                    color: Colors
                                                        .grey.shade500,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'Check-In: ',
                                                    style: TextStyle(
                                                      color:
                                                      Colors.black54,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Text(
                                                    resultFlightData1[
                                                    index]['Baggage'],
                                                    style: TextStyle(
                                                      color:
                                                      Colors.black54,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(),

                                              // Row with A30 and View More/View Less button
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  // Left side: A30 text
                                                  Text(
                                                    'A30',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .black54),
                                                  ),

                                                  // Right side: View More/View Less text with orange color
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isExpanded =
                                                        !isExpanded;
                                                      });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          isExpanded
                                                              ? 'View Less'
                                                              : 'View More',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .orange),
                                                        ),
                                                        Icon(
                                                          isExpanded
                                                              ? Icons
                                                              .keyboard_arrow_up
                                                              : Icons
                                                              .keyboard_arrow_down,
                                                          color: Colors
                                                              .orange, // Arrow icon color
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              // Expanded content if isExpanded is true
                                              if (isExpanded)
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .signal_cellular_off,
                                                            size: 16),
                                                        SizedBox(
                                                            width: 5),
                                                        Text('Narrow'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .wifi_off,
                                                            size: 16),
                                                        SizedBox(
                                                            width: 5),
                                                        Text('No WiFi'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .fastfood,
                                                            size: 16),
                                                        SizedBox(
                                                            width: 5),
                                                        Text(
                                                            'Fresh Food'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.power,
                                                            size: 16),
                                                        SizedBox(
                                                            width: 5),
                                                        Text('Outlet'),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                );
                              })
                              : Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(right: 10,left: 10),
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
                                      resultFlightData1[0]['CarrierName'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    /* Text(
                                            'Air Asia',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),*/
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
                                          resultFlightData1[0]
                                          ['DepartureDate']
                                              .toString()
                                              .substring(0, 10),
                                        ),
                                        Text(
                                          '${CommonUtils.convertToFormattedTime(resultFlightData1[0]['DepartureDate']).toString().toUpperCase()} ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(resultFlightData1[0]
                                        ['DepartCityName']),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Container( width: 70,
                                          child: Text(
                                            resultFlightData1[0]
                                            ['DepartAirportName'],
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
                                                resultFlightData1[0]
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
                                            resultFlightData1[0]
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
                                          resultFlightData1[0]
                                          ['ArrivalDate']
                                              .toString()
                                              .substring(0, 10),
                                        ),
                                        Text(
                                          '${CommonUtils.convertToFormattedTime(resultFlightData1[0]['ArrivalDate']).toString().toUpperCase()} ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(resultFlightData1[0]
                                        ['ArriveCityName']),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Container( width: 70,
                                          child: Text(
                                            resultFlightData1[0]
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
                                                resultFlightData1[0]
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
                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.shopping_bag,
                                              size: 16,
                                              color: Colors
                                                  .grey.shade500,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Cabin Baggage: ',
                                              style: TextStyle(
                                                color:
                                                Colors.black54,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Text(
                                              resultFlightData1[0]
                                              ['CabinBaggage'],
                                              style: TextStyle(
                                                color:
                                                Colors.black54,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),

                                        // Second row: Check-In baggage details
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.shopping_bag,
                                              size: 16,
                                              color: Colors
                                                  .grey.shade500,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Check-In: ',
                                              style: TextStyle(
                                                color:
                                                Colors.black54,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Text(
                                              resultFlightData1[0]
                                              ['Baggage'],
                                              style: TextStyle(
                                                color:
                                                Colors.black54,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),

                                        // Row with A30 and View More/View Less button
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            // Left side: A30 text
                                            Text(
                                              'A30',
                                              style: TextStyle(
                                                  color: Colors
                                                      .black54),
                                            ),

                                            // Right side: View More/View Less text with orange color
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  isExpanded =
                                                  !isExpanded;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    isExpanded
                                                        ? 'View Less'
                                                        : 'View More',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .orange),
                                                  ),
                                                  Icon(
                                                    isExpanded
                                                        ? Icons
                                                        .keyboard_arrow_up
                                                        : Icons
                                                        .keyboard_arrow_down,
                                                    color: Colors
                                                        .orange, // Arrow icon color
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        // Expanded content if isExpanded is true
                                        if (isExpanded)
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .signal_cellular_off,
                                                      size: 16),
                                                  SizedBox(
                                                      width: 5),
                                                  Text('Narrow'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .wifi_off,
                                                      size: 16),
                                                  SizedBox(
                                                      width: 5),
                                                  Text('No WiFi'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .fastfood,
                                                      size: 16),
                                                  SizedBox(
                                                      width: 5),
                                                  Text(
                                                      'Fresh Food'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.power,
                                                      size: 16),
                                                  SizedBox(
                                                      width: 5),
                                                  Text('Outlet'),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        'Fare Summary',
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

                                      // Add other pricing details or components as needed
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 0, left: 0, bottom: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          'Base Price',
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          resultFlightData[0]
                                          ["BookingBaseFare"],
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 0,
                                        left: 0,
                                        bottom: 4,
                                        top: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          'Tax Price',
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          resultFlightData[0]
                                          ["BookingTax"],
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 0,
                                        left: 0,
                                        bottom: 5,
                                        top: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          'Total Amount To Be Paid',
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          widget.TotalPrice,
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 5, top: 5),
                                  child: Text(
                                    'Travellers',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Adults',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: List.generate(
                                      adultCountInt, (i) {
                                    // Determine if there is valid adult data
                                    bool hasAdultData =
                                        _adultsList.length > i &&
                                            _adultsList[i] != null &&
                                            _adultsList[i]
                                            ['firstName'] !=
                                                null;

                                    print('hasAdultData: ' +
                                        hasAdultData.toString());

                                    return Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                            hasAdultData
                                                ? Color(0xFF152238)
                                                : Colors.grey,
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: !hasAdultData &&
                                                  !isEditAdult
                                                  ? () {
                                                // Navigate to the page to add an adult if there's no data
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                        AddAdultScreen(
                                                          isEdit:
                                                          'Add',
                                                          adultIndex:
                                                          i,
                                                          adultsList:
                                                          _adultsList,
                                                          flightDetails:
                                                          '',
                                                          resultFlightData:
                                                          '',
                                                          infantCount:
                                                          0,
                                                          childrenCount:
                                                          0,
                                                          adultCount:
                                                          adultCountInt,
                                                          departdate:
                                                          '',
                                                          userid:
                                                          '',
                                                          usertypeid:
                                                          '',
                                                        ),
                                                  ),
                                                ).then((_) {
                                                  // Fetch the updated adults list when returning to this page
                                                  _fetchAdults();
                                                });
                                              }
                                                  : null,
                                              // Disable if there is adult data or isEdit is true
                                              child: Text(
                                                hasAdultData
                                                    ? '${_adultsList[i]['firstName']} ${_adultsList[i]['surname']}'
                                                    : 'Select Adult ${i + 1}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: hasAdultData
                                                        ? Colors.black
                                                        : Colors
                                                        .black),
                                              ),
                                            ),
                                          ),
                                          // Edit Button
                                          IconButton(
                                            icon: Icon(Icons.edit,
                                                color: Color(0xFF152238)),
                                            onPressed: hasAdultData &&
                                                !isEditAdult
                                                ? () {
                                              // Navigate to edit screen if adult data exists and not in edit mode
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                      AddAdultScreen(
                                                        isEdit:
                                                        'Edit',
                                                        adultIndex:
                                                        i,
                                                        adultsList:
                                                        _adultsList,
                                                        flightDetails:
                                                        '',
                                                        resultFlightData:
                                                        '',
                                                        infantCount:
                                                        0,
                                                        childrenCount:
                                                        0,
                                                        adultCount:
                                                        adultCountInt,
                                                        departdate:
                                                        '',
                                                        userid: '',
                                                        usertypeid:
                                                        '',
                                                      ),
                                                ),
                                              ).then((_) {
                                                // Fetch the updated adults list when returning to this page
                                                _fetchAdults();
                                              });
                                            }
                                                : null, // Disable if there is no adult data or isEdit is true
                                          ),
                                          // Delete Button
                                          IconButton(
                                            icon: Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: hasAdultData &&
                                                !isEditAdult
                                                ? () {
                                              // Show confirmation dialog
                                              showDialog(
                                                context:
                                                context,
                                                builder:
                                                    (BuildContext
                                                context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Confirm Deletion'),
                                                    content: Text(
                                                        'Are you sure you want to delete this adult?'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text(
                                                            'No'),
                                                        onPressed:
                                                            () {
                                                          Navigator.of(context)
                                                              .pop(); // Close dialog
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text(
                                                            'Yes'),
                                                        onPressed:
                                                            () {
                                                          _deleteAdult(
                                                              i); // Call delete method
                                                          Navigator.of(context)
                                                              .pop(); // Close dialog
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                                : null, // Disable if there is no adult data or isEdit is true
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                                if (childrenCount > 1)
                                  Divider(),
                                if (childrenCount > 1)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Children',
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Column(
                                          children: List.generate(
                                              childrenCount, (i) {
                                            // Determine if there is valid child data
                                            bool hasChildData =
                                                _childrenList.length >
                                                    i &&
                                                    _childrenList[
                                                    i] !=
                                                        null &&
                                                    _childrenList[i][
                                                    'firstName'] !=
                                                        null;

                                            print('hasChildData: ' +
                                                hasChildData
                                                    .toString());

                                            return Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(8.0),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                    hasChildData
                                                        ? Colors
                                                        .green
                                                        : Colors
                                                        .grey,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child:
                                                    GestureDetector(
                                                      onTap: !hasChildData &&
                                                          !isEditChild
                                                          ? () {
                                                        // Navigate to the page to add a child if there's no data
                                                        Navigator
                                                            .push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                AddChildScreen(
                                                                  isEdit: 'Add',
                                                                  childIndex: i,
                                                                  childrenList: _childrenList,
                                                                  flightDetails: '',
                                                                  resultFlightData: '',
                                                                  infantCount: 0,
                                                                  childrenCount: childrenCount,
                                                                  adultCount: 0,
                                                                  departdate: '',
                                                                  userid: '',
                                                                  usertypeid: '',
                                                                ),
                                                          ),
                                                        ).then(
                                                                (_) {
                                                              // Fetch the updated children list when returning to this page
                                                              _fetchChildren();
                                                            });
                                                      }
                                                          : null,
                                                      // Disable if there is child data or isEdit is true
                                                      child: Text(
                                                        hasChildData
                                                            ? '${_childrenList[i]['firstName']} ${_childrenList[i]['surname']}'
                                                            : 'Select Child ${i +
                                                            1}',
                                                        style:
                                                        TextStyle(
                                                          fontSize:
                                                          16,
                                                          color: hasChildData
                                                              ? Colors
                                                              .black
                                                              : Colors
                                                              .black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // Edit Button
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons.edit,
                                                        color: Colors
                                                            .blue),
                                                    onPressed: hasChildData &&
                                                        !isEditChild
                                                        ? () {
                                                      // Navigate to edit screen if child data exists and not in edit mode
                                                      Navigator
                                                          .push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddChildScreen(
                                                                isEdit:
                                                                'Edit',
                                                                childIndex:
                                                                i,
                                                                childrenList:
                                                                _childrenList,
                                                                flightDetails:
                                                                '',
                                                                resultFlightData:
                                                                '',
                                                                infantCount:
                                                                0,
                                                                childrenCount:
                                                                childrenCount,
                                                                adultCount:
                                                                0,
                                                                departdate:
                                                                '',
                                                                userid:
                                                                '',
                                                                usertypeid:
                                                                '',
                                                              ),
                                                        ),
                                                      ).then(
                                                              (_) {
                                                            // Fetch the updated children list when returning to this page
                                                            _fetchChildren();
                                                          });
                                                    }
                                                        : null, // Disable if there is no child data or isEdit is true
                                                  ),
                                                  // Delete Button
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons.delete,
                                                        color: Colors
                                                            .red),
                                                    onPressed: hasChildData &&
                                                        !isEditChild
                                                        ? () {
                                                      // Show confirmation dialog
                                                      showDialog(
                                                        context:
                                                        context,
                                                        builder:
                                                            (BuildContext
                                                        context) {
                                                          return AlertDialog(
                                                            title:
                                                            Text(
                                                                'Confirm Deletion'),
                                                            content:
                                                            Text(
                                                                'Are you sure you want to delete this child?'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text(
                                                                    'No'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop(); // Close dialog
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: Text(
                                                                    'Yes'),
                                                                onPressed: () {
                                                                  _deleteChild(
                                                                      i); // Call delete method for child
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop(); // Close dialog
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }
                                                        : null, // Disable if there is no child data or isEdit is true
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (InfantCount > 1)
                                  Divider(),
                                if (InfantCount > 1)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Infants',
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Column(
                                          children: List.generate(
                                              InfantCount, (i) {
                                            // Determine if there is valid child data
                                            bool hasInfantData =
                                                _infantList.length >
                                                    i &&
                                                    _infantList[i] !=
                                                        null &&
                                                    _infantList[i][
                                                    'firstName'] !=
                                                        null;

                                            print('hasChildData: ' +
                                                hasInfantData
                                                    .toString());

                                            return Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(8.0),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                    hasInfantData
                                                        ? Colors
                                                        .green
                                                        : Colors
                                                        .grey,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child:
                                                    GestureDetector(
                                                      onTap: !hasInfantData &&
                                                          !isEditInfant
                                                          ? () {
                                                        // Navigate to the page to add a child if there's no data
                                                        Navigator
                                                            .push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                AddInfantScreen(
                                                                  isEdit: 'Add',
                                                                  InfantIndex: i,
                                                                  InfantList: _infantList,
                                                                  flightDetails: '',
                                                                  resultFlightData: '',
                                                                  infantCount: 0,
                                                                  childrenCount: InfantCount,
                                                                  adultCount: 0,
                                                                  departdate: '',
                                                                  userid: '',
                                                                  usertypeid: '',
                                                                ),
                                                          ),
                                                        ).then(
                                                                (_) {
                                                              // Fetch the updated children list when returning to this page
                                                              _fetchInfant();
                                                            });
                                                      }
                                                          : null,
                                                      // Disable if there is child data or isEdit is true
                                                      child: Text(
                                                        hasInfantData
                                                            ? '${_infantList[i]['firstName']} ${_infantList[i]['surname']}'
                                                            : 'Select Infant ${i +
                                                            1}',
                                                        style:
                                                        TextStyle(
                                                          fontSize:
                                                          16,
                                                          color: hasInfantData
                                                              ? Colors
                                                              .black
                                                              : Colors
                                                              .black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // Edit Button
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons.edit,
                                                        color: Colors
                                                            .blue),
                                                    onPressed: hasInfantData &&
                                                        !isEditInfant
                                                        ? () {
                                                      // Navigate to edit screen if child data exists and not in edit mode
                                                      Navigator
                                                          .push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddInfantScreen(
                                                                isEdit:
                                                                'Edit',
                                                                InfantIndex:
                                                                i,
                                                                InfantList:
                                                                _infantList,
                                                                flightDetails:
                                                                '',
                                                                resultFlightData:
                                                                '',
                                                                infantCount:
                                                                0,
                                                                childrenCount:
                                                                InfantCount,
                                                                adultCount:
                                                                0,
                                                                departdate:
                                                                '',
                                                                userid:
                                                                '',
                                                                usertypeid:
                                                                '',
                                                              ),
                                                        ),
                                                      ).then(
                                                              (_) {
                                                            // Fetch the updated children list when returning to this page
                                                            _fetchInfant();
                                                          });
                                                    }
                                                        : null, // Disable if there is no child data or isEdit is true
                                                  ),
                                                  // Delete Button
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons.delete,
                                                        color: Colors
                                                            .red),
                                                    onPressed: hasInfantData &&
                                                        !isEditInfant
                                                        ? () {
                                                      // Show confirmation dialog
                                                      showDialog(
                                                        context:
                                                        context,
                                                        builder:
                                                            (BuildContext
                                                        context) {
                                                          return AlertDialog(
                                                            title:
                                                            Text(
                                                                'Confirm Deletion'),
                                                            content:
                                                            Text(
                                                                'Are you sure you want to delete this child?'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text(
                                                                    'No'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop(); // Close dialog
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: Text(
                                                                    'Yes'),
                                                                onPressed: () {
                                                                  _deleteInfant(
                                                                      i); // Call delete method for child
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop(); // Close dialog
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }
                                                        : null, // Disable if there is no child data or isEdit is true
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ), SizedBox(height: 50

                            ,)     ,

                        ],
                      ),
                    ),
                  ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.shade100,
                        // Light grey color for the starting horizontal line
                        width: 2, // Thickness of the line
                      ),
                    ),
                  ),
                  height: 80,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10.0, top: 8),
                            child: Text(
                              Currency + widget.TotalPrice,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(right: 10.0, top: 8),
                            child: ElevatedButton(
                              onPressed: submitAdivahaFlightBooking,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF152238),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Container(
                                width: 95,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  'Book Flight',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
