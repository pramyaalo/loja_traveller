import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/response_handler.dart';
import 'ViewholidayDestinationModel.dart';
 



class ViewHolidayDestination extends StatefulWidget {
  final String Id;

  ViewHolidayDestination({required this.Id});

  @override
  _MyRechargePageState createState() => _MyRechargePageState();
}

class _MyRechargePageState extends State<ViewHolidayDestination> {
  Future<List<ViewholidayDestinationModel>?> getFlightTicketOrderQueue() async {
    String SubAgencyId = '';
    List<ViewholidayDestinationModel> bookingCardData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "MarkupHolidayDestinationViewEdit", "Id=${widget.Id}");
    log("idddddd" + widget.Id);
    return await __futureLabels?.then((value) async {
      String jsonResponse = ResponseHandler.parseData(value.body);

      try {
        Map<String, dynamic> map = json.decode(jsonResponse);
        List<dynamic> list = map["Table"];
        for (int i = 0; i < list.length; i++) {
          ViewholidayDestinationModel lm = ViewholidayDestinationModel.fromJson(list[i]);
          bookingCardData.add(lm);
        }
      } catch (error) {
        Fluttertoast.showToast(msg: error.toString());
      }
      return bookingCardData;
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
                "View Destination",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontSize: 19),
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
          child: FutureBuilder<List<ViewholidayDestinationModel>?>(
              future: getFlightTicketOrderQueue(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(left: 9, right: 9, top: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 1.0, // Border width
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  8.0)), // Optional: Add rounded corners
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 8),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment:
                                            AlignmentDirectional.topStart,
                                            child: Text(
                                              "    Customer Type",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              snapshot.data![index].userType,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Customer Name",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              snapshot.data![index].fullName,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Destination",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              snapshot.data![index].holidayCityName,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),

                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Markup Type",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              snapshot.data![index].markupType,
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Markup Value",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              snapshot.data![index].markupValue +
                                                  (snapshot.data![index].markupType == "Fixed" ? " INR" : " %"),
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              "    Status",
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional.center,
                                          child: Center(
                                            child: Text(" : "),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              snapshot.data![index].status == "1" ? 'Active' : 'Inactive',
                                              style: const TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),


                                  ],
                                ),


                                SizedBox(height: 8.0),
                              ],
                            ),
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

Widget buildCheckbox(String label, bool value, Function(bool?) onChanged) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3.0), // Adjust the bottom padding
    child: Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(label),
      ],
    ),
  );
}
