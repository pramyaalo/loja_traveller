import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flight_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class AddTravellers_Flight extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
  final int adultsCount;
  final int childrenCount;
  final int infantsCount;

  final String selectedClass;

  AddTravellers_Flight({
    required this.adultsCount,
    required this.childrenCount,
    required this.infantsCount,
    required this.selectedClass,
  });
}

class _MyPageState extends State<AddTravellers_Flight> {
  late int adultsCount;
  late int childrenCount;
  late int infantsCount;
  late String selectedClass;

  bool isEconomySelected = false;

  bool isPremiumEconomySelected = false;
  bool isBusinessSelected = false;
  bool isFirstSelected = false;
  void decrement() {
    setState(() {
      if (adultsCount > 1) {
        adultsCount--;

        print(adultsCount);
      }
    });
  }

  _saveString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setInt('adultsCount', adultsCount);
    prefs.setInt('childrenCount', childrenCount);
    prefs.setInt('infantsCount', infantsCount);
    setState(() {
      if (isEconomySelected == true) {
        prefs.setString('selectedClass', 'Economy');
        selectedClass = 'Economy';
      } else if (isPremiumEconomySelected == true) {
        prefs.setString('selectedClass', 'PremiumEconomy');
        selectedClass = 'PremiumEconomy';
      } else if (isBusinessSelected == true) {
        prefs.setString('selectedClass', 'Business');
        selectedClass = 'Business';
      } else if (isFirstSelected == true) {
        prefs.setString('selectedClass', 'First');
        selectedClass = 'First';
      }
    });

    print(adultsCount);
    print(isEconomySelected);
    print(isPremiumEconomySelected);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    adultsCount = widget.adultsCount ?? 1;
    childrenCount = widget.childrenCount ?? 0;

    infantsCount = widget.infantsCount ?? 1;
    selectedClass = widget.selectedClass ?? '';

