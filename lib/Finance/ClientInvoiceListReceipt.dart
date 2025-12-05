import 'package:flutter/material.dart';

class ClientInvoiceListReceipt extends StatefulWidget {
  const ClientInvoiceListReceipt({Key? key}) : super(key: key);

  @override
  State<ClientInvoiceListReceipt> createState() =>
      _BookingCardGeneralDetailsState();
}

class _BookingCardGeneralDetailsState extends State<ClientInvoiceListReceipt> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              "Credit Invoice List Receipt",
              style: TextStyle(fontFamily: "Montserrat", fontSize: 16),
            ),
            //title: Image.asset('assets/images/lojolog.png', width: 150, height: 30,),
            actions: [
              Image.asset(
                'assets/images/lojolog.png',
                width: 150,
                height: 50,
              ),
              SizedBox(
                width: 10,
              )
            ],
            backgroundColor:Color(0xFF00ADEE)),
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
                      Text('Credit Note',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Image.asset('assets/images/lojolog.png',
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
                    child: Text('Client Invoice',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17)),
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
                          Text('Delitax Travel',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'PLOT NO.1038/8536, DEEPERLIFE ROAD,',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        children: [
                          Text('City : KABWATA',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        children: [
                          Text(
                            'Post Code & Phone : 10101 | +260952484111',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        children: [
                          Text(
                            'Email : delitex@d2r.com',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        children: [
                          Text(
                            'Invoice date:  27 November 2023',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        children: [
                          Text(
                            'Invoice Number:  2657',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        children: [
                          Text(
                            'Booking Status : TicketIssued',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
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
                        child: Text('   Passenger Details:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17)),
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
                                  fontSize: 17, fontWeight: FontWeight.w500)),
                          Text(
                            'Type : Adult',
                            style: (TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Passenger ID : 30596403059640',
                              style: (TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15))),
                          Text('Age : 72',
                              style: (TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15))),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Phone : Air India',
                              style: (TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15))),
                          Text(
                            '	Ticket No : 17-Nov-2022',
                            style: (TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
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
                        child: Text('   OnWard Segment:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17)),
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 15, top: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Depart: Kolkata(CCU)',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                  'Arrival: Mumbai(BOM)',
                                  style: (TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 15, top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('	Depart Date:	29-Dec-2023',
                                    style: (TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15))),
                                Text('	Flight No: 6128',
                                    style: (TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 15, top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('	Arrival Date: 29-Dec-2023',
                                    style: (TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15))),
                                Text(
                                  '	Duration: 3h 5m',
                                  style: (TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15)),
                                ),
                              ],
                            ),
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
                        child: Text('   Payment Details:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17)),
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 15, top: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Chandan Mishra',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 15, top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Input Tax:	BRL 1927.00',
                                  style: (TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 15, top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Output tax: BRL 660.00',
                                    style: (TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 15, top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Net Amount: BRL 660.00',
                                    style: (TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 15, top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Price: BRL 660.00',
                                    style: (TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 3, left: 3, top: 10),
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
                              child: Text('  Invoice Total (BRL):',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 15, top: 10),
                                child: Text(
                                  'Remittance:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
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
                                      padding:
                                          EdgeInsets.only(left: 10, top: 4),
                                      child: Text(
                                        'Lead Passenger:',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(width: 7),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(top: 4),
                                      child: Text('Gaurav Jitentra',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding:
                                          EdgeInsets.only(left: 10, top: 4),
                                      child: Text(
                                        'Booking Ref: KEB37P',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding:
                                          EdgeInsets.only(left: 10, top: 4),
                                      child: Text(
                                        'Airline: IndiGo',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding:
                                          EdgeInsets.only(left: 10, top: 4),
                                      child: Text(
                                        'Start Date: 29-Dec-2023',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding:
                                          EdgeInsets.only(left: 10, top: 4),
                                      child: Text(
                                        'End Date: 29-Dec-2023 ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding:
                                          EdgeInsets.only(left: 10, top: 4),
                                      child: Text(
                                        'Total: BRL 5986.00',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Base Price',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              Text('     :   	',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  ' BRL 6520.74',
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
                              Text('Total Tax',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              Text('       :    	',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  'BRL 2129.90',
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              Text('    :    	',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text('BRL 8650.64',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                              ),
                              // Add more rows for Tax, T Fee, IGST, and Total Price
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
                        child: Text(' Received Payments:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17)),
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 10, top: 4),
                                child: Text(
                                  'Receipt No:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 4),
                                child: Text('R001',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 10, top: 4),
                                child: Text(
                                  'Allocated Amount: BRL 10000.00',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 10, top: 4),
                                child: Text(
                                  'Status: Paid',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 10, top: 4),
                                child: Text(
                                  'Date: 29-Dec-2023',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
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
                        child: Text('  Terms And Conditions:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17)),
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
