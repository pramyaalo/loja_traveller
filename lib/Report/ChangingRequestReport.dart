import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/response_handler.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_preferences.dart';
import 'ChangingRequestReportModel.dart';

class ChangingRequestReport extends StatefulWidget {
  const ChangingRequestReport({Key? key}) : super(key: key);

  @override
  _ChangingRequestReportState createState() => _ChangingRequestReportState();
}

class _ChangingRequestReportState extends State<ChangingRequestReport> {
  static late String userTypeID;
  static late String userID;
  @override
  void initState() {
    super.initState();
    _retrieveSavedValues();
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

  static Future<List<ChangingRequestReportModel>?> getLabels() async {
    List<ChangingRequestReportModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "ChangingRequestReportGet",
        "SerUserTypeId=$userTypeID&SerUserId=$userID&UserTypeId=$userTypeID&LoginUserTypeId=0&LoginUserId=0&StaffId=0&FromDate=&ToDate=");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          ChangingRequestReportModel lm =
          ChangingRequestReportModel.fromJson(list[i]);
          labelData.add(lm);
        }
      } catch (error) {}
      return labelData;
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
                  color: Colors.white,
                  size: 27,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              SizedBox(width: 1), // Set the desired width
              Text(
                "Changing Request",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Montserrat",
                    fontSize: 18),
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
        body: Center(
          child: FutureBuilder<List<ChangingRequestReportModel>?>(
              future: getLabels(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: PhysicalModel(
                                  color: Colors.white,
                                  elevation: 8,
                                  shadowColor: const Color(0xff9a9ce3),
                                  borderRadius: BorderRadius.circular(4),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data![index].bookingId,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    const IconData(0xefc6,
                                                        fontFamily:
                                                        'MaterialIcons'),
                                                    size: 15,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        right: 0),
                                                    child: Text(
                                                      "Request No: " +
                                                          snapshot.data![index]
                                                              .requestNumber,
                                                      style: TextStyle(
                                                        fontFamily:
                                                        "Montserrat",
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(), // Adds space between the two parts of the row
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      right: 0),
                                                  child: Text(
                                                    "Class: " +
                                                        snapshot.data![index]
                                                            .preferredClass,
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                    color: getStatusColor(snapshot.data![index].request),
                                                    border: Border.all(width: 0.1, color: Color(0xFF00ADEE)),
                                                    borderRadius: BorderRadius.circular(5.0),
                                                  ),
                                                  child: Text(
                                                    snapshot.data![index].request,
                                                    style: const TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            // Wrap right Column in Flexible to avoid overflow
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Image(
                                                        image: AssetImage('assets/images/tickiconpng.png'),
                                                        width: 16,
                                                        height: 16,
                                                        color: Color(0xFF00ADEE),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Flexible(
                                                        child: Text(
                                                          "Dep date: ${snapshot.data![index].departureDate}",
                                                          style: const TextStyle(
                                                            fontFamily: "Montserrat",
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 15,
                                                            color: Color(0xFF00ADEE),
                                                          ),
                                                          overflow: TextOverflow.visible,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Image(
                                                        image: AssetImage('assets/images/tickiconpng.png'),
                                                        width: 16,
                                                        height: 16,
                                                        color: Color(0xFF00ADEE),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Flexible(
                                                        child: Text(
                                                          "Arr Date: ${snapshot.data![index].arrivalDate}",
                                                          style: const TextStyle(
                                                            fontFamily: "Montserrat",
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 15,
                                                            color: Color(0xFF00ADEE),
                                                          ),
                                                          overflow: TextOverflow.visible,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),


                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}
Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'cancelled':
      return Colors.red;
    case 'processing':
      return Colors.orange;
    case 'completed':
      return Colors.green;
    default:
      return Colors.grey;
  }
}
