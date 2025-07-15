import 'package:flutter/material.dart';

class Holidayfilterpage extends StatefulWidget {
  final add;
  final String searchText;
 final bool  isTourGuideIncluded;
 final bool isNotAllowed;
  // final Map<String, bool> selectedStarRatings;
  final bool isSelected0To3000;
  final bool isSelected3000To5000;
  final bool isSelected5000To7500;
  final bool isSelected7500To9500;
  final bool isSelected9500To15000;
  final bool isSelected15000To30000;
  final bool isSelected30000Plus;

  const Holidayfilterpage({
    super.key,
    required this.add,
    required this.searchText,
    required this.isTourGuideIncluded,
    required this.isNotAllowed,
     required this.isSelected0To3000,
    required this.isSelected3000To5000,
    required this.isSelected5000To7500,
    required this.isSelected7500To9500,
    required this.isSelected9500To15000,
    required this.isSelected15000To30000,
    required this.isSelected30000Plus,

  });

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<Holidayfilterpage> {
// Switch and Checkbox states

  int selectedCount = 0;
  int c = 0;
  String selectedStarRating = '';
  bool isSelected0To3000 = false;
  bool isSelected3000To5000 = false;
  bool isSelected5000To7500 = false;
  bool isSelected7500To9500 = false;
  bool isSelected9500To15000 = false;
  bool isSelected15000To30000 = false;
  bool isSelected30000Plus = false;
  bool isTourGuideIncluded = false; // New state for "Tour Guide Included"
  bool isNotAllowed = false; // New state for "Not Allowed"

  TextEditingController _searchController = TextEditingController();

  void _updateSelectedCount() {


    int additionalCount = 0;
    int priceRangeCount = 0;
    if (isSelected0To3000 == true) priceRangeCount = 1;
    if (isSelected3000To5000 == true) priceRangeCount = 1;
    if (isSelected5000To7500 == true) priceRangeCount = 1;
    if (isSelected7500To9500 == true) priceRangeCount = 1;
    if (isSelected9500To15000 == true) priceRangeCount = 1;
    if (isSelected15000To30000 == true) priceRangeCount = 1;
    if (isSelected30000Plus == true) priceRangeCount = 1;

    if (isTourGuideIncluded==true) additionalCount=1; // Increment if Tour Guide is included
    if (isNotAllowed==true) additionalCount=1;
    c =   priceRangeCount+additionalCount;

    print('Total selected options: $c');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.text = widget.searchText;
    isTourGuideIncluded = widget.isTourGuideIncluded;
    isNotAllowed = widget.isNotAllowed;
     isSelected0To3000 = widget.isSelected0To3000;
    isSelected3000To5000 = widget.isSelected3000To5000;
    isSelected5000To7500 = widget.isSelected5000To7500;
    isSelected7500To9500 = widget.isSelected7500To9500;
    isSelected9500To15000 = widget.isSelected9500To15000;
    isSelected15000To30000 = widget.isSelected15000To30000;
    isSelected30000Plus = widget.isSelected30000Plus;
    // selectedCount = widget.selectedCount;


  }
  List<int> getSelectedStarRatings(Map<String, bool> starRatings) {
    List<int> selectedRatings = [];
    starRatings.forEach((key, value) {
      if (value) {
        selectedRatings.add(int.parse(key));
      }
    });
    return selectedRatings;
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
              "Filter",
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 10,left: 10,top: 10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Box
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(width:double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),  // Rounded corners
                          border: Border.all(color: Colors.grey),   // Border with color
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left:10),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: "Search hotel name...",
                              border: InputBorder.none,  // No border inside
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildPriceFilterSection(),
                    Divider(),
                    _buildGuidingOptionSection(),


                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Container(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade200, // Light grey color for the starting horizontal line
                      width: 1, // Thickness of the line
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              String searchText = _searchController.text.trim();

                              Navigator.pop(context, {
                                'searchText': searchText,

                                '0To3000': isSelected0To3000,
                                '3000To5000': isSelected3000To5000,
                                '5000To7500': isSelected5000To7500,
                                '7500To9500': isSelected7500To9500,
                                '9500To15000': isSelected9500To15000,
                                '15000To30000': isSelected15000To30000,
                                '30000Plus': isSelected30000Plus,
                                'selectedCount': c,
                                'isTourGuideIncluded': isTourGuideIncluded,
                                'isNotAllowed': isNotAllowed,
                              });
                            },
                            child: Center(child: Text('Save',style: TextStyle(fontSize: 17),)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange, // Set button background color to orange
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30), // Set button border radius
                              ),
                              minimumSize: Size(double.infinity, 50), // Full width and height
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildPriceFilterSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Price",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        _buildPriceCheckbox("0 - 3000", isSelected0To3000, (value) {
          setState(() {
            isSelected0To3000 = value!;
            _updateSelectedCount();
          });
        }),
        _buildPriceCheckbox("3000 - 5000", isSelected3000To5000, (value) {
          setState(() {
            isSelected3000To5000 = value!;
            _updateSelectedCount();
          });
        }),
        _buildPriceCheckbox("5000 - 7500", isSelected5000To7500, (value) {
          setState(() {
            isSelected5000To7500 = value!;
            _updateSelectedCount();
          });
        }),
        _buildPriceCheckbox("7500 - 9500", isSelected7500To9500, (value) {
          setState(() {
            isSelected7500To9500 = value!;
            _updateSelectedCount();
          });
        }),
        _buildPriceCheckbox("9500 - 15000", isSelected9500To15000, (value) {
          setState(() {
            isSelected9500To15000 = value!;
            _updateSelectedCount();
          });
        }),
        _buildPriceCheckbox("15000 - 30000", isSelected15000To30000, (value) {
          setState(() {
            isSelected15000To30000 = value!;
            _updateSelectedCount();
          });
        }),
        _buildPriceCheckbox("30000+", isSelected30000Plus, (value) {
          setState(() {
            isSelected30000Plus = value!;
            _updateSelectedCount();
          });
        }),
      ],
    );
  }

  Widget _buildGuidingOptionSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Guiding Option",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        _buildOptionCheckbox("Tour Guide Included", isTourGuideIncluded,
                (value) {
              setState(() {
                isTourGuideIncluded = value!;
                _updateSelectedCount();
              });
            }),
        _buildOptionCheckbox("Not Allowed", isNotAllowed, (value) {
          setState(() {
            isNotAllowed = value!;
            _updateSelectedCount();
          });
        }),
      ],
    );
  }

  Widget _buildPriceCheckbox(
      String title, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Checkbox(value: value, onChanged: onChanged),
      ],
    );
  }

  Widget _buildOptionCheckbox(
      String title, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Checkbox(value: value, onChanged: onChanged),
      ],
    );
  }
}
