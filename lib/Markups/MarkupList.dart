import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
 import '../utils/response_handler.dart';
import '../utils/shared_preferences.dart';
import 'Bus/MarkupBusDateModel.dart';
import 'MarkupHolidayFareModel.dart';
import 'MarkupListBusDestinationModel.dart';
import 'MarkupListBusFareModel.dart';
import 'MarkupListCarDestinationModel.dart';
import 'MarkupListCardateModel.dart';
import 'MarkupListFlightDateModel.dart';
import 'MarkupListFlightDestinationModel.dart';
import 'MarkupListFlightFareModel.dart';
import 'MarkupListHolidayDateModel.dart';
import 'MarkupListHolidayDestinationModel.dart';
import 'MarkupListHotelDestinationModel.dart';
import 'MarkupListHotelRatingsModel.dart';
import 'MarkupListModel.dart';
import 'markupCarFareModel.dart';
import 'markupHotelFareModel.dart';
import 'markupListHoteldateModel.dart';

class MarkupList extends StatefulWidget {
  const MarkupList({Key? key}) : super(key: key);

  @override
  State<MarkupList> createState() => _MarkupListState();
}

class _MarkupListState extends State<MarkupList>  with SingleTickerProviderStateMixin {
  static late String userTypeID;
  static late String userID;

  bool _isLoading = true;

  List<MarkupListModel> markupList = [];
  List<MarkupListFlightDateModel> dateList = [];
  List<MarkupListFlightDestinationModel> flightDestinationList = [];
  List<MarkupListFlightFareModel> flightFareList = [];

//hotel
  List<markupListHoteldateModel> hoteldateList = [];
  List<MarkupListHotelDestinationModel> hoteldestinationlist = [];
  List<markupHotelFareModel> hotelfarelist = [];
  List<MarkupListHotelRatingsModel> hotelratingslist = [];

  List<MarkupListCardateModel> cardateList = [];
  List<MarkupListCarDestinationModel> cardestinationlist = [];
  List<markupCarFareModel>carfarelist=[];


  List<MarkupListHolidayDateModel> holidaydateList = [];
  List<MarkupListHolidayDestinationModel> holidaydestinationList = [];
  List<MarkupHolidayFareModel> holidayfareList = [];

