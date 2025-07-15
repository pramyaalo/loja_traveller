import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/response_handler.dart';
import 'BookedItemViewModel.dart';
import 'PaymentModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AllocatePaymentScreen(),
    );
  }
}

class AllocatePaymentScreen extends StatefulWidget {
  @override
  _MyRechargePageState createState() => _MyRechargePageState();
}

class _MyRechargePageState extends State<AllocatePaymentScreen> {
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
      table21;
  List<BookedItemViewModel> tableData = [];
  List<PaymentModel> table34Data = [];
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
        "BookingCardViewGet", "BookFlightId=${savedId}&StaffId=0");
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
      table34 = map['Table34'];
      return jsonResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Allocate Payment",
            style: TextStyle(fontFamily: "Montserrat", fontSize: 17),
          ),
          //title: Image.asset('assets/images/lojologo.png', width: 150, height: 30,),
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

                    BookedItemViewModel m0 =
                        BookedItemViewModel.fromJson(table0[0]);
                    if (table0.isNotEmpty) {
                      m0 = BookedItemViewModel.fromJson(table0[0]);
                      print("fjhg" + m0.bookingType);
                    } else {
                      print('The list is empty.');
                    }

                    return SingleChildScrollView(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
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
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Booking Ref.',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    height: 45,
                                    width: 320,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color:
                                            Colors.grey, // Set the border color
                                        width: 1.0, // Set the border width
                                      ),
                                    ),
                                    child: Text(
                                      "    " + m0.bookingId,
                                      style: TextStyle(),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Pay Currency',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    height: 45,
                                    width: 320,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color:
                                            Colors.grey, // Set the border color
                                        width: 1.0, // Set the border width
                                      ),
                                    ),
                                    child: Text(
                                      "",
                                      style: TextStyle(),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Balance Due Date',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    height: 45,
                                    width: 320,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color:
                                            Colors.grey, // Set the border color
                                        width: 1.0, // Set the border width
                                      ),
                                    ),
                                    child: Text(
                                      m0.dueDate,
                                      style: TextStyle(),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Mode Of Payment',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Select Payment Mode',
                                        contentPadding:
                                            EdgeInsets.only(bottom: 5),
                                      ),
                                      value: selectedAccountType,
                                      items: accountTypes
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("   " + value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedAccountType = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Date Of Payment',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
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
                                        hintText: 'Select DOB',
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
                                SizedBox(height: 16),
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Against Invoice:',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded:
                                          true, // Set this property to true
                                      underline: Container(),
                                      items: [
                                        'Option 1',
                                        'Option 2',
                                        'Option 3'
                                      ]
                                          .map((String value) =>
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              ))
                                          .toList(),
                                      onChanged: (String? value) {
                                        // Handle dropdown change
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Receipt No',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
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
                                            width: 2.0, // Set the border width
                                          ),
                                        ),
                                        hintText: 'Enter Receipt No',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Payment Time Limit',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
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
                                SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
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
                                            width: 2.0, // Set the border width
                                          ),
                                        ),
                                        hintText: '00:AM:PM',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Remarks',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
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
                                SizedBox(height: 40),
                                Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 5, top: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Allocate For: ' + "Total",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 5, top: 4),
                                        child: Row(
                                          children: [
                                            Text(
                                                'Sale Amount: ' +
                                                    m34.bookingAmount,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 5, top: 4),
                                        child: Row(
                                          children: [
                                            Text(
                                                'Amount Allocated: ' +
                                                    m34.allocatedAmount,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 5, top: 4),
                                        child: Row(
                                          children: [
                                            Text(
                                                'Balance: ' + m34.balanceAmount,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 5, top: 4),
                                        child: Row(
                                          children: [
                                            Text('Allocate Amount: ' + "",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
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
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 5, top: 4),
                                        child: Row(
                                          children: [
                                            Text('Total Allocated Amount ' + "",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
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
                                      SizedBox(
                                        height: 16,
                                      ),
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
                                              foregroundColor: Color(0xFF00ADEE),
                                              backgroundColor: Color(0xFF00ADEE),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    5), // Adjust the radius as needed
                                              ), // Text color
                                            ),
                                            child: SizedBox(
                                                width: 115,
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    'Save',
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
                                              foregroundColor: Color(0xFF00ADEE),
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
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
