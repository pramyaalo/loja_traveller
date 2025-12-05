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
import 'bookings/Bus/Bus_Screen.dart';
import 'bookings/Car/Car_Screen.dart';
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
            'assets/images/lojologg.png',
            width: 100,
            height: 50,
          ),
        ],
        backgroundColor: Color(0xFF00ADEE),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(widget.Username,
                    style: TextStyle(
                        color: Colors.white, fontFamily: "Montserrat")),
                accountEmail: Text(widget.email,
                    style: TextStyle(
                        color: Colors.white, fontFamily: "Montserrat")),
                decoration: BoxDecoration(color: Color(0xFF00ADEE)),
                currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
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
                title: Text("Charges/Payment",
                    style: TextStyle(fontFamily: "Montserrat")),
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
                                        ChangingRequestReport()));
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
                                        PaymentCollectionReport()));
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
        // Background curve
        Column(
        children: <Widget>[
        Container(
        height: MediaQuery.of(context).size.height * .11,
        decoration: BoxDecoration(
          color: Color(0xFF00ADEE),
          boxShadow: [
            BoxShadow(color: Color(0xFF00ADEE), spreadRadius: 3),
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

    // Top Icons row (FLIGHT, HOTEL, TOURS, CAR, BUS)
    Padding(
    padding: const EdgeInsets.only(top: 30),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [

    // ✔ Flights
    _buildTopCard(
    'assets/images/flights.png',
    'Flights',
    () {
    Navigator.push(context,
    MaterialPageRoute(builder: (_) => FlightScreen()));
    },
    ),

    // ✔ Hotels
    _buildTopCard(
    'assets/images/hotel.png',
    'Hotels',
    () {
    Navigator.push(context,
    MaterialPageRoute(builder: (_) => HotelsScreen()));
    },
    ),

    // ✔ Tours
    _buildTopCard(
    'assets/images/holiday.jpg',
    'Tours',
    () {
    Navigator.push(context,
    MaterialPageRoute(builder: (_) => Holidays()));
    },
    ),

    // ✔ Car
    _buildTopCard(
    'assets/images/car.png', // ADD THIS IMAGE
    'Car',
    () {
    Navigator.push(context,
    MaterialPageRoute(builder: (_) => CarScreen()));
    },
    ),

    // ✔ Bus
    _buildTopCard(
    'assets/images/bus.png', // ADD THIS IMAGE
    'Bus',
    () {
    Navigator.push(context,
    MaterialPageRoute(builder: (_) => BusScreen()));
    },
    ),
    ],
    ),
    ),
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
                                                                title: '40',
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
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookingCard(),
                                                      ),
                                                    );
                                                  },
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
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          InvoiceList(),
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
                                                            'Total Invoice',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                color: Colors
                                                                    .white,
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
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PaymentCollectionReport(),
                                                      ),
                                                    );
                                                  },
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
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CancelledBooking(),
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
                                                            'Total Cancellation',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                color: Colors
                                                                    .white,
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
        backgroundColor: Color(0xFF00ADEE),
        // Background color
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
Widget _buildTopCard(String image, String title, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      height: 90,
      width: 65,
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 32, width: 32),
            SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
