import 'package:flutter/material.dart';

class HotelFilterPage extends StatefulWidget {
  final add;
  final String searchText;
 // final Map<String, bool> selectedStarRatings;
  final bool isSelected0To3000;
  final bool isSelected3000To5000;
  final bool isSelected5000To7500;
  final bool isSelected7500To9500;
  final bool isSelected9500To15000;
  final bool isSelected15000To30000;
  final bool isSelected30000Plus;
  final List<int> selectedStarRatings;


  const   HotelFilterPage({
    super.key,
    required this.add,
    required this.searchText,
    required this.selectedStarRatings,
    required this.isSelected0To3000,
    required this.isSelected3000To5000,
    required this.isSelected5000To7500,
    required this.isSelected7500To9500,
    required this.isSelected9500To15000,
    required this.isSelected15000To30000,
    required this.isSelected30000Plus,
    //required this.selectedCount,
  });

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<HotelFilterPage> {
// Switch and Checkbox states

  int selectedCount = 0;
  int c=0;
  String selectedStarRating = '';
  bool isSelected0To3000 = false;
  bool isSelected3000To5000 = false;
  bool isSelected5000To7500 = false;
  bool isSelected7500To9500 = false;
  bool isSelected9500To15000 = false;
  bool isSelected15000To30000 = false;
  bool isSelected30000Plus = false;
  bool isZeroStarSelected = false;
  bool isOneStarSelected = false;
  bool isTwoStarSelected = false;
  bool isThreeStarSelected = false;
  bool isFourStarSelected = false;
  bool isFiveStarSelected = false;




@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.text = widget.searchText;
    isZeroStarSelected = widget.selectedStarRatings.contains(0);
    isOneStarSelected = widget.selectedStarRatings.contains(1);
    isTwoStarSelected = widget.selectedStarRatings.contains(2);
    isThreeStarSelected = widget.selectedStarRatings.contains(3);
    isFourStarSelected = widget.selectedStarRatings.contains(4);
    isFiveStarSelected = widget.selectedStarRatings.contains(5);
    isSelected0To3000 = widget.isSelected0To3000;
    isSelected3000To5000 = widget.isSelected3000To5000;
    isSelected5000To7500 = widget.isSelected5000To7500;
    isSelected7500To9500 = widget.isSelected7500To9500;
    isSelected9500To15000 = widget.isSelected9500To15000;
    isSelected15000To30000 = widget.isSelected15000To30000;
    isSelected30000Plus = widget.isSelected30000Plus;
   // selectedCount = widget.selectedCount;


  }

  TextEditingController _searchController = TextEditingController();
  void _updateSelectedCount() {
    int starCount = 0;
    if (isZeroStarSelected == true) {
      starCount = 1;
    }
    else
    {
      starCount=0;
    }
    if (isOneStarSelected == true) {
      starCount = 1;
    }
    if (isTwoStarSelected == true) {
      starCount = 1;
    }
    if (isThreeStarSelected == true) {
      starCount = 1;
    }
    if (isFourStarSelected == true) {
      starCount = 1;
    }
    if (isFiveStarSelected == true) {
      starCount = 1;
    }


    int priceRangeCount = 0;

    if (isSelected0To3000==true) {
      priceRangeCount = 1; // Count if Early is selected
    }
    else
    {
      priceRangeCount=0;
    }
    if (isSelected3000To5000==true) {
      priceRangeCount = 1; // Count if Morning is selected
    }

    if (isSelected5000To7500==true) {
      priceRangeCount = 1; // Count if Noon is selected
    }

    if (isSelected7500To9500==true) {
      priceRangeCount = 1; // Count if Evening is selected
    }

    if (isSelected9500To15000==true) {
      priceRangeCount = 1; // Count if Evening is selected
    }
    if (isSelected15000To30000==true) {
      priceRangeCount = 1; // Count if Evening is selected
    }
    if (isSelected30000Plus==true) {
      priceRangeCount = 1; // Count if Evening is selected
    }
// Total count of all selections
    c =    starCount  + priceRangeCount;


    print('Total selected options: $c');
  }

