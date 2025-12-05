import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/HolidayPassengerModel.dart';
import '../utils/response_handler.dart';
import 'BookedItemViewModel.dart';
import 'CancelBookingListModel.dart';
import 'PassengerModel.dart';
import 'PaymentModel.dart';

class BookingCancelScreen extends StatefulWidget {
  final id;
  BookingCancelScreen({super.key, required this.id});
  @override
  _MyRechargePageState createState() => _MyRechargePageState();
}

class _MyRechargePageState extends State<BookingCancelScreen> {
  String _userImage = '';
  String selectedAccountType = 'Select Payment Mode';
  Future _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF007E01),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  "Add Photo",
                  style: TextStyle(
                    color: Color(0xFF00ADEE),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 100.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      child: Center(
                          child: Text("Gallery",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17))),
                      onTap: () {
                        _openGallery();
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(color: Colors.grey, thickness: 1),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    child: Center(
                        child: Text("Take Photo",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17))),
                    onTap: () {
                      _openCamera();
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF007E01),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Color(0xFF00ADEE),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  var accountTypes = [
    'Select Payment Mode',
    'Cash',
    'Cheque',
    'Credit Cards',
    'Debit Cards',
    'Electronic Bank Transfers',
    'Mobile Payments'
  ];
  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        _userImage = encodedImage;
        print('baseeeeeeb4:$_userImage');
      });
    }
  }

  Future<void> _openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final encodedImage = base64Encode(imageBytes);

      setState(() {
        _userImage = encodedImage;
        print('baseeeeeeb4:$_userImage');
      });
    }
  }

  static String savedId = '';

  late List<dynamic> table0,
      table1,
      table2,
      table3,
      table4,
      table5,
      table6,
      table8,
      table9,
      table10,
      table12,
      table13,
      table14,
      table16,
      table18,
      table19,
      table22,
      table23,
      table24,
      table34,
      table39,
      table40,
      table20,
      table21,
      table28;
  List<BookedItemViewModel> tableData = [];
  List<PassengerModel> table2Data = [];
  List<PaymentModel> table34Data = [];
  List<CancelBookingListModel> table28Data = [];
  List<HolidayPassengerModel> table18Data = [];
  var selectedDate = DateTime.now().obs;
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

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  Future<void> loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedId = prefs.getString('userId')!;
    });
  }

  Future<String?> getLabels() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "BookingCardViewGet", "BookFlightId=${widget.id}&StaffId=0");
    print('jfghhjgh' + savedId);
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);

      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table2 = map["Table2"];
      table8 = map['Table8'];
      table5 = map["Table5"];
      table10 = map["Table10"];
      table13 = map["Table13"];
      table20 = map["Table20"];
      table18 = map['Table18'];
      table28 = map['Table28'];
      table34 = map['Table34'];
      return jsonResponse;
    });
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
                "Booking cancellation",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: 17),
              ),
            ],
          ),
          actions: [
            Image.asset(
              'assets/images/lojologg.png',
              width: 150,
              height: 50,
            ),
            SizedBox(
              width: 10,
            )
          ],
          backgroundColor: Color(0xFF00ADEE),
        ),
        body: Center(
          child: FutureBuilder<String?>(
              future: getLabels(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  try {
                    PaymentModel m34 = PaymentModel.fromJson(table34[0]);
                    if (table34.isNotEmpty) {
                      m34 = PaymentModel.fromJson(table34[0]);
                      print("fjhg" + m34.balanceAmount);
                    } else {
                      print('The list is empty.');
                    }
                    tableData.clear();
                    if (table0.isNotEmpty) {
                      BookedItemViewModel m0 =
                          BookedItemViewModel.fromJson(table0[0]);
                      for (int i = 0; i < table0.length; i++) {
                        BookedItemViewModel t1Data =
                            BookedItemViewModel.fromJson(table0[i]);
                        tableData.add(t1Data);
                        print(
                            'Index: $i, tableData0 Length: ${tableData.length}, t1Data: $t1Data');
                      }
                    }
                    table18Data.clear();
                    if (table18.isNotEmpty) {
                      HolidayPassengerModel m16 =
                          HolidayPassengerModel.fromJson(table18[0]);

                      for (int i = 0; i < table18.length; i++) {
                        HolidayPassengerModel t18Data =
                            HolidayPassengerModel.fromJson(table18[i]);
                        table18Data.add(t18Data);
                        print(
                            'Index: $i, Table16 Length: ${table18.length}, t1Data: $t18Data');
                      }
                    }
                    table2Data.clear();
                    if (table2.isNotEmpty) {
                      PassengerModel m2 = PassengerModel.fromJson(table2[0]);
                      for (int i = 0; i < table2.length; i++) {
                        PassengerModel t2Data =
                            PassengerModel.fromJson(table2[i]);
                        table2Data.add(t2Data);
                        print(
                            'Index: $i, Table4 Length: ${table2.length}, t1Data: $t2Data');
                      }
                    }
                    table28Data.clear();
                    if (table28.isNotEmpty) {
                      CancelBookingListModel m2 =
                          CancelBookingListModel.fromJson(table28[0]);
                      for (int i = 0; i < table28.length; i++) {
                        CancelBookingListModel t28Data =
                            CancelBookingListModel.fromJson(table28[i]);
                        table28Data.add(t28Data);
                        print(
                            'Index: $i, Table4 Length: ${table28.length}, t1Data: $t28Data');
                      }
                    }
                    return SingleChildScrollView(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                                children: List.generate(
                              tableData.length,
                              (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        print('Button Clicked');
                                        _showSelectionDialog(context);
                                      },
                                      child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Colors.transparent,
                                            // Adjust the size as needed
                                            child: ClipOval(
                                              child: Image.asset(
                                                'assets/images/profile.png', // Replace with your placeholder image asset path
                                                width: 100,
                                                height: 100,
                                              ),
                                            ),
                                          ),
                                          Icon(Icons.camera_alt),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Passengers Data',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 0,
                                  ),
                                  if (tableData[index].bookingType ==
                                      "Flight".toString())
                                    Container(
                                      child: Column(
                                        children: List.generate(
                                            table2Data.length,
                                            (index) => Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 5,
                                                              top: 10),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              'Passenger Name: ' +
                                                                  "${table2Data[index].passenger}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 5,
                                                              top: 4),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              'Type: ' +
                                                                  "${table2Data[index].type}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 5,
                                                              top: 4),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              'Birth Date: ' +
                                                                  "${table2Data[index].tfpDOB}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 5,
                                                              top: 4),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              '	Identity No: ' +
                                                                  "${table2Data[index].tfpIdentityNo}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 5,
                                                              top: 4),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              'Phone Number: ' +
                                                                  "${table2Data[index].tfpPhoneNo}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 5,
                                                              top: 4),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              'Email: ' +
                                                                  "${table2Data[index].tfpEmail}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 9,
                                                    ),
                                                  ],
                                                )),
                                      ),
                                    ),
                                  if (tableData[index].bookingType ==
                                      "Holiday".toString())
                                    Container(
                                      child: Column(
                                        children: List.generate(
                                            table18Data.length,
                                            (index) => Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 5,
                                                              top: 10),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              'Passenger Name: ' +
                                                                  "${table18Data[index].passenger}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 5,
                                                              top: 4),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              'Type: ' +
                                                                  "${table18Data[index].type}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 5,
                                                              top: 4),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              'Birth Date: ' +
                                                                  "${table18Data[index].dob}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 5,
                                                              top: 4),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              '	Identity No: ' +
                                                                  "${table18Data[index].tfpIdentityNo}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 5,
                                                              top: 4),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              'Phone Number: ' +
                                                                  "${table18Data[index].phoneNo}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 5,
                                                              top: 4),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              'Email: ' +
                                                                  "${table18Data[index].email}",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 9,
                                                    ),
                                                  ],
                                                )),
                                      ),
                                    ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, top: 4),
                                    child: Row(
                                      children: [
                                        Text('Request Number',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 10),
                                    child: Container(
                                      height: 45,
                                      child: TextField(
                                        style: TextStyle(),
                                        textAlign: TextAlign.justify,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              color: Colors
                                                  .black, // Set the border color
                                              width:
                                                  2.0, // Set the border width
                                            ),
                                          ),
                                          hintText: '00',
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        'Departure Date',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 10,
                                    ),
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextField(
                                        onTap: () {
                                          chooseDate();
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'dd/MM/yyyy',
                                          prefixIcon: GestureDetector(
                                            onTap: () {
                                              chooseDate();
                                            },
                                            child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight:
                                                    25), // Replace with your desired icon
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Color(0xFF00ADEE)),
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(bottom: 5),
                                        ),
                                        readOnly: true,
                                        controller:
                                            dateController, // Use the TextEditingController
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        'Arrival Date',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 10,
                                    ),
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextField(
                                        onTap: () {
                                          chooseDate();
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'dd/MM/yyyy',
                                          prefixIcon: GestureDetector(
                                            onTap: () {
                                              chooseDate();
                                            },
                                            child: Image.asset(
                                                'assets/images/calendar.png',
                                                cacheWidth: 25,
                                                cacheHeight:
                                                    25), // Replace with your desired icon
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Color(0xFF00ADEE)),
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(bottom: 5),
                                        ),
                                        readOnly: true,
                                        controller:
                                            dateController, // Use the TextEditingController
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        'Message',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 5),
                                    child: Container(
                                      height: 160,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: '  ',
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                //validateTextField();
                                                /*  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              KYCApplication()));*/
                                              },
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Color(0xFF00ADEE), backgroundColor: Color(0xFF00ADEE), shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5), // Adjust the radius as needed
                                                ), // Text color
                                              ),
                                              child: SizedBox(
                                                  width: 115,
                                                  height: 40,
                                                  child: Center(
                                                    child: Text(
                                                      'Submit',
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(
                                              width: 1,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                /*  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  AddReview()));*/
                                              },
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Color(0xFF00ADEE), backgroundColor: Colors.red, shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5), // Adjust the radius as needed
                                                ), // Text color
                                              ),
                                              child: SizedBox(
                                                  width: 115,
                                                  height: 40,
                                                  child: Center(
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ]));
                  } catch (error) {
                    print('Unexpected error: $error');
                    return Text('An unexpected error occurred.');
                  }
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}
