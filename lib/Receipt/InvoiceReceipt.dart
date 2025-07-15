import 'package:flutter/material.dart';

class Receipt extends StatefulWidget {
  const Receipt({Key? key}) : super(key: key);

  @override
  State<Receipt> createState() => _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<Receipt> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                "Invoice List",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: 17),
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
          backgroundColor: Color(0xFF00ADEE),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
            ),
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Invoice', style: TextStyle(fontSize: 20)),
                      Image.asset('assets/images/lojologo.png',
                          width: 200, height: 50),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 3, left: 3),
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
                    color: Colors.black26,
                    alignment: Alignment.center,
                    child: Text('Invoice',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17)),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Corporate1',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Text('InvoiceDate : 27 September 2022'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '#13 First Cross st,',
                          ),
                          Text('Invoice Number : 1454'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        children: [
                          Text('Annanager West'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        children: [
                          Text('City : Riyadh'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        children: [
                          Text('Post Code & Phone : 600024 | 0645164489'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        children: [
                          Text('Email : Corporate1@gmail.com'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 3, left: 3),
                      child: Divider(
                        color: Colors.black,
                        height: 2,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 3, left: 3),
                      child: Container(
                        height: 40,
                        color: Colors.black26,
                        alignment: Alignment.centerLeft,
                        child: Text('   Passenger(s)',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17)),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('JamesWright',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600)),
                          Text('ETicket No : U6SUBL'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Booking Status : Cancelled'),
                          Text('No. Of Passengers : 2'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Airline : Air India'),
                          Text(
                            'Start Date : 01-Nov-2022',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(' '),
                          Text(
                            'End Date : 17-Nov-2022',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 3, left: 3, top: 10),
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
                        color: Colors.black26,
                        alignment: Alignment.centerLeft,
                        child: Text('   OnWard Segment :-',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17)),
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 16, top: 10),
                                child: Text(
                                  'Depart                              : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Delhi (DEL)',
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
                                  'Departure Date / Time  : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
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
                                  'Arrival                              : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
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
                                  '	Arrival Date / Time       : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
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
                                  'Flight No                          : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '915',
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
                                  'Class                                : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  ' ',
                                ),
                              ),
                            ],
                          ),
                        ]),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 3, left: 3, top: 10),
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
                        color: Colors.black26,
                        alignment: Alignment.centerLeft,
                        child: Text('   Return Segment :-',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17)),
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 16, top: 10),
                                child: Text(
                                  'Depart                              : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Delhi (DEL)',
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
                                  'Departure Date / Time  : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
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
                                  'Arrival                              : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
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
                                  '	Arrival Date / Time       : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
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
                                  'Flight No                          : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '915',
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
                                  'Class                                : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  ' ',
                                ),
                              ),
                            ],
                          ),
                        ]),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 3, left: 3, top: 10),
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
                        color: Colors.black26,
                        alignment: Alignment.centerLeft,
                        child: Text('   Price Details',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10),
                          child: Text(
                            'Fare Breakup (SAR)',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: Text(
                            'Total (SAR)',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 16, top: 10),
                                child: Text(
                                  'Pax Type      :',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 10),
                                child: Text('Adult',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 16, top: 10),
                                child: Text(
                                  'Base             :',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'SAR 459355.00',
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
                                  'Tax                :',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'SAR 2792.53',
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
                                  'T Fee             :',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'SAR 0.00',
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
                                  'IGST(18%)    :',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'SAR 0.0',
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
                                  'Total              :',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'SAR 8572.19',
                                ),
                              ),
                            ],
                          ),
                        ]),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 3, left: 3, top: 10),
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
                        color: Colors.black26,
                        alignment: Alignment.center,
                        child: Text('   Invoice Total (SAR)',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 7, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Total Price',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Row(
                        children: [
                          Text('Services towards issuance of air tickets',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 6,
                      width: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Base Price',
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
                        Text('Tax',
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
                        Text('T Fee',
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
                        Text('IGST(18%)',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('    :           	',
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
                        Text('Total Price ',
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Row(
                        children: [
                          Text('Category of Service : Support Services',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'This is a computer-generated Invoice and Digitally signed.',
                      style: TextStyle(fontSize: 12),
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
      ),
    );
  }
}