  List<int> getSelectedStarRatings(Map<String, bool> starRatings) {
    List<int> selectedRatings = [];

    starRatings.forEach((key, value) {
      if (value) {  // If the checkbox is selected
        selectedRatings.add(int.parse(key)); // Add the key (star rating) as an integer
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
              SizedBox(width: 1),
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
          backgroundColor: Color(0xFF152238),
        ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 10,left: 10,top: 10),
                child:  Column(crossAxisAlignment: CrossAxisAlignment.start,
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

            

            
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Star Rating",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List.generate(5, (index) => Icon(Icons.star_border)), // 0 stars (all borders)
                          ),
                          Checkbox(
                            value: isZeroStarSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                isZeroStarSelected = value!;
                                _updateSelectedCount();
                              });
                            },
                          ),
                        ],
                      ),
            
                      // Row for 1 Star selected with a checkbox on the right
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),  // 1 star selected
                              ...List.generate(4, (index) => Icon(Icons.star_border)),
                            ],
                          ),
                          Checkbox(
                            value: isOneStarSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                isOneStarSelected = value!;
                                _updateSelectedCount();
                              });
                            },
                          ),
                        ],
                      ),
            
                      // Row for 2 Stars selected with a checkbox on the right
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ...List.generate(2, (index) => Icon(Icons.star, color: Colors.amber)),  // 2 stars selected
                              ...List.generate(3, (index) => Icon(Icons.star_border)),
                            ],
                          ),
                          Checkbox(
                            value: isTwoStarSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                isTwoStarSelected = value!;
                                _updateSelectedCount();
                              });
                            },
                          ),
                        ],
                      ),
            
                      // Row for 3 Stars selected with a checkbox on the right
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ...List.generate(3, (index) => Icon(Icons.star, color: Colors.amber)),  // 3 stars selected
                              ...List.generate(2, (index) => Icon(Icons.star_border)),
                            ],
                          ),
                          Checkbox(
                            value: isThreeStarSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                isThreeStarSelected = value!;
                                _updateSelectedCount();
                              });
                            },
                          ),
                        ],
                      ),
            
                      // Row for 4 Stars selected with a checkbox on the right
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ...List.generate(4, (index) => Icon(Icons.star, color: Colors.amber)),  // 4 stars selected
                              Icon(Icons.star_border),
                            ],
                          ),
                          Checkbox(
                            value: isFourStarSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                isFourStarSelected = value!;
                                _updateSelectedCount();
                              });
                            },
                          ),
                        ],
                      ),
            
                      // Row for 5 Stars selected with a checkbox on the right
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List.generate(5, (index) => Icon(Icons.star, color: Colors.amber)),  // 5 stars selected
                          ),
                          Checkbox(
                            value: isFiveStarSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                isFiveStarSelected = value!;
                                _updateSelectedCount();
                              });
                            },
                          ),
                        ],
                      ),
            
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Price",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
            
                      // 0 - 3000 price range with checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("0 - 3000"),
                          Checkbox(
                            value: isSelected0To3000,  // Checkbox state
                            onChanged: (bool? value) {
                              setState(() {
                                isSelected0To3000 = value!;
                                _updateSelectedCount();
                              });
                            },
                          ),
                        ],
                      ),
            
                      // 3000 - 5000 price range with checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("3000 - 5000"),
                          Checkbox(
                            value: isSelected3000To5000,  // Checkbox state
                            onChanged: (bool? value) {
                              setState(() {
                                isSelected3000To5000 = value!;
                                _updateSelectedCount();
                              });
                            },
                          ),
                        ],
                      ),
            
                      // 5000 - 7500 price range with checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("5000 - 7500"),
                          Checkbox(
                            value: isSelected5000To7500,  // Checkbox state
                            onChanged: (bool? value) {
                              setState(() {
                                isSelected5000To7500 = value!;
                                _updateSelectedCount();
                              });
                            },
                          ),
                        ],
                      ),
            
                      // 7500 - 9500 price range with checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("7500 - 9500"),
                          Checkbox(
                            value: isSelected7500To9500,  // Checkbox state
                            onChanged: (bool? value) {
                              setState(() {
                                isSelected7500To9500 = value!;
                                _updateSelectedCount();
                              });
                            },
                          ),
                        ],
                      ),
            
                      // 9500 - 15000 price range with checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("9500 - 15000"),
                          Checkbox(
                            value: isSelected9500To15000,  // Checkbox state
                            onChanged: (bool? value) {
                              setState(() {
                                isSelected9500To15000 = value!;
                                 _updateSelectedCount();
                              });
                            },
                          ),
                        ],
                      ),
            
                      // 15000 - 30000 price range with checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("15000 - 30000"),
                          Checkbox(
                            value: isSelected15000To30000,  // Checkbox state
                            onChanged: (bool? value) {
                              setState(() {
                                isSelected15000To30000 = value!;
                                _updateSelectedCount();
                              });
                            },
                          ),
                        ],
                      ),
            
                      // 30000+ price range with checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("30000+"),
                          Checkbox(
                            value: isSelected30000Plus,  // Checkbox state
                            onChanged: (bool? value) {
                              setState(() {
                                isSelected30000Plus = value!;
                                _updateSelectedCount();
                              });
                            },
                          ),
                        ],
                      ),
            
                      SizedBox(height: 20),
                    
            
            
                     /* Text('Total selected filters: $c'),*/
            
            
                ]),
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

                              // Creating the selectedStarRatings map
                              Map<String, bool> selectedStarRatings = {
                                '0': isZeroStarSelected,
                                '1': isOneStarSelected,
                                '2': isTwoStarSelected,
                                '3': isThreeStarSelected,
                                '4': isFourStarSelected,
                                '5': isFiveStarSelected,
                              };

                              List<int> getSelectedStarRatings(Map<String, bool> starRatings) {
                                List<int> selectedRatings = [];
                                starRatings.forEach((key, value) {
                                  if (value) { // If the checkbox is selected
                                    selectedRatings.add(int.parse(key)); // Add the key (star rating) as an integer
                                  }
                                });
                                return selectedRatings;
                              }


                              // Pop this page and send data back to the previous page
                              Navigator.pop(context, {
                                'searchText': searchText,
                                'selectedStarRatings': getSelectedStarRatings(selectedStarRatings), // Sending the star ratings map
                                '0To3000': isSelected0To3000,
                                '3000To5000': isSelected3000To5000,
                                '5000To7500': isSelected5000To7500,
                                '7500To9500': isSelected7500To9500,
                                '9500To15000': isSelected9500To15000,
                                '15000To30000': isSelected15000To30000,
                                '30000Plus': isSelected30000Plus,
                                'selectedCount': c,
                              });

                              print("searchText: $searchText");
                              print("selectedStarRatings: ${getSelectedStarRatings(selectedStarRatings)}");
                              print("Price Range 0 to 3000: $isSelected0To3000");
                              print("Price Range 3000 to 5000: $isSelected3000To5000");
                              print("Price Range 5000 to 7500: $isSelected5000To7500");
                              print("Price Range 7500 to 9500: $isSelected7500To9500");
                              print("Price Range 9500 to 15000: $isSelected9500To15000");
                              print("Price Range 15000 to 30000: $isSelected15000To30000");
                              print("Price Range 30000+: $isSelected30000Plus");
                              print("selectedCount: $c");
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
      ));
  }
}
