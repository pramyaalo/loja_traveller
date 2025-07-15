import 'dart:convert';
import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../utils/response_handler.dart';
import 'package:http/http.dart' as http;

class ClientInvoiceReceipt extends StatefulWidget {
  const ClientInvoiceReceipt({Key? key}) : super(key: key);
  @override
  State<ClientInvoiceReceipt> createState() => _CarClientInvoiceReceiptState();
}

class _CarClientInvoiceReceiptState extends State<ClientInvoiceReceipt> {
  late List<dynamic> table0, table1, table2, table3, table4, table5, table11;
  /*Future<String?> getInvoiceReceiptJSON() async {
    Future<http.Response>? __futureLabels = ResponseHandler.performPost("CarClientInvoice_Receipt", "Id=${ids}");
    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map["Table1"];
      table2 = map["Table2"];
      table3 = map["Table3"];
      table4 = map["Table4"];
      table5 = map["Table5"];
      table11 = map["Table11"];
      return jsonResponse;
    } );
  }
*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Client Invoice",
                style: TextStyle(fontFamily: "Montserrat"),
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
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    margin: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 4, top: 4, left: 4),
                            width: double.infinity,
                            height: 50,
                            color: Color(0xffe1e3ea),
                            child: Center(
                              child: Text(
                                "Client Invoice",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
                              child: Image.asset(
                                'assets/images/lojologo.png',
                                width: 150,
                                height: 30,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                            child: Text(
                                "#13 First Cross st, Annanager West, Riyadh, 0645164489, Corporate1@gmail.com, 600024 ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            height: 0.5,
                            color: Colors.grey,
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Passengers",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              "Mr RizwanMohamed",
                              style: TextStyle(
                                  fontFamily: "Montserrat", fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Color(0xffe1e3ea),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Booking Reference : ",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.bold)),
                                    Text("U6SUBL",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Booking Date             : ",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.normal)),
                                    Text("27 September 2022",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Consultant                  : ",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.normal)),
                                    Text("Corporate1",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Phone Number         : ",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.normal)),
                                    Text("0645164489",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Email                            : ",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.normal)),
                                    Text("Corporate1@gmail.com",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Issue Date                   : ",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.normal)),
                                    Text("27 September 2022",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Flight Details",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Itinerary                       :   ",
                                      style:
                                          TextStyle(fontFamily: "Montserrat"),
                                    ),
                                    Expanded(
                                        child: Text(
                                      "Delhi (DEL) - Dubai (DXB) - Muharraq (BAH) - Paris (PAR)",
                                      style:
                                          TextStyle(fontFamily: "Montserrat"),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "PNR Number             :   ",
                                      style:
                                          TextStyle(fontFamily: "Montserrat"),
                                    ),
                                    Expanded(
                                        child: Text(
                                      "U6SUBL",
                                      style:
                                          TextStyle(fontFamily: "Montserrat"),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DottedLine(),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Flight               :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "${"Delhi (DEL) - Dubai (DXB)"}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Departure                  :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "${"01-Nov-2022,04:30 PM"}",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Arrival               :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "${"01-Nov-2022, 07:00 PM"}",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Airline PNR   :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "U6SUBL",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Status   :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "Confirmed",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  DottedLine(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Flight               :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "${"Delhi (DEL) - Dubai (DXB)"}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Departure                  :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "${"01-Nov-2022,04:30 PM"}",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Arrival               :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "${"01-Nov-2022, 07:00 PM"}",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Airline PNR   :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "U6SUBL",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Status   :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "Confirmed",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          DottedLine(),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Flight               :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "${"Delhi (DEL) - Dubai (DXB)"}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Departure                  :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "${"01-Nov-2022,04:30 PM"}",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Arrival               :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "${"01-Nov-2022, 07:00 PM"}",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Airline PNR   :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "U6SUBL",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Status   :   ",
                                        style:
                                            TextStyle(fontFamily: "Montserrat"),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "Confirmed",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat"),
                                      )),
                                    ],
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          DottedLine(),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              color: Color(0xffe1e3ea),
                              child: Center(
                                child: Text(
                                  "Description",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                PhysicalModel(
                                  color: Color(0xFF00ADEE),
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.all(10),
                                        child: Text(
                                          "Passenger",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 0, 10, 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Pax",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              "1 ADT",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 0, 10, 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Base Fare",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              "${"SAR  459355.00"}  ",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 0, 10, 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Taxes & Fee",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              "${"SAR  2792.53"}  ",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14),
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
                          /*SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text("Pax", style: TextStyle(fontFamily: "Montserrat", fontSize: 13, fontWeight: FontWeight.bold),),),
                        DataColumn(label: Text("Base Fare", style: TextStyle(fontFamily: "Montserrat", fontSize: 13, fontWeight: FontWeight.bold),),),
                        DataColumn(label: Text("Taxes & Fee", style: TextStyle(fontFamily: "Montserrat", fontSize: 13, fontWeight: FontWeight.bold),),),
                      ],

                      rows: [
                        DataRow(cells: [
                          DataCell(Text("1 ADT" , style: TextStyle(fontFamily: "Montserrat", fontSize: 13, fontWeight: FontWeight.normal),)),
                          DataCell(Text("${m4.Currency} ${m4.TotalSales}", style: TextStyle(fontFamily: "Montserrat", fontSize: 13, fontWeight: FontWeight.normal),)),
                          DataCell(Text("${m4.Currency} ${m4.InputTax}", style: TextStyle(fontFamily: "Montserrat", fontSize: 13, fontWeight: FontWeight.normal),)),
                        ])
                      ],

                    )
                ),
              ),*/

                          SizedBox(
                            height: 5,
                          ),
                          DottedLine(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 5, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Online Convenience Fee",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${"SAR 0.00"}  ",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 0.5,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 5, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${"SAR  8572.19"} ",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xffe1e3ea),
                            ),
                            margin: EdgeInsets.only(left: 3, right: 3),
                            width: double.infinity,
                            height: 50,
                            child: Center(
                              child: Text(
                                "Remittance",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Lead Passenger        :   ",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                        child: Text(
                                      "Mr RizwanMohamed",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                      ),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Booking Reference  :   ",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                        child: Text(
                                      "m0.TicketNo",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                      ),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Departure                   :   ",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                        child: Text(
                                      "m0.BookedOnDt",
                                      style:
                                          TextStyle(fontFamily: "Montserrat"),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Consultant                  :   ",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                        child: Text(
                                      "m0.AuthorizedBy",
                                      style:
                                          TextStyle(fontFamily: "Montserrat"),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total                              :   ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Montserrat"),
                                    ),
                                    Expanded(
                                        child: Text(
                                      "${"m4.Currency"} ${"m4.TotalNett"}",
                                      style:
                                          TextStyle(fontFamily: "Montserrat"),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Received           :   ",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                        child: Text(
                                      "${"m4.Currency"} ${"m4.TotalNett"}",
                                      style:
                                          TextStyle(fontFamily: "Montserrat"),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(right: 4, left: 4, bottom: 7),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              color: Color(0xffe1e3ea),
                              child: Center(
                                child: Text(
                                  "© Copyright G0Rehlat. All Rights Reserved.",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ),
                        ])))));
  }
}
