import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../Booking/HotelFilterPage.dart';
import '../../models/hotel_model.dart';
import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';
import '../flight/FilterPage.dart';
import 'hotel_description.dart';

class HotelDetail extends StatefulWidget {
  final checkinDate,
      checkoutDate,
      RoomCount,
      AdultCountRoom1,
      ChildrenCountRoom1,
      AdultCountRoom2,
      ChildrenCountRoom2,
      AdultCountRoom3,
      ChildrenCountRoom3,
      AdultCountRoom4,
      ChildrenCountRoom4,
      cityid,
      countrycode;

  const HotelDetail(
      {super.key,
      required this.checkinDate,
      required this.checkoutDate,
      required this.RoomCount,
      required this.AdultCountRoom1,
      required this.ChildrenCountRoom1,
      required this.AdultCountRoom2,
      required this.ChildrenCountRoom2,
      required this.AdultCountRoom3,
      required this.ChildrenCountRoom3,
      required this.AdultCountRoom4,
      required this.ChildrenCountRoom4,
      required this.cityid,
      required this.countrycode});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  int selectedCount = 0;
  late ScrollController _scrollController;
  String searchText='';
  late String userTypeID = '';
  String searchedHotel = '';
  String selectedStarRating = '';
  bool selected0To3000 = false;
  List<dynamic> fullResultList = [];
  bool selected3000To5000 = false;
  bool selected5000To7500 = false;
  bool selected7500To9500 = false;
  bool selected9500To15000 = false;
  bool selected15000To30000 = false;
  bool selected30000Plus = false;

  bool isSelected0To3000 = false;
  bool isSelected3000To5000 = false;
  bool isSelected5000To7500 = false;
  bool isSelected7500To9500 = false;
  bool isSelected9500To15000 = false;
  bool isSelected15000To30000 = false;
  bool isSelected30000Plus = false;
    List<int> selectedStarRatings=[];
  String? selectedSortOption = "Low to High";
  late String userID = '';
  late String Currency = '';


