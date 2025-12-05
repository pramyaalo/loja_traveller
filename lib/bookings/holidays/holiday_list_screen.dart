import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as developer;
import 'package:xml/xml.dart' as xml;

import '../../HolidayFilterPage.dart';
import '../../utils/shared_preferences.dart';
import 'holiday_detail_screen.dart';

class HolidayListScreen extends StatefulWidget {
  final checkinDate,
      RoomCount,
      AdultCountRoom1,
      ChildrenCountRoom1,
      AdultCountRoom2,
      ChildrenCountRoom2,
      AdultCountRoom3,
      ChildrenCountRoom3,
      AdultCountRoom4,
      ChildrenCountRoom4,
      Locationid;
  const HolidayListScreen(
      {super.key,
      required this.checkinDate,
      required this.RoomCount,
      required this.AdultCountRoom1,
      required this.ChildrenCountRoom1,
      required this.AdultCountRoom2,
      required this.ChildrenCountRoom2,
      required this.AdultCountRoom3,
      required this.ChildrenCountRoom3,
      required this.AdultCountRoom4,
      required this.ChildrenCountRoom4,
      required this.Locationid});

  @override
  State<HolidayListScreen> createState() => _HolidayListNewState();
}

class _HolidayListNewState extends State<HolidayListScreen> {
  bool isLoading = false;
  bool isZeroStarSelected = false;
  bool isOneStarSelected = false;
  bool isTwoStarSelected = false;
  bool isThreeStarSelected = false;
  bool isNotAllowed = false;
  bool isFourStarSelected = false;
  bool isFiveStarSelected = false;
  List<dynamic> fullResultList = [];
  var holidayList = [];
  String? selectedSortOption = "Low to High";
  String featuresInclusion = '';
  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';
  bool isSelected0To3000 = false;
  bool isSelected3000To5000 = false;
  bool isTourGuideIncluded = false;

  bool isSelected5000To7500 = false;
  bool isSelected7500To9500 = false;
  bool isSelected9500To15000 = false;
  bool isSelected15000To30000 = false;
  bool isSelected30000Plus = false;
  String searchText='';
  bool _isBottomBarVisible = true;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _retrieveSavedValues();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isBottomBarVisible) {
          setState(() {
            _isBottomBarVisible = false;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // User is scrolling up, show the bottom bar
        if (!_isBottomBarVisible) {
          setState(() {
            _isBottomBarVisible = true;
          });
        }
      }
    });
  }

  void _applyPriceFilter(List<dynamic> results, Map<String, dynamic> filters) {
    // Check if no price range filter is selected
    bool noPriceFilterSelected = !filters['isSelected0To3000'] &&
        !filters['isSelected3000To5000'] &&
        !filters['isSelected5000To7500'] &&
        !filters['isSelected7500To9500'] &&
        !filters['isSelected9500To15000'] &&
        !filters['isSelected15000To30000'] &&
        !filters['isSelected30000Plus'];

    // If no filters are selected, return all hotels
    if (noPriceFilterSelected) {
      setState(() {
        holidayList = results; // Display all hotels
      });
      return; // Exit the function early
    }

    // Filter hotels based on selected price ranges
    List<dynamic> filteredHotels = results.where((hotel) {
      // Create a variable to store if the hotel matches any selected price range
      bool matchesPriceRange = false;

      // Convert TotalPrice to double, default to 0.0 if parsing fails
      double totalPrice = double.tryParse(hotel['amount'].toString()) ?? 0.0;

      // Check for each price range if it matches the hotel price using filters
      if (filters['isSelected0To3000'] && totalPrice >= 0 && totalPrice <= 3000) {
        matchesPriceRange = true;
      }
      if (filters['isSelected3000To5000'] && totalPrice > 3000 && totalPrice <= 5000) {
        matchesPriceRange = true;
      }
      if (filters['isSelected5000To7500'] && totalPrice > 5000 && totalPrice <= 7500) {
        matchesPriceRange = true;
      }
      if (filters['isSelected7500To9500'] && totalPrice > 7500 && totalPrice <= 9500) {
        matchesPriceRange = true;
      }
      if (filters['isSelected9500To15000'] && totalPrice > 9500 && totalPrice <= 15000) {
        matchesPriceRange = true;
      }
      if (filters['isSelected15000To30000'] && totalPrice > 15000 && totalPrice <= 30000) {
        matchesPriceRange = true;
      }
      if (filters['isSelected30000Plus'] && totalPrice > 30000) {
        matchesPriceRange = true;
      }

      return matchesPriceRange;
    }).toList();

    // Update the hotel list displayed in your UI
    setState(() {
      holidayList = filteredHotels; // Update the displayed hotels
    });
  }

  void _showGuidingOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Select Guiding Options",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