  List<MarkupBusDateModel> busdateList = [];
  List<MarkupListBusDestinationModel> busdestinationList = [];
  List<MarkupListBusFareModel> busfareList = [];



  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _retrieveSavedValues();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
    userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
    print("userTypeID: $userTypeID");
    print("userID: $userID");
    await _fetchFlightData();
    await _fetchHotelData();
    await _fetchCardata();
    await _fetchHolidaydata();
    await _fetchBusdata();
  }

  Future<void> _fetchFlightData() async {
    setState(() {
      _isLoading = true;
    });

    final data = await getFlightTicketOrderQueue();

    setState(() {
      markupList = List<MarkupListModel>.from(data['markupList'] ?? []);
      dateList = List<MarkupListFlightDateModel>.from(data['dateList'] ?? []);
      flightDestinationList = List<MarkupListFlightDestinationModel>.from(
          data['FlightDestinationList'] ?? []);
      flightFareList =
          List<MarkupListFlightFareModel>.from(data['flightfarelist'] ?? []);
      _isLoading = false;
    });
  }

  Future<void> _fetchHotelData() async {
    setState(() {
      _isLoading = true;
    });

    final data = await getFlightTicketOrderQueue();

    setState(() {
      hoteldateList =
          List<markupListHoteldateModel>.from(data['hoteldateList'] ?? []);
      hoteldestinationlist = List<MarkupListHotelDestinationModel>.from(
          data['hoteldestinationlist'] ?? []);
      hotelfarelist =
          List<markupHotelFareModel>.from(data['hotelfarelist'] ?? []);

      hotelratingslist = List<MarkupListHotelRatingsModel>.from(
          data['hotelratingslist'] ?? []);

      //hotelratingslist
      _isLoading = false;
    });
  }

  Future<void> _fetchCardata() async {
    setState(() {
      _isLoading = true;
    });

    final data = await getFlightTicketOrderQueue();

    setState(() {
      cardateList =
          List<MarkupListCardateModel>.from(data['cardateList'] ?? []);
      cardestinationlist = List<MarkupListCarDestinationModel>.from(
          data['cardestinationlist'] ?? []);
      carfarelist =
      List<markupCarFareModel>.from(data['carfarelist'] ?? []);

      hotelratingslist =
      List<MarkupListHotelRatingsModel>.from(data['hotelratingslist'] ?? []);

      //hotelratingslist
      _isLoading = false;
    });
  }

  Future<void> _fetchHolidaydata() async {
    setState(() {
      _isLoading = true;
    });

    final data = await getFlightTicketOrderQueue();

    setState(() {
      holidaydateList =
      List<MarkupListHolidayDateModel>.from(data['holidaydateList'] ?? []);
      holidaydestinationList = List<MarkupListHolidayDestinationModel>.from(
          data['holidaydestinationList'] ?? []);
      holidayfareList =
      List<MarkupHolidayFareModel>.from(data['holidayfareList'] ?? []);




      _isLoading = false;
    });
  }
  Future<void> _fetchBusdata() async {
    setState(() {
      _isLoading = true;
    });

    final data = await getFlightTicketOrderQueue();

    setState(() {
      busdateList =
      List<MarkupBusDateModel>.from(data['busdateList'] ?? []);
      busdestinationList = List<MarkupListBusDestinationModel>.from(
          data['busdestinationList'] ?? []);
      busfareList =
      List<MarkupListBusFareModel>.from(data['busfareList'] ?? []);



      _isLoading = false;
    });
  }
  //MarkupBusDateModel

  //holidaydateList
  static Future<Map<String, List<dynamic>>> getFlightTicketOrderQueue() async {
    List<MarkupListModel> markupList = [];
    List<MarkupListFlightDateModel> dateList = [];
    List<MarkupListFlightDestinationModel> FlightDestinationList = [];
    List<MarkupListFlightFareModel> flightfarelist = [];

    List<markupListHoteldateModel> hoteldateList = [];
    List<MarkupListHotelDestinationModel> hoteldestinationlist = [];
    List<markupHotelFareModel> hotelfarelist = [];
    List<MarkupListHotelRatingsModel> hotelratingslist = [];

    List<MarkupListCardateModel> cardateList = [];
    List<MarkupListCarDestinationModel> cardestinationlist = [];
    List<markupCarFareModel>carfarelist=[];

    List<MarkupListHolidayDateModel>holidaydateList=[];
    List<MarkupListHolidayDestinationModel>holidaydestinationList=[];
    List<MarkupHolidayFareModel>holidayfareList=[];

    List<MarkupBusDateModel>busdateList=[];
    List<MarkupListBusDestinationModel>busdestinationList=[];
    List<MarkupListBusFareModel>busfareList=[];
    Future<http.Response>? response = ResponseHandler.performPost(
        "Markuplist", "UserTypeId=$userTypeID&UserId=$userID");

    if (response == null) {
      return {
        "markupList": [],
        "dateList": [],
        "FlightDestinationList": [],
        "flightfarelist": [],
        "hoteldateList": [],
        "hoteldestinationlist": [],
        "hotelfarelist": [],
        "hotelratingslist": [],
        "cardateList": [],
        "cardestinationlist": [],
        "carfarelist":[],
        "holidaydateList":[],
        "holidaydestinationList":[],
        "holidayfareList":[],
        "busdateList":[],
        "busdestinationList":[],
        "busfareList":[],
      };
    }

    return response.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);

        if (map.containsKey("Table")) {
          markupList = (map["Table"] as List)
              .map((e) => MarkupListModel.fromJson(e))
              .toList();
        }

        if (map.containsKey("Table1")) {
          dateList = (map["Table1"] as List)
              .map((e) => MarkupListFlightDateModel.fromJson(e))
              .toList();
        }

        if (map.containsKey("Table2")) {
          FlightDestinationList = (map["Table2"] as List)
              .map((e) => MarkupListFlightDestinationModel.fromJson(e))
              .toList();
        }

        if (map.containsKey("Table3")) {
          flightfarelist = (map["Table3"] as List)
              .map((e) => MarkupListFlightFareModel.fromJson(e))
              .toList();
        }

        if (map.containsKey("Table4")) {
          hoteldateList = (map["Table4"] as List)
              .map((e) => markupListHoteldateModel.fromJson(e))
              .toList();
          //hotelDestinationList
          //hoteldateList
        }
        if (map.containsKey("Table5")) {
          hoteldestinationlist = (map["Table5"] as List)
              .map((e) => MarkupListHotelDestinationModel.fromJson(e))
              .toList();
          //hotelDestinationList
          //hoteldateList
        }

        if (map.containsKey("Table6")) {
          hotelfarelist = (map["Table6"] as List)
              .map((e) => markupHotelFareModel.fromJson(e))
              .toList();
        }
        if (map.containsKey("Table7")) {
          hotelratingslist = (map["Table7"] as List)
              .map((e) => MarkupListHotelRatingsModel.fromJson(e))
              .toList();
        }
        if (map.containsKey("Table12")) {
          cardateList = (map["Table12"] as List)
              .map((e) => MarkupListCardateModel.fromJson(e))
              .toList();
        }

        if (map.containsKey("Table11")) {
          cardestinationlist = (map["Table11"] as List)
              .map((e) => MarkupListCarDestinationModel.fromJson(e))
              .toList();
        }

        if (map.containsKey("Table13")) {
          carfarelist = (map["Table13"] as List)
              .map((e) => markupCarFareModel.fromJson(e))
              .toList();
        }

        if (map.containsKey("Table8")) {
          holidaydateList = (map["Table8"] as List)
              .map((e) => MarkupListHolidayDateModel.fromJson(e))
              .toList();
        }
        if (map.containsKey("Table9")) {
          holidaydestinationList = (map["Table9"] as List)
              .map((e) => MarkupListHolidayDestinationModel.fromJson(e))
              .toList();
        }

        if (map.containsKey("Table10")) {
          holidayfareList = (map["Table10"] as List)
              .map((e) => MarkupHolidayFareModel.fromJson(e))
              .toList();
        }

        if (map.containsKey("Table15")) {
          busdateList = (map["Table15"] as List)
              .map((e) => MarkupBusDateModel.fromJson(e))
              .toList();
        }
        if (map.containsKey("Table14")) {
          busdestinationList = (map["Table14"] as List)
              .map((e) => MarkupListBusDestinationModel.fromJson(e))
              .toList();
        }

        if (map.containsKey("Table16")) {
          busfareList = (map["Table16"] as List)
              .map((e) => MarkupListBusFareModel.fromJson(e))
              .toList();
        }



      } catch (error) {
        // Log error if needed
      }

      return {
        "markupList": markupList,
        "dateList": dateList,
        "FlightDestinationList": FlightDestinationList,
        "flightfarelist": flightfarelist,
        "hoteldateList": hoteldateList,
        "hoteldestinationlist": hoteldestinationlist,
        "hotelfarelist": hotelfarelist,
        "hotelratingslist": hotelratingslist,
        "cardateList": cardateList,
        "cardestinationlist":cardestinationlist,
        "carfarelist":carfarelist,
        "holidaydateList":holidaydateList,
        "holidaydestinationList":holidaydestinationList,
        "holidayfareList":holidayfareList,
        "busdateList":busdateList,
        "busdestinationList":busdestinationList,
        "busfareList":busfareList,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              titleSpacing: 1,
              backgroundColor:Color(0xFF00ADEE),
              elevation: 0,
              title: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 27,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 1),
                  Text(
                    "Markup List",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 17.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Image.asset(
                    'assets/images/lojolog.png',
                    width: 100,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(62),
                child: Container(
                  color: Colors.white, // 👈 sets background color of the entire bottom section
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: TabBar(
                          isScrollable: true,
                          controller: _tabController,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFF00ADEE), width: 1),
                            color: Colors.blue.shade100,
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(fontSize: 16),
                          tabs: const [
                            Tab(text: 'Flight Markup'),
                            Tab(text: 'Hotel Markup'),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        height: 1,
                      ),
                    ],
                  ),
                ),
              ),

            ),



            body: TabBarView( controller: _tabController,children: [
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : markupList.isEmpty
                      ? const Center(child: Text("No flight data available"))
                      : ListView(
                          padding: EdgeInsets.all(10),
                          children: [
                            // Markup List Section Header
                            Text(
                              "Markup Flight Airline",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),

                            // Markup List Items
                            ...markupList.map((item) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: PhysicalModel(
                                  color: Colors.white,
                                  elevation: 8,
                                  shadowColor: Color(0xff9a9ce3),
                                  borderRadius: BorderRadius.circular(4),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.customerName,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Airline: ${item.airlineName}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Type: ${item.markupType}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            color: Color(0xffededed),
                                            thickness: 1),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.book_outlined,
                                                    size: 14),
                                                SizedBox(width: 4),
                                                Text(
                                                  "ID: ",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  item.id,
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 2.5),
                                              decoration: BoxDecoration(
                                                color: item.status == "1"
                                                    ? Colors.green
                                                    : Colors.red,
                                                border: Border.all(
                                                    width: 0.1,
                                                    color: Color(0xFF00ADEE)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Text(
                                                item.status == "1"
                                                    ? "Active"
                                                    : "InActive",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),

                            SizedBox(height: 20),

                            Text(
                              "Markup Flight Date",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),

                            // Date List Items
                            ...dateList.map((item) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: PhysicalModel(
                                  color: Colors.white,
                                  elevation: 8,
                                  shadowColor: Color(0xff9a9ce3),
                                  borderRadius: BorderRadius.circular(4),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.customerName,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "From date: ${item.fromDate}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "To date: ${item.toDate}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Type: ${item.markupType}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            color: Color(0xffededed),
                                            thickness: 1),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.book_outlined,
                                                    size: 14),
                                                SizedBox(width: 4),
                                                Text(
                                                  "ID: ",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  item.id,
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 2.5),
                                              decoration: BoxDecoration(
                                                color: item.status == "1"
                                                    ? Colors.green
                                                    : Colors.red,
                                                border: Border.all(
                                                    width: 0.1,
                                                    color: Color(0xFF00ADEE)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Text(
                                                item.status == "1"
                                                    ? "Active"
                                                    : "InActive",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),

                            SizedBox(height: 20),

                            Text(
                              "Markup Flight Destination",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),

                            // Date List Items
                            ...flightDestinationList.map((item) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: PhysicalModel(
                                  color: Colors.white,
                                  elevation: 8,
                                  shadowColor: Color(0xff9a9ce3),
                                  borderRadius: BorderRadius.circular(4),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.customerName,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "From Airport: ${item.fromAirport}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "To Airport: ${item.toAirport}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Type: ${item.markupType}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            color: Color(0xffededed),
                                            thickness: 1),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.book_outlined,
                                                    size: 14),
                                                SizedBox(width: 4),
                                                Text(
                                                  "ID: ",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  item.id,
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 2.5),
                                              decoration: BoxDecoration(
                                                color: item.status == "1"
                                                    ? Colors.green
                                                    : Colors.red,
                                                border: Border.all(
                                                    width: 0.1,
                                                    color: Color(0xFF00ADEE)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Text(
                                                item.status == "1"
                                                    ? "Active"
                                                    : "InActive",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),

                            SizedBox(height: 20),

                            Text(
                              "Markup Flight Fare",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),

                            // Date List Items
                            ...flightFareList.map((item) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: PhysicalModel(
                                  color: Colors.white,
                                  elevation: 8,
                                  shadowColor: Color(0xff9a9ce3),
                                  borderRadius: BorderRadius.circular(4),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.customerName,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "From Fare: ${item.currency+item.fromFare}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "To Fare: ${item.currency+item.toFare}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Type: ${item.markupType}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            color: Color(0xffededed),
                                            thickness: 1),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.book_outlined,
                                                    size: 14),
                                                SizedBox(width: 4),
                                                Text(
                                                  "ID: ",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  item.id,
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 2.5),
                                              decoration: BoxDecoration(
                                                color: item.status == "1"
                                                    ? Colors.green
                                                    : Colors.red,
                                                border: Border.all(
                                                    width: 0.1,
                                                    color: Color(0xFF00ADEE)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Text(
                                                item.status == "1"
                                                    ? "Active"
                                                    : "InActive",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),

              // Other tabs
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : hoteldateList.isEmpty
                      ? const Center(child: Text("No Hotel data available"))
                      : ListView(
                          padding: EdgeInsets.all(10),
                          children: [
                            Text(
                              "Markup Hotel Date",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),

                            // Date List Items
                            ...hoteldateList.map((item) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: PhysicalModel(
                                  color: Colors.white,
                                  elevation: 8,
                                  shadowColor: Color(0xff9a9ce3),
                                  borderRadius: BorderRadius.circular(4),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.customerName,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "From date: ${item.fromDate}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "To date: ${item.toDate}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Type: ${item.markupType}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            color: Color(0xffededed),
                                            thickness: 1),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.book_outlined,
                                                    size: 14),
                                                SizedBox(width: 4),
                                                Text(
                                                  "ID: ",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  item.id,
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 2.5),
                                              decoration: BoxDecoration(
                                                color: item.status == "1"
                                                    ? Colors.green
                                                    : Colors.red,
                                                border: Border.all(
                                                    width: 0.1,
                                                    color: Color(0xFF00ADEE)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Text(
                                                item.status == "1"
                                                    ? "Active"
                                                    : "InActive",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),

                            SizedBox(height: 20),

                            Text(
                              "Markup Hotel Destination",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),

                            // Date List Items
                            ...hoteldestinationlist.map((item) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: PhysicalModel(
                                  color: Colors.white,
                                  elevation: 8,
                                  shadowColor: Color(0xff9a9ce3),
                                  borderRadius: BorderRadius.circular(4),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.customerName,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Destination: ${item.hotelCityName}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Type: ${item.markupType}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            color: Color(0xffededed),
                                            thickness: 1),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.book_outlined,
                                                    size: 14),
                                                SizedBox(width: 4),
                                                Text(
                                                  "ID: ",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  item.id,
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 2.5),
                                              decoration: BoxDecoration(
                                                color: item.status == "1"
                                                    ? Colors.green
                                                    : Colors.red,
                                                border: Border.all(
                                                    width: 0.1,
                                                    color: Color(0xFF00ADEE)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Text(
                                                item.status == "1"
                                                    ? "Active"
                                                    : "InActive",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),

                            SizedBox(height: 20),

                            Text(
                              "Markup Hotel Fare",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),

                            // Date List Items
                            ...hotelfarelist.map((item) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: PhysicalModel(
                                  color: Colors.white,
                                  elevation: 8,
                                  shadowColor: Color(0xff9a9ce3),
                                  borderRadius: BorderRadius.circular(4),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.customerName,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "From Fare: ${item.currency+item.fromFare}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "To Fare: ${item.currency+item.toFare}",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Type: ${item.markupType}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            color: Color(0xffededed),
                                            thickness: 1),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.book_outlined,
                                                    size: 14),
                                                SizedBox(width: 4),
                                                Text(
                                                  "ID: ",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  item.id,
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 2.5),
                                              decoration: BoxDecoration(
                                                color: item.status == "1"
                                                    ? Colors.green
                                                    : Colors.red,
                                                border: Border.all(
                                                    width: 0.1,
                                                    color: Color(0xFF00ADEE)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Text(
                                                item.status == "1"
                                                    ? "Active"
                                                    : "InActive",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),

                            SizedBox(height: 20),

                            Text(
                              "Markup Hotel Rating",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),

                            // Date List Items
                            ...hotelratingslist.map((item) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: PhysicalModel(
                                  color: Colors.white,
                                  elevation: 8,
                                  shadowColor: Color(0xff9a9ce3),
                                  borderRadius: BorderRadius.circular(4),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.customerName,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Hotel Rating: ${item.hotelRating} Star",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Type: ${item.markupType}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            color: Color(0xffededed),
                                            thickness: 1),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.book_outlined,
                                                    size: 14),
                                                SizedBox(width: 4),
                                                Text(
                                                  "ID: ",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  item.id,
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 2.5),
                                              decoration: BoxDecoration(
                                                color: item.status == "1"
                                                    ? Colors.green
                                                    : Colors.red,
                                                border: Border.all(
                                                    width: 0.1,
                                                    color: Color(0xFF00ADEE)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Text(
                                                item.status == "1"
                                                    ? "Active"
                                                    : "InActive",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),

              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : cardateList.isEmpty
                      ? const Center(child: Text("No Car data available"))
                      : ListView(padding: EdgeInsets.all(10), children: [
                          Text(
                            "Markup Car Date",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),

                          // Date List Items
                          ...cardateList.map((item) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: PhysicalModel(
                                color: Colors.white,
                                elevation: 8,
                                shadowColor: Color(0xff9a9ce3),
                                borderRadius: BorderRadius.circular(4),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.customerName,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "From date: ${item.fromDate}",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "To date: ${item.toDate}",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Type: ${item.markupType}",
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                          color: Color(0xffededed),
                                          thickness: 1),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.book_outlined,
                                                  size: 14),
                                              SizedBox(width: 4),
                                              Text(
                                                "ID: ",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                item.id,
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 2.5),
                                            decoration: BoxDecoration(
                                              color: item.status == "1"
                                                  ? Colors.green
                                                  : Colors.red,
                                              border: Border.all(
                                                  width: 0.1,
                                                  color: Color(0xFF00ADEE)),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Text(
                                              item.status == "1"
                                                  ? "Active"
                                                  : "InActive",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),

                          SizedBox(height: 20),

                          Text(
                            "Markup Car Destination",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),

                          // Date List Items
                          ...cardestinationlist.map((item) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: PhysicalModel(
                                color: Colors.white,
                                elevation: 8,
                                shadowColor: Color(0xff9a9ce3),
                                borderRadius: BorderRadius.circular(4),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.customerName,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Destination: ${item.fromAirport}",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Type: ${item.markupType}",
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                          color: Color(0xffededed),
                                          thickness: 1),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.book_outlined,
                                                  size: 14),
                                              SizedBox(width: 4),
                                              Text(
                                                "ID: ",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                item.id,
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 2.5),
                                            decoration: BoxDecoration(
                                              color: item.status == "1"
                                                  ? Colors.green
                                                  : Colors.red,
                                              border: Border.all(
                                                  width: 0.1,
                                                  color: Color(0xFF00ADEE)),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Text(
                                              item.status == "1"
                                                  ? "Active"
                                                  : "InActive",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),

                          SizedBox(height: 20),

                          Text(
                            "Markup Car Fare",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),

                          // Date List Items
                          ...carfarelist.map((item) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: PhysicalModel(
                                color: Colors.white,
                                elevation: 8,
                                shadowColor: Color(0xff9a9ce3),
                                borderRadius: BorderRadius.circular(4),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.customerName,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "From Fare: ${item.currency+item.fromFare}",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "To Fare: ${item.currency+item.toFare}",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Type: ${item.markupType}",
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                          color: Color(0xffededed),
                                          thickness: 1),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.book_outlined,
                                                  size: 14),
                                              SizedBox(width: 4),
                                              Text(
                                                "ID: ",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                item.id,
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 2.5),
                                            decoration: BoxDecoration(
                                              color: item.status == "1"
                                                  ? Colors.green
                                                  : Colors.red,
                                              border: Border.all(
                                                  width: 0.1,
                                                  color: Color(0xFF00ADEE)),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Text(
                                              item.status == "1"
                                                  ? "Active"
                                                  : "InActive",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),

                          SizedBox(height: 20),


                        ]),

//holiday
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : holidaydateList.isEmpty
                  ? const Center(child: Text("No Holiday data available"))
                  : ListView(padding: EdgeInsets.all(10), children: [
                Text(
                  "Markup Holiday Date",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),

                // Date List Items
                ...holidaydateList.map((item) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: Color(0xff9a9ce3),
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.customerName,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "From date: ${item.fromDate}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "To date: ${item.toDate}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Type: ${item.markupType}",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                                color: Color(0xffededed),
                                thickness: 1),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.book_outlined,
                                        size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      "ID: ",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      item.id,
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: item.status == "1"
                                        ? Colors.green
                                        : Colors.red,
                                    border: Border.all(
                                        width: 0.1,
                                        color: Color(0xFF00ADEE)),
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    item.status == "1"
                                        ? "Active"
                                        : "InActive",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),

                SizedBox(height: 20),

                Text(
                  "Markup Holiday Destination",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),

                // Date List Items
                ...holidaydestinationList.map((item) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: Color(0xff9a9ce3),
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.customerName,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Destination: ${item.holidayCityName}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Type: ${item.markupType}",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                                color: Color(0xffededed),
                                thickness: 1),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.book_outlined,
                                        size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      "ID: ",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      item.id,
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: item.status == "1"
                                        ? Colors.green
                                        : Colors.red,
                                    border: Border.all(
                                        width: 0.1,
                                        color: Color(0xFF00ADEE)),
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    item.status == "1"
                                        ? "Active"
                                        : "InActive",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),

                SizedBox(height: 20),

                Text(
                  "Markup Holiday Fare",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),

                // Date List Items
                ...holidayfareList.map((item) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: Color(0xff9a9ce3),
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.customerName,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "From Fare: ${item.currency+item.fromFare}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "To Fare: ${item.currency+item.toFare}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Type: ${item.markupType}",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                                color: Color(0xffededed),
                                thickness: 1),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.book_outlined,
                                        size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      "ID: ",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      item.id,
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: item.status == "1"
                                        ? Colors.green
                                        : Colors.red,
                                    border: Border.all(
                                        width: 0.1,
                                        color: Color(0xFF00ADEE)),
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    item.status == "1"
                                        ? "Active"
                                        : "InActive",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),

                SizedBox(height: 20),


              ]),

//bus
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : busdateList.isEmpty
                  ? const Center(child: Text("No Bus data available"))
                  : ListView(padding: EdgeInsets.all(10), children: [
                Text(
                  "Markup Bus Date",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),

                // Date List Items
                ...busdateList.map((item) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: Color(0xff9a9ce3),
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.customerName,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "From date: ${item.fromDate}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "To date: ${item.toDate}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Type: ${item.markupType}",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                                color: Color(0xffededed),
                                thickness: 1),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.book_outlined,
                                        size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      "ID: ",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      item.id,
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: item.status == "1"
                                        ? Colors.green
                                        : Colors.red,
                                    border: Border.all(
                                        width: 0.1,
                                        color: Color(0xFF00ADEE)),
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    item.status == "1"
                                        ? "Active"
                                        : "InActive",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),

                SizedBox(height: 20),

                Text(
                  "Markup Bus Destination",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),

                // Date List Items
                ...busdestinationList.map((item) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: Color(0xff9a9ce3),
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.customerName,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "From Station: ${item.fromBusStation}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "To Station: ${item.toBusStation}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Type: ${item.markupType}",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                                color: Color(0xffededed),
                                thickness: 1),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.book_outlined,
                                        size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      "ID: ",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      item.id,
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: item.status == "1"
                                        ? Colors.green
                                        : Colors.red,
                                    border: Border.all(
                                        width: 0.1,
                                        color: Color(0xFF00ADEE)),
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    item.status == "1"
                                        ? "Active"
                                        : "InActive",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),

                SizedBox(height: 20),

                Text(
                  "Markup Bus Fare",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),

                // Date List Items
                ...busfareList.map((item) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: Color(0xff9a9ce3),
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.customerName,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "From Fare: ${item.currency+ item.fromFare}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "To Fare: ${item.currency+item.toFare}",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Type: ${item.markupType}",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "Value: ${item.markupValue} ${item.markupType == "Percentage" ? "%" : "INR"}",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                                color: Color(0xffededed),
                                thickness: 1),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.book_outlined,
                                        size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      "ID: ",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      item.id,
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: item.status == "1"
                                        ? Colors.green
                                        : Colors.red,
                                    border: Border.all(
                                        width: 0.1,
                                        color: Color(0xFF00ADEE)),
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    item.status == "1"
                                        ? "Active"
                                        : "InActive",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),

                SizedBox(height: 20),


              ]),


            ])));
  }
}
