import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddGuestes_Hotel extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adultsCount;
  final int childrenCount;
  final int adultsCount1;
  final int childrenCount1;
  final int adultsCount2;
  final int childrenCount2;
  final int adultsCount3;
  final int childrenCount3;
  final String roomcount;

  AddGuestes_Hotel({
    required this.checkInDate,
    required this.checkOutDate,
    required this.adultsCount,
    required this.childrenCount,
    required this.adultsCount1,
    required this.childrenCount1,
    required this.adultsCount2,
    required this.childrenCount2,
    required this.adultsCount3,
    required this.childrenCount3,
    required this.roomcount,
  });
}

class _MyPageState extends State<AddGuestes_Hotel> {
  late DateTime _selectedCheckInDate;
  late DateTime _selectedCheckOutDate;
  late int adultsCount;
  late int adultsCount1;
  late int adultsCount2;
  late int adultsCount3;
  late int childrenCount;
  late int childrenCount1;
  late int childrenCount2;
  late int childrenCount3;
  late String roomCount;

  @override
  void initState() {
    super.initState();
    //_loadSavedString();
    roomCount = "1";
    _selectedCheckInDate = widget.checkInDate;
    _selectedCheckOutDate = widget.checkOutDate;
    adultsCount = widget.adultsCount ?? 1;
    childrenCount = widget.childrenCount ?? 0;

    adultsCount1 = widget.adultsCount1 ?? 1;
    childrenCount1 = widget.childrenCount1 ?? 0;

    adultsCount2 = widget.adultsCount2 ?? 1;
    childrenCount2 = widget.childrenCount2 ?? 0;

    adultsCount3 = widget.adultsCount3 ?? 1;
    childrenCount3 = widget.childrenCount3 ?? 0;

    roomCount = widget.roomcount ?? '';
    print('ljopijioadultsCount' + roomCount.toString());
    if (roomCount.isEmpty) {
      selectedValue = '1';
    } else {
      selectedValue = roomCount;
    }
  }

  String selectedDate = '', selectedReturnDate = '';

  String selectedValue = '1';

  int infantsCount = 0;
  bool isExpanded = false;
  bool isEconomySelected = false;
  bool isPremiumEconomySelected = false;
  bool isBusinessSelected = false;
  bool isFirstSelected = false;

  void decrementAdultRoom1() {
    setState(() {
      if (adultsCount > 1) {
        adultsCount--;
      }
    });
  }

  void decrementChildrenRoom1() {
    setState(() {
      if (childrenCount > 0) {
        childrenCount--;
      }
    });
  }

  void decrementAdultRoom2() {
    setState(() {
      if (adultsCount1 > 1) {
        adultsCount1--;
      }
    });
  }

  void decrementChildrenRoom2() {
    setState(() {
      if (childrenCount1 > 0) {
        childrenCount1--;
      }
    });
  }

  void decrementAdultRoom3() {
    setState(() {
      if (adultsCount2 > 1) {
        adultsCount2--;
      }
    });
  }

  void decrementChildrenRoom3() {
    setState(() {
      if (childrenCount2 > 0) {
        childrenCount2--;
      }
    });
  }

  void decrementAdultRoom4() {
    setState(() {
      if (adultsCount3 > 1) {
        adultsCount3--;
      }
    });
  }

  void decrementChildrenRoom4() {
    setState(() {
      if (childrenCount3 > 0) {
        childrenCount3--;
      }
    });
  }

  void decrement2() {
    setState(() {
      if (infantsCount > 0) {
        infantsCount--;
      }
    });
  }

  void incrementAdultRoom1() {
    setState(() {
      adultsCount = adultsCount < 4 ? adultsCount + 1 : 4;
      print('kfjgk' + adultsCount.toString());
    });
  }

  void incrementChildrenRoom1() {
    setState(() {
      childrenCount = childrenCount < 2 ? childrenCount + 1 : 2;
    });
  }

  void incrementAdultRoom2() {
    setState(() {
      adultsCount1 = adultsCount1 < 4 ? adultsCount1 + 1 : 4;
    });
  }

  void incrementChildrenRoom2() {
    setState(() {
      childrenCount1 = childrenCount1 < 2 ? childrenCount1 + 1 : 2;
    });
  }

  void incrementAdultRoom3() {
    setState(() {
      adultsCount2 = adultsCount2 < 4 ? adultsCount2 + 1 : 4;
    });
  }

  void incrementChildrenRoom3() {
    setState(() {
      childrenCount2 = childrenCount2 < 2 ? childrenCount2 + 1 : 2;
    });
  }