Divider(),

                  _buildOptionCheckbox("Tour Guide Included", isTourGuideIncluded, (value) {
                    setState(() {
                      isTourGuideIncluded = value!; // Update the state here
                    });
                  }),
                  _buildOptionCheckbox("Not Included", isNotAllowed, (value) {
                    setState(() {
                      isNotAllowed = value!; // Update the state here
                    });
                  }),
                Divider(),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Map<String, bool> filters = {
                          'isGuidingAllowed': isTourGuideIncluded,
                          'isGuidingNotAllowed': isNotAllowed,
                        };

                        _applyGuidingOptions(fullResultList, filters);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Show Tours',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          },
        );
      },
    );
  }


  int selectedCount = 0; // Declare a variable to hold the total count of selected options



  Widget _buildOptionCheckbox(
      String title, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildCheckbox(String title, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
  void _showPriceFilterBottomSheet(BuildContext context) {
    // Create a local copy of the checkbox states
    bool localSelected0To3000 = isSelected0To3000;
    bool localSelected3000To5000 = isSelected3000To5000;
    bool localSelected5000To7500 = isSelected5000To7500;
    bool localSelected7500To9500 = isSelected7500To9500;
    bool localSelected9500To15000 = isSelected9500To15000;
    bool localSelected15000To30000 = isSelected15000To30000;
    bool localSelected30000Plus = isSelected30000Plus;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow for scrolling when necessary
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setLocalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60),
                          child:   Text(
                            "Price Range",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
Divider(),
                    SizedBox(height: 5),
                    _buildCheckbox("0 - 3000", localSelected0To3000, (value) {
                      setLocalState(() {
                        localSelected0To3000 = value!;
                      });
                    }),
                    _buildCheckbox("3000 - 5000", localSelected3000To5000, (value) {
                      setLocalState(() {
                        localSelected3000To5000 = value!;
                      });
                    }),
                    _buildCheckbox("5000 - 7500", localSelected5000To7500, (value) {
                      setLocalState(() {
                        localSelected5000To7500 = value!;
                      });
                    }),
                    _buildCheckbox("7500 - 9500", localSelected7500To9500, (value) {
                      setLocalState(() {
                        localSelected7500To9500 = value!;
                      });
                    }),
                    _buildCheckbox("9500 - 15000", localSelected9500To15000, (value) {
                      setLocalState(() {
                        localSelected9500To15000 = value!;
                      });
                    }),
                    _buildCheckbox("15000 - 30000", localSelected15000To30000, (value) {
                      setLocalState(() {
                        localSelected15000To30000 = value!;
                      });
                    }),
                    _buildCheckbox("30000+", localSelected30000Plus, (value) {
                      setLocalState(() {
                        localSelected30000Plus = value!;
                      });
                    }),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: ()  {
                          // Update the main state with the local selections
                          setState(() {
                            isSelected0To3000 = localSelected0To3000;
                            isSelected3000To5000 = localSelected3000To5000;
                            isSelected5000To7500 = localSelected5000To7500;
                            isSelected7500To9500 = localSelected7500To9500;
                            isSelected9500To15000 = localSelected9500To15000;
                            isSelected15000To30000 = localSelected15000To30000;
                            isSelected30000Plus = localSelected30000Plus;
                          });
                          Map<String, dynamic> filters = {
                            'isSelected0To3000': isSelected0To3000,
                            'isSelected3000To5000': isSelected3000To5000,
                            'isSelected5000To7500': isSelected5000To7500,
                            'isSelected7500To9500': isSelected7500To9500,
                            'isSelected9500To15000': isSelected9500To15000,
                            'isSelected15000To30000': isSelected15000To30000,
                            'isSelected30000Plus': isSelected30000Plus,
                          };
                          _applyPriceFilter(fullResultList, filters);
                          Navigator.of(context).pop(); // Close the bottom sheet
                          // Call your filtering logic here
                        },
                        child: Text(
                          'Show Hotels',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Close Button
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context); // Close the bottom sheet
                        },
                      ),

                          Padding(
                            padding: const EdgeInsets.only(left: 80),
                            child: Text(
                              "Sort",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                    ],
                  ),
                  Divider(color: Colors.grey.shade400),

                  // Sort options
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Low to High
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSortOption = "Low to High";
                            print("Selected: Low to High");
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Minimize space
                          children: [
                            Radio<String>(
                              value: "Low to High",
                              groupValue: selectedSortOption,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedSortOption = value;
                                  print("Selected: Low to High");
                                });
                              },
                            ),
                            Text("Low to High"),
                          ],
                        ),
                      ),

                      // High to Low
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSortOption = "High to Low";
                            print("Selected: High to Low");
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Minimize space
                          children: [
                            Radio<String>(
                              value: "High to Low",
                              groupValue: selectedSortOption,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedSortOption = value;
                                  print("Selected: High to Low");
                                });
                              },
                            ),
                            Text("High to Low"),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Display Results Button
                  SizedBox(height: 16), // Spacing before the button
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (selectedSortOption != null) {
                          // Call the _applySort function with the fullResultList and the selected sort option
                          _applySort(fullResultList, selectedSortOption!); // Use the non-null assertion operator
                        } else {
                          print("No sorting option selected.");
                        }
                        Navigator.pop(context);
                        print("Show Hotels pressed.");
                      },
                      child: Text(
                        'Show Hotels',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _applySort(List<dynamic> results, String sortOrder) {
    // Ensure sorting works correctly
    if (sortOrder == "Low to High") {
       results.sort((a, b) => _parsePrice(a['amount']).compareTo(_parsePrice(b['amount'])));
      print("Sorting: Low to High");
    } else if (sortOrder == "High to Low") {
      // Sort in descending order (high price to low price)
      results.sort((a, b) => _parsePrice(b['amount']).compareTo(_parsePrice(a['amount'])));
      print("Sorting: High to Low");
    }

    // After sorting, update the result list
    setState(() {
      holidayList = results; // Update with sorted results
    });

    print('Sorted hotels: $results');
  }
  double _parsePrice(dynamic price) {
    if (price is String) {
      return double.tryParse(price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
    } else if (price is num) {
      return price.toDouble();
    } else {
      return 0.0; // Fallback if it's neither string nor number
    }
  }

  void _applyGuidingOptions(List<dynamic> results, Map<String, bool> filters) {
    print('Displaying all tours: $results');

    List<dynamic> filteredResults = results.where((tour) {
      String guidingOption = tour['guidingOptions'];

      // If both filters are unchecked, return all results
      if (filters['isGuidingAllowed'] == false && filters['isGuidingNotAllowed'] == false) {
        return true; // Return all tours
      }

      // Check if the tour matches the selected guiding option filters
      bool matchesGuidingAllowed = (filters['isGuidingAllowed'] == true && guidingOption == 'Tour Guide Included');
      bool matchesGuidingNotAllowed = (filters['isGuidingNotAllowed'] == true && guidingOption == 'Tour Guide Not Included');

      // Return true if the tour matches either of the guiding option filters
      return matchesGuidingAllowed || matchesGuidingNotAllowed;
    }).toList();

    setState(() {
      this.holidayList = filteredResults; // Update the result list with filtered results
    });

    print('Filtered tours by guiding option: $filteredResults');
  }




  Widget _buildStarRow(int starCount, StateSetter setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: List.generate(
              starCount, (index) => Icon(Icons.star, color: Colors.amber)) +
              List.generate(5 - starCount, (index) => Icon(Icons.star_border)),
        ),
        Checkbox(
          value: _getCheckboxValue(starCount),
          onChanged: (bool? value) {
            setState(() {
              _setCheckboxValue(starCount, value!);
            });
          },
        ),
      ],
    );
  }

  bool _getCheckboxValue(int starCount) {
    switch (starCount) {
      case 0:
        return isZeroStarSelected;
      case 1:
        return isOneStarSelected;
      case 2:
        return isTwoStarSelected;
      case 3:
        return isThreeStarSelected;
      case 4:
        return isFourStarSelected;
      case 5:
        return isFiveStarSelected;
      default:
        return false;
    }
  }

  void _setCheckboxValue(int starCount, bool value) {
    switch (starCount) {
      case 0:
        isZeroStarSelected = value;
        break;
      case 1:
        isOneStarSelected = value;
        break;
      case 2:
        isTwoStarSelected = value;
        break;
      case 3:
        isThreeStarSelected = value;
        break;
      case 4:
        isFourStarSelected = value;
        break;
      case 5:
        isFiveStarSelected = value;
        break;
    }
  }

  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
      print('Currency: $Currency');
      Map<String, dynamic> filters = {
        'searchText': 'searchedHotel',
        'selectedStarRating': 'selectedStarRating',
        '0To3000': 'selected0To3000',
        '3000To5000': 'selected3000To5000',
        '5000To7500': 'selected5000To7500',
        '7500To9500': 'selected7500To9500',
        '9500To15000': 'selected9500To15000',
        '15000To30000': 'selected15000To30000',
        '30000Plus': 'selected30000Plus',
      };      fetchTourList(filters);
    });
  }

  List<Map<String, dynamic>> extractJsonFromXml(String xmlString) {
    // Parse the XML string
    var document = xml.XmlDocument.parse(xmlString);

    // Extract the JSON string from the XML string
    String jsonString = document.findAllElements('string').first.text;

    // Decode the JSON string into a list of maps
    List<Map<String, dynamic>> jsonList =
        json.decode(jsonString).cast<Map<String, dynamic>>();

    return jsonList;
  }

  void navigate(Widget screen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  Future<void> fetchTourList(Map<String, dynamic> filters) async {
    String fin_date =
        widget.checkinDate.toString().split(' ')[0].replaceAll('/', '-');
    print('fin_date' + fin_date);
    final url =
        Uri.parse('https://traveldemo.org/travelapp/b2capi.asmx/TourGetList');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = {
      'DestinationName': widget.Locationid,
      'FromDate': fin_date,
      'ToDate': fin_date,
      'AdultCount': widget.AdultCountRoom1.toString(),
      'ChildCount': widget.ChildrenCountRoom1.toString(),
      'DefaultCurrency': 'KES',
      'UserId': userID.toString(),
    };
    print('Destination Name: ${widget.Locationid.toString()}');
    print('From Date: ${fin_date.toString()}');
    print('To Date: $fin_date');
    print('Adult Count: ${widget.AdultCountRoom1.toString()}');
    print('Child Count: ${widget.ChildrenCountRoom1.toString()}');
    print('Default Currency: ${Currency.toString()}');
    print('User ID: ${userID.toString()}');
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Request successful, handle the response data
        //print('Response: ${response.body}');
        setState(() {
          holidayList = extractJsonFromXml(response.body).toList();
          featuresInclusion = holidayList[0]['featuresInclusion'].toString();
          print('featuresInchjtlusion' + featuresInclusion);
          print('holidayList length: ');
          print(holidayList.length);
          fullResultList =
              holidayList;
          _applyHotelFiltersToResult(holidayList, filters);
        });
      } else {
        // Request failed, handle the failure scenario
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions or errors that occurred during the request
      print('Error sending request: $error');
    }

    setState(() {
      isLoading = false;
    });
  }
  //name
  void _applyHotelFiltersToResult(
      List<dynamic> hotelResult, Map<String, dynamic> filters) {
    List<dynamic> filteredResults = [];

    // Extract filter values
      isSelected0To3000 = filters['0To3000'] ?? false;
      isSelected3000To5000 = filters['3000To5000'] ?? false;
      isSelected5000To7500 = filters['5000To7500'] ?? false;
      isSelected7500To9500 = filters['7500To9500'] ?? false;
      isSelected9500To15000 = filters['9500To15000'] ?? false;
      isSelected15000To30000 = filters['15000To30000'] ?? false;
      isSelected30000Plus = filters['30000Plus'] ?? false;

      searchText = filters['searchText'] ?? "";
      isTourGuideIncluded = filters['isTourGuideIncluded'] ?? false;
      isNotAllowed = filters['isNotAllowed'] ?? false;

    // Check if any filters are selected
    bool anyFilterSelected = isSelected0To3000 ||
        isSelected3000To5000 ||
        isSelected5000To7500 ||
        isSelected7500To9500 ||
        isSelected9500To15000 ||
        isSelected15000To30000 ||
        isSelected30000Plus ||
        searchText.isNotEmpty ||
        isTourGuideIncluded ||  // Check if the "Tour Guide Included" filter is applied
        isNotAllowed;  // Check if the "Not Allowed" filter is applied

    if (!anyFilterSelected) {
      filteredResults = List.from(hotelResult);
    } else {
      // Filter hotels based on selected price ranges, guiding options, and search text
      for (var hotel in hotelResult) {
        String guidingOption = hotel['guidingOptions'] ?? "";  // Assuming hotel has a guidingOption field
        double hotelPrice = double.tryParse(hotel['amount'].toString()) ?? 0.0;
        String hotelName = hotel['name'] ?? "";

        // Check if the hotel is in any of the selected price ranges
        bool isInSelectedPriceRange = false;
        if (isSelected0To3000 && hotelPrice >= 0 && hotelPrice <= 3000) {
          isInSelectedPriceRange = true;
        }
        if (isSelected3000To5000 && hotelPrice > 3000 && hotelPrice <= 5000) {
          isInSelectedPriceRange = true;
        }
        if (isSelected5000To7500 && hotelPrice > 5000 && hotelPrice <= 7500) {
          isInSelectedPriceRange = true;
        }
        if (isSelected7500To9500 && hotelPrice > 7500 && hotelPrice <= 9500) {
          isInSelectedPriceRange = true;
        }
        if (isSelected9500To15000 && hotelPrice > 9500 && hotelPrice <= 15000) {
          isInSelectedPriceRange = true;
        }
        if (isSelected15000To30000 && hotelPrice > 15000 && hotelPrice <= 30000) {
          isInSelectedPriceRange = true;
        }
        if (isSelected30000Plus && hotelPrice > 30000) {
          isInSelectedPriceRange = true;
        }

        // Apply guiding option filters
        bool matchesGuidingOption = false;
        if (isTourGuideIncluded && guidingOption == "Tour Guide Included") {
          matchesGuidingOption = true;
        }
        if (isNotAllowed && guidingOption == "Not Allowed") {
          matchesGuidingOption = true;
        }

        // Determine whether to add the hotel to the filtered results
        bool shouldAddHotel = false;
        int selectedCount = filters['selectedCount'] ?? 0;

        if (selectedCount == 0) {
          // Apply search filter only
          if (searchText.isNotEmpty &&
              hotelName.toLowerCase().contains(searchText.toLowerCase())) {
            shouldAddHotel = true;
          }
        } else if (selectedCount == 1) {
          // Apply price range or guiding option filter
          if (isInSelectedPriceRange || matchesGuidingOption) {
            shouldAddHotel = true;
          }
        } else if (selectedCount == 2) {
          // Apply both price range and guiding option filter
          if (isInSelectedPriceRange && matchesGuidingOption) {
            shouldAddHotel = true;
          }
        }

        if (shouldAddHotel) {
          filteredResults.add(hotel);
        }
      }
    }

    // Update the state with the filtered results
    setState(() {
      this.holidayList = filteredResults; // Update your hotel results
    });
  }

  List<Widget> createIconsForWords(String features) {
    List<String> words = features.split("||");
    List<Widget> icons = [];
    for (String word in words) {
      icons.add(Row(
        children: [
          Icon(Icons.check),
          Container(
              width: 148,
              child: Text(
                word,
                style: TextStyle(color: Colors.green),
              )),
        ],
      ));
    }
    return icons;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> iconsForFeaturesInclusion =
        createIconsForWords(featuresInclusion);
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
                "Available Tours",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Montserrat",
                    fontSize: 18),
              ),
            ],
          ),
          actions: [
            Image.asset(
              'assets/images/lojolog.png',
              width: 100,
              height: 50,
            ),

          ],
          backgroundColor:Color(0xFF00ADEE),
        ),
        body: isLoading
            ? ListView.builder(
                itemCount: 10, // Number of skeleton items
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListTile(
                      leading: Container(
                        width: 64.0,
                        height: 64.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 16.0,
                            margin: EdgeInsets.symmetric(vertical: 4.0),
                            color: Colors.white,
                          ),
                          Container(
                            width: double.infinity,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(vertical: 4.0),
                            color: Colors.white,
                          ),
                          Container(
                            width: double.infinity,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(vertical: 4.0),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                          itemCount: holidayList.length,
                          itemBuilder: (context, index) {
                            //return Text(snapshot.data?[index].LabelName ?? "got null");
                            return InkWell(
                              child: Container(
                                margin: const EdgeInsets.only(right: 5,left:5 ,top: 5),
                                child: Material(
                                  elevation: 10,
                                  child: Container(
                                    padding: const EdgeInsets.only(right: 10,left: 10,bottom: 5,top: 5),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: const Color(0xFFFAE8FA),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: const Color(0xFF870987),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.local_offer,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                    Text(
                                                      (holidayList[index]
                                                              ['durationvalue'] +
                                                          holidayList[index]
                                                              ['durationmetric']),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 10),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Duration',
                                                style: TextStyle(
                                                    color: Colors.black, fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 110,
                                                height: 120,
                                                child: CachedNetworkImage(
                                                  imageUrl: holidayList[index]['imgUrl'],
                                                  placeholder: (context, url) => const Center(
                                                      child: SizedBox(
                                                          height: 30,
                                                          width: 35,
                                                          child:
                                                              CircularProgressIndicator())),
                                                  errorWidget: (context, url, error) =>
                                                      const Icon(Icons.error),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              /*Image(
                                                //image: AssetImage('assets/images/hotel_list_1.jpg'),
                                                image: NetworkImage(snapshot.data![index].ImageUrl, ),
                                                width: 150,
                                                height: 220,
                                                fit: BoxFit.cover,
                                              ),*/

                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                            width: 200,
                                                            child: Text(
                                                              holidayList[index]['name'],
                                                              overflow:
                                                                  TextOverflow.ellipsis,
                                                              maxLines: 1,
                                                              softWrap: false,
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight.bold),
                                                            )),
                                                        const SizedBox(
                                                          height: 3,
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              IconData(0xf053c,
                                                                  fontFamily:
                                                                      'MaterialIcons'),
                                                              size: 15,
                                                            ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            SizedBox(
                                                                width: 150,
                                                                child: Text(
                                                                  holidayList[index]
                                                                      ['countryname'],
                                                                  overflow: TextOverflow
                                                                      .ellipsis,
                                                                  maxLines: 1,
                                                                  softWrap: false,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight.w500,
                                                                      fontSize: 12),
                                                                )),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          '${holidayList[index]['currency']} ${holidayList[index]['amount']}',
                                                          style: const TextStyle(
                                                              color: Colors.red,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          child: Text(
                                                            '${holidayList[index]['featuresInclusion']}',
                                                            style: const TextStyle(
                                                                color: Colors.black,
                                                                fontWeight:
                                                                    FontWeight.w500,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Code: ${holidayList[index]['code']}',
                                                          style: const TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      width: 250,
                                                      height: 1,
                                                      child: DecoratedBox(
                                                        decoration: const BoxDecoration(
                                                            color: Color(0xffededed)),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          holidayList[index]
                                                              ['activityFactsheetType'],
                                                          style: TextStyle(
                                                              color: Color(0xFF00AF80),
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 12),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            String TourCode =
                                                                holidayList[index]['code']
                                                                    .toString();
                                                            String SightSeeingMarkup =
                                                                holidayList[index][
                                                                        'sightSeeingMarkup']
                                                                    .toString();
                                                            String defaultCurrency =
                                                                holidayList[index][
                                                                        'defaultCurrency']
                                                                    .toString();
                                                            String DefaultyCurrencyvalue =
                                                                holidayList[index][
                                                                        'defaultCurrencyvalue']
                                                                    .toString();
                                                            navigate(HolidayDescription(
                                                              holidayList:
                                                                  holidayList[index],
                                                              Tourcode: TourCode,
                                                              SightSeeingMarkup:
                                                                  SightSeeingMarkup,
                                                              defaultCurrency:
                                                                  defaultCurrency,
                                                              DefaultyCurrencyvalue:
                                                                  DefaultyCurrencyvalue,
                                                              RoomCount: widget.RoomCount,
                                                              adultCount:
                                                                  widget.AdultCountRoom1,
                                                              childrenCount: widget
                                                                  .ChildrenCountRoom1,
                                                              Checkindate:
                                                                  widget.checkinDate,
                                                              imageUrl: holidayList[index]
                                                                  ['imgUrl'],
                                                            ));
                                                          },
                                                          child: Text(
                                                            'View Details',
                                                            style: TextStyle(
                                                                color: Color(0xFF00AF80),
                                                                fontWeight:
                                                                    FontWeight.w500,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                    ),
                  ],
                ),
                if (_isBottomBarVisible)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                     final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Holidayfilterpage(add: '',  searchText:searchText ,// Pass the searchText from result
                                                isTourGuideIncluded:isTourGuideIncluded,
                                                isNotAllowed:isNotAllowed,
                                                isSelected0To3000:isSelected0To3000, // Pass isSelected0To3000
                                                isSelected3000To5000: isSelected3000To5000, // Pass isSelected3000To5000
                                                isSelected5000To7500:isSelected5000To7500, // Pass isSelected5000To7500
                                                isSelected7500To9500:isSelected7500To9500, // Pass isSelected7500To9500
                                                isSelected9500To15000: isSelected9500To15000, // Pass isSelected9500To15000
                                                isSelected15000To30000: isSelected15000To30000, // Pass isSelected15000To30000
                                                isSelected30000Plus:isSelected30000Plus, )),
                                    );

                                     if (result != null) {
                                      setState(() {
                                        print('Selected filter count:');
                                        fetchTourList(result);
                                      });
                                    }
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // Ensures the row only takes necessary space
                                    children: [
                                      Icon(
                                        Icons.filter_alt_outlined,
                                        size:
                                        20, // Adjust the icon size as needed
                                        color: Colors.grey.shade600,
                                      ),
                                      SizedBox(height: 7),
                                      // Optional: Adjust this for spacing between icon and text
                                      GestureDetector(onTap: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Holidayfilterpage(add: '',
                                                    searchText:searchText ,// Pass the searchText from result
                                                    isTourGuideIncluded:isTourGuideIncluded,
                                                    isNotAllowed:isNotAllowed,
                                                    isSelected0To3000:isSelected0To3000, // Pass isSelected0To3000
                                                    isSelected3000To5000: isSelected3000To5000, // Pass isSelected3000To5000
                                                    isSelected5000To7500:isSelected5000To7500, // Pass isSelected5000To7500
                                                    isSelected7500To9500:isSelected7500To9500, // Pass isSelected7500To9500
                                                    isSelected9500To15000: isSelected9500To15000, // Pass isSelected9500To15000
                                                    isSelected15000To30000: isSelected15000To30000, // Pass isSelected15000To30000
                                                    isSelected30000Plus:isSelected30000Plus, )),
                                        );

                                        // If we received any result from the filter page
                                        if (result != null) {
                                          setState(() {
                                            print('Selected filter count:');
                                            fetchTourList(result);
                                          });
                                        }
                                      },
                                        child: Text(
                                          "Filter",
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Time Icon and Text
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showGuidingOptionsBottomSheet(context);
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // Ensures the row only takes necessary space
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        size: 20,
                                        // Adjust the size of the icon as needed
                                        color: Colors.grey
                                            .shade600, // Match the icon color with the text
                                      ),
                                      SizedBox(height: 7),
                                      // Optional: Add a tiny width for spacing
                                      Text(
                                        "Guiding",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),


                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showPriceFilterBottomSheet(context);
                                    print("Price tapped");
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // Ensure no extra space is taken
                                    children: [
                                      Icon(
                                        Icons.currency_rupee_outlined,
                                        size: 20, // Adjust the size as needed
                                        color: Colors.grey.shade600,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "Price",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Sort Icon and Text
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showSortBottomSheet(context);
                                    print("Sort tapped");
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // Ensure no extra space is taken
                                    children: [
                                      Icon(
                                        Icons.sort,
                                        size: 20, // Adjust the size as needed
                                        color: Colors.grey.shade600,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "Sort",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ));
  }
}
