import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
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
import 'MultiCityBookFlightNow.dart';

class MultiCityBooking extends StatefulWidget {
  final dynamic flightDetails, adultCount, childrenCount, infantCount,StopCountFirst,StopCountSecond,StopCountThird,TotalPrice;

  const MultiCityBooking(
      {super.key,
      required this.flightDetails,
      required this.infantCount,
      required this.childrenCount,
      required this.adultCount,
      required this.StopCountFirst,
        required this.StopCountSecond,
        required this.StopCountThird,
      required this.TotalPrice});

  @override
  State<MultiCityBooking> createState() => _TwoWayBookingState();
}

class _TwoWayBookingState extends State<MultiCityBooking> {
  var resultFlightData = [];
  bool isBookingLoading = false;
  bool isLoading = false;
  List<Map<String, dynamic>> _adultsList = [];
  List<Map<String, dynamic>> _childrenList = [];
  List<Map<String, dynamic>> _infantList = [];
  bool isEditAdult = false;
  bool isEditChild = false;
  bool isEditInfant = false;
  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';
  bool isExpanded = false;
  bool isExpanded1 = false;
  @override
  void initState() {
    super.initState();
print('StopCountFirst:${widget.StopCountFirst}');
    print('StopCountSecond:${widget.StopCountSecond}');
    print('StopCountThird:${widget.StopCountThird}');

    _retrieveSavedValues();
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
  Future<void> _fetchAdults() async {
    final dbHelper = DatabaseHelper.instance;
    final adults = await dbHelper.getAdults(); // Fetch adults from the database
    setState(() {
      _adultsList = adults;
      // Update the list to refresh UI
    });
  }
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
    /*  'TitleAdult1': selectedTitleAdult1.toString(),
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
     /* 'Address': contactAddressController.text.toString(),
      'City': contactCityController.text.toString(),
      'CountryCode': 'IN',
      'CountryName': _CountryController.text.toString(),
      'MobileNumber': contactMobileController.text.toString(),
      'Email': contactEmailController.text.toString(),
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
  Future<void> _fetchInfant() async {
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
  Future<void> _deleteInfant(int index) async {
    final dbHelper = InfantDatabaseHelper
        .instance; // Ensure you have a database helper instance
    if (_childrenList.length > index) {
      await dbHelper.deleteInfant(_childrenList[index]
      ['id']); // Use the appropriate method to delete from your database
      _fetchInfant(); // Refresh the list of adults after deletion
    }
  }
  Future<void> _deleteAdult(int index) async {
    final dbHelper =
        DatabaseHelper.instance; // Ensure you have a database helper instance
    if (_adultsList.length > index) {
      await dbHelper.deleteAdults(_adultsList[index]
      ['id']); // Use the appropriate method to delete from your database
      _fetchAdults(); // Refresh the list of adults after deletion
    }
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
  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
      print('Currency: $userID');
      // Call sendFlightSearchRequest() here after SharedPreferences values are retrieved
      getAdivahaFlightDetails();
    });
  }

  Future<void> getAdivahaFlightDetails() async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaFlightDetailsGet');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};



    String resultIndex = widget.flightDetails['ResultIndexID'];
    String traceId = widget.flightDetails['ItemId'];
    print("ResultIndexID: $resultIndex");
    print("ItemId: $traceId");

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
          'TripType': 'MultiCity',
          'UserID': '2611',
          'DefaultCurrency': 'KES'
        },
      );
      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        print('Request successful! Parsing response...');

        // Extract JSON from XML and parse the data
        var parsedJson = extractJsonFromXml(response.body).toList();

        print('Full response:');
        developer.log(parsedJson.toString());

        // Step 1: Separate data by StopCount conditions
        List<dynamic> finalResultFlightData = [];

        // Loop through each entry in parsed JSON
        for (var flight in parsedJson) {
          String stopCount = flight['StopCount'] ?? '0';
          String rowType = flight['RowType'] ?? '';



          // Logic based on StopCount and RowType
          if (stopCount == "0" && rowType == "MainRow") {
            // StopCount is 0: Add only MainRow data
            finalResultFlightData.add(flight);
            print('Adding MainRow data for StopCount == 0');
          }
          else if (stopCount == "1" && rowType == "SubRow") {
            // StopCount is 1: Add only SubRow data
            finalResultFlightData.add(flight);
            print('Adding SubRow data for StopCount == 1');
          }
        }

        // Update the UI with the final result
        setState(() {
          resultFlightData = finalResultFlightData;
          if (resultFlightData.isEmpty) {
            print('No valid flight data to display');
          } else {
            print('Final Result Flight Data: ${resultFlightData.toString()}');
          }
        });
      }



      else {
        print('Request failed with status: ${response.statusCode}');
        _showErrorMessage('Server error, please try again later.');
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

  void _showErrorMessage(String message) {
    // This method can show a dialog or a snackbar to the user
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
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
          ? ListView.builder(
              itemCount: 10, // Number of skeleton items
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListTile(
                    leading: Container(
                      width: 64.0,
                      height: 64.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 16.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          color: Colors.white,
                        ),
                        Container(
                          width: double.infinity,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          color: Colors.white,
                        ),
                        Container(
                          width: double.infinity,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                );
              })
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      color: Color(0xffd9dce1),
                      child: Column(
                        children: [
                          resultFlightData.length > 1
                              ? Column(
                                children: [
                                  ListView.builder(
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
                                                          SizedBox(height: 5),
                                                          // Add small space between text
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
                                                            width:75,
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
                                                          Text(resultFlightData[
                                                          index]
                                                          ['ArrivalDate']
                                                              .toString()
                                                              .substring(0, 10)),
                                                          SizedBox(height: 5),
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
                                                          Container( width: 75,
                                                            child: Text(
                                                              resultFlightData[index][
                                                              'ArrivalAirportName'],
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12), textAlign: TextAlign
                                                                .end,
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


                                            if (index + 1 < resultFlightData.length && index == 1)
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
                                            if (index + 1 < resultFlightData.length && index == 4)
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
                                            if (index < resultFlightData.length && index == 4)
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

                                            //Run anathum screenshot anupunga ok
                                          ],
                                        );
                                      }),
      SizedBox(
        height: 6,
      ),
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
      ), SizedBox(height: 50),
                                ],
                              )
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
                                              Text(
                                                resultFlightData[0]
                                                    ['DepartAirportName'],
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
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
                                              Text(
                                                resultFlightData[0]
                                                    ['ArrivalAirportName'],
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
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
                                                resultFlightData[0]['Baggage'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13),
                                              ),
                                              Text(
                                                'CheckIn\n Baggage',
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
                                                resultFlightData[0]
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
                                  ),
                                ),

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
                    color: Colors.white,
                    height: 80,
                    child: Column(
                      children: [
                        Divider(color: Colors.grey.shade400),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 8),
                              child: Text(
                                Currency + widget.TotalPrice,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0, top: 8),
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
                                        fontSize: 18, fontWeight: FontWeight.bold),
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