  void incrementAdultRoom4() {
    setState(() {
      adultsCount3 = adultsCount3 < 4 ? adultsCount3 + 1 : 4;
    });
  }

  void incrementChildrenRoom4() {
    setState(() {
      childrenCount3 = childrenCount3 < 2 ? childrenCount3 + 1 : 2;
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
                color: Colors.black,
                size: 27,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(width: 1), // Set the desired width
            Text(
              "Rooms",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  fontSize: 19),
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
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Room',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 45,
                        width: 350,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.only(bottom: 5, right: 10, left: 10),
                          ),
                          value: selectedValue,
                          items: <String>['1', '2', '3', '4']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                              roomCount = selectedValue;
                              print('roomCount' + roomCount);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),

            Visibility(
              visible: selectedValue == '1',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '  Room 1:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),

                  const SizedBox(
                    height: 8,
                  ),
                  // Wrap "Adults" and "Children" with a Container for the border
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        // Adults Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                'Adults',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementAdultRoom1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  adultsCount.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementAdultRoom1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 9),
                        // Children Section
                        Center(
                          child: Visibility(
                            visible: selectedValue == '1',
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5, left: 5),
                                      child: Text(
                                        'Children',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: decrementChildrenRoom1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Icon(
                                              Icons.remove,
                                              size: 18,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          childrenCount.toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        GestureDetector(
                                          onTap: incrementChildrenRoom1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF152238),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              size: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Visibility(
              visible: selectedValue == '2',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  Room 1:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                'Adults',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementAdultRoom1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  adultsCount.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementAdultRoom1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5, left: 5),
                              child: Text(
                                'Children',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementChildrenRoom1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  childrenCount.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementChildrenRoom1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '  Room 2:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                'Adults',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementAdultRoom2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  adultsCount1.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementAdultRoom2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: selectedValue == '2',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
                                child: Text(
                                  'Children',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: decrementChildrenRoom2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        size: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    childrenCount1.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: incrementChildrenRoom2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF152238),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 15,
            ),
            Visibility(
              visible: selectedValue == '3',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  Room 1:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                'Adults',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementAdultRoom1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  adultsCount.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementAdultRoom1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5, left: 5),
                              child: Text(
                                'Children',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementChildrenRoom1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  childrenCount.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementChildrenRoom1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '  Room 2:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                'Adults',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementAdultRoom2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  adultsCount1.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementAdultRoom2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5, left: 5),
                              child: Text(
                                'Children',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementChildrenRoom2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  childrenCount1.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementChildrenRoom2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '  Room 3:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                'Adults',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementAdultRoom3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  adultsCount2.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementAdultRoom3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: selectedValue == '3',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
                                child: Text(
                                  'Children',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: decrementChildrenRoom3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        size: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    childrenCount2.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: incrementChildrenRoom3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF152238),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 15,
            ),

            Visibility(
              visible: selectedValue == '4',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  Room 1:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                'Adults',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementAdultRoom1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  adultsCount.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementAdultRoom1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5, left: 5),
                              child: Text(
                                'Children',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementChildrenRoom1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  childrenCount.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementChildrenRoom1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '  Room 2:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                'Adults',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementAdultRoom2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  adultsCount1.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementAdultRoom2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5, left: 5),
                              child: Text(
                                'Children',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementChildrenRoom2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  childrenCount1.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementChildrenRoom2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '  Room 3:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                'Adults',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementAdultRoom3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  adultsCount2.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementAdultRoom3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5, left: 5),
                              child: Text(
                                'Children',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementChildrenRoom3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  childrenCount2.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementChildrenRoom3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '  Room 4:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                'Adults',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementAdultRoom4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  adultsCount3.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: incrementAdultRoom4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF152238),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: selectedValue == '4',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
                                child: Text(
                                  'Children',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: decrementChildrenRoom4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        size: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    childrenCount3.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: incrementChildrenRoom4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF152238),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 15,
            ),

            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    {
                      'checkInDate': _selectedCheckInDate,
                      'checkOutDate': _selectedCheckOutDate,
                      'roomcount': roomCount,
                      'adultsCount': adultsCount,
                      'childrenCount': childrenCount,
                      'adultsCount1': adultsCount1,
                      'childrenCount1': childrenCount1,
                      'adultsCount2': adultsCount2,
                      'childrenCount2': childrenCount2,
                      'adultsCount3': adultsCount3,
                      'childrenCount3': childrenCount3,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF152238), // Background color of the button
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Circular radius of 20
                  ),
                ),
                child: Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Add more rows or widgets as needed
          ],
        ),
      ),
    );
  }
}