  bool isZeroStarSelected = false;
  bool isOneStarSelected = false;
  bool isTwoStarSelected = false;
  bool isThreeStarSelected = false;
  bool isFourStarSelected = false;
  bool isFiveStarSelected = false;
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

  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
      print('Currency: $Currency');
    });

    // Ensure filters are populated correctly
    Map<String, dynamic> filters = {
      'searchText': searchedHotel,
      'selectedStarRating': selectedStarRating,
      '0To3000': selected0To3000,
      '3000To5000': selected3000To5000,
      '5000To7500': selected5000To7500,
      '7500To9500': selected7500To9500,
      '9500To15000': selected9500To15000,
      '15000To30000': selected15000To30000,
      '30000Plus': selected30000Plus,
    };

    // Call getHotelList after filters are set
    await getHotelList(filters);
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
                          child: Text(
                            "Price Range",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 10),
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
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),// Prevent dismissing by tapping outside
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
                          child: Center(
                            child: Text(
                              "Sort",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
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
                      child: GestureDetector(onTap: () {
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
      // Sort in ascending order (low price to high price)
      results.sort((a, b) => _parsePrice(a['TotalPrice']).compareTo(_parsePrice(b['TotalPrice'])));
      print("Sorting: Low to High");
    } else if (sortOrder == "High to Low") {
      // Sort in descending order (high price to low price)
      results.sort((a, b) => _parsePrice(b['TotalPrice']).compareTo(_parsePrice(a['TotalPrice'])));
      print("Sorting: High to Low");
    }

    // After sorting, update the result list
    setState(() {
      hotelResult = results; // Update with sorted results
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


  // Helper method to build a checkbox
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

  void _applyPriceFilter(List<dynamic> results, Map<String, dynamic> filters) {
    List<dynamic> filteredHotels = results.where((hotel) {
      // Create a variable to store if the hotel matches any selected price range
      bool matchesPriceRange = false;

      // Convert TotalPrice to double, default to 0.0 if parsing fails
      double totalPrice = double.tryParse(hotel['TotalPrice'].toString()) ?? 0.0;

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
      hotelResult = filteredHotels; // Update the displayed hotels
    });
  }







  void _showStarRatingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the modal to be scrollable if needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox( // Set a max height for the modal
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6, // 60% of screen height
                ),
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
                          child: Text(
                            "Star Rating",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Divider(),
                    for (int i = 0; i <= 5; i++) _buildStarRow(i, setState),

                    SizedBox(height: 16), // Add some space before the button
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Map<String, bool> filters = {
                            'isZeroStarSelected': isZeroStarSelected,
                            'isOneStarSelected': isOneStarSelected,
                            'isTwoStarSelected': isTwoStarSelected,
                            'isThreeStarSelected': isThreeStarSelected,
                            'isFourStarSelected': isFourStarSelected,
                            'isFiveStarSelected': isFiveStarSelected,
                          };

                          _applyStarRatingFilter(fullResultList, filters);
                          Navigator.of(context).pop();
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


  void _applyStarRatingFilter(List<dynamic> results, Map<String, dynamic> filters) {
    print('Displaying all flights: $results');

    // Filter based on star ratings
    List<dynamic> filteredResults = results.where((hotel) {
      int hotelStars = int.tryParse(hotel['StarCategory'].toString()) ?? 0;
      // Check if the flight matches any of the selected star rating filters
      bool matchesStarRating = (filters['isZeroStarSelected'] == true && hotelStars == 0) ||
          (filters['isOneStarSelected'] == true && hotelStars == 1) ||
          (filters['isTwoStarSelected'] == true && hotelStars == 2) ||
          (filters['isThreeStarSelected'] == true && hotelStars == 3) ||
          (filters['isFourStarSelected'] == true && hotelStars == 4) ||
          (filters['isFiveStarSelected'] == true && hotelStars == 5);

      // Return true if the flight matches any selected star rating
      return matchesStarRating;
    }).toList();

    setState(() {
      this.hotelResult = filteredResults; // Update the result list with filtered results
    });

    print('Filtered flights by star rating: $filteredResults');
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




  bool isLoading = false;
  var hotelResult = [];
  List<dynamic> filteredHotels = [];

  bool _isBottomBarVisible = true;

  Future<void> getHotelList(Map<String, dynamic> filters) async {
    DateTime checkinDateTime = DateTime.parse(widget.checkinDate.toString());
    String finDate = DateFormat('yyyy-MM-dd').format(checkinDateTime);
    print('finDate: ${finDate ?? 'N/A'}'); // Updated print statement

    DateTime checkinDateTime1 = DateTime.parse(widget.checkoutDate.toString());
    String finDate1 = DateFormat('yyyy-MM-dd').format(checkinDateTime1);
    print('finDate1: ${finDate1 ?? 'N/A'}'); // Updated print statement

    final url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaHotelGetList');

    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final requestBody = {
      'CityId': widget.cityid.toString(),
      'CountryCode': widget.countrycode.toString(),
      'APICurrencyCode': 'INR',
      'DefaultCurrency': 'KES',
      'UserID': userID.toString(),
      'UserTypeID': userTypeID.toString(),
      'CheckIn': finDate,
      'CheckOut': finDate1,
      'Rooms': widget.RoomCount.toString(),
      'AdultCountRoom1': widget.AdultCountRoom1.toString(),
      'ChildrenCountRoom1': '1',
      'Child1AgeRoom1': '8',
      'Child2AgeRoom1': '',
      'AdultCountRoom2': '',
      'ChildrenCountRoom2': '',
      'Child1AgeRoom2': '',
      'Child2AgeRoom2': '',
      'AdultCountRoom3': '',
      'ChildrenCountRoom3': '',
      'Child1AgeRoom3': '',
      'Child2AgeRoom3': '',
    };
    print('CityId: ${widget.cityid.toString()}');
    print('CountryCode: ${widget.countrycode.toString()}');
    print('APICurrencyCode: INR');
    print('DefaultCurrency: ${Currency.toString()}');
    print('UserID: ${userID.toString()}');
    print('UserTypeID: ${userTypeID.toString()}');
    print('CheckIn: $finDate');
    print('CheckOut: $finDate1');
    print('Rooms: ${widget.RoomCount.toString()}');
    print('AdultCountRoom1: ${widget.AdultCountRoom1.toString()}');
    print('ChildrenCountRoom1: 1');
    print('Child1AgeRoom1: 8');
    print('Child2AgeRoom1: ');
    print('AdultCountRoom2: ');
    print('ChildrenCountRoom2:');
    print('Child1AgeRoom2: ');
    print('Child2AgeRoom2: ');
    print('AdultCountRoom3: ');
    print('ChildrenCountRoom3: ');
    print('Child1AgeRoom3: ');
    print('Child2AgeRoom3: ');

    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        url,
        headers: headers,
        body: requestBody,
      );
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        // Handle the successful response here
        print('Request successful! Response:');
        developer.log(response.body);
        var jsonResult = json.decode(ResponseHandler.parseData(response.body));
        setState(() {
          hotelResult = jsonResult;
          fullResultList =
              hotelResult; // Assuming 'flights' is the key for the flight data
          print('Extracted flights: $fullResultList');
        });
          _applyHotelFiltersToResult(hotelResult, filters);

        // Apply the filter based on the search text
      } else {
        // Handle the failure scenario
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions or errors that occurred during the request
      print('Error sending request: $error');
    }
  }

  void _applyHotelFiltersToResult(
      List<dynamic> hotelResult, Map<String, dynamic> filters)
  {
    List<dynamic> filteredResults = [];

    // Extract filter values
      isSelected0To3000 = filters['0To3000'] ?? false;
      isSelected3000To5000 = filters['3000To5000'] ?? false;
      isSelected5000To7500 = filters['5000To7500'] ?? false;
      isSelected7500To9500 = filters['7500To9500'] ?? false;
      isSelected9500To15000 = filters['9500To15000'] ?? false;
      isSelected15000To30000 = filters['15000To30000'] ?? false;
      isSelected30000Plus = filters['30000Plus'] ?? false;

     selectedStarRatings = filters['selectedStarRatings'] ?? [];
      searchText = filters['searchText'] ?? "";
    // Check if any filters are selected
    bool anyFilterSelected = isSelected0To3000 ||
        isSelected3000To5000 ||
        isSelected5000To7500 ||
        isSelected7500To9500 ||
        isSelected9500To15000 ||
        isSelected15000To30000 ||
        isSelected30000Plus ||
        selectedStarRatings.isNotEmpty ||
        searchText.isNotEmpty;

    if (!anyFilterSelected) {
      filteredResults = List.from(hotelResult);
    } else {
       for (var hotel in hotelResult) {
        double hotelPrice =
            double.tryParse(hotel['TotalPrice'].toString()) ?? 0.0;
        int hotelStars = int.tryParse(hotel['StarCategory'].toString()) ?? 0;
        String hotelName = hotel['HotelName'] ?? "";
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
        if (isSelected15000To30000 &&
            hotelPrice > 15000 &&
            hotelPrice <= 30000) {
          isInSelectedPriceRange = true;
        }
        if (isSelected30000Plus && hotelPrice > 30000) {
          isInSelectedPriceRange = true;
        }

        bool isInSelectedStarRating = selectedStarRatings.contains(hotelStars);
        bool shouldAddHotel = false;
        int selectedCount = filters['selectedCount'] ?? 0; // Get selectedCount
        print('Sending flight selectedCount: $selectedCount');
        if (selectedCount == 0) {
          // Condition when only one filter is selected
          if (searchText.isNotEmpty &&
              hotelName.toLowerCase().contains(searchText.toLowerCase())) {
            shouldAddHotel = true;
          }
        } else if (selectedCount == 1) {
          // Condition when only one filter is selected (modify as per your logic)
          if (isInSelectedPriceRange || isInSelectedStarRating) {
            shouldAddHotel = true;
          }
        } else if (selectedCount == 2) {
          // Condition when two filters are selected (modify as per your logic)
          if (isInSelectedPriceRange && isInSelectedStarRating) {
            shouldAddHotel = true;
          }
        }
        // Add more conditions based on selectedCount if necessary

        if (shouldAddHotel) {
          filteredResults.add(hotel);
        }
      }
    }

    // Update the state with the filtered results
    setState(() {
      this.hotelResult = filteredResults; // Update your hotel results
    });
  }

  void navigate(Widget screen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
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
                "Available Hotels",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Montserrat",
                    fontSize: 18),
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
                          itemCount: hotelResult.length,
                          itemBuilder: (context, index) {
                            String star = hotelResult[index]['StarCategory']?.toString() ?? '';
                            String displayStar = '';
                            if (star.isEmpty || star == '0') {
                              displayStar = '1 Star Hotel';
                            } else {
                              displayStar = '$star Star Hotel';
                            }
                            String refund = hotelResult[index]['RefundString']?.toString().toLowerCase() ?? '';
                            //return Text(snapshot.data?[index].LabelName ?? "got null");
                            return InkWell(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 10, left: 10, top: 5),
                                child: Material(
                                  elevation: 10,
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color(0xFFFAE8FA),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color:
                                                      const Color(0xFF870987),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.local_offer,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                    Text(
                                                        displayStar,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              RatingBar.builder(
                                                initialRating: _getInitialRating(
                                                    int.tryParse(hotelResult[index]['StarCategory']?.toString() ?? '') ?? 1
                                                ),
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 15,
                                                itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                                                itemBuilder: (context, _) => const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              )

                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 100,
                                                height: 115,
                                                child: CachedNetworkImage(
                                                  imageUrl: hotelResult[index]['ImageUrl']?.toString() ?? '',
                                                  placeholder: (context, url) => const Center(
                                                    child: SizedBox(
                                                      height: 30,
                                                      width: 35,
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                            width: 200,
                                                            child: Text(
                                                              hotelResult[index]
                                                                  ['HotelName'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              softWrap: false,
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                        const SizedBox(
                                                          height: 5,
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
                                                            Expanded(
                                                              child: Text(
                                                                hotelResult[index]['Address']?.toString() ?? '',
                                                                overflow: TextOverflow.ellipsis,
                                                                maxLines: 1,
                                                                softWrap: false,
                                                                style: const TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            )

                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          '${(hotelResult[index]['RoomCount'] ?? "").toString()} Room For ${(hotelResult[index]['TotalDays'] ?? "").toString()} Days',
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12.5,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${hotelResult[index]['DefaultCurrency'] ?? ""} ${hotelResult[index]['TotalPrice'] ?? ""}',
                                                          style: const TextStyle(
                                                            color: Colors.red,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Hotel ID: ${hotelResult[index]['ItemID']}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
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
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Color(
                                                                    0xffededed)),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          hotelResult[index]['RefundString']?.toString() ?? '',
                                                          style: TextStyle(
                                                            color: refund.contains('non') ? Colors.red : const Color(0xFF00AF80),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14,
                                                          ),
                                                        ),

                                                        GestureDetector(
                                                          onTap: () {
                                                            String
                                                                StarCategory =
                                                                hotelResult[
                                                                        index][
                                                                    'StarCategory'];
                                                            String HotelId =
                                                                hotelResult[
                                                                        index]
                                                                    ['ItemID'];
                                                            String ResultIndex =
                                                                hotelResult[index]
                                                                        [
                                                                        'ResultIndex']
                                                                    .toString();
                                                            print('traceid:' +
                                                                hotelResult[index]
                                                                        [
                                                                        'TraceId']
                                                                    .toString());
                                                            String Hotelname =
                                                                hotelResult[index]
                                                                        [
                                                                        'HotelName']
                                                                    .toString();
                                                            String
                                                                Hoteladdress =
                                                                hotelResult[index]
                                                                        [
                                                                        'Address']
                                                                    .toString();
                                                            navigate(HotelDescription(
                                                                hotelDetail:
                                                                    hotelResult[
                                                                        index],
                                                                hotelid:
                                                                    HotelId,
                                                                resultindex:
                                                                    ResultIndex,
                                                                traceid: hotelResult[index]['TraceId']
                                                                    .toString(),
                                                                Starcategory:
                                                                    StarCategory,
                                                                RoomCount: widget
                                                                    .RoomCount,
                                                                adultCount: widget
                                                                    .AdultCountRoom1,
                                                                childrenCount: widget
                                                                    .ChildrenCountRoom1,
                                                                Checkindate: widget
                                                                    .checkinDate,
                                                                CheckoutDate: widget
                                                                    .checkoutDate,
                                                                hotelname:
                                                                    Hotelname,
                                                                hoteladdress:
                                                                    Hoteladdress,
                                                                imageurl: hotelResult[
                                                                            index]
                                                                        [
                                                                        'ImageUrl']
                                                                    .toString(),
                                                                Refundable: hotelResult[index]['RefundString'],
                                                                totaldays: hotelResult[
                                                                            index]
                                                                        ['TotalDays']
                                                                    .toString()));

                                                          },
                                                          child: Text(
                                                            'View Details',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF00AF80),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                        const SizedBox(
                                          height: 10,
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
                                        print('Search Text: $searchText');
                                        print('isSelected0To3000: $isSelected0To3000');
                                        print('isSelected3000To5000: $isSelected3000To5000');
                                        print('isSelected5000To7500: $isSelected5000To7500');
                                        print('isSelected7500To9500: $isSelected7500To9500');
                                        print('isSelected9500To15000: $isSelected9500To15000');
                                        print('isSelected15000To30000: $isSelected15000To30000');
                                        print('isSelected30000Plus: $isSelected30000Plus');
                                         final result = await
                                         Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder: (context) => HotelFilterPage(
                                               add: '', // Pass your value for `add`
                                               searchText:searchText ,// Pass the searchText from result
                                               selectedStarRatings: selectedStarRatings, // Pass star ratings
                                               isSelected0To3000:isSelected0To3000, // Pass isSelected0To3000
                                               isSelected3000To5000: isSelected3000To5000, // Pass isSelected3000To5000
                                               isSelected5000To7500:isSelected5000To7500, // Pass isSelected5000To7500
                                               isSelected7500To9500:isSelected7500To9500, // Pass isSelected7500To9500
                                               isSelected9500To15000: isSelected9500To15000, // Pass isSelected9500To15000
                                               isSelected15000To30000: isSelected15000To30000, // Pass isSelected15000To30000
                                               isSelected30000Plus:isSelected30000Plus, // Pass isSelected30000Plus
                                               //selectedCount: result['selectedCount'], // Pass selectedCount
                                             ),
                                           ),
                                         );


                                         if (result != null) {
                                          setState(() {
                                            isSelected30000Plus=result['30000Plus'];
                                            print('Selected filter count:'+isSelected30000Plus.toString());
                                            getHotelList(result);
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
                                          Text(
                                            "Filter",
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.bold,
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
                                        _showStarRatingBottomSheet(context);
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
                                          GestureDetector(onTap: () {
                                            _showStarRatingBottomSheet(context);
                                          },
                                            child: Text(
                                              "Rating",
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
                                          GestureDetector(onTap: () {
                                            _showPriceFilterBottomSheet(context);
                                            print("Price tapped");
                                          },
                                            child: Text(
                                              "Price",
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
                                              fontWeight: FontWeight.bold,
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

double _getInitialRating(int starCategory) {
  if (starCategory >= 1 && starCategory <= 5) {
    return starCategory.toDouble();
  } else {
    return 1.0; // Set a default of one star if 'StarCategory' is not in the valid range
  }

}

