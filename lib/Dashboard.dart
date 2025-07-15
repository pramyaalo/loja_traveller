import 'dart:convert';
import 'dart:developer';



import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:loja_traveller/utils/response_handler.dart';
import 'package:loja_traveller/utils/shared_preferences.dart';



import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'Booking/AllBookingList.dart';
import 'Booking/BookingCard.dart';
import 'Booking/BookingRefundsDue.dart';
import 'Booking/CancelledBooking.dart';
import 'Booking/NewBooking.dart';
import 'Booking/OpenBooking.dart';
import 'Booking/PartPayment.dart';
import 'Booking/PendingPayment.dart';
import 'Booking/ProductWiseBooking.dart';
import 'Booking/ServiceRequest.dart';
import 'Booking/TwoWayBoardingFlightsList.dart';
import 'Booking/UnConfirmedBooking.dart';
import 'Charges Payment/CancellationCharges.dart';
 import 'Finance/ClientInvoices.dart';
import 'Finance/CreditNotes.dart';
import 'Finance/DebtorAgingReport.dart';
import 'Finance/FinancialBook.dart';
import 'Finance/FlightTicketList.dart';
import 'Finance/InvoiceList.dart';
 import 'Finance/TransactionReport.dart';
import 'Finance/Vouchers.dart';

import 'Help/ArchivedTickets.dart';
import 'Help/ClosedTickets.dart';
import 'Help/CreateTicket.dart';
import 'Help/OpenTicket.dart';
import 'Help/ResolvedTickets.dart';
import 'Markups/Bus/MarkupBusDate.dart';
import 'Markups/Bus/MarkupBusDestination.dart';
import 'Markups/Bus/MarkupBusFare.dart';
import 'Markups/Holiday/MarkupHolidaydate.dart';
import 'Markups/Holiday/Markupholidayfare.dart';
import 'Markups/Holiday/markupHolidayDestination.dart';
import 'Markups/Hotel/MarkupHotelDestination.dart';
import 'Markups/Hotel/MarkupHotelFare.dart';
import 'Markups/Hotel/MarkupHoteldate.dart';
import 'Markups/Hotel/MarkupHotelrating.dart';
import 'Markups/MarkupFlightAirline.dart';
import 'Markups/MarkupFlightDate.dart';
import 'Markups/MarkupFlightDestination.dart';
import 'Markups/MarkupFlightFare.dart';
import 'Markups/MarkupList.dart';
import 'Markups/car/MarkupCarDestination.dart';
import 'Markups/car/MarkupcarFare.dart';
import 'Markups/car/Markupcardate.dart';
import 'Models/DashboardModel.dart';

import 'Models/hotel_destination_models.dart';
import 'Queues/ApprovePartPayment.dart';
import 'Queues/ApproveRefundQueue.dart';
import 'Queues/CancelBookingQueue.dart';
import 'Queues/CancelTicketQueue.dart';
import 'Queues/FraudCheckQueue.dart';
import 'Queues/PendingQueue.dart';
import 'Queues/RefundedBookingQueue.dart';
import 'Queues/TicketOrderQueue.dart';
import 'Report/BookingCancellationReport.dart';
import 'Report/BookingReport.dart';
import 'Report/ChangingRequestReport.dart';
import 'Report/ClientInvoiceReport.dart';
import 'Report/InvoiceReport.dart';
import 'Report/LedgerStatementReport.dart';
import 'Report/PaymentCollectionReport.dart';
import 'Report/RequestCancellationReport.dart';
import 'Report/TicketReport.dart';
import 'Report/UnConfirmedBooking.dart';
import 'Report/UnTicketReport.dart';

import 'Report/WalletStateMentreport.dart';
import 'Report/sales_report.dart';
import 'SMS/EmailTicket.dart';
import 'Travellers/ActiveTravellers.dart';
import 'Travellers/ApproveTravellers.dart';
import 'Travellers/ChangePasswordTravellers.dart';
import 'Travellers/ManageTravellers.dart';
import 'Travellers/UnBlockTravellers.dart';
import 'Wallets/CreditBalanceRequest.dart';
import 'Wallets/CreditRequestApproved.dart';
import 'Wallets/CreditRequestReceipt.dart';
import 'Wallets/CreditRequestRejected.dart';
import 'Wallets/CreditUsage.dart';
import 'Wallets/FundReceivedHistory.dart';
import 'Wallets/FundTransfer.dart';
import 'Wallets/FundTransferHistory.dart';
import 'bookings/flight/AddTravellers_Flight.dart';
import 'bookings/flight/FlightScreenModel.dart';
import 'bookings/flight/flight_screen.dart';
import 'bookings/flight/multicity_flight_list.dart';
import 'bookings/flight/one_way_flight_list.dart';
import 'bookings/holidays/HolidaysScreen.dart';
import 'bookings/hotels/hotels_screen.dart';

class Dashboard extends StatefulWidget {
  final Username, email, currency;
  const Dashboard(
      {super.key,
        required this.Username,
        required this.email,
        required this.currency});
  @override
  _CorDashboardState createState() => _CorDashboardState();
}

class _CorDashboardState extends State<Dashboard> {
  late List<dynamic> table0, table1, table2, table3, table4, table5, table6;
  late String userTypeID = '';
  late String userID = '';
  @override
  void initState() {
    super.initState();
    _retrieveSavedValues();
    pageController = PageController();
  }

