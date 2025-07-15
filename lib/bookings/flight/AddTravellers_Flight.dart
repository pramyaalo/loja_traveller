// Updated AddTravellers_Flight.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTravellers_Flight extends StatefulWidget {
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

  @override
  _AddTravellers_FlightState createState() => _AddTravellers_FlightState();
}

class _AddTravellers_FlightState extends State<AddTravellers_Flight> {
  late int adultsCount;
  late int childrenCount;
  late int infantsCount;
  late String selectedClass;
  int selectedClassId = 2; // Default Economy

  @override
  void initState() {
    super.initState();
    adultsCount = widget.adultsCount;
    childrenCount = widget.childrenCount;
    infantsCount = widget.infantsCount;
    selectedClass = widget.selectedClass;

    switch (selectedClass) {
      case 'All':
        selectedClassId = 1;
        break;
      case 'Economy':
        selectedClassId = 2;
        break;
      case 'PremiumEconomy':
        selectedClassId = 3;
        break;
      case 'Business':
        selectedClassId = 4;
        break;
      case 'PremiumBusiness':
        selectedClassId = 5;
        break;
      case 'First':
        selectedClassId = 6;
        break;
    }
  }

  void updateClass(String value, int id) {
    setState(() {
      selectedClass = value;
      selectedClassId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 1,
        backgroundColor:Color(0xFF00ADEE), // Custom dark color
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 27),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 1),
            Text(
              "Traveller,Class",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontSize: 19,
              ),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildCounterRow("Adults (12+ yrs)", adultsCount, () {
              if (adultsCount > 1) setState(() => adultsCount--);
            }, () => setState(() => adultsCount++)),
            buildCounterRow("Children (2-12 yrs)", childrenCount, () {
              if (childrenCount > 0) setState(() => childrenCount--);
            }, () => setState(() => childrenCount++)),
            buildCounterRow("Infants (0-2 yrs)", infantsCount, () {
              if (infantsCount > 0) setState(() => infantsCount--);
            }, () => setState(() => infantsCount++)),
            SizedBox(height: 20),
            buildRadioTile("All", 1),
            buildRadioTile("Economy", 2),
            buildRadioTile("PremiumEconomy", 3),
            buildRadioTile("Business", 4),
            buildRadioTile("PremiumBusiness", 5),
            buildRadioTile("First", 6),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'adultsCount': adultsCount,
                    'childrenCount': childrenCount,
                    'infantCount': infantsCount,
                    'selectedClass': selectedClass,
                    'selectedClassId': selectedClassId,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:Color(0xFF00ADEE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Done", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCounterRow(
      String label,
      int value,
      VoidCallback onDecrement,
      VoidCallback onIncrement,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.black54)),
          Row(
            children: [
              GestureDetector(
                onTap: onDecrement,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.remove, size: 18, color: Colors.grey),
                ),
              ),
              SizedBox(width: 8),
              Text(value.toString(), style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              GestureDetector(
                onTap: onIncrement,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor:Color(0xFF00ADEE),
                  child: Icon(Icons.add, size: 18, color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildRadioTile(String title, int id) {
    return GestureDetector(
      onTap: () => updateClass(title, id),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: selectedClassId == id ? Colors.pink.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.replaceAll("Premium", "Premium "),
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            Radio<String>(
              value: title,
              groupValue: selectedClass,
              onChanged: (value) => updateClass(value!, id),
              activeColor: Color(0xFF00ADEE),
            )
          ],
        ),
      ),
    );
  }
}
