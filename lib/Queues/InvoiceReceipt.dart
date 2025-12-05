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
                "Invoice",
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
                      Image.asset('assets/images/lojologg.png',
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
                        child: Text('   Hotel Details:',
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
                                  'Hotel Name : ',
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
                                  'Four Points by Sheraton Bur Dubai',
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
                                  '	Room Type : ',
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
                                  'Classic Room,1 Double Bed,\nNonsmoking',
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
                                  'Nights          : ',
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
                                  '1',
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
                                  '	Check In     : ',
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
                                  'Check Out   : ',
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
                                  '	30 November 2023',
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
                        child: Text('  Invoice Total (BRL):',
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
                            'Remittance:',
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
                                  'Lead Passenger:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(top: 10),
                                child: Text('Gaurav Jitentra',
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
                                  'Consultant:',
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
                                  'Delitax Travel',
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
                                  ' Booking Ref:',
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
                                  'GIOISY(7240890328684)',
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
                                  '	Total:',
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
                                  'BRL 8650.64',
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
                                  'CheckOut Date: ',
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
                                  '30 November 2023',
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
                    SizedBox(
                      height: 6,
                      width: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Base Price',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('     :   	',
                            style: TextStyle(fontWeight: FontWeight.w600)),
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
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('       :    	',
                            style: TextStyle(fontWeight: FontWeight.w600)),
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
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('    :    	',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text(
                            'BRL 8650.64',
                          ),
                        ),
                        // Add more rows for Tax, T Fee, IGST, and Total Price
                      ],
                    ),
                    SizedBox(
                      height: 10,
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
                        child: Text('  Terms And Conditions:',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                              'Room Description : Classic Room,1 Double Bed,\nNonsmoking  ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
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
                          Text('Room Promotion : Member’s price: 32%|  ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
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
                          Text('Smoking Preference : NoPreference  ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
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
                          Text('Amenity:  Free WiFi ,  ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
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
                          Text('Inclusion:  Free WiFi ,  ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
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
                          Text('Hotel Policy:     ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Text(
                        '  As per the decree issued by UAE Government, 5% VAT shall be levied for all the hotels booking whose check in are from 1st Jan 2018 onward. The hotels may charge the same directly from customers for past bookings whose check in fall on or after 1st Jan 2018. Even if the accommodation was booked and paid for before 1st January 2018. Please inform your customers accordingly. | |CheckIn Time-Begin: 3:00 PM CheckIn Time-End: midnightCheckOut Time: 12:00 PMCheckIn Instructions: <ul> <li>Extra-person charges may apply and vary depending on property policy</li><li>Government-issued photo identification and a credit card, debit card, or cash deposit may be required at check-in for incidental charges</li><li>Special requests are subject to availability upon check-in and may incur additional charges; special requests cannot be guaranteed</li><li>This property accepts credit cards and debit cards; cash is not accepted</li><li>This property reserves the right to pre-authorize the guest credit card prior to arrival.</li><li>Please note that cultural norms and guest policies may differ by country and by property; the policies listed are provided by the property</li> </ul> Special Instructions : Front desk staff will greet guests on arrival. Guests are recommended to download the property expedia mobile app before check-in.Minimum CheckIn Age : 18Mandatory Fees: <p>You  asked to pay the following charges at the property:</p> <ul><li>Deposit: AED 200 per accommodation, per day</li><li>Breakage deposit: AED 750 per stay</li><li>A tax is imposed by the city: AED 15.00 per accommodation, per night</li></ul> <p>We have included all charges provided to us by the property. </p> Optional Fees: <ul> <li>Fee for buffet breakfast: approximately AED 60 for adults and AED 30 for children</li> <li>Crib (infant bed) fee: AED 100.0 per stay</li><li>Rollaway bed fee: AED 150.0 per day</li> </ul> <p>The above list may not be comprehensive. Fees and deposits may not include tax and are subject to change. </p>Cards Accepted: Visa,Diners Club,Debit cards,Cash not accepted,American Express,JCB International,Mastercard<ul> <li>One child 12 years old or younger stays free when occupying the parent or guardian room, using existing bedding. </li><li>Only registered guests are allowed in the guestrooms. </li> <li>The property has connecting/adjoining rooms, which are subject to availability and can be requested by contacting the property using the number on the booking confirmation. </li><li>This property advises that enhanced cleaning and guest safety measures are currently in place.</li><li>Disinfectant is used to clean the property.</li><li>Social distancing measures are in place and guests are provided with hand sanitizer.</li> </ul>,Service animals are allowed,Service animals are exempt from fees/restrictions,Pets not allowed,Professional property host/manager,Property confirms they are implementing guest safety measures,Social distancing measures are in place,Property confirms they are implementing enhanced cleaning measures,Guests are provided with free hand sanitizer,Property is cleaned with disinfectant,Essential workers only - NOW.e.f 31.03.2014, Government of Dubai is applying “Tourism Dirham” a fee ranging from AED 7-20 per room per night, which the guests availing the stay will have to pay to the hotel directly as applied before check-out.Please refer to the following Terms of Use - http://mytravelagent.online/termsofuse.pdfEarly check out will attract full cancellation charge unless otherwise specified.|City tax and Resort fee are to be paid directly at hotel if applicable.',
                        style: TextStyle(fontSize: 12),
                      ),
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
                          Text('Cancellation Policy:     ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Text(
                        'Classic Room,1 Double Bed,Nonsmoking#^#100.00% of total amount will be charged, If cancelled between 06-Nov-2023 00:00:00 and 18-Nov-2023 23:59:59.|100.00% of total amount will be charged, If cancelled between 19-Nov-2023 00:00:00 and 30-Nov-2023 23:59:59.|#!#',
                        style: TextStyle(fontSize: 12),
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
