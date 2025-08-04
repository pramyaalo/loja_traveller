import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import '../../utils/response_handler.dart';

class TwoWayBooking extends StatefulWidget {
  final flightDetails;
  const TwoWayBooking({
    super.key,
    required this.flightDetails,
  });

  @override
  State<TwoWayBooking> createState() => _TwoWayBookingState();
}

class _TwoWayBookingState extends State<TwoWayBooking> {
  var resultFlightData = [];
  bool isBookingLoading = false;
  bool isLoading = false;

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
      'TripType': 'Oneway',
      'UserId': '',
      'TravelPolicy': 'InPolicy',
      'TravelPolicyId': '',
      'AdultCount': '1',
      'ChildCount': '0',
      'InfantCount': '0',
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
      'TitleAdult1': 'Mrs',
      'FNameAdult1': 'Shanthini Vasan',
      'LNameAdult1': 'K',
      'LDOBAdult1': '1990/01/01',
      'GenderAdult1': '1',
      'DocNumAdult1': '65757657655',
      'ExpDateAdult1': '2025/01/01',
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
      'Address': 'New Street',
      'City': 'Nagercoil',
      'CountryCode': 'IN',
      'CountryName': 'India',
      'MobileNumber': '9988776655',
      'Email': 'abc@abc.com',
      'AdultTravellerID1': '',
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

  Future<void> getAdivahaFlightDetails() async {
    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaFlightDetailsGet');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    print(widget.flightDetails['ResultIndexID']);
    print(widget.flightDetails['ItemId']);

    String resultIndex = widget.flightDetails['ResultIndexID'];
    String traceId = widget.flightDetails['ItemId'];

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
          'TripType': 'Oneway'
        },
      );
      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        dynamic tmp_resultFlightData =
            json.decode(ResponseHandler.parseData(response.body));

        setState(() {
          resultFlightData = tmp_resultFlightData;
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
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.asset(
                                        'assets/images/img.png',
                                        height: 50,
                                        width: 50,
                                      )),
                                  Text(
                                    'Aksaa Air',
                                    style: TextStyle(color: Color(0xff777777)),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '06:00 AM - 09:25 AM',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Row(
                                    children: [
                                      Text('DEL',
                                          style: TextStyle(
                                              color: Color(0xff777777),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13)),
                                      Icon(Icons.arrow_right_alt),
                                      Text('MAA',
                                          style: TextStyle(
                                              color: Color(0xff777777),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13))
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '3 hr 25 min',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '1 Stop',
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                              Container(
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'INR 1,444',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Refundable',
                                style: TextStyle(
                                    color: Color(0xff11A578), fontSize: 13),
                              ),
                              Text(
                                'Fare Details',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 13),
                              ),
                              Text(
                                'More Details',
                                style: TextStyle(
                                    color: Color(0xffdf7417), fontSize: 13),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.asset(
                                        'assets/images/img.png',
                                        height: 50,
                                        width: 50,
                                      )),
                                  Text(
                                    'Aksaa Air',
                                    style: TextStyle(color: Color(0xff777777)),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '06:00 AM - 09:25 AM',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Row(
                                    children: [
                                      Text('DEL',
                                          style: TextStyle(
                                              color: Color(0xff777777),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13)),
                                      Icon(Icons.arrow_right_alt),
                                      Text('MAA',
                                          style: TextStyle(
                                              color: Color(0xff777777),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13))
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '3 hr 25 min',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '1 Stop',
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                              Container(
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'INR 1,444',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Refundable',
                                style: TextStyle(
                                    color: Color(0xff11A578), fontSize: 13),
                              ),
                              Text(
                                'Fare Details',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 13),
                              ),
                              Text(
                                'More Details',
                                style: TextStyle(
                                    color: Color(0xffdf7417), fontSize: 13),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Traveller Details',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'First Name',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Last Name',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Date of birth',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Nationality',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Document Number',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Expiry Date',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Contact Details',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Email Address',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Mobile Number',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Address',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'City',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Country',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 10.0,
                        backgroundColor: Theme.of(context).primaryColor,
                        shadowColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.all(10.0),
                        minimumSize: const Size(double.infinity, 50.0),
                      ),
                      child: const Text(
                        "Continue Booking",
                        style: TextStyle(fontFamily: "Montserrat"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
