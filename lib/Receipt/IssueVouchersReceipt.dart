import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class IssueVouchersReceipt extends StatefulWidget {
  const IssueVouchersReceipt({Key? key}) : super(key: key);

  @override
  State<IssueVouchersReceipt> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<IssueVouchersReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vouchers",
          style: TextStyle(fontFamily: "Montserrat", fontSize: 16),
        ),
        //title: Image.asset('assets/images/lojologo.png', width: 150, height: 30,),
        actions: [
          Image.asset(
            'assets/images/lojologo.png',
            width: 150,
            height: 30,
          ),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: Color(0xFF00ADEE),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF00ADEE), width: 1),
          ),
          margin: EdgeInsets.only(
            right: 10,
            left: 10,
            top: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('BOOKING VOUCHERS',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    Image.asset('assets/images/lojologo.png',
                        width: 80, height: 50),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date: Jun Thu 02, 2022',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('Hi Jameswright'),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                      'Thank you for booking with Travel Demo. Our preferred partner would like to invite you to join a paid subscription service for access to discount offers.')),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Travel Demo Reference number: 3Z155W')),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                      'Please print and take this booking confirmation with you to the airport. It may speed up your check-in experience.')),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                      'For any concerns/queries related to this booking, please mention this reference number in all your future communications with us. You can contact us toll-free on')),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Booking Status: Processing')),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 3, left: 3),
                child: Divider(
                  color: Colors.black12,
                  thickness: 1,
                  height: 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 3, left: 3),
                child: Container(
                  height: 40,
                  color: Color(0xFF00ADEE),
                  alignment: Alignment.centerLeft,
                  child: Text('   Travellers Information',
                      style: TextStyle(
                          color: Color(0xFF00ADEE),
                          fontWeight: FontWeight.w600,
                          fontSize: 17)),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          ' JamesWright',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 3, left: 3),
                    child: Container(
                      height: 40,
                      color: Color(0xFF00ADEE),
                      alignment: Alignment.centerLeft,
                      child: Text('  Booking Information',
                          style: TextStyle(
                              color: Color(0xFF00ADEE),
                              fontWeight: FontWeight.w600,
                              fontSize: 17)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 15, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('PNR : UARZJ38',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 15, top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ticket Number:3Z155W',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 15, top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Passenger Name: JamesWright',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 3, left: 3, top: 10),
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                      height: 0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 3, left: 3),
                    child: Container(
                      height: 40,
                      color: Color(0xFF00ADEE),
                      alignment: Alignment.centerLeft,
                      child: Text('   OnWard Airlines :-',
                          style: TextStyle(
                              color: Color(0xFF00ADEE),
                              fontWeight: FontWeight.w600,
                              fontSize: 17)),
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text('  Airline Segments',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                  fontSize: 15)),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        DottedLine(),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 10),
                              child: Text(
                                'Dept.Date         : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '17-Feb-2023',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 10),
                              child: Text(
                                'Dep. Time         : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '01-Nov-2022',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 10),
                              child: Text(
                                'From                  : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'Dubai (DXB)',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 10),
                              child: Text(
                                '	To                      : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '	Munich (MUC)	',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 10),
                              child: Text(
                                '	Arv. Time         : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '05:55 AM',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 10),
                              child: Text(
                                'Flight No.          : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '	763 ',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 10),
                              child: Text(
                                'Airline                : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '	Lufthansa ',
                              ),
                            ),
                          ],
                        ),
                      ]),
                  SizedBox(
                    height: 5,
                  ),
                  DottedLine(),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            'Dept.Date         : ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            '17-Feb-2023',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            'Dep. Time         : ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            '01-Nov-2022',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            'From                  : ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Dubai (DXB)',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            '	To                      : ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            '	Munich (MUC)	',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            '	Arv. Time         : ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            '05:55 AM',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            'Flight No.          : ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            '	763 ',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            'Airline                : ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            '	Lufthansa ',
                          ),
                        ),
                      ],
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(right: 3, left: 3),
                    child: Container(
                      height: 40,
                      color: Color(0xFF00ADEE),
                      alignment: Alignment.centerLeft,
                      child: Text('   Return Airlines :-',
                          style: TextStyle(
                              color: Color(0xFF00ADEE),
                              fontWeight: FontWeight.w600,
                              fontSize: 17)),
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text('  Airline Segments',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                  fontSize: 15)),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        DottedLine(),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 10),
                              child: Text(
                                'Dept.Date         : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '17-Feb-2023',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 10),
                              child: Text(
                                'Dep. Time         : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '01-Nov-2022',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 10),
                              child: Text(
                                'From                  : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'Dubai (DXB)',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 10),
                              child: Text(
                                '	To                      : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '	Munich (MUC)	',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 10),
                              child: Text(
                                '	Arv. Time         : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '05:55 AM',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 10),
                              child: Text(
                                'Flight No.          : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '	763 ',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 10),
                              child: Text(
                                'Airline                : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '	Lufthansa ',
                              ),
                            ),
                          ],
                        ),
                      ]),
                  SizedBox(
                    height: 5,
                  ),
                  DottedLine(),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            'Dept.Date         : ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            '17-Feb-2023',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            'Dep. Time         : ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            '01-Nov-2022',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            'From                  : ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Dubai (DXB)',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            '	To                      : ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            '	Munich (MUC)	',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            '	Arv. Time         : ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            '05:55 AM',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            'Flight No.          : ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            '	763 ',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            'Airline                : ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            '	Lufthansa ',
                          ),
                        ),
                      ],
                    ),
                  ]),
                  SizedBox(
                    height: 6,
                    width: 6,
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Pax',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Text('     :	',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          'SAR 459355.00',
                        ),
                      ),
                      // Add more rows for Tax, T Fee, IGST, and Total Price
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Basic Fare	',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Text('      :    	',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          'SAR 2792.53',
                        ),
                      ),
                      // Add more rows for Tax, T Fee, IGST, and Total Price
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Tax & Charges	',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Text('     :           	',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          'SAR 0.00',
                        ),
                      ),
                      // Add more rows for Tax, T Fee, IGST, and Total Price
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Total ',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Text('    :    	',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          'SAR 8572.19',
                        ),
                      ),
                      // Add more rows for Tax, T Fee, IGST, and Total Price
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