    print('ljopijioadultsCount' + selectedClass.toString());
    if (selectedClass.isEmpty) {
      selectedClass = 'Economy';
    }
    if (selectedClass == 'Economy') {
      isEconomySelected = true;
    }
    if (selectedClass == 'PremiumEconomy') {
      isPremiumEconomySelected = true;
    }
    if (selectedClass == 'Business') {
      isBusinessSelected = true;
    }
    if (selectedClass == 'First') {
      isFirstSelected = true;
    }
    //_loadSavedString();
  }

  /* _loadSavedString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      adultsCount = prefs.getInt('adultsCount') ?? 0;
      childrenCount = prefs.getInt('childrenCount') ?? 0;
      infantsCount = prefs.getInt('infantsCount') ?? 0;
      String isEconomy = prefs.getString('isEconomySelected') ?? '';
      String PremiumEconomy = prefs.getString('PremiumEconomy') ?? '';
      String Business = prefs.getString('Business') ?? '';
      String isFirstSelecteed = prefs.getString('isFirstSelected') ?? '';
      print('Adults Count: $adultsCount');
      print('Children Count: $childrenCount');
      print('Infants Count: $infantsCount');
      print('Is Economy Selected: $isEconomy');
      print('Premium Economy: $PremiumEconomy');
      print('Business: $Business');
      print('Is First Selected: $isFirstSelecteed');

      if (PremiumEconomy != '') {
        isPremiumEconomySelected = true;
        print('Premium Eafdconomy: $isPremiumEconomySelected');
      }
      if (isEconomy != '') {
        isEconomySelected = true;
        print('Premium Eafdconomy: $isEconomySelected');
      }
      if (Business != '') {
        isBusinessSelected = true;
        print('Premium Eafdconomy: $isBusinessSelected');
      }
      if (isFirstSelecteed != '') {
        isFirstSelected = true;
        print('Premium Eafdconomy: $isFirstSelected');
      }
    });
  }*/

  void decrement1() {
    setState(() {
      if (childrenCount > 0) {
        childrenCount--;
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

  void toggleEconomy() {
    setState(() {
      isBusinessSelected = false;
      isPremiumEconomySelected = false;
      isFirstSelected = false;
      selectedClass = 'Economy';
      isEconomySelected = !isEconomySelected;
    });
  }

  void toggleEconomy1() {
    setState(() {
      isBusinessSelected = false;
      isEconomySelected = false;
      isFirstSelected = false;
      isPremiumEconomySelected = !isPremiumEconomySelected;
    });
  }

  void toggleEconomy2() {
    setState(() {
      isEconomySelected = false;
      isPremiumEconomySelected = false;
      isFirstSelected = false;
      isBusinessSelected = !isBusinessSelected;
    });
  }

  void toggleEconomy3() {
    setState(() {
      isEconomySelected = false;
      isPremiumEconomySelected = false;
      isBusinessSelected = false;
      isFirstSelected = !isFirstSelected;
    });
  }

  void increment() {
    setState(() {
      adultsCount++;
      print(adultsCount);
    });
  }

  void increment1() {
    setState(() {
      childrenCount++;
    });
  }

  void increment2() {
    setState(() {
      infantsCount++;
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
              "Travellers,Class",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  fontSize: 19),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/logo.png',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    'Adults       (12+yrs)',
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
                      onTap: decrement,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)),
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
                      onTap: increment,
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
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: Text(
                    'Children    (2-12 Years)',
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
                      onTap: decrement1,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)),
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
                      onTap: increment1,
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
              height: 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        'Infants      (0-2 Years)',
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
                          onTap: decrement2,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey)),
                            child: Icon(
                              Icons.remove,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          infantsCount.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: increment2,
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
                  height: 40,
                ),
                GestureDetector(
                  onTap: toggleEconomy,
                  child: Container(
                    padding: EdgeInsets.only(right: 5, bottom: 2, left: 5),
                    decoration: BoxDecoration(
                      color: isEconomySelected
                          ? Colors.pink.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Economy',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Radio(
                          value: true,
                          groupValue: isEconomySelected,
                          onChanged: (value) => toggleEconomy(),
                          activeColor: Color(0xFF152238),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: toggleEconomy1,
                  child: Container(
                    padding: EdgeInsets.only(right: 5, bottom: 2, left: 5),
                    decoration: BoxDecoration(
                      color: isPremiumEconomySelected
                          ? Colors.pink.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Premium Economy',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Radio(
                          value: true,
                          groupValue: isPremiumEconomySelected,
                          onChanged: (value) => toggleEconomy1(),
                          activeColor: Color(0xFF152238),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: toggleEconomy2,
                  child: Container(
                    padding: EdgeInsets.only(right: 5, bottom: 2, left: 5),
                    decoration: BoxDecoration(
                      color: isBusinessSelected
                          ? Colors.pink.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Business',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Radio(
                          value: true,
                          groupValue: isBusinessSelected,
                          onChanged: (value) => toggleEconomy2(),
                          activeColor: Color(0xFF152238),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: toggleEconomy3,
                  child: Container(
                    padding: EdgeInsets.only(right: 5, bottom: 2, left: 5),
                    decoration: BoxDecoration(
                      color: isFirstSelected
                          ? Colors.pink.shade50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'First',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Radio(
                          value: true,
                          groupValue: isFirstSelected,
                          onChanged: (value) => toggleEconomy3(),
                          activeColor: Color(0xFF152238),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // _saveString();
                  if (isEconomySelected == true) {
                    selectedClass = 'Economy';
                  } else if (isPremiumEconomySelected == true) {
                    selectedClass = 'PremiumEconomy';
                  } else if (isBusinessSelected == true) {
                    selectedClass = 'Business';
                  } else if (isFirstSelected == true) {
                    selectedClass = 'First';
                  }
                  Navigator.pop(
                    context,
                    {
                      'adultsCount': adultsCount,
                      'childrenCount': childrenCount,
                      'infantCount': infantsCount,
                      'selectedClass': selectedClass,
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