  void reloadDashboard() {
    // Add your code here to reload the dashboard content
    // For b2c, you can fetch new data or reset the state
  }
  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      print("userTypeID" + userTypeID);
      print("userID" + userID);
    });
  }

  Future<String?> getInvoiceReceiptJSON() async {
    print("userTypeID" + userTypeID);
    print("userID" + userID);
    Future<http.Response>? futureLabels = ResponseHandler.performPost(
        "TravellerDashboard", "UserTypeId=${userTypeID}&UserId=${userID}");
    return await futureLabels.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      Map<String, dynamic> map = json.decode(jsonResponse);
      table0 = map["Table"];
      table1 = map["Table1"];
      table2 = map["Table2"];
      table3 = map["Table3"];
      table4 = map["Table4"];
      table5 = map["Table5"];
      table6 = map["Table6"];
      log('Response: $jsonResponse');
      return jsonResponse;
    });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isInvoiceSelected = false;
  late String Balance = "",
      Balance1 = '',
      affiliate = "",
      TotalEarnings = "",
      AvailableBalance = "",
      DirectIncome = "",
      LevelIncome = "",
      BinaryIncome = "",
      Notification = "",
      Kyc = "",
      UnusedEpins = "",
      UsedEpins = "",
      TransferedEpins = "",
      ReceivedEpins = "",
      TotalWithdrawals = "",
      FundTrasnfered = "",
      FundReceived = "",
      MessageSent = "",
      Inbox = "",
      TotalOrders = "",
      NewOrders = "",
      CompletedOrders = "",
      PersonalMember = "",
      TeamMember = "";
  String? UserId;
  String? Name;
  String imageUrl = '';
  String? UserName;
  bool ispremium = false;
  List<Color> gradientColors = [
    Colors.cyan,
    Color(0xFF152238),
  ];

  bool showAvg = false;
  int currentIndex = 0;
  late PageController pageController;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 1,
        title: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 27,
              ),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),

            SizedBox(width: 1), // Set the desired width
            Text(
              "DashBoard",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Montserrat", fontSize: 19),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/lojologo.png',
            width: 100,
            height: 50,
          ),

        ],
        backgroundColor:Color(0xFF00ADEE),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(widget.Username,
                    style: TextStyle(fontFamily: "Montserrat")),
                accountEmail: Text(widget.email,
                    style: TextStyle(fontFamily: "Montserrat")),
                decoration: BoxDecoration(color:Color(0xFF00ADEE)),
                currentAccountPicture: CircleAvatar(
                    backgroundColor:Color(0xFF00ADEE),
                    child: Text(
                        widget.Username.isEmpty
                            ? ""
                            : widget.Username.substring(0, 1),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 19))),
              ),
              ListTile(
                onTap: () {
                  setState(() {});
                  Navigator.pop(context);
                },
                leading: Icon(Icons.home, color: Colors.black),
                title: Text("Dashboard",
                    style: TextStyle(fontFamily: "Montserrat")),
              ),
              ExpansionTile(
                title: Text(
                  "Booking",
                  style: TextStyle(fontFamily: "Montserrat"),
                ),
                textColor: Colors.black,
                leading: Icon(
                    const IconData(0xee5e, fontFamily: 'MaterialIcons'),
                    color: Colors.black),
                iconColor: Colors.black,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 62),
                    child: Row(
                      children: [
                        Icon(Icons.ramp_right),

                        SizedBox(
                            width:
                            10), // Adjust the space between icon and text
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BookingCard(),
                              ),
                            );
                          },
                          child: Text(
                            "Booking Card",
                            style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",

                              // You can apply other text styles as needed
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),


              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Vouchers()));
                },
                leading: Icon(Icons.align_vertical_bottom_outlined,
                    color: Colors.black),
                title: Text("Issue Vouchers",
                    style: TextStyle(fontFamily: "Montserrat")),
              ),
              ExpansionTile(
                title: Text("Invoices",
                    style: TextStyle(fontFamily: "Montserrat")),
                textColor: Colors.black,
                leading: Icon(Icons.inventory_outlined, color: Colors.black),
                iconColor: Colors.black,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    FlightTicketList(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(Icons.computer_outlined),
                              SizedBox(width: 10),
                              Text(
                                "Flight Ticket List",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    InvoiceList(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(Icons.computer_outlined),
                              SizedBox(width: 10),
                              Text(
                                "Invoice List",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ClientInvoiceList(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(Icons.pause_presentation_outlined),
                              SizedBox(width: 10),
                              Text(
                                "Client Invoice List",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CreditNoteInvoiceList(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(Icons.surround_sound),
                              SizedBox(width: 10),
                              Text(
                                "Credit Note",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                ],
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EmailTicket()));
                },
                leading: Icon(Icons.align_vertical_bottom_outlined,
                    color: Colors.black),
                title: Text("SMS/Email Ticket",
                    style: TextStyle(fontFamily: "Montserrat")),
              ),
              ExpansionTile(
                title:
                Text("Charges/Payment", style: TextStyle(fontFamily: "Montserrat")),
                textColor: Colors.black,
                leading: Icon(
                    const IconData(0xe2eb, fontFamily: 'MaterialIcons'),
                    color: Colors.black),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ChangingRequestReport(

                                        )));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.assessment_sharp),
                              SizedBox(width: 10),
                              Text(
                                "Cancellation Charges",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PaymentCollectionReport(

                                        )));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.join_full_outlined),
                              SizedBox(width: 10),
                              Text(
                                "Make Payment",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),
                ],
              ),
              ExpansionTile(
                title:
                Text("Reports", style: TextStyle(fontFamily: "Montserrat")),
                textColor: Colors.black,
                leading: Icon(
                    const IconData(0xe621, fontFamily: 'MaterialIcons'),
                    color: Colors.black),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BookingReport()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.computer),
                              SizedBox(width: 10),
                              Text(
                                "Booking Report",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BookingCancellationReport()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.arrow_circle_left_outlined),
                              SizedBox(width: 10),
                              Text(
                                "Booking Cancellation Report",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UnConfirmedBooking()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.adjust_rounded),
                              SizedBox(width: 10),
                              Text(
                                "UnConfirmed Booking",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RequestCancellationReport()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.volume_down_alt),
                              SizedBox(width: 10),
                              Text(
                                "Request Cancellation Report",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                 /* Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ChangingRequestReport()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.chair),
                              SizedBox(width: 10),
                              Text(
                                "Changing Request Report",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ClientInvoiceReport()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.attach_money_outlined),
                              SizedBox(width: 10),
                              Text(
                                "Client Invoice Report",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        InvoiceReport()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.book_online_sharp),
                              SizedBox(width: 10),
                              Text(
                                "Invoice Report",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LedgerSttementReport()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.payments_sharp),
                              SizedBox(width: 10),
                              Text(
                                "Ledger Statement Report",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PaymentCollectionReport()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.payments_rounded),
                              SizedBox(width: 10),
                              Text(
                                "Payment Collection Report",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SalesReport()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.handshake),
                              SizedBox(width: 10),
                              Text(
                                "Sales Report",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TicketReport()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.handshake_outlined),
                              SizedBox(width: 10),
                              Text(
                                "Ticket Report",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UnTicketReport()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.album_rounded),
                              SizedBox(width: 10),
                              Text(
                                "Unticket Report",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        WalletStateMentreport()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.album_rounded),
                              SizedBox(width: 10),
                              Text(
                                "Wallet Statement Report",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                ],
              ),
              ExpansionTile(
                title:
                Text("Wallets", style: TextStyle(fontFamily: "Montserrat")),
                textColor: Colors.black,
                leading: Icon(
                    const IconData(0xe19a, fontFamily: 'MaterialIcons'),
                    color: Colors.black),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CreditUsage()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.create_new_folder_outlined),
                              SizedBox(width: 10),
                              Text(
                                "Credit Usage",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CreditBalanceRequest()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.credit_card_off_sharp),
                              SizedBox(width: 10),
                              Text(
                                "Credit Balance Request",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CreditRequestApproved()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.car_rental),
                              SizedBox(width: 10),
                              Text(
                                "Credit Request Approved",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CreditRequestRejected()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.crib_sharp),
                              SizedBox(width: 10),
                              Text(
                                "Credit Request Rejected",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BalanceReceipt()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.chrome_reader_mode),
                              SizedBox(width: 10),
                              Text(
                                "Credit Request Receipt",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        FundReceivedHistory()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.real_estate_agent),
                              SizedBox(width: 10),
                              Text(
                                "Fund Received History",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(),
                ],
              ),
              ExpansionTile(
                title:
                Text("Markups", style: TextStyle(fontFamily: "Montserrat")),
                textColor: Colors.black,
                leading: Icon(
                    const IconData(0xe19a, fontFamily: 'MaterialIcons'),
                    color: Colors.black),
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MarkupFlightDestination()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.credit_card_off_sharp),
                              SizedBox(width: 10),
                              Text(
                                "Markup Flight Destination",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MarkupFlightAirline()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.car_rental),
                              SizedBox(width: 10),
                              Text(
                                "Markup Flight Airline",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MarkupFlightDate()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.crib_sharp),
                              SizedBox(width: 10),
                              Text(
                                "Markup Flight Date",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MarkupFlightFare()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.chrome_reader_mode),
                              SizedBox(width: 10),
                              Text(
                                "Markup Flight Fare",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MarkupHotelDestination()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.format_underline_rounded),
                              SizedBox(width: 10),
                              Text(
                                "Markup Hotel Destination",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MarkupHoteldate()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.close_fullscreen_rounded),
                              SizedBox(width: 10),
                              Text(
                                "markup Hotel date",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MarkupHotelFare()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.real_estate_agent),
                              SizedBox(width: 10),
                              Text(
                                "Markup Hotel Fare",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MarkupHotelrating()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.real_estate_agent),
                              SizedBox(width: 10),
                              Text(
                                "Markup Hotel Rating",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                  SizedBox(
                    height: 8,
                  ),
                  Divider(),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: <Widget>[
                // The containers in the background
                new Column(
                  children: <Widget>[
                    new Container(
                      height: MediaQuery.of(context).size.height * .11,
                      decoration: BoxDecoration(
                        color:Color(0xFF00ADEE),
                        boxShadow: [
                          BoxShadow(color:Color(0xFF00ADEE), spreadRadius: 3)
                        ],
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width,
                            80.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    FlightScreen()));
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                          top: 35,
                          right: 5.0,
                          left: 40.0,
                        ),
                        child: Container(
                          height: 105.0,
                          width: 85.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/flights.png', // Replace 'assets/bus_icon.png' with your actual image asset path
                                  height: 40.0,
                                  width: 50.0,
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Flights',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HotelsScreen()));
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                          top: 35,
                          right: 5.0,
                          left: 5.0,
                        ),
                        child: Container(
                          height: 105.0,
                          width: 85.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/hotel.png', // Replace with your actual image asset path
                                  height: 40.0,
                                  width: 50.0,
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Hotels',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Holidays()));
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                          top: 35,
                          right: 5.0,
                          left: 5.0,
                        ),
                        child: Container(
                          height: 105.0,
                          width: 85.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/holiday.jpg', // Replace 'assets/bus_icon.png' with your actual image asset path
                                  height: 40.0,
                                  width: 50.0,
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Tours',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: FutureBuilder<String?>(
                  future: getInvoiceReceiptJSON(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      try {
                        log('Datagfggg: :${snapshot.data}');
                        Table0 m0 = Table0.fromJson(table0[0]);

                        Table6 m6 = Table6.fromJson(table6[0]);
                        log('Datagrrwwfggg: :${m6}');
                        return SingleChildScrollView(
                            child: Container(
                                margin: EdgeInsets.all(0),
                                child: InkWell(
                                    child: PhysicalModel(
                                      color: Colors.white,
                                      elevation: 8,
                                      shadowColor: Color(0xff9a9ce3),
                                      borderRadius: BorderRadius.circular(4),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 25),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CreditBalanceRequest()));
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/withdraw2.png',
                                                          cacheHeight: 65,
                                                          cacheWidth: 65,
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          'Deposit',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: Colors.black,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 55,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (BuildContext
                                                        context) =>
                                                            BookingCard(),
                                                      ),
                                                    );
                                                  },
                                                  child: Stack(
                                                    alignment:
                                                    Alignment.bottomCenter,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            top: 17),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              'Bookings',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors.black,
                                                                fontWeight:
                                                                FontWeight.w500,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                    context) =>
                                                                        BookingCard(),
                                                                  ),
                                                                );
                                                              },
                                                              child: Text(
                                                                m0.totalBookings,
                                                                style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Colors
                                                                      .lightBlue,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            top: 40),
                                                        child: Center(
                                                          child: Container(
                                                            height: 45,
                                                            width: 45,
                                                            child: PieChart(
                                                              PieChartData(
                                                                sections: [
                                                                  PieChartSectionData(
                                                                    color:
                                                                    Colors.blue,
                                                                    value: 70,
                                                                    title: '40%',
                                                                    radius: 30,
                                                                    titleStyle:
                                                                    TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                  ),
                                                                  PieChartSectionData(
                                                                    color: Colors
                                                                        .green,
                                                                    value: 45,
                                                                    radius: 30,
                                                                    titleStyle:
                                                                    TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                  ),
                                                                  PieChartSectionData(
                                                                    color:
                                                                    Colors.red,
                                                                    value: 30,
                                                                    radius: 30,
                                                                    titleStyle:
                                                                    TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ],
                                                                sectionsSpace: 3,
                                                                centerSpaceRadius:
                                                                40,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 55,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 25),
                                                  //FundTransfer
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FundTransfer()));
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/transfer.png',
                                                          cacheHeight: 65,
                                                          cacheWidth: 65,
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          'Transfer',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: Colors.black,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 60,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Card(
                                                    color: Color(0xff41d1d1),
                                                    elevation: 2,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () { Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                              BookingCard(
                                                              ),
                                                        ),
                                                      );},
                                                      child: Container(
                                                        //walletn

                                                        child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                m0.totalBookings,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: 25,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                'Total Booking',
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                              )
                                                            ]),

                                                        height: 120,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 1.5),
                                                Expanded(
                                                  child: GestureDetector(onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                            InvoiceList(
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                    child: Card(
                                                      color: Color(0xff3050af),
                                                      elevation: 2,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                      ),
                                                      child: Container(
                                                        height: 120,
                                                        child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                m0.totalInvoice,
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.white,
                                                                    fontSize: 25,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                'Total Invoice',
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color:
                                                                    Colors.white,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                              )
                                                            ]),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Card(
                                                    color: Color(0xffeb8899),
                                                    elevation: 2,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () { Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                              PaymentCollectionReport(
                                                              ),
                                                        ),
                                                      );},
                                                      child: Container(
                                                        //walletn

                                                        child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                m0.totalSales,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: 25,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                'Total Sales',
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                              )
                                                            ]),

                                                        height: 120,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 1.5),
                                                Expanded(
                                                  child: GestureDetector(onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                            CancelledBooking(
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                    child: Card(
                                                      color: Color(0xffe7a236),
                                                      elevation: 2,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                      ),
                                                      child: Container(
                                                        height: 120,
                                                        child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                m0.totalCancelation,
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.white,
                                                                    fontSize: 25,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                'Total Cancellation',
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    color:
                                                                    Colors.white,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                              )
                                                            ]),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))));
                      } catch (error) {
                        print('Unexpected error: $error');
                        return Text('An unexpected error occurred.');
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor:Color(0xFF00ADEE), // Background color
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home "),
          BottomNavigationBarItem(
              icon: Icon(Icons.holiday_village), label: "Bookings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Invoice"),
          BottomNavigationBarItem(
              icon: Icon(Icons.vertical_distribute_sharp), label: "Vouchers"),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallets"),
        ],
        onTap: (value) {
          if (value == 0) {
            // Reload the dashboard when "Home" tab is clicked
            reloadDashboard();
          }
          if (value == 1)
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => BookingCard()));
          if (value == 2)
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => InvoiceList()));
          if (value == 3)
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Vouchers()));
          if (value == 4)
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CreditUsage()));
          else {
            // Navigate to other tabs as usual
            currentIndex = value;
          }
          setState(() {
            // Update the current index
            currentIndex = value;
          });
        },
        /* onTap: (value) {
          if (value == 0) reloadDashboard();
          if (value == 1)
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HotelsScreen(),
            ));
          if (value == 2)
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Holidays(),
            ));
          if (value == 3)
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreditUsage(),
            ));
        },*/
      ),
    );
  }
}

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({Key? key}) : super(key: key);

  @override
  _FlightsScreenState createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  bool __shouldShowReturn = true;
  bool isMulti = false;

  String Economy = '',
      PremiumEconomy = '',
      Business = '',
      isFirstSelected = '',
      selectedClass = '';
  int AdultCount = 1, childrenCount = 0, infantsCount = 0;
  String displayText1 = '';

  TextEditingController orginController = new TextEditingController();
  TextEditingController orginController1 = new TextEditingController();

  TextEditingController destinationController = new TextEditingController();
  TextEditingController destinationController1 = new TextEditingController();

  //String tripValue = 'Round trip';
  List tripOptions = [
    {"Id": 0, "Name": "Round trip"},
    {"Id": 1, "Name": "One Way"},
    {"Id": 2, "Name": "Multi-City"},
  ];

  @override
  void initState() {
    orginController.text = 'DEL';
    destinationController.text = 'MAA';
    orginController1.text = 'MAA';
    destinationController1.text = 'DXB';
    //searchBookingTravellers();
    tTripType = '1';
    isSelected = true;
    __shouldShowReturn = false;
    //_loadSavedString();
    if (selectedClass == '') {
      selectedClass = 'Economy';
    }

    super.initState();
  }
  int selectedClassId=0;
  /*_loadSavedString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      AdultCount = prefs.getInt('adultsCount') ?? 0;
      childrenCount = prefs.getInt('childrenCount') ?? 0;
      infantsCount = prefs.getInt('infantsCount') ?? 0;
      Economy = prefs.getString('isEconomySelected') ?? '';
      PremiumEconomy = prefs.getString('PremiumEconomy') ?? '';
      Business = prefs.getString('Business') ?? '';
      isFirstSelected = prefs.getString('isFirstSelected') ?? '';
      print('Adults Count: $AdultCount');
      print('Children Count: $childrenCount');
      print('Infants Count: $infantsCount');
      print('Is Economy Selected: $Economy');
      print('Premium Economy: $PremiumEconomy');
      print('Business: $Business');
      print('Is First Selected: $isFirstSelected');
    });
  }*/

  _saveString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setInt('adultsCount', AdultCount);
    prefs.setInt('childrenCount', childrenCount);
    prefs.setInt('infantsCount', infantsCount);
    setState(() {
      prefs.setString('isEconomySelected', Economy);
      prefs.setString('PremiumEconomy', PremiumEconomy);
      prefs.setString('Business', Business);
      prefs.setString('isFirstSelected', isFirstSelected);
    });
  }

  List businessClass = [
    {"Id": 0, "Name": "Economy"},
    {"Id": 1, "Name": "Premium"},
    {"Id": 2, "Name": "Business"},
    {"Id": 3, "Name": "First Class"},
  ];
  String firstDropdownValue = '0';
  String secondDropdownValue = '0';
  String thirdDropdownValue = '0';

  List<String> numbers = List.generate(10, (index) => index.toString());

  List<String> commonOptions = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  var tClassType = '0';
  var tpolicyID = '-1';
  String tTripType = '0';
  bool isSwapped = false;

  List<TripData> trips = [];
  String FinalOutput = '',
      FinalOutPut1 = '',
      SelectionValue = '',
      SelectionValue1 = '',
      FinalOutputMulti = '',
      FinalOutput1Multi = '',
      FinalOutputMultiSecond = '',
      FinalOutput1MultiSecond = '',
      FinalOutputMultiThird = '',
      FinalOutput1MultiThird = '',
      FinalOutputMultiFourth = '',
      FinalOutput1MultiFourth = '',
      OriginPlace = '',
      DestinationPlace = '';

  var tFromCity = '';
  var tToCity = '';
  var tDepartDate = '';
  var tReturnDate = '';

  var tCorporateId = '';
  var tjsonTraveller = '';
  var tDefaultCurrency = 'SAR';

  DateTime selecteddDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime selectedReturnDate = DateTime.now();

  DateTime selecteddDate1 = DateTime.now();
  DateTime selecteddDate2 = DateTime.now();
  DateTime selecteddDate3 = DateTime.now();
  DateTime selecteddDate4 = DateTime.now();
  bool isCityAdded = false;

  void toggleCity() {
    setState(() {
      if (isCityAdded) {
        // If a city is already added, clear the last box data (e.g., from and to fields)
        if (trips.isNotEmpty) {
          trips.last.from = '';
          trips.last.to = '';
          trips.last.date = null; // Clear the date if needed
          trips.removeLast(); // Optionally remove the trip if you want to completely remove it
        }
        FinalOutputMultiFourth = '';
        FinalOutput1MultiFourth = '';
      } else {
        // If no city is added, add a new trip with empty fields
        trips.add(TripData(from: '', to: '', date: null));
      }

      // Toggle the state of isCityAdded
      isCityAdded = !isCityAdded;
    });
  }
  Future<void> _selectDate(BuildContext context, int type) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selecteddDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selecteddDate) {
      setState(() {
        if (type == 1) {
          selecteddDate = picked;
        } else if (type == 2) {
          selectedReturnDate = picked;
        } else if (type == 3) {
          selectedDate = picked;
        } else if (type == 4) {
          selecteddDate1 = picked;
        } else if (type == 5) {
          selecteddDate2 = picked;
        } else if (type == 6) {
          selecteddDate3 = picked;
        } else {
          selecteddDate4 = picked;
        }
      });
    }
  }

  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';
  Future<List<FlightScreenModel>> fetchAutocompleteData(String empName) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/FlightAirportAutocomplete?empName=$empName';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final xmlDocument = xml.XmlDocument.parse(response.body);
      final responseData = xmlDocument.findAllElements('string').first.text;

      final decodedData = json.decode(responseData);
      return decodedData
          .map<FlightScreenModel>((data) => FlightScreenModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load autocomplete data');
    }
  }

  bool isSelected = false;
  bool isSelected1 = false;
  bool isSelected2 = false;

  @override
  Widget build(BuildContext context) {
    void navigate(Widget screen) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => screen));
    }

    if (Economy != '') {
      displayText1 = Economy;
      print('Is Economy Selected: $displayText1');
    }
    if (PremiumEconomy != '') {
      displayText1 = PremiumEconomy;
      print('Is Economy Selected: $displayText1');
    }
    if (Business != '') {
      displayText1 = Business;
      print('Is Economy Selected: $displayText1');
    }
    if (isFirstSelected != '') {
      displayText1 = isFirstSelected;
      print('Is Economy Selected: $displayText1');
    }
    String adultsText = AdultCount > 1 ? '$AdultCount Adults' : '1 Adult';
    String childrenText = childrenCount > 0 ? '$childrenCount Children' : '';
    String InfantCount = infantsCount > 0 ? '$infantsCount Infants' : '';

    String Adult = '$adultsText ';
    String Children = '$childrenText';
    String Infants = '$InfantCount';

    List hotelDestination = [
      HotelDestination(
          title: "Month End Off",
          subtitle: "80% offer for this month",
          image:
          "https://www.yatra.com/ythomepagecms/media/todayspick/2020/Oct/98d57b3ddef131c2160085fff31776a1.jpg"),
      HotelDestination(
          title: "Coupons",
          subtitle: "Offer upto Rs.7000",
          image:
          "https://cdn.via.com/static/img/v1/newui/sg/general/offer/1503382796693_InternationalFlight_Offer_21.jpg"),
      HotelDestination(
          title: "Offers",
          subtitle: "Air India Offers",
          image:
          "https://www.airindia.in/writereaddata/Portal/CMS_Template_Banner/8_1_special-offer-banner.jpg"),
    ];

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
            width: 100,
            height: 50,
          ),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor:Color(0xFF00ADEE),
      ),
      body: Center(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          tTripType = '1';
                                          __shouldShowReturn = false;
                                          isSelected = true;
                                          isSelected1 = false;
                                          isSelected2 = false;
                                          print('object' + tTripType!.toString());
                                        });
                                      },
                                      child: Container(
                                        width: 97,
                                        padding: EdgeInsets.only(
                                            left: 5, bottom: 6, right: 5, top: 6),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.pink.shade50
                                              : Colors.white,
                                          border: Border.all(
                                              color: isSelected
                                                  ? Color(0xFF152238)
                                                  : Colors.grey),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'One-way',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? Color(0xFF152238)
                                                : Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          tTripType = '0';
                                          __shouldShowReturn = true;
                                          isSelected1 = true;
                                          isSelected = false;
                                          isSelected2 = false;
                                          print('object' + isSelected1!.toString());
                                        });
                                      },
                                      child: Container(
                                        width: 97,
                                        padding: EdgeInsets.only(
                                            left: 5, bottom: 6, right: 5, top: 6),
                                        decoration: BoxDecoration(
                                          color: isSelected1
                                              ? Colors.pink.shade50
                                              : Colors.white,
                                          border: Border.all(
                                              color: isSelected1
                                                  ? Color(0xFF152238)
                                                  : Colors.grey),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Roundtrip',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected1
                                                ? Color(0xFF152238)
                                                : Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          tTripType = '2';
                                          isSelected1 = false;
                                          isSelected = false;
                                          isSelected2 = true;
                                          print('objecwdewet' +
                                              isSelected2!.toString());
                                        });
                                      },
                                      child: Container(
                                        width: 97,
                                        padding: EdgeInsets.only(
                                            left: 5, bottom: 6, right: 5, top: 6),
                                        decoration: BoxDecoration(
                                          color: isSelected2
                                              ? Colors.pink.shade50
                                              : Colors.white,
                                          border: Border.all(
                                              color: isSelected2
                                                  ? Color(0xFF152238)
                                                  : Colors.grey),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Multi-City',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected2
                                                ? Color(0xFF152238)
                                                : Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (tTripType == '1')
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10, top: 8, bottom: 6),
                                        child: Text(
                                          'From',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Display FinalOutput or FinalOutPut1 based on isSwapped
                                            Text(
                                              isSwapped
                                                  ? FinalOutPut1
                                                  : FinalOutput,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 27,
                                          child: Autocomplete<FlightScreenModel>(
                                            // Autocomplete widget for "From"
                                            optionsBuilder: (TextEditingValue
                                            textEditingValue) async {
                                              if (textEditingValue.text.isEmpty) {
                                                return const Iterable<
                                                    FlightScreenModel>.empty();
                                              }
                                              return await fetchAutocompleteData(
                                                  textEditingValue.text);
                                            },
                                            displayStringForOption: (FlightScreenModel
                                            option) =>
                                            '${option.name}, ${option.id}, ${option.municipality}',
                                            onSelected: (FlightScreenModel?
                                            selectedOption) {
                                              if (selectedOption != null) {
                                                print(
                                                    'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                setState(() {
                                                  FinalOutput = selectedOption.id;
                                                  OriginPlace =
                                                      selectedOption.municipality;
                                                  SelectionValue =
                                                      selectedOption.name;
                                                });
                                                // Do something with the selected option
                                              }
                                            },
                                            fieldViewBuilder: (context, controller,
                                                focusNode, onFieldSubmitted) {
                                              return TextFormField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                onFieldSubmitted: (String value) {
                                                  // Your logic here
                                                },
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                  EdgeInsets.only(top: 0),
                                                  border: InputBorder.none,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.1,
                                        color: Colors.grey,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10, top: 8, bottom: 6),
                                        child: Text(
                                          'To',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Text(
                                          isSwapped ? FinalOutput : FinalOutPut1,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 27,
                                          child: Autocomplete<FlightScreenModel>(
                                            // Autocomplete widget for "To"
                                            optionsBuilder: (TextEditingValue
                                            textEditingValue) async {
                                              if (textEditingValue.text.isEmpty) {
                                                return const Iterable<
                                                    FlightScreenModel>.empty();
                                              }
                                              return await fetchAutocompleteData(
                                                  textEditingValue.text);
                                            },
                                            displayStringForOption: (FlightScreenModel
                                            option) =>
                                            '${option.name}, ${option.id}, ${option.municipality}',
                                            onSelected: (FlightScreenModel?
                                            selectedOption) {
                                              if (selectedOption != null) {
                                                print(
                                                    'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                setState(() {
                                                  FinalOutPut1 = selectedOption.id;
                                                  DestinationPlace =
                                                      selectedOption.municipality;
                                                });
                                                // Do something with the selected option
                                              }
                                            },
                                            fieldViewBuilder: (context, controller,
                                                focusNode, onFieldSubmitted) {
                                              return TextFormField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                onFieldSubmitted: (String value) {
                                                  // Your logic here
                                                },
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                  EdgeInsets.only(top: 0),
                                                  border: InputBorder.none,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Depart",
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      _selectDate(context, 1);
                                                    },
                                                    child: Text(
                                                      "${selecteddDate.toLocal()}"
                                                          .split(' ')[0],
                                                      style: TextStyle(
                                                          fontFamily: "Montserrat",
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Saturday",
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: __shouldShowReturn
                                                  ? () {
                                                // Handle the tap when __shouldShowReturn is true
                                                _selectDate(context, 2);
                                              }
                                                  : null, // Set onTap to null when __shouldShowReturn is false
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Return",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    __shouldShowReturn
                                                        ? "${selectedReturnDate.toLocal()}"
                                                        .split(' ')[0]
                                                        : "Select Date",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: __shouldShowReturn
                                                          ? Colors.black
                                                          : Colors.black38,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    __shouldShowReturn
                                                        ? "Friday"
                                                        : "book return",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                if (tTripType == '0')
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10, top: 8, bottom: 6),
                                        child: Text(
                                          'From',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Display FinalOutput or FinalOutPut1 based on isSwapped
                                            Text(
                                              isSwapped
                                                  ? FinalOutPut1
                                                  : FinalOutput,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 27,
                                          child: Autocomplete<FlightScreenModel>(
                                            // Autocomplete widget for "From"
                                            optionsBuilder: (TextEditingValue
                                            textEditingValue) async {
                                              if (textEditingValue.text.isEmpty) {
                                                return const Iterable<
                                                    FlightScreenModel>.empty();
                                              }
                                              return await fetchAutocompleteData(
                                                  textEditingValue.text);
                                            },
                                            displayStringForOption: (FlightScreenModel
                                            option) =>
                                            '${option.name}, ${option.id}, ${option.municipality}',
                                            onSelected: (FlightScreenModel?
                                            selectedOption) {
                                              if (selectedOption != null) {
                                                print(
                                                    'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                setState(() {
                                                  FinalOutput = selectedOption.id;
                                                  OriginPlace =
                                                      selectedOption.municipality;
                                                  SelectionValue =
                                                      selectedOption.name;
                                                });
                                                // Do something with the selected option
                                              }
                                            },
                                            fieldViewBuilder: (context, controller,
                                                focusNode, onFieldSubmitted) {
                                              return TextFormField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                onFieldSubmitted: (String value) {
                                                  // Your logic here
                                                },
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                  EdgeInsets.only(top: 0),
                                                  border: InputBorder.none,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.1,
                                        color: Colors.grey,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10, top: 8, bottom: 6),
                                        child: Text(
                                          'To',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Text(
                                          isSwapped ? FinalOutput : FinalOutPut1,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 27,
                                          child: Autocomplete<FlightScreenModel>(
                                            // Autocomplete widget for "To"
                                            optionsBuilder: (TextEditingValue
                                            textEditingValue) async {
                                              if (textEditingValue.text.isEmpty) {
                                                return const Iterable<
                                                    FlightScreenModel>.empty();
                                              }
                                              return await fetchAutocompleteData(
                                                  textEditingValue.text);
                                            },
                                            displayStringForOption: (FlightScreenModel
                                            option) =>
                                            '${option.name}, ${option.id}, ${option.municipality}',
                                            onSelected: (FlightScreenModel?
                                            selectedOption) {
                                              if (selectedOption != null) {
                                                print(
                                                    'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                setState(() {
                                                  FinalOutPut1 = selectedOption.id;
                                                  DestinationPlace =
                                                      selectedOption.municipality;
                                                });
                                                // Do something with the selected option
                                              }
                                            },
                                            fieldViewBuilder: (context, controller,
                                                focusNode, onFieldSubmitted) {
                                              return TextFormField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                onFieldSubmitted: (String value) {
                                                  // Your logic here
                                                },
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                  EdgeInsets.only(top: 0),
                                                  border: InputBorder.none,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Depart",
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      _selectDate(context, 1);
                                                    },
                                                    child: Text(
                                                      "${selecteddDate.toLocal()}"
                                                          .split(' ')[0],
                                                      style: TextStyle(
                                                          fontFamily: "Montserrat",
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Saturday",
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: __shouldShowReturn
                                                  ? () {
                                                // Handle the tap when __shouldShowReturn is true
                                                _selectDate(context, 2);
                                              }
                                                  : null, // Set onTap to null when __shouldShowReturn is false
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Return",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    __shouldShowReturn
                                                        ? "${selectedReturnDate.toLocal()}"
                                                        .split(' ')[0]
                                                        : "Select Date",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: __shouldShowReturn
                                                          ? Colors.black
                                                          : Colors.black38,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    __shouldShowReturn
                                                        ? "Friday"
                                                        : "book return",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 14,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                Container(
                                  width: double.infinity,
                                  height: 0.1,
                                  color: Colors.grey,
                                ),
                                Visibility(
                                  visible: tTripType == '2',
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10,
                                                        bottom: 4,
                                                        top: 10),
                                                    child: Text(
                                                      isSwapped
                                                          ? FinalOutput
                                                          : FinalOutput,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10),
                                                    child: Container(
                                                      height: 27,
                                                      width: 75,
                                                      child: Autocomplete<
                                                          FlightScreenModel>(
                                                        optionsBuilder:
                                                            (TextEditingValue
                                                        textEditingValue) async {
                                                          if (textEditingValue
                                                              .text.isEmpty) {
                                                            return const Iterable<
                                                                FlightScreenModel>.empty();
                                                          }
                                                          return await fetchAutocompleteData(
                                                              textEditingValue
                                                                  .text);
                                                        },
                                                        displayStringForOption:
                                                            (FlightScreenModel
                                                        option) =>
                                                        '${option.municipality}',
                                                        onSelected:
                                                            (FlightScreenModel?
                                                        selectedOption) {
                                                          if (selectedOption !=
                                                              null) {
                                                            print(
                                                                'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                            setState(() {
                                                              FinalOutput =
                                                                  selectedOption.id;
                                                              OriginPlace =
                                                                  selectedOption
                                                                      .municipality;
                                                              SelectionValue =
                                                                  selectedOption
                                                                      .name;
                                                            });
                                                          }
                                                        },
                                                        fieldViewBuilder: (context,
                                                            controller,
                                                            focusNode,
                                                            onFieldSubmitted) {
                                                          return TextFormField(
                                                            controller: controller,
                                                            focusNode: focusNode,
                                                            onFieldSubmitted:
                                                                (String value) {
                                                              // Your logic here
                                                            },
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              color: Colors.black54,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                            ),
                                                            decoration:
                                                            InputDecoration(
                                                              hintText: 'From',
                                                              isDense: true,
                                                              contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 0),
                                                              border:
                                                              InputBorder.none,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 4, top: 10),
                                                    child: Text(
                                                      isSwapped
                                                          ? FinalOutPut1
                                                          : FinalOutPut1,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 27,
                                                    width: 75,
                                                    child: Autocomplete<
                                                        FlightScreenModel>(
                                                      optionsBuilder: (TextEditingValue
                                                      textEditingValue) async {
                                                        if (textEditingValue
                                                            .text.isEmpty) {
                                                          return const Iterable<
                                                              FlightScreenModel>.empty();
                                                        }
                                                        return await fetchAutocompleteData(
                                                            textEditingValue.text);
                                                      },
                                                      displayStringForOption:
                                                          (FlightScreenModel
                                                      option) =>
                                                      '${option.municipality}',
                                                      onSelected:
                                                          (FlightScreenModel?
                                                      selectedOption) {
                                                        if (selectedOption !=
                                                            null) {
                                                          print(
                                                              'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                          setState(() {
                                                            FinalOutPut1 =
                                                                selectedOption.id;
                                                            DestinationPlace =
                                                                selectedOption
                                                                    .municipality;
                                                          });
                                                        }
                                                      },
                                                      fieldViewBuilder: (context,
                                                          controller,
                                                          focusNode,
                                                          onFieldSubmitted) {
                                                        return TextFormField(
                                                          controller: controller,
                                                          focusNode: focusNode,
                                                          onFieldSubmitted:
                                                              (String value) {
                                                            // Your logic here
                                                          },
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            color: Colors.black54,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                          ),
                                                          decoration:
                                                          InputDecoration(
                                                            hintText: 'To',
                                                            isDense: true,
                                                            contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0),
                                                            border:
                                                            InputBorder.none,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      _selectDate(context, 4);
                                                    },
                                                    child: Container(
                                                      width: 75,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 0, top: 5),
                                                        child: Text(
                                                          selecteddDate1 != null
                                                              ? DateFormat('dd-MMM')
                                                              .format(
                                                              selecteddDate1!)
                                                              : '',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    25, // Adjust the height as needed
                                                    child: Container(
                                                      width: 75,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 0),
                                                        child: TextField(
                                                          onTap: () {
                                                            _selectDate(context, 4);
                                                          },
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.black54,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                          controller:
                                                          TextEditingController(
                                                            text: selecteddDate1 !=
                                                                null
                                                                ? DateFormat('yyyy')
                                                                .format(
                                                                selecteddDate1!)
                                                                : '',
                                                          ),
                                                          readOnly: true,
                                                          decoration:
                                                          InputDecoration(
                                                            border:
                                                            InputBorder.none,
                                                            hintText: 'Select Year',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.1,
                                        color: Colors.grey,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10,
                                                        bottom: 4,
                                                        top: 10),
                                                    child: Text(
                                                      isSwapped
                                                          ? FinalOutputMultiSecond
                                                          : FinalOutputMultiSecond,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10),
                                                    child: Container(
                                                      height: 27,
                                                      width: 75,
                                                      child: Autocomplete<
                                                          FlightScreenModel>(
                                                        optionsBuilder:
                                                            (TextEditingValue
                                                        textEditingValue) async {
                                                          if (textEditingValue
                                                              .text.isEmpty) {
                                                            return const Iterable<
                                                                FlightScreenModel>.empty();
                                                          }
                                                          return await fetchAutocompleteData(
                                                              textEditingValue
                                                                  .text);
                                                        },
                                                        displayStringForOption:
                                                            (FlightScreenModel
                                                        option) =>
                                                        '${option.municipality}',
                                                        onSelected:
                                                            (FlightScreenModel?
                                                        selectedOption) {
                                                          if (selectedOption !=
                                                              null) {
                                                            print(
                                                                'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                            setState(() {
                                                              FinalOutputMultiSecond =
                                                                  selectedOption.id;
                                                              OriginPlace =
                                                                  selectedOption
                                                                      .municipality;
                                                              SelectionValue =
                                                                  selectedOption
                                                                      .name;
                                                            });
                                                          }
                                                        },
                                                        fieldViewBuilder: (context,
                                                            controller,
                                                            focusNode,
                                                            onFieldSubmitted) {
                                                          return TextFormField(
                                                            controller: controller,
                                                            focusNode: focusNode,
                                                            onFieldSubmitted:
                                                                (String value) {
                                                              // Your logic here
                                                            },
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              color: Colors.black54,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                            ),
                                                            decoration:
                                                            InputDecoration(
                                                              hintText: 'From',
                                                              isDense: true,
                                                              contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 0),
                                                              border:
                                                              InputBorder.none,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 4, top: 10),
                                                    child: Text(
                                                      isSwapped
                                                          ? FinalOutputMultiSecond
                                                          : FinalOutput1MultiSecond,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 27,
                                                    width: 75,
                                                    child: Autocomplete<
                                                        FlightScreenModel>(
                                                      optionsBuilder: (TextEditingValue
                                                      textEditingValue) async {
                                                        if (textEditingValue
                                                            .text.isEmpty) {
                                                          return const Iterable<
                                                              FlightScreenModel>.empty();
                                                        }
                                                        return await fetchAutocompleteData(
                                                            textEditingValue.text);
                                                      },
                                                      displayStringForOption:
                                                          (FlightScreenModel
                                                      option) =>
                                                      '${option.municipality}',
                                                      onSelected:
                                                          (FlightScreenModel?
                                                      selectedOption) {
                                                        if (selectedOption !=
                                                            null) {
                                                          print(
                                                              'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                          setState(() {
                                                            FinalOutput1MultiSecond =
                                                                selectedOption.id;
                                                            DestinationPlace =
                                                                selectedOption
                                                                    .municipality;
                                                          });
                                                        }
                                                      },
                                                      fieldViewBuilder: (context,
                                                          controller,
                                                          focusNode,
                                                          onFieldSubmitted) {
                                                        return TextFormField(
                                                          controller: controller,
                                                          focusNode: focusNode,
                                                          onFieldSubmitted:
                                                              (String value) {
                                                            // Your logic here
                                                          },
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            color: Colors.black54,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                          ),
                                                          decoration:
                                                          InputDecoration(
                                                            hintText: 'To',
                                                            isDense: true,
                                                            contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0),
                                                            border:
                                                            InputBorder.none,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      _selectDate(context, 5);
                                                    },
                                                    child: Container(
                                                      width: 75,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 0, top: 5),
                                                        child: Text(
                                                          selecteddDate2 != null
                                                              ? DateFormat('dd-MMM')
                                                              .format(
                                                              selecteddDate2!)
                                                              : '',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    25, // Adjust the height as needed
                                                    child: Container(
                                                      width: 75,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 0),
                                                        child: TextField(
                                                          onTap: () {
                                                            _selectDate(context, 5);
                                                          },
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.black54,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                          controller:
                                                          TextEditingController(
                                                            text: selecteddDate2 !=
                                                                null
                                                                ? DateFormat('yyyy')
                                                                .format(
                                                                selecteddDate2!)
                                                                : '',
                                                          ),
                                                          readOnly: true,
                                                          decoration:
                                                          InputDecoration(
                                                            border:
                                                            InputBorder.none,
                                                            hintText: 'Select Year',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.1,
                                        color: Colors.grey,
                                      ),
                                      Column(
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            bottom: 4,
                                                            top: 10),
                                                        child: Text(
                                                          isSwapped
                                                              ? FinalOutputMultiThird
                                                              : FinalOutputMultiThird,
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                        child: Container(
                                                          height: 27,
                                                          width: 75,
                                                          child: Autocomplete<
                                                              FlightScreenModel>(
                                                            optionsBuilder:
                                                                (TextEditingValue
                                                            textEditingValue) async {
                                                              if (textEditingValue
                                                                  .text.isEmpty) {
                                                                return const Iterable<
                                                                    FlightScreenModel>.empty();
                                                              }
                                                              return await fetchAutocompleteData(
                                                                  textEditingValue
                                                                      .text);
                                                            },
                                                            displayStringForOption:
                                                                (FlightScreenModel
                                                            option) =>
                                                            '${option.municipality}',
                                                            onSelected:
                                                                (FlightScreenModel?
                                                            selectedOption) {
                                                              if (selectedOption !=
                                                                  null) {
                                                                print(
                                                                    'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                                setState(() {
                                                                  FinalOutputMultiThird =
                                                                      selectedOption
                                                                          .id;
                                                                  OriginPlace =
                                                                      selectedOption
                                                                          .municipality;
                                                                  SelectionValue =
                                                                      selectedOption
                                                                          .name;
                                                                });
                                                              }
                                                            },
                                                            fieldViewBuilder: (context,
                                                                controller,
                                                                focusNode,
                                                                onFieldSubmitted) {
                                                              return TextFormField(
                                                                controller:
                                                                controller,
                                                                focusNode:
                                                                focusNode,
                                                                onFieldSubmitted:
                                                                    (String value) {
                                                                  // Your logic here
                                                                },
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                ),
                                                                decoration:
                                                                InputDecoration(
                                                                  hintText: 'From',
                                                                  isDense: true,
                                                                  contentPadding:
                                                                  EdgeInsets
                                                                      .only(
                                                                      top:
                                                                      0),
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            bottom: 4, top: 10),
                                                        child: Text(
                                                          isSwapped
                                                              ? FinalOutput1MultiThird
                                                              : FinalOutput1MultiThird,
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 27,
                                                        width: 75,
                                                        child: Autocomplete<
                                                            FlightScreenModel>(
                                                          optionsBuilder:
                                                              (TextEditingValue
                                                          textEditingValue) async {
                                                            if (textEditingValue
                                                                .text.isEmpty) {
                                                              return const Iterable<
                                                                  FlightScreenModel>.empty();
                                                            }
                                                            return await fetchAutocompleteData(
                                                                textEditingValue
                                                                    .text);
                                                          },
                                                          displayStringForOption:
                                                              (FlightScreenModel
                                                          option) =>
                                                          '${option.municipality}',
                                                          onSelected:
                                                              (FlightScreenModel?
                                                          selectedOption) {
                                                            if (selectedOption !=
                                                                null) {
                                                              print(
                                                                  'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                              setState(() {
                                                                FinalOutput1MultiThird =
                                                                    selectedOption
                                                                        .id;
                                                                DestinationPlace =
                                                                    selectedOption
                                                                        .municipality;
                                                              });
                                                            }
                                                          },
                                                          fieldViewBuilder: (context,
                                                              controller,
                                                              focusNode,
                                                              onFieldSubmitted) {
                                                            return TextFormField(
                                                              controller:
                                                              controller,
                                                              focusNode: focusNode,
                                                              onFieldSubmitted:
                                                                  (String value) {
                                                                // Your logic here
                                                              },
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                color:
                                                                Colors.black54,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                FontWeight.w500,
                                                              ),
                                                              decoration:
                                                              InputDecoration(
                                                                hintText: 'To',
                                                                isDense: true,
                                                                contentPadding:
                                                                EdgeInsets.only(
                                                                    top: 0),
                                                                border: InputBorder
                                                                    .none,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          _selectDate(context, 6);
                                                        },
                                                        child: Container(
                                                          width: 75,
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 0,
                                                                top: 5),
                                                            child: Text(
                                                              selecteddDate3 != null
                                                                  ? DateFormat(
                                                                  'dd-MMM')
                                                                  .format(
                                                                  selecteddDate3!)
                                                                  : '',
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                        25, // Adjust the height as needed
                                                        child: Container(
                                                          width: 75,
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(left: 0),
                                                            child: TextField(
                                                              onTap: () {
                                                                _selectDate(
                                                                    context, 6);
                                                              },
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                              controller:
                                                              TextEditingController(
                                                                text: selecteddDate3 !=
                                                                    null
                                                                    ? DateFormat(
                                                                    'yyyy')
                                                                    .format(
                                                                    selecteddDate3!)
                                                                    : '',
                                                              ),
                                                              readOnly: true,
                                                              decoration:
                                                              InputDecoration(
                                                                border: InputBorder
                                                                    .none,
                                                                hintText:
                                                                'Select Year',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.1,
                                        color: Colors.grey,
                                      ),
                                      for (int i = 0; i < trips.length; i++)
                                        Column(
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              bottom: 4,
                                                              top: 10),
                                                          child: Text(
                                                            isSwapped
                                                                ? FinalOutputMultiFourth
                                                                : FinalOutputMultiFourth,
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              color: Colors.black,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                          child: Container(
                                                            height: 27,
                                                            width: 75,
                                                            child: Autocomplete<
                                                                FlightScreenModel>(
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                              textEditingValue) async {
                                                                if (textEditingValue
                                                                    .text.isEmpty) {
                                                                  return const Iterable<
                                                                      FlightScreenModel>.empty();
                                                                }
                                                                return await fetchAutocompleteData(
                                                                    textEditingValue
                                                                        .text);
                                                              },
                                                              displayStringForOption:
                                                                  (FlightScreenModel
                                                              option) =>
                                                              '${option.municipality}',
                                                              onSelected:
                                                                  (FlightScreenModel?
                                                              selectedOption) {
                                                                if (selectedOption !=
                                                                    null) {
                                                                  print(
                                                                      'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                                  setState(() {
                                                                    FinalOutputMultiFourth =
                                                                        selectedOption
                                                                            .id;
                                                                    OriginPlace =
                                                                        selectedOption
                                                                            .municipality;
                                                                    SelectionValue =
                                                                        selectedOption
                                                                            .name;
                                                                  });
                                                                }
                                                              },
                                                              fieldViewBuilder:
                                                                  (context,
                                                                  controller,
                                                                  focusNode,
                                                                  onFieldSubmitted) {
                                                                return TextFormField(
                                                                  controller:
                                                                  controller,
                                                                  focusNode:
                                                                  focusNode,
                                                                  onFieldSubmitted:
                                                                      (String
                                                                  value) {
                                                                    // Your logic here
                                                                  },
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                    fontSize: 14,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                  decoration:
                                                                  InputDecoration(
                                                                    hintText:
                                                                    'From',
                                                                    isDense: true,
                                                                    contentPadding:
                                                                    EdgeInsets
                                                                        .only(
                                                                        top:
                                                                        0),
                                                                    border:
                                                                    InputBorder
                                                                        .none,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              bottom: 4,
                                                              top: 10),
                                                          child: Text(
                                                            isSwapped
                                                                ? FinalOutput1MultiFourth
                                                                : FinalOutput1MultiFourth,
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              color: Colors.black,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 27,
                                                          width: 75,
                                                          child: Autocomplete<
                                                              FlightScreenModel>(
                                                            optionsBuilder:
                                                                (TextEditingValue
                                                            textEditingValue) async {
                                                              if (textEditingValue
                                                                  .text.isEmpty) {
                                                                return const Iterable<
                                                                    FlightScreenModel>.empty();
                                                              }
                                                              return await fetchAutocompleteData(
                                                                  textEditingValue
                                                                      .text);
                                                            },
                                                            displayStringForOption:
                                                                (FlightScreenModel
                                                            option) =>
                                                            '${option.municipality}',
                                                            onSelected:
                                                                (FlightScreenModel?
                                                            selectedOption) {
                                                              if (selectedOption !=
                                                                  null) {
                                                                print(
                                                                    'Selected: ${selectedOption.name} (${selectedOption.id})');
                                                                setState(() {
                                                                  FinalOutput1MultiFourth =
                                                                      selectedOption
                                                                          .id;
                                                                  DestinationPlace =
                                                                      selectedOption
                                                                          .municipality;
                                                                });
                                                              }
                                                            },
                                                            fieldViewBuilder: (context,
                                                                controller,
                                                                focusNode,
                                                                onFieldSubmitted) {
                                                              return TextFormField(
                                                                controller:
                                                                controller,
                                                                focusNode:
                                                                focusNode,
                                                                onFieldSubmitted:
                                                                    (String value) {
                                                                  // Your logic here
                                                                },
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                ),
                                                                decoration:
                                                                InputDecoration(
                                                                  hintText: 'To',
                                                                  isDense: true,
                                                                  contentPadding:
                                                                  EdgeInsets
                                                                      .only(
                                                                      top:
                                                                      0),
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            _selectDate(context, 7);
                                                          },
                                                          child: Container(
                                                            width: 75,
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 0,
                                                                  top: 5),
                                                              child: Text(
                                                                selecteddDate4 !=
                                                                    null
                                                                    ? DateFormat(
                                                                    'dd-MMM')
                                                                    .format(
                                                                    selecteddDate4!)
                                                                    : '',
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        SizedBox(
                                                          height:
                                                          25, // Adjust the height as needed
                                                          child: Container(
                                                            width: 75,
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 0),
                                                              child: TextField(
                                                                onTap: () {
                                                                  _selectDate(
                                                                      context, 7);
                                                                },
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                                controller:
                                                                TextEditingController(
                                                                  text: selecteddDate4 !=
                                                                      null
                                                                      ? DateFormat(
                                                                      'yyyy')
                                                                      .format(
                                                                      selecteddDate4!)
                                                                      : '',
                                                                ),
                                                                readOnly: true,
                                                                decoration:
                                                                InputDecoration(
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                  hintText:
                                                                  'Select Year',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: toggleCity,
                                            child: Container(
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                    5), // Set border radius
                                                border: Border.all(
                                                    color: Color(0xFF152238)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  isCityAdded
                                                      ? 'REMOVE CITY'
                                                      : 'ADD CITY',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF152238),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.1,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                                /*  Container(
                              width: double.infinity,
                              height: 0.1,
                              color: Colors.grey,
                            ),*/
                                SizedBox(
                                  height: 0,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 0.1,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 0),
                                  margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Travellers',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(), // Add some space between "From" and "To"
                                      Text(
                                        'Class',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 0),
                                  margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          _saveString();
                                          final selectedDates =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                      AddTravellers_Flight(
                                                        adultsCount:
                                                        AdultCount,
                                                        childrenCount:
                                                        childrenCount,
                                                        infantsCount:
                                                        infantsCount,
                                                        selectedClass:
                                                        selectedClass,
                                                      )));
                                          if (selectedDates != null) {
                                            setState(() {
                                              AdultCount =
                                              selectedDates['adultsCount'];
                                              childrenCount =
                                              selectedDates['childrenCount'];
                                              infantsCount =
                                              selectedDates['infantCount'];
                                              selectedClass =
                                              selectedDates['selectedClass'];
                                              selectedClassId =
                                              selectedDates['selectedClassId'];
                                              print(
                                                  'selectedClass' + selectedClass);
                                              print(
                                                  'selectedClassId' + selectedClassId.toString());
                                            });
                                          }
                                        },
                                        child: Text(
                                          Children + Adult + Infants,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Spacer(), // Add some space between "From" and "To"
                                      Text(
                                        selectedClass,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 0.1,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    width: 300,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 300,
                                          height: 46,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (tTripType == '0') {

                                                //navigate(TwoWayDomestic());
                                                navigate(TwoWayBoardingFlightsList(
                                                  add:'ADD',
                                                  adult: AdultCount.toString(),
                                                  children:
                                                  childrenCount.toString(),
                                                  infants: infantsCount.toString(),
                                                  orgin: FinalOutput,
                                                  originCountry: OriginPlace,
                                                  destinationCourntry:
                                                  DestinationPlace,
                                                  destination: FinalOutPut1,
                                                  departDate: selecteddDate,
                                                  returnDate: selectedReturnDate,
                                                ));
                                              } else if (tTripType == "1") {
                                                print('sfdf' + FinalOutput);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OnewayFlightsList(
                                                              add:'ADD',
                                                              adult: AdultCount
                                                                  .toString(),
                                                              children:
                                                              childrenCount
                                                                  .toString(),
                                                              infants: infantsCount
                                                                  .toString(),
                                                              orgin: FinalOutput
                                                                  .toString(),
                                                              destination:
                                                              FinalOutPut1
                                                                  .toString(),
                                                              departDate:
                                                              selecteddDate
                                                                  .toString(),
                                                              userId: userID,
                                                              currency: Currency,
                                                              classtype:selectedClassId),
                                                    ));
                                              } else if (tTripType == "2") {
                                                print(
                                                    "destinationControlsedqwler1:" +
                                                        FinalOutputMulti);
                                                print(
                                                    'adult: ${AdultCount.toString()}');
                                                print(
                                                    'children: ${childrenCount.toString()}');
                                                print(
                                                    'infants: ${infantsCount.toString()}');
                                                print('orgin: $FinalOutput');
                                                print('destination: $FinalOutPut1');
                                                print('orgin1: $FinalOutputMulti');
                                                print(
                                                    'destination1: $FinalOutput1Multi');
                                                print(
                                                    'orgin2: $FinalOutputMultiSecond');
                                                print(
                                                    'destination2: $FinalOutput1MultiSecond');
                                                print(
                                                    'orgin3: $FinalOutputMultiThird');
                                                print(
                                                    'destination3: $FinalOutput1MultiThird');
                                                print(
                                                    'orgin4: $FinalOutputMultiFourth');
                                                print(
                                                    'destination4: $FinalOutput1MultiFourth');
                                                print('departdate2: $selectedDate');
                                                print(
                                                    'departDate1: $selecteddDate1');
                                                print(
                                                    'departDate3: $selecteddDate3');
                                                print(
                                                    'departdate4: $selecteddDate4');

                                                navigate(MultiCityFlightsList(
                                                  add:'ADD',
                                                  adult: AdultCount.toString(),
                                                  children:
                                                  childrenCount.toString(),
                                                  infants: infantsCount.toString(),
                                                  origin1: FinalOutput,
                                                  destination1: FinalOutPut1,
                                                  origin2: FinalOutputMultiSecond,
                                                  destination2:
                                                  FinalOutput1MultiSecond,
                                                  origin3: FinalOutputMultiThird,
                                                  destination3:
                                                  FinalOutput1MultiThird,
                                                  origin4: FinalOutputMultiFourth,
                                                  destination4:
                                                  FinalOutput1MultiFourth,
                                                  departdate2: selecteddDate2,
                                                  departDate1: selecteddDate1,
                                                  departDate3: selecteddDate3,
                                                  departdate4: selecteddDate4,
                                                  ClassType: '',
                                                ));
                                              }
                                            },
                                            child: Text(
                                              "SEARCH",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xFF00ADEE),

                                              // Background color of the button
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    20), // Circular radius of 20
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 231,
                      width: double.infinity,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            width: 330,
                            height: 200,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                            child: Card(
                              elevation: 10.0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Container(
                                    width: 330,
                                    height: 200,
                                    /*child: Image(
                      image: NetworkImage(hotelDestination[index].image),
                      fit: BoxFit.fill,
                    ),*/
                                    child: CachedNetworkImage(
                                      imageUrl: hotelDestination[index].image,
                                      placeholder: (context, url) => Center(
                                          child: SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: CircularProgressIndicator())),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                      width: 330,
                                      height: 55,
                                      color: Colors.black.withOpacity(0.6),
                                      padding: EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                hotelDestination[index].title,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: Text(
                                                  hotelDestination[index].subtitle,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      fontFamily: "Montserrat",
                                                      fontSize: 13,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Explore",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                elevation: 16.0),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: hotelDestination.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

Widget buildDropdown(
    List<String> items, String value, Function(Object?) onChanged) {
  return Container(
    width: 150,
    height: 30,
    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
    ),
    child: DropdownButton(
      dropdownColor: Colors.white,
      underline: SizedBox(),
      value: value,
      iconSize: 0.0,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 13,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    ),
  );
}
