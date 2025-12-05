import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as developer;

import '../DatabseHelper.dart';
import '../bookings/AddAdultScreen.dart';
import '../bookings/flight/AddChildScreen.dart';
import '../bookings/flight/AddInfantScreen.dart';
import '../bookings/flight/Children_DatabaseHelper.dart';
import '../bookings/flight/FlightBookNow.dart';
import '../bookings/flight/InfantDatabaseHelper.dart';
import '../bookings/flight/Oneway_ConfirmationScreen.dart';
import '../bookings/flight/RoundTripBookNowFlight.dart';
import '../utils/commonutils.dart';
import '../utils/shared_preferences.dart';

class TwoWayBooking extends StatefulWidget {
  final dynamic flightDetailsList,
      flightDetails,
      adultCount,
      childrenCount,
      infantCount,
      departdate,
      stopCount,
      departCity,
      TotalPrice,
      stopCountForward,
      stopCountReturn,
      bookingapi;

  const TwoWayBooking(
      {super.key,
        required this.flightDetailsList,
        required this.flightDetails,
        required this.infantCount,
        required this.childrenCount,
        required this.adultCount,
        required this.departdate,
        required this.stopCount,
        required this.departCity,
        required this.TotalPrice,
        required this.stopCountForward,
        required this.stopCountReturn,
        required this.bookingapi});

  @override
  State<TwoWayBooking> createState() => _TwoWayBookingState();
}

class _TwoWayBookingState extends State<TwoWayBooking> {
  var resultFlightData = [];
  Set<int> expandedIndexes = {};
  bool isBookingLoading = false;
  bool isLoading = false;
  bool isEditAdult = false;
  bool isEditChild = false;
  bool isEditInfant = false;
  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';
  bool isExpanded = false;
  bool isExpanded1 = false;
  List<Map<String, dynamic>> _adultsList = [];
  List<Map<String, dynamic>> _childrenList = [];
  List<Map<String, dynamic>> _infantList = [];
  String convertDuration(String duration) {
    // Case 1: ISO 8601 duration format (PT..H..M)
    final regex = RegExp(r'PT(\d+H)?(\d+M)?');
    final match = regex.firstMatch(duration);

    if (match != null) {
      final hours = match.group(1)?.replaceAll('H', '') ?? '0';
      final minutes = match.group(2)?.replaceAll('M', '') ?? '0';

      String result = '';
      if (hours != '0') result += '${int.parse(hours)} hr ';
      if (minutes != '0') result += '${int.parse(minutes)} min';
      return result.trim();
    }

    // Case 2: Plain number in minutes (e.g., "200")
    if (int.tryParse(duration) != null) {
      int totalMinutes = int.parse(duration);
      int hours = totalMinutes ~/ 60;
      int minutes = totalMinutes % 60;

      String result = '';
      if (hours > 0) result += '${hours} hr ';
      if (minutes > 0) result += '${minutes} min';
      return result.trim();
    }

    return duration; // fallback
  }
// Adult 1
  String TitleAdult1 = '';
  String FNameAdult1 = '';
  String MNameAdult1 = '';
  String LNameAdult1 = '';
  String LDOBAdult1 = '';
  String GenderAdult1 = '';
  String DocNumAdult1 = '';
  String issueDateAdult1 = '';
  String expDateAdult1 = '';

// Adult 2
  String TitleAdult2 = '';
  String FNameAdult2 = '';
  String MNameAdult2 = '';
  String LNameAdult2 = '';
  String LDOBAdult2 = '';
  String GenderAdult2 = '';
  String DocNumAdult2 = '';
  String IssueDateAdult2 = '';
  String ExpDateAdult2 = '';

  // Adult 3
  String TitleAdult3 = '';
  String FNameAdult3 = '';
  String MNameAdult3 = '';
  String LNameAdult3 = '';
  String LDOBAdult3 = '';
  String GenderAdult3 = '';
  String DocNumAdult3 = '';
  String IssueDateAdult3 = '';
  String ExpDateAdult3 = '';

  // Adult 4
  String TitleAdult4 = '';
  String FNameAdult4 = '';
  String MNameAdult4 = '';
  String LNameAdult4 = '';
  String LDOBAdult4 = '';
  String GenderAdult4 = '';
  String DocNumAdult4 = '';
  String IssueDateAdult4 = '';
  String ExpDateAdult4 = '';

  // Adult 5
  String TitleAdult5 = '';
  String FNameAdult5 = '';
  String MNameAdult5 = '';
  String LNameAdult5 = '';
  String LDOBAdult5 = '';
  String GenderAdult5 = '';
  String DocNumAdult5 = '';
  String IssueDateAdult5 = '';
  String ExpDateAdult5 = '';

  // Adult 6
  String TitleAdult6 = '';
  String FNameAdult6 = '';
  String MNameAdult6 = '';
  String LNameAdult6 = '';
  String LDOBAdult6 = '';
  String GenderAdult6 = '';
  String DocNumAdult6 = '';
  String IssueDateAdult6 = '';
  String ExpDateAdult6 = '';

  // Adult 7
  String TitleAdult7 = '';
  String FNameAdult7 = '';
  String MNameAdult7 = '';
  String LNameAdult7 = '';
  String LDOBAdult7 = '';
  String GenderAdult7 = '';
  String DocNumAdult7 = '';
  String IssueDateAdult7 = '';
  String ExpDateAdult7 = '';

  // Adult 8
  String TitleAdult8 = '';
  String FNameAdult8 = '';
  String MNameAdult8 = '';
  String LNameAdult8 = '';
  String LDOBAdult8 = '';
  String GenderAdult8 = '';
  String DocNumAdult8 = '';
  String IssueDateAdult8 = '';
  String ExpDateAdult8 = '';

  // Adult 9
  String TitleAdult9 = '';
  String FNameAdult9 = '';
  String MNameAdult9 = '';
  String LNameAdult9 = '';
  String LDOBAdult9 = '';
  String GenderAdult9 = '';
  String DocNumAdult9 = '';
  String IssueDateAdult9 = '';
  String ExpDateAdult9 = '';

  // Adult 10
  String TitleAdult10 = '';
  String FNameAdult10 = '';
  String MNameAdult10 = '';
  String LNameAdult10 = '';
  String LDOBAdult10 = '';
  String GenderAdult10 = '';
  String DocNumAdult10 = '';
  String IssueDateAdult10 = '';
  String ExpDateAdult10 = '';

  // Child 1
  String TitleChild1 = '';
  String FNameChild1 = '';
  String MNameChild1 = '';
  String LNameChild1 = '';
  String LDOBChild1 = '';
  String GenderChild1 = '';
  String DocNumChild1 = '';
  String IssueDateChild1 = '';
  String ExpDateChild1 = '';

// Child 2
  String TitleChild2 = '';
  String FNameChild2 = '';
  String MNameChild2 = '';
  String LNameChild2 = '';
  String LDOBChild2 = '';
  String GenderChild2 = '';
  String DocNumChild2 = '';
  String IssueDateChild2 = '';
  String ExpDateChild2 = '';

// Child 3
  String TitleChild3 = '';
  String FNameChild3 = '';
  String MNameChild3 = '';
  String LNameChild3 = '';
  String LDOBChild3 = '';
  String GenderChild3 = '';
  String DocNumChild3 = '';
  String IssueDateChild3 = '';
  String ExpDateChild3 = '';

// Child 4
  String TitleChild4 = '';
  String FNameChild4 = '';
  String MNameChild4 = '';
  String LNameChild4 = '';
  String LDOBChild4 = '';
  String GenderChild4 = '';
  String DocNumChild4 = '';
  String IssueDateChild4 = '';
  String ExpDateChild4 = '';

// Child 5
  String TitleChild5 = '';
  String FNameChild5 = '';
  String MNameChild5 = '';
  String LNameChild5 = '';
  String LDOBChild5 = '';
  String GenderChild5 = '';
  String DocNumChild5 = '';
  String IssueDateChild5 = '';
  String ExpDateChild5 = '';

  // Infant 1
  String TitleInfant1 = '';
  String FNameInfant1 = '';
  String MNameInfant1 = '';
  String LNameInfant1 = '';
  String LDOBInfant1 = '';
  String GenderInfant1 = '';
  String DocNumInfant1 = '';
  String IssueDateInfant1 = '';
  String ExpDateInfant1 = '';

// Infant 2
  String TitleInfant2 = '';
  String FNameInfant2 = '';
  String MNameInfant2 = '';
  String LNameInfant2 = '';
  String LDOBInfant2 = '';
  String GenderInfant2 = '';
  String DocNumInfant2 = '';
  String IssueDateInfant2 = '';
  String ExpDateInfant2 = '';

// Infant 3
  String TitleInfant3 = '';
  String FNameInfant3 = '';
  String MNameInfant3 = '';
  String LNameInfant3 = '';
  String LDOBInfant3 = '';
  String GenderInfant3 = '';
  String DocNumInfant3 = '';
  String IssueDateInfant3 = '';
  String ExpDateInfant3 = '';

// Infant 4
  String TitleInfant4 = '';
  String FNameInfant4 = '';
  String MNameInfant4 = '';
  String LNameInfant4 = '';
  String LDOBInfant4 = '';
  String GenderInfant4 = '';
  String DocNumInfant4 = '';
  String IssueDateInfant4 = '';
  String ExpDateInfant4 = '';

// Infant 5
  String TitleInfant5 = '';
  String FNameInfant5 = '';
  String MNameInfant5 = '';
  String LNameInfant5 = '';
  String LDOBInfant5 = '';
  String GenderInfant5 = '';
  String DocNumInfant5 = '';
  String IssueDateInfant5 = '';
  String ExpDateInfant5 = '';
  List<String> countries = [];
  String? selectedCountry;
  String? selectedCountryCode;
  String? selectedPhoneCode;
  Map<String, String> countryPhoneMap = {
    'Afghanistan': '+93',
    'Albania': '+355',
    'Algeria': '+213',
    'Andorra': '+376',
    'Angola': '+244',
    'Antigua and Barbuda': '+1268',
    'Argentina': '+54',
    'Armenia': '+374',
    'Aruba': '+297',
    'Australia': '+61',
    'Austria': '+43',
    'Azerbaijan': '+994',
    'Bahamas': '+1242',
    'Bahrain': '+973',
    'Bangladesh': '+880',
    'Barbados': '+1246',
    'Belarus': '+375',
    'Belgium': '+32',
    'Belize': '+501',
    'Benin': '+229',
    'Bhutan': '+975',
    'Bolivia': '+591',
    'Bosnia and Herzegovina': '+387',
    'Botswana': '+267',
    'Brazil': '+55',
    'Brunei': '+673',
    'Bulgaria': '+359',
    'Burundi': '+257',
    'Cambodia': '+855',
    'Cameroon': '+237',
    'Canada': '+1',
    'Cape Verde': '+238',
    'Chile': '+56',
    'China': '+86',
    'Colombia': '+57',
    'Comoros': '+269',
    'Costa Rica': '+506',
    'Croatia': '+385',
    'Cuba': '+53',
    'Cyprus': '+357',
    'Czech Republic': '+420',
    'Democratic Republic of the Congo': '+243',
    'Denmark': '+45',
    'Djibouti': '+253',
    'Dominica': '+1767',
    'Dominican Republic': '+1809',
    'Ecuador': '+593',
    'Egypt': '+20',
    'Equatorial Guinea': '+240',
    'Eritrea': '+291',
    'Estonia': '+372',
    'Eswatini': '+268',
    'Ethiopia': '+251',
    'Fiji': '+679',
    'Finland': '+358',
    'France': '+33',
    'Gambia': '+220',
    'Georgia': '+995',
    'Germany': '+49',
    'Ghana': '+233',
    'Greece': '+30',
    'Guam': '+1671',
    'Guatemala': '+502',
    'Guinea': '+224',
    'Guinea-Bissau': '+245',
    'Guyana': '+592',
    'Haiti': '+509',
    'Honduras': '+504',
    'Hungary': '+36',
    'Iceland': '+354',
    'India': '+91',
    'Indonesia': '+62',
    'Iran': '+98',
    'Iraq': '+964',
    'Ireland': '+353',
    'Israel': '+972',
    'Italy': '+39',
    'Jamaica': '+1876',
    'Japan': '+81',
    'Jordan': '+962',
    'Kazakhstan': '+7',
    'Kenya': '+254',
    'Kiribati': '+686',
    'Kuwait': '+965',
    'Kyrgyzstan': '+996',
    'Lebanon': '+961',
    'Lesotho': '+266',
    'Liberia': '+231',
    'Liechtenstein': '+423',
    'Lithuania': '+370',
    'Luxembourg': '+352',
    'Madagascar': '+261',
    'Malawi': '+265',
    'Malaysia': '+60',
    'Maldives': '+960',
    'Mali': '+223',
    'Malta': '+356',
    'Marshall Islands': '+692',
    'Martinique': '+596',
    'Mauritania': '+222',
    'Mauritius': '+230',
    'Mexico': '+52',
    'Moldova': '+373',
    'Monaco': '+377',
    'Mongolia': '+976',
    'Montenegro': '+382',
    'Morocco': '+212',
    'Mozambique': '+258',
    'Myanmar': '+95',
    'Namibia': '+264',
    'Nauru': '+674',
    'Nepal': '+977',
    'Netherlands': '+31',
    'New Zealand': '+64',
    'Nicaragua': '+505',
    'Niger': '+227',
    'Nigeria': '+234',
    'Norway': '+47',
    'Oman': '+968',
    'Pakistan': '+92',
    'Palau': '+680',
    'Panama': '+507',
    'Paraguay': '+595',
    'Peru': '+51',
    'Philippines': '+63',
    'Poland': '+48',
    'Portugal': '+351',
    'Qatar': '+974',
    'Republic of the Congo': '+242',
    'Romania': '+40',
    'Russia': '+7',
    'Rwanda': '+250',
    'Saint Kitts and Nevis': '+1869',
    'Saint Lucia': '+1758',
    'Samoa': '+685',
    'San Marino': '+378',
    'Saudi Arabia': '+966',
    'Senegal': '+221',
    'Serbia': '+381',
    'Seychelles': '+248',
    'Singapore': '+65',
    'Slovakia': '+421',
    'Slovenia': '+386',
    'Solomon Islands': '+677',
    'Somalia': '+252',
    'South Korea': '+82',
    'South Sudan': '+211',
    'Spain': '+34',
    'Sri Lanka': '+94',
    'Sudan': '+249',
    'Suriname': '+597',
    'Sweden': '+46',
    'Switzerland': '+41',
    'Syria': '+963',
    'Tajikistan': '+992',
    'Tanzania': '+255',
    'Thailand': '+66',
    'Timor-Leste': '+670',
    'Togo': '+228',
    'Tonga': '+676',
    'Trinidad and Tobago': '+1868',
    'Tunisia': '+216',
    'Turkey': '+90',
    'Turkmenistan': '+993',
    'Tuvalu': '+688',
    'Uganda': '+256',
    'Ukraine': '+380',
    'United Arab Emirates': '+971',
    'United Kingdom': '+44',
    'United States of America': '+1',
    'Uruguay': '+598',
    'Uzbekistan': '+998',
    'Vanuatu': '+678',
    'Vatican City': '+379',
    'Venezuela': '+58',
    'Vietnam': '+84',
    'Yemen': '+967',
    'Zambia': '+260',
    'Zimbabwe': '+263',
  };
  @override
  void initState() {
    super.initState();
    _retrieveSavedValues();
    fetchCountries();
    fetchNationalities();
  }
  Future<void> fetchCountries() async {
    final response = await http.post(
      Uri.parse('https://boqoltravel.com/app/b2badminapi.asmx/GetCountries'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode == 200) {
      final rawXml = response.body;

      try {
        final document = xml.XmlDocument.parse(rawXml);
        final elements = document.findAllElements('string');
        if (elements.isNotEmpty) {
          final result = elements.first.text;

          // Split and remove duplicates
          final items = result.split(',').map((e) => e.trim()).toSet().toList();

          setState(() {
            countries = items;
          });
        } else {
          print('No <string> tag found');
        }
      } catch (e) {
        print('XML parse error: $e');
      }
    } else {
      print('Request failed: ${response.statusCode}');
    }
  }
  String formatDepartureDate(String departureDate) {
    // Parse the date string into a DateTime object
    DateTime date = DateTime.parse(departureDate);

    // Format the date to get the day of the week and month
    String formattedDate = DateFormat('EEE, d MMM').format(date);
    print('formatedadate' + formattedDate.toString());

    // Get the day of the month to add the ordinal suffix (st, nd, rd, th)
    String dayWithSuffix = _addOrdinalSuffix(date.day);

    // Replace the day in the formatted string with the day + suffix
    return formattedDate.replaceFirst(RegExp(r'\d+'), dayWithSuffix);
  }
  Future<void> _deleteChild(int index) async {
    final dbHelper = ChildrenDatabaseHelper
        .instance; // Ensure you have a database helper instance
    if (_childrenList.length > index) {
      await dbHelper.deleteChildrens(_childrenList[index]
      ['id']); // Use the appropriate method to delete from your database
      _fetchChildren(); // Refresh the list of adults after deletion
    }
  }
  Future<void> _fetchInfant() async {
    final dbHelper = InfantDatabaseHelper.instance;
    final adults = await dbHelper.getInfant(); // Fetch adults from the database
    setState(() {
      _infantList = adults;
      // Update the list to refresh UI
    });
  }
  Future<void> _fetchChildren() async {
    final dbHelper = ChildrenDatabaseHelper.instance;
    final adults =
    await dbHelper.getChildrens(); // Fetch adults from the database
    setState(() {
      _childrenList = adults;
      // Update the list to refresh UI
    });
  }
  Future<void> _deleteInfant(int index) async {
    final dbHelper = InfantDatabaseHelper
        .instance; // Ensure you have a database helper instance
    if (_childrenList.length > index) {
      await dbHelper.deleteInfant(_childrenList[index]
      ['id']); // Use the appropriate method to delete from your database
      _fetchInfant(); // Refresh the list of adults after deletion
    }
  }
  List<String> nationalityList = [];
  String? selectedNationality;

  Future<void> fetchNationalities() async {
    final response = await http.post(
      Uri.parse('https://boqoltravel.com/app/b2badminapi.asmx/GetCountries'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode == 200) {
      final rawXml = response.body;

      try {
        final document = xml.XmlDocument.parse(rawXml);
        final elements = document.findAllElements('string');
        if (elements.isNotEmpty) {
          final result = elements.first.text;

          final items = result.split(',').map((e) => e.trim()).toSet().toList();

          setState(() {
            nationalityList = items;
          });
        } else {
          print('No <string> found in XML');
        }
      } catch (e) {
        print('Error parsing XML: $e');
      }
    } else {
      print('Failed: ${response.statusCode}');
    }
  }
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController CityController = TextEditingController();
  TextEditingController StreetNoController = TextEditingController();
  TextEditingController HouseNoController = TextEditingController();
  TextEditingController MobileNoController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  String formattedFromDate = '';
  Future<void> _deleteAdult(int index) async {
    final dbHelper =
        DatabaseHelper.instance; // Ensure you have a database helper instance
    if (_adultsList.length > index) {
      await dbHelper.deleteAdults(_adultsList[index]
      ['id']); // Use the appropriate method to delete from your database
      _fetchAdults(); // Refresh the list of adults after deletion
    }
  }
  String convertToApiFDate(String dateStr) {
    if (dateStr.isEmpty) return "";

    List<String> formats = [
      "d MMMM yyyy", // e.g., 16 April 1997
      "yyyy-MM-dd",  // e.g., 2025-08-21
      "yyyy/MM/dd",  // e.g., 2024/05/14
    ];

    for (var format in formats) {
      try {
        DateTime dt = DateFormat(format).parse(dateStr);
        return DateFormat("yyyy-MM-dd").format(dt); // API format
      } catch (_) {
        continue; // try next format
      }
    }

    print("⚠️ Could not parse date: $dateStr");
    return dateStr; // fallback
  }
  String formatDate(String inputDate) {
    try {
      // Parse the input string (e.g., "2027/03/30")
      DateTime parsedDate = DateFormat('yyyy/MM/dd').parse(inputDate);

      // Convert to yyyy-MM-dd
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      print("Date format error: $e");
      return inputDate; // fallback if parsing fails
    }
  }
  String buildPassengerJson({
    required List<Map<String, dynamic>> adultsList,
    required List<Map<String, dynamic>> childrenList,
    required List<Map<String, dynamic>> infantsList,
  })
  {
    List<Map<String, dynamic>> passengers = [];



    // 🔹 Adults
    for (var adult in adultsList) {
      passengers.add({
        "PassID": (passengers.length + 1).toString(),
        "PaxType": "Adult",
        "Title": adult["title"] ?? "",
        "FirstName": adult["firstName"] ?? "",
        "LastName": adult["surname"] ?? "",
        "Gender": adult["gender"] ?? "",
        "DateOfBirth": convertToApiFDate(adult["dob"]),
        "DoumentType": "Passport",
        "DoumentNo": adult["documentNumber"] ?? "",
        "ExpiryDate": convertToApiFDate(adult["expiryDate"]),
        "IssueDate": convertToApiFDate(adult["issueDate"]),
        "Nationality": adult["nationality"] ?? "India - IN",
        "BaseFare":resultFlightData[0][
        "BookingBaseFare"] ?? "0",
        "TaxFare": resultFlightData[0][
        "BookingTax"] ?? "0",
      });
    }

    // 🔹 Children
    for (var child in childrenList) {
      passengers.add({
        "PassID": (passengers.length + 1).toString(),
        "PaxType": "Child",
        "Title": child["title"] ?? "",
        "FirstName": child["firstName"] ?? "",
        "LastName": child["surname"] ?? "",
        "Gender": child["gender"] ?? "",
        "DateOfBirth": convertToApiFDate(child["dob"]),
        "DoumentType": "Passport",
        "DoumentNo": child["documentNumber"] ?? "",
        "ExpiryDate": convertToApiFDate(child["expiryDate"]),
        "IssueDate": convertToApiFDate(child["issueDate"]),
        "Nationality": child["nationality"] ?? "India - IN",
        "BaseFare": child["baseFare"] ?? "0",
        "TaxFare": child["taxFare"] ?? "0",
      });
    }

    // 🔹 Infants
    for (var infant in infantsList) {
      passengers.add({
        "PassID": (passengers.length + 1).toString(),
        "PaxType": "Infant",
        "Title": infant["title"] ?? "",
        "FirstName": infant["firstName"] ?? "",
        "LastName": infant["surname"] ?? "",
        "Gender": infant["gender"] ?? "",
        "DateOfBirth": convertToApiFDate(infant["dob"]),
        "DoumentType": "Passport",
        "DoumentNo": infant["documentNumber"] ?? "",
        "ExpiryDate": convertToApiFDate(infant["expiryDate"]),
        "IssueDate": convertToApiFDate(infant["issueDate"]),
        "Nationality": infant["nationality"] ?? "India - IN",
        "BaseFare": infant["baseFare"] ?? "0",
        "TaxFare": infant["taxFare"] ?? "0",
      });
    }

    return jsonEncode(passengers);
  }
  Future<void> submitAdivahaFlightBooking() async {
    final url = Uri.parse(
        'https://lojatravel.com/app/b2badminapi.asmx/FlightBooking_Save');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    String fullCountry = selectedCountry.toString(); // e.g. "India - IN"
    String onlyCountryName = fullCountry.split(' - ').first;
    DateTime date = DateTime.parse(widget.departdate.toString());

    String formattedFromDate = DateFormat('dd-MM-yyyy').format(date);


    print(formattedFromDate); // Example: 18-09-2025
    String expDate = formatDate(expDateAdult1);
    print(expDate);


    String email = EmailController.text.trim();
    String mobileNo = MobileNoController.text.trim();
    String houseNo = HouseNoController.text.trim();
    String street = StreetNoController.text.trim();
    String city = CityController.text.trim();

    String country = selectedCountry ?? "";




    // Build address by combining house + street (optional logic)
    String address = "$houseNo, $street";

    // Prepare JSON map
    List<Map<String, dynamic>> contactDetails = [
      {
        "Email": email,
        "MobileNo": mobileNo,
        "Address": address,
        "City": city,
        "Country": country,
      }
    ];

    // Convert to JSON string
    String contactDetailJson = jsonEncode(contactDetails);

    print("Final JSON: $contactDetailJson");



    String passengerJson = buildPassengerJson(
      adultsList: _adultsList,
      childrenList: _childrenList,
      infantsList: _infantList,
    );

    print(passengerJson);


    var reqBody = {
      'DepartureDate':formattedFromDate,
      'BookingAPI':widget.bookingapi,
      'BookingJson':json.encode(widget.flightDetailsList),
      'ContactDetailJson': contactDetailJson,
      'ReqPassangerJson': passengerJson,
    };




    printFullJson(widget.flightDetailsList);
    print('================= Request Body Start =================');
    reqBody.forEach((key, value) {
      print('$key: $value');
    });
    print('================= Request Body End =================');

    try {
      setState(() {
        isBookingLoading = true;
      });

      final response = await http.post(
        url,
        headers: headers,
        body: reqBody,
      );

      setState(() {
        isBookingLoading = false;
      });
      if (response.statusCode == 200) {
        print("asdfsgg${response.body}");
        handleBookingResponse(response.body);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Server error. Try again later.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error sending request: $error');
      // Handle any exceptions or errors that occurred during the request
    }
  }
  void handleBookingResponse(String apiMessage) {
    // Simple XML strip to get the numeric ID between tags
    final regex = RegExp(r'>(\d+)<');
    final match = regex.firstMatch(apiMessage);
    final bookingId = match?.group(1) ?? '';

    if (bookingId.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Oneway_ConfirmationScreen(
            bookingId: bookingId,
            PassengerName: "$TitleAdult1 $FNameAdult1 $LNameAdult1",
            Gender: GenderAdult1.toString(),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Booking failed, please verify your data..')),
      );
    }
  }

  Future<void> _fetchAdults() async {
    final dbHelper = DatabaseHelper.instance;
    final adults = await dbHelper.getAdults(); // Fetch adults from the database
    setState(() {
      _adultsList = adults;
      // Update the list to refresh UI
    });
  }
  String _addOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '$day'; // Special case for 11th, 12th, 13th
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
      print('Currency: $Currency');
      // Call sendFlightSearchRequest() here after SharedPreferences values are retrieved
      getAdivahaFlightDetails();
    });
  }





  Map<String, dynamic>? fareSummary;
  void parseFareSummary(String xmlResponse) {
    try {
      final document = xml.XmlDocument.parse(xmlResponse);
      final strings = document.findAllElements('string').toList();

      if (strings.length < 3) {
        print("⚠️ Less than 3 <string> elements found.");
        return;
      }

      final fareSummaryJson = strings[2].text; // 3rd <string>

      if (fareSummaryJson.isEmpty) {
        print("⚠️ Fare summary JSON is empty.");
        return;
      }

      final decoded = jsonDecode(fareSummaryJson);

      if (decoded == null || decoded is! List) {
        print("⚠️ Fare summary JSON is not a List: $decoded");
        return;
      }

      final List<dynamic> fareSummaryList = decoded;
      if (fareSummaryList.isEmpty) {
        print("⚠️ Fare summary list is empty.");
        return;
      }

      fareSummary = fareSummaryList.first; // assign to class variable

      print("Adult Fare: ${fareSummary!['AdualFare']}");
      print("Tax: ${fareSummary!['AdualTaxFare']}");
      print("Discount: ${fareSummary!['TotalDiscount']}");
      print("Grand Total: ${fareSummary!['GrandTotal']}");
    } catch (e) {
      print("⚠️ Error parsing fare summary: $e");
    }
  }

  List<bool> expandedList = [];
  Future<void> getAdivahaFlightDetails() async {
    String resultIndex = widget.flightDetails['ResultIndexID']?.toString() ?? "";
    String traceId = widget.flightDetails['ItemId']?.toString() ?? "";
    String Bookingapi = widget.flightDetails['BookingAPI']?.toString() ?? "";
    print("ResultIndexID: ${widget.flightDetails['ResultIndexID']}");
    print("ItemId: ${widget.flightDetails['ItemId']}");
    print("BookingAPI: ${widget.flightDetails['BookingAPI']}");

    final url = Uri.parse(
        'https://lojatravel.com/app/b2badminapi.asmx/FlightBooking_Details');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    try {
      setState(() {
        isLoading = true;
      });
      String jsonStrTP = '';
      String fareIndexToSend = resultIndex;

// Only for TP, send flightDetailsList and empty FareIndexID
      if (Bookingapi == "TP") {
        jsonStrTP = json.encode(widget.flightDetailsList);
        fareIndexToSend = ''; // FareIndexID empty for TP
      } else if (Bookingapi == "Adivaha" || Bookingapi == "TB") {
        jsonStrTP = ''; // JsonStrTP empty
        fareIndexToSend=resultIndex;
      }
      final requestBody = {
        'JsonStrTP': jsonStrTP,
        'JsonReturn':[]
      };
      printFullJson(widget.flightDetailsList);
      developer.log('📤 Sending request to Adivaha API with full data:');
      requestBody.forEach((key, value) {
        developer.log('$key: ${value.toString()}');
      });

      final response = await http.post(
        url,
        headers: headers,
        body: requestBody,
      );

      setState(() {
        isLoading = false;
      });
      print('✅ Request successful! Parsing response...');
      if (response.statusCode == 200) {


        var parsedJson = extractJsonFromXml(response.body);

        if (parsedJson is! List) {
          print('❌ Invalid response format: Not a list');
          _showErrorMessage('Invalid data format from server.');
          return;
        }

        // ✅ Custom filtering using StopCount and RowType
        // ✅ Custom filtering using StopCount and RowType
        List finalResultFlightData = [];

        for (var flight in parsedJson) {
          String stopCount = flight['StopCount']?.toString() ?? '0';
          String rowType = flight['RowType']?.toString() ?? '';

          // Direct flight (no stops) → MainRow only
          if (widget.stopCountForward == "0" && rowType == "MainRow") {
            finalResultFlightData.add(flight);
            print('✅ Added MainRow for direct flight (StopCount == 0)');
          }

          // Connecting flights (1+ stops) → SubRow only
          else if ((widget.stopCountForward == "1" || widget.stopCountForward == "2") && rowType == "SubRow") {
            finalResultFlightData.add(flight);
            print('✅ Added SubRow for connecting flight (StopCount == $stopCount)');
          }
        }


        if (finalResultFlightData.isEmpty) {
          print('❌ No valid flight data returned');
          _showErrorMessage('No flights available.');
          return;
        }

        setState(() {
          resultFlightData = finalResultFlightData;
          expandedList = List.generate(resultFlightData.length, (_) => false);
        });
        print('❌ Requsadddfest failed with status: ${response.statusCode}');
        parseFareSummary(response.body);
        print('❌ Requadfest failed with status: ${response.statusCode}');
      } else {
        print('❌ Request failed with status: ${response.statusCode}');
        _showErrorMessage('Server error, please try again later.');
      }
    } catch (error) {
      print('❌ Error sending request: $error');
      _showErrorMessage('Unexpected error occurred.');
    }
  }

  void printFullJson(List<dynamic> matchingRows) {
    final encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(matchingRows);
    developer.log(prettyJson, name: 'FilterezffddFlightDetails');
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

  void _showErrorMessage(String message) {
    // This method can show a dialog or a snackbar to the user
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    int adultCountInt = int.parse(widget.adultCount);
    int childrenCount = int.parse(widget.childrenCount);
    int InfantCount = int.parse(widget.infantCount);
    double adultFare = double.tryParse(fareSummary?['AdualFare'] ?? "0") ?? 0;
    double adultTax = double.tryParse(fareSummary?['AdualTaxFare'] ?? "0") ?? 0;
    double childFare = double.tryParse(fareSummary?['ChildFare'] ?? "0") ?? 0;
    double childTax = double.tryParse(fareSummary?['ChildTaxFare'] ?? "0") ?? 0;
    double infantFare = double.tryParse(fareSummary?['InfantFare'] ?? "0") ?? 0;
    double infantTax =
        double.tryParse(fareSummary?['InfantTaxFare'] ?? "0") ?? 0;

    double totalFare = double.tryParse(fareSummary?['TotalFare'] ?? '0') ?? 0;
    double gst = double.tryParse(fareSummary?['TotalGST'] ?? '0') ?? 0;
    double convenience =
        double.tryParse(fareSummary?['TotalConvenience'] ?? '0') ?? 0;
    double discount =
        double.tryParse(fareSummary?['TotalDiscount'] ?? '0') ?? 0;
    double grandTotal = double.tryParse(fareSummary?['GrandTotal'] ?? '0') ?? 0;

    double totalAdult = (adultFare + adultTax) * adultCountInt;
    double totalChild = (childFare + childTax) * childrenCount;
    double totalInfant = (infantFare + infantTax) * InfantCount;
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
              "Flight Booking",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Montserrat", fontSize: 18),
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
      body:isLoading
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
          : Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Color(0xffd9dce1),
                child: Column(
                  children: [
                    resultFlightData.length > 1
                        ? Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: resultFlightData.length,
                          itemBuilder:
                              (BuildContext context, int index) {
                            final flight = resultFlightData[index];
                            bool isExpanded =
                            expandedIndexes.contains(index);

                            final stopCount = int.tryParse(
                                flight['StopCount']
                                    .toString()) ??
                                0;

                            DateTime? arrivalDate;
                            DateTime? nextDepartureDate;
                            String? layoverDurationStr;
                            String? layoverAirportCode;

                            if (index + 1 <
                                resultFlightData.length) {
                              arrivalDate = DateTime.parse(
                                  resultFlightData[index]
                                  ['ArrivalDate']);
                              nextDepartureDate = DateTime.parse(
                                  resultFlightData[index + 1]
                                  ['DepartureDate']);

                              final layoverDuration =
                              nextDepartureDate
                                  .difference(arrivalDate);
                              final layoverHours =
                                  layoverDuration.inHours;
                              final layoverMinutes = layoverDuration
                                  .inMinutes
                                  .remainder(60);
                              layoverDurationStr =
                              "$layoverHours hr $layoverMinutes min";
                              layoverAirportCode =
                              resultFlightData[index]
                              ['ArriveCityCode'];
                            }

                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      if (flight["RowType"] ==
                                          "MainRow") ...[
                                        Text(
                                          "Flight Details : ${flight['DepartCityName']} → ${flight['ArriveCityName']} "
                                              "on ${DateFormat('dd MMM yyyy').format(DateTime.parse(flight['DepartureDate']))}",
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                      // ✅ Heading for 1+ Stops (only once per MainRow group)
                                      if (flight["RowType"] ==
                                          "SubRow" &&
                                          (index == 0 ||
                                              resultFlightData[
                                              index -
                                                  1]
                                              [
                                              "MainRowNumber"]
                                                  .toString() !=
                                                  flight["MainRowNumber"]
                                                      .toString())) ...[
                                        Builder(
                                          builder: (_) {
                                            // 👉 Find its MainRow
                                            final subRows = resultFlightData
                                                .where((row) =>
                                            row["RowType"] ==
                                                "SubRow" &&
                                                row["MainRowNumber"]
                                                    .toString() ==
                                                    flight["MainRowNumber"]
                                                        .toString())
                                                .toList();

                                            // ✅ Origin = first subrow departure
                                            final departCity = subRows
                                                .isNotEmpty
                                                ? subRows.first[
                                            "DepartCityName"]
                                                : flight[
                                            "DepartCityName"];

                                            // ✅ Destination = last subrow arrival
                                            final arriveCity = subRows
                                                .isNotEmpty
                                                ? subRows.last[
                                            "ArriveCityName"]
                                                : flight[
                                            "ArriveCityName"];

                                            // ✅ Take departure date from first subrow
                                            final depDate = subRows
                                                .isNotEmpty
                                                ? DateFormat(
                                                'dd MMM yyyy')
                                                .format(DateTime
                                                .parse(subRows
                                                .first[
                                            "DepartureDate"]))
                                                : (flight["DepartureDate"] !=
                                                null
                                                ? DateFormat(
                                                'dd MMM yyyy')
                                                .format(DateTime
                                                .parse(
                                                flight["DepartureDate"]))
                                                : '');

                                            return Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  "Flight Details : $departCity → $arriveCity on $depDate",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .w500,
                                                      color: Colors
                                                          .black,
                                                      fontSize: 16),
                                                ),
                                                const SizedBox(
                                                    height: 8),
                                              ],
                                            );
                                          },
                                        ),
                                      ],

                                      // Airline Row
                                      Row(
                                        children: [
                                          Image.asset(
                                              'assets/images/img.png',
                                              width: 40),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              flight['CarrierName'] ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),

                                      // Flight Detail Row
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          // Departure
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(flight['DepartureDate']
                                                  ?.toString()
                                                  .substring(
                                                  0, 10) ??
                                                  ''),
                                              Text(
                                                CommonUtils.formatToMonthDayWeek(flight['DepartureDate']),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                              Text(flight[
                                              'DepartCityName'] ??
                                                  ''),
                                              SizedBox(height: 2),
                                              SizedBox(
                                                width: 75,
                                                child: Text(
                                                  flight['DepartAirportName'] ??
                                                      '',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Text(
                                                'Terminal ${flight['DepartureTerminal'] ?? ''}',
                                                style: TextStyle(
                                                    color: Colors
                                                        .orange,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),

                                          // Travel Time
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    top: 16),
                                                child: Text(
                                                  convertDuration(
                                                      resultFlightData[
                                                      index]
                                                      [
                                                      'TravelTime'] ??
                                                          ''),
                                                  style:
                                                  const TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .w500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Image.asset(
                                                (resultFlightData[
                                                index]
                                                [
                                                'StopCount'] ==
                                                    '0')
                                                    ? "assets/images/NonStop.png"
                                                    : (resultFlightData[index]
                                                [
                                                'StopCount'] ==
                                                    '1')
                                                    ? "assets/images/oneStop.png"
                                                    : "assets/images/TwoStop.png",
                                                width: 70,
                                                fit:
                                                BoxFit.fitWidth,
                                              ),
                                            ],
                                          ),

                                          // Arrival
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .end,
                                            children: [
                                              Text(flight['ArrivalDate']
                                                  ?.toString()
                                                  .substring(
                                                  0, 10) ??
                                                  ''),
                                              Text(
                                                CommonUtils
                                                    .formatToMonthDayWeek(
                                                    flight[
                                                    'ArrivalDate']),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                              Text(flight[
                                              'ArriveCityName'] ??
                                                  ''),
                                              SizedBox(height: 2),
                                              SizedBox(
                                                width: 75,
                                                child: Text(
                                                  flight['ArrivalAirportName'] ??
                                                      '',
                                                  textAlign:
                                                  TextAlign.end,
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Text(
                                                'Terminal ${flight['ArrivalTerminal'] ?? ''}',
                                                style: TextStyle(
                                                    color: Colors
                                                        .orange,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Icon(Icons.shopping_bag,
                                              size: 16,
                                              color: Colors.grey),
                                          SizedBox(width: 5),
                                          Text('Cabin Baggage: ',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors
                                                      .black54)),
                                          Text(
                                              flight['CabinBaggage'] ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors
                                                      .black54)),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.shopping_bag,
                                              size: 16,
                                              color: Colors.grey),
                                          SizedBox(width: 5),
                                          Text('Check-In: ',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors
                                                      .black54)),
                                          Text(
                                              flight['Baggage'] ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors
                                                      .black54)),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          if (index == 0)
                                            Text(
                                              "Adults(${widget.adultCount}) "
                                                  "Child(${widget.childrenCount}) "
                                                  "Infants(${widget.infantCount})",
                                              style:
                                              const TextStyle(
                                                color: Colors.green,
                                              ),
                                            ),
                                          if (index ==
                                              0) // 👉 Only for first index show View More/Less
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (expandedIndexes
                                                      .contains(
                                                      index)) {
                                                    expandedIndexes
                                                        .remove(
                                                        index);
                                                  } else {
                                                    expandedIndexes
                                                        .add(index);
                                                  }
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    expandedIndexes
                                                        .contains(
                                                        index)
                                                        ? 'View Less'
                                                        : 'View Policy',
                                                    style: const TextStyle(
                                                        color: Colors
                                                            .orange),
                                                  ),
                                                  Icon(
                                                    expandedIndexes
                                                        .contains(
                                                        index)
                                                        ? Icons
                                                        .keyboard_arrow_up
                                                        : Icons
                                                        .keyboard_arrow_down,
                                                    color: Colors
                                                        .orange,
                                                  )
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),

                                      if (isExpanded && index == 0)
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Column 1
                                            if ((flight["MiniFareRuleJourneyPoint1"]?.isNotEmpty ?? false) ||
                                                (flight["MiniFareRuleType1"]?.isNotEmpty ?? false) ||
                                                (flight["MiniFareRuleDetails1"]?.isNotEmpty ?? false))
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if (flight["MiniFareRuleJourneyPoint1"] != null)
                                                    Text(
                                                      flight["MiniFareRuleJourneyPoint1"],
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  if (flight["MiniFareRuleJourneyPoint1"] != null) SizedBox(height: 4),
                                                  if (flight["MiniFareRuleType1"] != null)
                                                    Text(flight["MiniFareRuleType1"]),
                                                  if (flight["MiniFareRuleType1"] != null) SizedBox(height: 4),
                                                  if (flight["MiniFareRuleDetails1"] != null)
                                                    Text(flight["MiniFareRuleDetails1"]),
                                                ],
                                              ),

                                            // Column 2
                                            if ((flight["MiniFareRuleJourneyPoint2"]?.isNotEmpty ?? false) ||
                                                (flight["MiniFareRuleType2"]?.isNotEmpty ?? false) ||
                                                (flight["MiniFareRuleDetails2"]?.isNotEmpty ?? false))
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if (flight["MiniFareRuleJourneyPoint2"] != null)
                                                    Text(flight["MiniFareRuleJourneyPoint2"]),
                                                  if (flight["MiniFareRuleJourneyPoint2"] != null) SizedBox(height: 4),
                                                  if (flight["MiniFareRuleType2"] != null)
                                                    Text(flight["MiniFareRuleType2"]),
                                                  if (flight["MiniFareRuleType2"] != null) SizedBox(height: 4),
                                                  if (flight["MiniFareRuleDetails2"] != null)
                                                    Text(flight["MiniFareRuleDetails2"]),
                                                ],
                                              ),

                                            // Column 3
                                            if ((flight["MiniFareRuleJourneyPoint3"]?.isNotEmpty ?? false) ||
                                                (flight["MiniFareRuleType3"]?.isNotEmpty ?? false) ||
                                                (flight["MiniFareRuleDetails3"]?.isNotEmpty ?? false))
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if (flight["MiniFareRuleJourneyPoint3"] != null)
                                                    Text(flight["MiniFareRuleJourneyPoint3"]),
                                                  if (flight["MiniFareRuleJourneyPoint3"] != null) SizedBox(height: 4),
                                                  if (flight["MiniFareRuleType3"] != null)
                                                    Text(flight["MiniFareRuleType3"]),
                                                  if (flight["MiniFareRuleType3"] != null) SizedBox(height: 4),
                                                  if (flight["MiniFareRuleDetails3"] != null)
                                                    Text(flight["MiniFareRuleDetails3"]),
                                                ],
                                              ),
                                          ],
                                        ),

                                      if (isExpanded && index == 0)
                                        Divider(),
                                      if (isExpanded && index == 0)
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            // First Section
                                            Text(
                                              "Penalty Charges :",
                                              style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                                height: 6),

                                            // Content in bullet style
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                    "• Last Ticketing Date : ${flight["LastTicketingDate"]}"),
                                                SizedBox(height: 4),
                                                Text(
                                                    "• Ticket Advisory :${flight["TicketAdvisory"]}"),
                                                SizedBox(height: 4),
                                                Text(
                                                    "• Penalty Reissue Charge:${flight["PenaltyReissueCharge"]}"),
                                              ],
                                            ),

                                            const SizedBox(
                                                height: 12),
                                          ],
                                        ),

                                      if ( index == 0)
                                        Container(
                                          color: Colors.grey[100], // Light grey background
                                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/money.png",
                                                        height: 18,
                                                        width: 18,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        flight["Refundable"],
                                                        style: TextStyle(
                                                          color: Colors.teal,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),


                                                  const SizedBox(width: 8),
                                                  const Text(
                                                    "Fare Rules",
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight: FontWeight.w500,
                                                      decoration: TextDecoration.underline,
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
                                if (flight["RowType"] ==
                                    "MainRow") ...[

                                  const SizedBox(height: 3),
                                ],
                                Builder(
                                  builder: (context) {
                                    if (index + 1 <
                                        resultFlightData.length) {
                                      final current =
                                      resultFlightData[index];
                                      final next = resultFlightData[
                                      index + 1];

                                      final currentRowType =
                                          current['RowType']
                                              ?.toString() ??
                                              '';
                                      final nextRowType =
                                          next['RowType']
                                              ?.toString() ??
                                              '';
                                      final currentMainRow =
                                          current['MainRowNumber']
                                              ?.toString() ??
                                              '';
                                      final nextMainRow =
                                          next['MainRowNumber']
                                              ?.toString() ??
                                              '';

                                      // ✅ Show layover only between flights of the same MainRow group and if both are SubRows
                                      if (currentMainRow ==
                                          nextMainRow &&
                                          currentRowType ==
                                              'SubRow' &&
                                          nextRowType == 'SubRow') {
                                        DateTime arrivalDate =
                                        DateTime.parse(current[
                                        'ArrivalDate']);
                                        DateTime nextDepartureDate =
                                        DateTime.parse(next[
                                        'DepartureDate']);

                                        Duration layoverDuration =
                                        nextDepartureDate
                                            .difference(
                                            arrivalDate);
                                        String layoverHours =
                                        layoverDuration.inHours
                                            .toString();
                                        String layoverMinutes =
                                        (layoverDuration
                                            .inMinutes
                                            .remainder(60))
                                            .toString();
                                        String layoverAirportCode =
                                            current['ArriveCityCode'] ??
                                                '';

                                        return Container(
                                          padding:
                                          EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 10),
                                          width: double.infinity,
                                          color: Colors.white,
                                          child: Container(
                                            width: double.infinity,
                                            padding:
                                            EdgeInsets.all(10),
                                            decoration:
                                            BoxDecoration(
                                              color: Colors
                                                  .yellow.shade100,
                                              border: Border.all(
                                                  color: Colors
                                                      .orange),
                                              borderRadius:
                                              BorderRadius
                                                  .circular(6),
                                            ),
                                            child: Text(
                                              'Layover: $layoverHours hr $layoverMinutes min at $layoverAirportCode',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                  Colors.black),
                                            ),
                                          ),
                                        );
                                      }
                                    }

                                    // If no layover, return empty widget
                                    return SizedBox.shrink();
                                  },
                                ),
                              ],
                            );
                          },
                        ),

                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      'Fare Summary',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  margin:
                                  EdgeInsets.only(bottom: 0),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3,
                                        vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        // Base Fare Section
                                        if (adultCountInt > 0)
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                  "ADT x $adultCountInt"),
                                              Text(
                                                  "${fareSummary?['AdualFare']}"),
                                            ],
                                          ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        if (childrenCount > 0)
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                  "CHD x $childrenCount"),
                                              Text(
                                                  "${fareSummary?['ChildFare']}"),
                                            ],
                                          ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        if (InfantCount > 0)
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                  "INF x $InfantCount"),
                                              Text(
                                                  "${fareSummary?['InfantFare']}"),
                                            ],
                                          ),

                                        SizedBox(height: 10),
                                        Text("Tax",
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight
                                                    .bold)),
                                        SizedBox(height: 10),
                                        // Tax Section
                                        if (adultCountInt > 0)
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                  "ADT x $adultCountInt"),
                                              Text(
                                                  "${fareSummary?['AdualTaxFare']}"),
                                            ],
                                          ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        if (childrenCount > 0)
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                  "CHD x $childrenCount"),
                                              Text(
                                                  "${fareSummary?['ChildTaxFare']}"),
                                            ],
                                          ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        if (InfantCount > 0)
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                  "INF x $InfantCount"),
                                              Text(
                                                  "${fareSummary?['InfantTaxFare']}"),
                                            ],
                                          ),

                                        SizedBox(height: 10),

                                        // Summary
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text("Total Fare"),
                                            Text(totalFare
                                                .toStringAsFixed(
                                                2)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text("GST(0.10%)"),
                                            Text(
                                                gst.toStringAsFixed(
                                                    2)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(
                                                "Convenience Fees"),
                                            Text(convenience
                                                .toStringAsFixed(
                                                2)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text("Discount"),
                                            Text(
                                                "${discount.toStringAsFixed(2)}"),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Divider(),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text("Grand Total",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize: 17)),
                                            Text(
                                              grandTotal
                                                  .toStringAsFixed(
                                                  2),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold),
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
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, bottom: 5, top: 5),
                                child: Text(
                                  'Travellers',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Adults',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Column(
                                children: List.generate(
                                    adultCountInt, (i) {
                                  // Determine if there is valid adult data
                                  bool hasAdultData =
                                      _adultsList.length > i &&
                                          _adultsList[i] != null &&
                                          _adultsList[i]
                                          ['firstName'] !=
                                              null;
                                  if (hasAdultData) {
                                    switch (i) {
                                      case 0:
                                        TitleAdult1 = _adultsList[i]
                                        ['title'] ??
                                            '';
                                        FNameAdult1 = _adultsList[i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult1 = _adultsList[i]
                                        ['middleName'] ??
                                            '';
                                        LNameAdult1 = _adultsList[i]
                                        ['surname'] ??
                                            '';
                                        LDOBAdult1 = _adultsList[i]
                                        ['dob'] ??
                                            '';
                                        GenderAdult1 =
                                            _adultsList[i]
                                            ['gender'] ??
                                                '';
                                        DocNumAdult1 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        issueDateAdult1 =
                                            _adultsList[i]
                                            ['issueDate'] ??
                                                '';
                                        expDateAdult1 = _adultsList[
                                        i]['expiryDate'] ??
                                            '';
                                        break;
                                      case 1:
                                        TitleAdult2 = _adultsList[i]
                                        ['title'] ??
                                            '';
                                        FNameAdult2 = _adultsList[i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult2 = _adultsList[i]
                                        ['middleName'] ??
                                            '';
                                        LNameAdult2 = _adultsList[i]
                                        ['surname'] ??
                                            '';
                                        LDOBAdult2 = _adultsList[i]
                                        ['dob'] ??
                                            '';
                                        GenderAdult2 =
                                            _adultsList[i]
                                            ['gender'] ??
                                                '';
                                        DocNumAdult2 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult2 =
                                            _adultsList[i]
                                            ['issueDate'] ??
                                                '';
                                        ExpDateAdult2 = _adultsList[
                                        i]['expiryDate'] ??
                                            '';
                                        break;
                                      case 2:
                                        TitleAdult3 = _adultsList[i]
                                        ['title'] ??
                                            '';
                                        FNameAdult3 = _adultsList[i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult3 = _adultsList[i]
                                        ['middleName'] ??
                                            '';
                                        LNameAdult3 = _adultsList[i]
                                        ['surname'] ??
                                            '';
                                        LDOBAdult3 = _adultsList[i]
                                        ['dob'] ??
                                            '';
                                        GenderAdult3 =
                                            _adultsList[i]
                                            ['gender'] ??
                                                '';
                                        DocNumAdult3 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult3 =
                                            _adultsList[i]
                                            ['issueDate'] ??
                                                '';
                                        ExpDateAdult3 = _adultsList[
                                        i]['expiryDate'] ??
                                            '';
                                        break;
                                      case 3:
                                        TitleAdult4 = _adultsList[i]
                                        ['title'] ??
                                            '';
                                        FNameAdult4 = _adultsList[i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult4 = _adultsList[i]
                                        ['middleName'] ??
                                            '';
                                        LNameAdult4 = _adultsList[i]
                                        ['surname'] ??
                                            '';
                                        LDOBAdult4 = _adultsList[i]
                                        ['dob'] ??
                                            '';
                                        GenderAdult4 =
                                            _adultsList[i]
                                            ['gender'] ??
                                                '';
                                        DocNumAdult4 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult4 =
                                            _adultsList[i]
                                            ['issueDate'] ??
                                                '';
                                        ExpDateAdult4 = _adultsList[
                                        i]['expiryDate'] ??
                                            '';
                                        break;
                                      case 4:
                                        TitleAdult5 = _adultsList[i]
                                        ['title'] ??
                                            '';
                                        FNameAdult5 = _adultsList[i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult5 = _adultsList[i]
                                        ['middleName'] ??
                                            '';
                                        LNameAdult5 = _adultsList[i]
                                        ['surname'] ??
                                            '';
                                        LDOBAdult5 = _adultsList[i]
                                        ['dob'] ??
                                            '';
                                        GenderAdult5 =
                                            _adultsList[i]
                                            ['gender'] ??
                                                '';
                                        DocNumAdult5 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult5 =
                                            _adultsList[i]
                                            ['issueDate'] ??
                                                '';
                                        ExpDateAdult5 = _adultsList[
                                        i]['expiryDate'] ??
                                            '';
                                        break;
                                      case 5:
                                        TitleAdult6 = _adultsList[i]
                                        ['title'] ??
                                            '';
                                        FNameAdult6 = _adultsList[i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult6 = _adultsList[i]
                                        ['middleName'] ??
                                            '';
                                        LNameAdult6 = _adultsList[i]
                                        ['surname'] ??
                                            '';
                                        LDOBAdult6 = _adultsList[i]
                                        ['dob'] ??
                                            '';
                                        GenderAdult6 =
                                            _adultsList[i]
                                            ['gender'] ??
                                                '';
                                        DocNumAdult6 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult6 =
                                            _adultsList[i]
                                            ['issueDate'] ??
                                                '';
                                        ExpDateAdult6 = _adultsList[
                                        i]['expiryDate'] ??
                                            '';
                                        break;
                                      case 6:
                                        TitleAdult7 = _adultsList[i]
                                        ['title'] ??
                                            '';
                                        FNameAdult7 = _adultsList[i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult7 = _adultsList[i]
                                        ['middleName'] ??
                                            '';
                                        LNameAdult7 = _adultsList[i]
                                        ['surname'] ??
                                            '';
                                        LDOBAdult7 = _adultsList[i]
                                        ['dob'] ??
                                            '';
                                        GenderAdult7 =
                                            _adultsList[i]
                                            ['gender'] ??
                                                '';
                                        DocNumAdult7 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult7 =
                                            _adultsList[i]
                                            ['issueDate'] ??
                                                '';
                                        ExpDateAdult7 = _adultsList[
                                        i]['expiryDate'] ??
                                            '';
                                        break;
                                      case 7:
                                        TitleAdult8 = _adultsList[i]
                                        ['title'] ??
                                            '';
                                        FNameAdult8 = _adultsList[i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult8 = _adultsList[i]
                                        ['middleName'] ??
                                            '';
                                        LNameAdult8 = _adultsList[i]
                                        ['surname'] ??
                                            '';
                                        LDOBAdult8 = _adultsList[i]
                                        ['dob'] ??
                                            '';
                                        GenderAdult8 =
                                            _adultsList[i]
                                            ['gender'] ??
                                                '';
                                        DocNumAdult8 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult8 =
                                            _adultsList[i]
                                            ['issueDate'] ??
                                                '';
                                        ExpDateAdult8 = _adultsList[
                                        i]['expiryDate'] ??
                                            '';
                                        break;
                                      case 8:
                                        TitleAdult9 = _adultsList[i]
                                        ['title'] ??
                                            '';
                                        FNameAdult9 = _adultsList[i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult9 = _adultsList[i]
                                        ['middleName'] ??
                                            '';
                                        LNameAdult9 = _adultsList[i]
                                        ['surname'] ??
                                            '';
                                        LDOBAdult9 = _adultsList[i]
                                        ['dob'] ??
                                            '';
                                        GenderAdult9 =
                                            _adultsList[i]
                                            ['gender'] ??
                                                '';
                                        DocNumAdult9 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult9 =
                                            _adultsList[i]
                                            ['issueDate'] ??
                                                '';
                                        ExpDateAdult9 = _adultsList[
                                        i]['expiryDate'] ??
                                            '';
                                        break;
                                      case 9:
                                        TitleAdult10 =
                                            _adultsList[i]
                                            ['title'] ??
                                                '';
                                        FNameAdult10 =
                                            _adultsList[i]
                                            ['firstName'] ??
                                                '';
                                        MNameAdult10 = _adultsList[
                                        i]['middleName'] ??
                                            '';
                                        LNameAdult10 =
                                            _adultsList[i]
                                            ['surname'] ??
                                                '';
                                        LDOBAdult10 = _adultsList[i]
                                        ['dob'] ??
                                            '';
                                        GenderAdult10 =
                                            _adultsList[i]
                                            ['gender'] ??
                                                '';
                                        DocNumAdult10 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult10 =
                                            _adultsList[i]
                                            ['issueDate'] ??
                                                '';
                                        ExpDateAdult10 =
                                            _adultsList[i][
                                            'expiryDate'] ??
                                                '';
                                        break;
                                    }
                                  }

                                  print('hasAdultData: ' +
                                      hasAdultData.toString());

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14,
                                        right: 15,
                                        top: 7),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                          hasAdultData
                                              ? Color(
                                              0xFF1C5870)
                                              : Colors.grey,
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: !hasAdultData &&
                                                !isEditAdult
                                                ? () {
                                              // Navigate to the page to add an adult if there's no data
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                      AddAdultScreen(
                                                        isEdit:
                                                        'Add',
                                                        adultIndex:
                                                        i,
                                                        adultsList:
                                                        _adultsList,
                                                        flightDetails:
                                                        '',
                                                        resultFlightData:
                                                        '',
                                                        infantCount:
                                                        0,
                                                        childrenCount:
                                                        0,
                                                        adultCount:
                                                        adultCountInt,
                                                        departdate:
                                                        '',
                                                        userid:
                                                        '',
                                                        usertypeid:
                                                        '',
                                                      ),
                                                ),
                                              ).then((_) {
                                                // Fetch the updated adults list when returning to this page
                                                _fetchAdults();
                                              });
                                            }
                                                : null,
                                            // Disable if there is adult data or isEdit is true
                                            child: Text(
                                              hasAdultData
                                                  ? '${_adultsList[i]['firstName']} ${_adultsList[i]['surname']}'
                                                  : 'Select Adult ${i + 1}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: hasAdultData
                                                      ? Colors.black
                                                      : Colors
                                                      .black),
                                            ),
                                          ),
                                        ),
                                        // Edit Button
                                        IconButton(
                                          icon: Icon(Icons.edit,
                                              color: Color(
                                                  0xFF1C5870)),
                                          onPressed: hasAdultData &&
                                              !isEditAdult
                                              ? () {
                                            // Navigate to edit screen if adult data exists and not in edit mode
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                    AddAdultScreen(
                                                      isEdit:
                                                      'Edit',
                                                      adultIndex:
                                                      i,
                                                      adultsList:
                                                      _adultsList,
                                                      flightDetails:
                                                      '',
                                                      resultFlightData:
                                                      '',
                                                      infantCount:
                                                      0,
                                                      childrenCount:
                                                      0,
                                                      adultCount:
                                                      adultCountInt,
                                                      departdate:
                                                      '',
                                                      userid: '',
                                                      usertypeid:
                                                      '',
                                                    ),
                                              ),
                                            ).then((_) {
                                              // Fetch the updated adults list when returning to this page
                                              _fetchAdults();
                                            });
                                          }
                                              : null, // Disable if there is no adult data or isEdit is true
                                        ),
                                        // Delete Button
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: hasAdultData &&
                                              !isEditAdult
                                              ? () {
                                            // Show confirmation dialog
                                            showDialog(
                                              context:
                                              context,
                                              builder:
                                                  (BuildContext
                                              context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Confirm Deletion'),
                                                  content: Text(
                                                      'Are you sure you want to delete this adult?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text(
                                                          'No'),
                                                      onPressed:
                                                          () {
                                                        Navigator.of(context)
                                                            .pop(); // Close dialog
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text(
                                                          'Yes'),
                                                      onPressed:
                                                          () {
                                                        _deleteAdult(
                                                            i); // Call delete method
                                                        Navigator.of(context)
                                                            .pop(); // Close dialog
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                              : null, // Disable if there is no adult data or isEdit is true
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                              if (childrenCount > 1) Divider(),
                              if (childrenCount > 1)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Children',
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Column(
                                        children: List.generate(
                                            childrenCount, (i) {
                                          // Determine if there is valid child data
                                          bool hasChildData =
                                              _childrenList.length >
                                                  i &&
                                                  _childrenList[
                                                  i] !=
                                                      null &&
                                                  _childrenList[i][
                                                  'firstName'] !=
                                                      null;
                                          if (hasChildData) {
                                            switch (i) {
                                              case 0:
                                                TitleChild1 =
                                                    _childrenList[i]
                                                    [
                                                    'title'] ??
                                                        '';
                                                FNameChild1 =
                                                    _childrenList[i]
                                                    [
                                                    'firstName'] ??
                                                        '';
                                                MNameChild1 =
                                                    _childrenList[i]
                                                    [
                                                    'middleName'] ??
                                                        '';
                                                LNameChild1 =
                                                    _childrenList[i]
                                                    [
                                                    'surname'] ??
                                                        '';
                                                LDOBChild1 =
                                                    _childrenList[i]
                                                    [
                                                    'dob'] ??
                                                        '';
                                                GenderChild1 =
                                                    _childrenList[i]
                                                    [
                                                    'gender'] ??
                                                        '';
                                                DocNumChild1 =
                                                    _childrenList[i]
                                                    [
                                                    'documentNumber'] ??
                                                        '';
                                                IssueDateChild1 =
                                                    _childrenList[i]
                                                    [
                                                    'issueDate'] ??
                                                        '';
                                                ExpDateChild1 =
                                                    _childrenList[i]
                                                    [
                                                    'expiryDate'] ??
                                                        '';
                                                break;
                                              case 1:
                                                TitleChild2 =
                                                    _childrenList[i]
                                                    [
                                                    'title'] ??
                                                        '';
                                                FNameChild2 =
                                                    _childrenList[i]
                                                    [
                                                    'firstName'] ??
                                                        '';
                                                MNameChild2 =
                                                    _childrenList[i]
                                                    [
                                                    'middleName'] ??
                                                        '';
                                                LNameChild2 =
                                                    _childrenList[i]
                                                    [
                                                    'surname'] ??
                                                        '';
                                                LDOBChild2 =
                                                    _childrenList[i]
                                                    [
                                                    'dob'] ??
                                                        '';
                                                GenderChild2 =
                                                    _childrenList[i]
                                                    [
                                                    'gender'] ??
                                                        '';
                                                DocNumChild2 =
                                                    _childrenList[i]
                                                    [
                                                    'documentNumber'] ??
                                                        '';
                                                IssueDateChild2 =
                                                    _childrenList[i]
                                                    [
                                                    'issueDate'] ??
                                                        '';
                                                ExpDateChild2 =
                                                    _childrenList[i]
                                                    [
                                                    'expiryDate'] ??
                                                        '';
                                                break;
                                              case 2:
                                                TitleChild3 =
                                                    _childrenList[i]
                                                    [
                                                    'title'] ??
                                                        '';
                                                FNameChild3 =
                                                    _childrenList[i]
                                                    [
                                                    'firstName'] ??
                                                        '';
                                                MNameChild3 =
                                                    _childrenList[i]
                                                    [
                                                    'middleName'] ??
                                                        '';
                                                LNameChild3 =
                                                    _childrenList[i]
                                                    [
                                                    'surname'] ??
                                                        '';
                                                LDOBChild3 =
                                                    _childrenList[i]
                                                    [
                                                    'dob'] ??
                                                        '';
                                                GenderChild3 =
                                                    _childrenList[i]
                                                    [
                                                    'gender'] ??
                                                        '';
                                                DocNumChild3 =
                                                    _childrenList[i]
                                                    [
                                                    'documentNumber'] ??
                                                        '';
                                                IssueDateChild3 =
                                                    _childrenList[i]
                                                    [
                                                    'issueDate'] ??
                                                        '';
                                                ExpDateChild3 =
                                                    _childrenList[i]
                                                    [
                                                    'expiryDate'] ??
                                                        '';
                                                break;
                                              case 3:
                                                TitleChild4 =
                                                    _childrenList[i]
                                                    [
                                                    'title'] ??
                                                        '';
                                                FNameChild4 =
                                                    _childrenList[i]
                                                    [
                                                    'firstName'] ??
                                                        '';
                                                MNameChild4 =
                                                    _childrenList[i]
                                                    [
                                                    'middleName'] ??
                                                        '';
                                                LNameChild4 =
                                                    _childrenList[i]
                                                    [
                                                    'surname'] ??
                                                        '';
                                                LDOBChild4 =
                                                    _childrenList[i]
                                                    [
                                                    'dob'] ??
                                                        '';
                                                GenderChild4 =
                                                    _childrenList[i]
                                                    [
                                                    'gender'] ??
                                                        '';
                                                DocNumChild4 =
                                                    _childrenList[i]
                                                    [
                                                    'documentNumber'] ??
                                                        '';
                                                IssueDateChild4 =
                                                    _childrenList[i]
                                                    [
                                                    'issueDate'] ??
                                                        '';
                                                ExpDateChild4 =
                                                    _childrenList[i]
                                                    [
                                                    'expiryDate'] ??
                                                        '';
                                                break;
                                              case 4:
                                                TitleChild5 =
                                                    _childrenList[i]
                                                    [
                                                    'title'] ??
                                                        '';
                                                FNameChild5 =
                                                    _childrenList[i]
                                                    [
                                                    'firstName'] ??
                                                        '';
                                                MNameChild5 =
                                                    _childrenList[i]
                                                    [
                                                    'middleName'] ??
                                                        '';
                                                LNameChild5 =
                                                    _childrenList[i]
                                                    [
                                                    'surname'] ??
                                                        '';
                                                LDOBChild5 =
                                                    _childrenList[i]
                                                    [
                                                    'dob'] ??
                                                        '';
                                                GenderChild5 =
                                                    _childrenList[i]
                                                    [
                                                    'gender'] ??
                                                        '';
                                                DocNumChild5 =
                                                    _childrenList[i]
                                                    [
                                                    'documentNumber'] ??
                                                        '';
                                                IssueDateChild5 =
                                                    _childrenList[i]
                                                    [
                                                    'issueDate'] ??
                                                        '';
                                                ExpDateChild5 =
                                                    _childrenList[i]
                                                    [
                                                    'expiryDate'] ??
                                                        '';
                                                break;
                                            }
                                          }

                                          print('hasChildData: ' +
                                              hasChildData
                                                  .toString());

                                          return Padding(
                                            padding:
                                            const EdgeInsets
                                                .all(8.0),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                  hasChildData
                                                      ? Colors
                                                      .green
                                                      : Colors
                                                      .grey,
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child:
                                                  GestureDetector(
                                                    onTap: !hasChildData &&
                                                        !isEditChild
                                                        ? () {
                                                      // Navigate to the page to add a child if there's no data
                                                      Navigator
                                                          .push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddChildScreen(
                                                                isEdit: 'Add',
                                                                childIndex: i,
                                                                childrenList: _childrenList,
                                                                flightDetails: '',
                                                                resultFlightData: '',
                                                                infantCount: 0,
                                                                childrenCount: childrenCount,
                                                                adultCount: 0,
                                                                departdate: '',
                                                                userid: '',
                                                                usertypeid: '',
                                                              ),
                                                        ),
                                                      ).then(
                                                              (_) {
                                                            // Fetch the updated children list when returning to this page
                                                            _fetchChildren();
                                                          });
                                                    }
                                                        : null,
                                                    // Disable if there is child data or isEdit is true
                                                    child: Text(
                                                      hasChildData
                                                          ? '${_childrenList[i]['firstName']} ${_childrenList[i]['surname']}'
                                                          : 'Select Child ${i + 1}',
                                                      style:
                                                      TextStyle(
                                                        fontSize:
                                                        16,
                                                        color: hasChildData
                                                            ? Colors
                                                            .black
                                                            : Colors
                                                            .black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // Edit Button
                                                IconButton(
                                                  icon: Icon(
                                                      Icons.edit,
                                                      color: Colors
                                                          .blue),
                                                  onPressed: hasChildData &&
                                                      !isEditChild
                                                      ? () {
                                                    // Navigate to edit screen if child data exists and not in edit mode
                                                    Navigator
                                                        .push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddChildScreen(
                                                              isEdit:
                                                              'Edit',
                                                              childIndex:
                                                              i,
                                                              childrenList:
                                                              _childrenList,
                                                              flightDetails:
                                                              '',
                                                              resultFlightData:
                                                              '',
                                                              infantCount:
                                                              0,
                                                              childrenCount:
                                                              childrenCount,
                                                              adultCount:
                                                              0,
                                                              departdate:
                                                              '',
                                                              userid:
                                                              '',
                                                              usertypeid:
                                                              '',
                                                            ),
                                                      ),
                                                    ).then(
                                                            (_) {
                                                          // Fetch the updated children list when returning to this page
                                                          _fetchChildren();
                                                        });
                                                  }
                                                      : null, // Disable if there is no child data or isEdit is true
                                                ),
                                                // Delete Button
                                                IconButton(
                                                  icon: Icon(
                                                      Icons.delete,
                                                      color: Colors
                                                          .red),
                                                  onPressed: hasChildData &&
                                                      !isEditChild
                                                      ? () {
                                                    // Show confirmation dialog
                                                    showDialog(
                                                      context:
                                                      context,
                                                      builder:
                                                          (BuildContext
                                                      context) {
                                                        return AlertDialog(
                                                          title:
                                                          Text('Confirm Deletion'),
                                                          content:
                                                          Text('Are you sure you want to delete this child?'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: Text('No'),
                                                              onPressed: () {
                                                                Navigator.of(context).pop(); // Close dialog
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: Text('Yes'),
                                                              onPressed: () {
                                                                _deleteChild(i); // Call delete method for child
                                                                Navigator.of(context).pop(); // Close dialog
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                      : null, // Disable if there is no child data or isEdit is true
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              if (InfantCount > 1) Divider(),
                              if (InfantCount > 1)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Infants',
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Column(
                                        children: List.generate(
                                            InfantCount, (i) {
                                          // Determine if there is valid child data
                                          bool hasInfantData =
                                              _infantList.length >
                                                  i &&
                                                  _infantList[i] !=
                                                      null &&
                                                  _infantList[i][
                                                  'firstName'] !=
                                                      null;
                                          if (hasInfantData) {
                                            switch (i) {
                                              case 0:
                                                TitleInfant1 =
                                                    _infantList[i][
                                                    'title'] ??
                                                        '';
                                                FNameInfant1 =
                                                    _infantList[i][
                                                    'firstName'] ??
                                                        '';
                                                MNameInfant1 =
                                                    _infantList[i][
                                                    'middleName'] ??
                                                        '';
                                                LNameInfant1 =
                                                    _infantList[i][
                                                    'surname'] ??
                                                        '';
                                                LDOBInfant1 =
                                                    _infantList[i][
                                                    'dob'] ??
                                                        '';
                                                GenderInfant1 =
                                                    _infantList[i][
                                                    'gender'] ??
                                                        '';
                                                DocNumInfant1 =
                                                    _infantList[i][
                                                    'documentNumber'] ??
                                                        '';
                                                IssueDateInfant1 =
                                                    _infantList[i][
                                                    'issueDate'] ??
                                                        '';
                                                ExpDateInfant1 =
                                                    _infantList[i][
                                                    'expiryDate'] ??
                                                        '';
                                                break;

                                              case 1:
                                                TitleInfant2 =
                                                    _infantList[i][
                                                    'title'] ??
                                                        '';
                                                FNameInfant2 =
                                                    _infantList[i][
                                                    'firstName'] ??
                                                        '';
                                                MNameInfant2 =
                                                    _infantList[i][
                                                    'middleName'] ??
                                                        '';
                                                LNameInfant2 =
                                                    _infantList[i][
                                                    'surname'] ??
                                                        '';
                                                LDOBInfant2 =
                                                    _infantList[i][
                                                    'dob'] ??
                                                        '';
                                                GenderInfant2 =
                                                    _infantList[i][
                                                    'gender'] ??
                                                        '';
                                                DocNumInfant2 =
                                                    _infantList[i][
                                                    'documentNumber'] ??
                                                        '';
                                                IssueDateInfant2 =
                                                    _infantList[i][
                                                    'issueDate'] ??
                                                        '';
                                                ExpDateInfant2 =
                                                    _infantList[i][
                                                    'expiryDate'] ??
                                                        '';
                                                break;

                                              case 2:
                                                TitleInfant3 =
                                                    _infantList[i][
                                                    'title'] ??
                                                        '';
                                                FNameInfant3 =
                                                    _infantList[i][
                                                    'firstName'] ??
                                                        '';
                                                MNameInfant3 =
                                                    _infantList[i][
                                                    'middleName'] ??
                                                        '';
                                                LNameInfant3 =
                                                    _infantList[i][
                                                    'surname'] ??
                                                        '';
                                                LDOBInfant3 =
                                                    _infantList[i][
                                                    'dob'] ??
                                                        '';
                                                GenderInfant3 =
                                                    _infantList[i][
                                                    'gender'] ??
                                                        '';
                                                DocNumInfant3 =
                                                    _infantList[i][
                                                    'documentNumber'] ??
                                                        '';
                                                IssueDateInfant3 =
                                                    _infantList[i][
                                                    'issueDate'] ??
                                                        '';
                                                ExpDateInfant3 =
                                                    _infantList[i][
                                                    'expiryDate'] ??
                                                        '';
                                                break;

                                              case 3:
                                                TitleInfant4 =
                                                    _infantList[i][
                                                    'title'] ??
                                                        '';
                                                FNameInfant4 =
                                                    _infantList[i][
                                                    'firstName'] ??
                                                        '';
                                                MNameInfant4 =
                                                    _infantList[i][
                                                    'middleName'] ??
                                                        '';
                                                LNameInfant4 =
                                                    _infantList[i][
                                                    'surname'] ??
                                                        '';
                                                LDOBInfant4 =
                                                    _infantList[i][
                                                    'dob'] ??
                                                        '';
                                                GenderInfant4 =
                                                    _infantList[i][
                                                    'gender'] ??
                                                        '';
                                                DocNumInfant4 =
                                                    _infantList[i][
                                                    'documentNumber'] ??
                                                        '';
                                                IssueDateInfant4 =
                                                    _infantList[i][
                                                    'issueDate'] ??
                                                        '';
                                                ExpDateInfant4 =
                                                    _infantList[i][
                                                    'expiryDate'] ??
                                                        '';
                                                break;

                                              case 4:
                                                TitleInfant5 =
                                                    _infantList[i][
                                                    'title'] ??
                                                        '';
                                                FNameInfant5 =
                                                    _infantList[i][
                                                    'firstName'] ??
                                                        '';
                                                MNameInfant5 =
                                                    _infantList[i][
                                                    'middleName'] ??
                                                        '';
                                                LNameInfant5 =
                                                    _infantList[i][
                                                    'surname'] ??
                                                        '';
                                                LDOBInfant5 =
                                                    _infantList[i][
                                                    'dob'] ??
                                                        '';
                                                GenderInfant5 =
                                                    _infantList[i][
                                                    'gender'] ??
                                                        '';
                                                DocNumInfant5 =
                                                    _infantList[i][
                                                    'documentNumber'] ??
                                                        '';
                                                IssueDateInfant5 =
                                                    _infantList[i][
                                                    'issueDate'] ??
                                                        '';
                                                ExpDateInfant5 =
                                                    _infantList[i][
                                                    'expiryDate'] ??
                                                        '';
                                                break;
                                            }
                                          }

                                          print('hasChildData: ' +
                                              hasInfantData
                                                  .toString());

                                          return Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                              right: 10,
                                            ),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                  hasInfantData
                                                      ? Colors
                                                      .green
                                                      : Colors
                                                      .grey,
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child:
                                                  GestureDetector(
                                                    onTap: !hasInfantData &&
                                                        !isEditInfant
                                                        ? () {
                                                      // Navigate to the page to add a child if there's no data
                                                      Navigator
                                                          .push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddInfantScreen(
                                                                isEdit: 'Add',
                                                                InfantIndex: i,
                                                                InfantList: _infantList,
                                                                flightDetails: '',
                                                                resultFlightData: '',
                                                                infantCount: 0,
                                                                childrenCount: InfantCount,
                                                                adultCount: 0,
                                                                departdate: '',
                                                                userid: '',
                                                                usertypeid: '',
                                                              ),
                                                        ),
                                                      ).then(
                                                              (_) {
                                                            // Fetch the updated children list when returning to this page
                                                            _fetchInfant();
                                                          });
                                                    }
                                                        : null,
                                                    // Disable if there is child data or isEdit is true
                                                    child: Text(
                                                      hasInfantData
                                                          ? '${_infantList[i]['firstName']} ${_infantList[i]['surname']}'
                                                          : 'Select Infant ${i + 1}',
                                                      style:
                                                      TextStyle(
                                                        fontSize:
                                                        16,
                                                        color: hasInfantData
                                                            ? Colors
                                                            .black
                                                            : Colors
                                                            .black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // Edit Button
                                                IconButton(
                                                  icon: Icon(
                                                      Icons.edit,
                                                      color: Color(
                                                          0xFF1C5870)),
                                                  onPressed: hasInfantData &&
                                                      !isEditInfant
                                                      ? () {
                                                    // Navigate to edit screen if child data exists and not in edit mode
                                                    Navigator
                                                        .push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddInfantScreen(
                                                              isEdit:
                                                              'Edit',
                                                              InfantIndex:
                                                              i,
                                                              InfantList:
                                                              _infantList,
                                                              flightDetails:
                                                              '',
                                                              resultFlightData:
                                                              '',
                                                              infantCount:
                                                              0,
                                                              childrenCount:
                                                              InfantCount,
                                                              adultCount:
                                                              0,
                                                              departdate:
                                                              '',
                                                              userid:
                                                              '',
                                                              usertypeid:
                                                              '',
                                                            ),
                                                      ),
                                                    ).then(
                                                            (_) {
                                                          // Fetch the updated children list when returning to this page
                                                          _fetchInfant();
                                                        });
                                                  }
                                                      : null, // Disable if there is no child data or isEdit is true
                                                ),
                                                // Delete Button
                                                IconButton(
                                                  icon: Icon(
                                                      Icons.delete,
                                                      color: Colors
                                                          .red),
                                                  onPressed: hasInfantData &&
                                                      !isEditInfant
                                                      ? () {
                                                    // Show confirmation dialog
                                                    showDialog(
                                                      context:
                                                      context,
                                                      builder:
                                                          (BuildContext
                                                      context) {
                                                        return AlertDialog(
                                                          title:
                                                          Text('Confirm Deletion'),
                                                          content:
                                                          Text('Are you sure you want to delete this child?'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: Text('No'),
                                                              onPressed: () {
                                                                Navigator.of(context).pop(); // Close dialog
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: Text('Yes'),
                                                              onPressed: () {
                                                                _deleteInfant(i); // Call delete method for child
                                                                Navigator.of(context).pop(); // Close dialog
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                      : null, // Disable if there is no child data or isEdit is true
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10),
                                child: Text(
                                  "Contact Details",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Enter Your Email:",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                // Padding 10 on all sides
                                child: TextField(
                                  controller: EmailController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Email',
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 10),
                                    border: OutlineInputBorder(
                                      // Add border
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      // Optional: rounded corners
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                    ),
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                    ),
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Select Country",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                child: Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey),
                                    // Border color
                                    borderRadius:
                                    BorderRadius.circular(
                                        8), // Rounded corners
                                  ),
                                  child:
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        value: selectedCountry,
                                        hint: Text(
                                            'Select a country'),
                                        isExpanded: true,
                                        // Optional: makes the dropdown take full width
                                        items: countries
                                            .map((String value) {
                                          final parts =
                                          value.split(' - ');
                                          final countryName =
                                          parts[0].trim();
                                          final countryCode =
                                          parts.length > 1
                                              ? parts[1].trim()
                                              : '';
                                          final phoneCode =
                                              countryPhoneMap[
                                              countryName] ??
                                                  '';

                                          final displayText = phoneCode
                                              .isNotEmpty
                                              ? '$countryName - $countryCode ($phoneCode)'
                                              : '$countryName - $countryCode';

                                          return DropdownMenuItem<
                                              String>(
                                            value: value,
                                            child:
                                            Text(displayText),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          final parts = newValue!
                                              .split(' - ');
                                          final countryName =
                                          parts[0].trim();
                                          final countryCode =
                                          parts.length > 1
                                              ? parts[1].trim()
                                              : '';
                                          final phoneCode =
                                              countryPhoneMap[
                                              countryName] ??
                                                  '';

                                          setState(() {
                                            selectedCountry =
                                                newValue;
                                            selectedCountryCode =
                                                countryCode;
                                            selectedPhoneCode =
                                                phoneCode;
                                          });

                                          print(
                                              'Country Code: $selectedCountryCode');
                                          print(
                                              'Phone Code: $selectedPhoneCode');
                                        }),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Enter Your Mobile:",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                // Padding 10 on all sides
                                child: TextField(
                                  controller: MobileNoController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Mobile',
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 10),
                                    border: OutlineInputBorder(
                                      // Add border
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      // Optional: rounded corners
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                    ),
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                    ),
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "House No:",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                // Padding 10 on all sides
                                child: TextField(
                                  controller: HouseNoController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter House No',
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 10),
                                    border: OutlineInputBorder(
                                      // Add border
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      // Optional: rounded corners
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                    ),
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                    ),
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Street:",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                // Padding 10 on all sides
                                child: TextField(
                                  controller: StreetNoController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Street No',
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 10),
                                    border: OutlineInputBorder(
                                      // Add border
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      // Optional: rounded corners
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                    ),
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                    ),
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "City:",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                // Padding 10 on all sides
                                child: TextField(
                                  controller: CityController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter City',
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 10),
                                    border: OutlineInputBorder(
                                      // Add border
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      // Optional: rounded corners
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                    ),
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                    ),
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Zip Code:",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                // Padding 10 on all sides
                                child: TextField(
                                  controller: zipCodeController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Zip Code',
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 10),
                                    border: OutlineInputBorder(
                                      // Add border
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      // Optional: rounded corners
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                    ),
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey),
                                    ),
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Country",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                child: Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey),
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child:
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedNationality,
                                      hint: Text(
                                          'Select Nationality'),
                                      isExpanded: true,
                                      items: nationalityList
                                          .map((String value) {
                                        return DropdownMenuItem<
                                            String>(
                                          value: value,
                                          child: Text(value
                                              .split(' - ')[
                                          0]), // Show only name
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedNationality =
                                              newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    )
                        : Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/img.png'),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                resultFlightData[0]['CarrierName'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              /* Text(
                                            'Air Asia',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),*/
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    resultFlightData[0]
                                    ['DepartureDate']
                                        .toString()
                                        .substring(0, 10),
                                  ),
                                  Text(
                                    '${CommonUtils.convertToFormattedTime(resultFlightData[0]['DepartureDate']).toString().toUpperCase()} ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(resultFlightData[0]
                                  ['DepartCityName']),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      resultFlightData[0]
                                      ['DepartAirportName'],
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                      'Terminal' +
                                          " " +
                                          resultFlightData[0]
                                          ['DepartureTerminal'],
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 12)),
                                ],
                              ),
                              Container(
                                width: 65,
                                child: Text(
                                  resultFlightData[0]['TravelTime'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    resultFlightData[0]
                                    ['ArrivalDate']
                                        .toString()
                                        .substring(0, 10),
                                  ),
                                  Text(
                                    '${CommonUtils.convertToFormattedTime(resultFlightData[0]['ArrivalDate']).toString().toUpperCase()} ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(resultFlightData[0]
                                  ['ArriveCityName']),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      resultFlightData[0]
                                      ['ArrivalAirportName'],
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                      'Terminal' +
                                          " " +
                                          resultFlightData[0]
                                          ['ArrivalTerminal'],
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.shopping_bag,
                                        size: 16,
                                        color: Colors.grey.shade500,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Cabin Baggage: ',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        resultFlightData[0]
                                        ['CabinBaggage'],
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),

                                  // Second row: Check-In baggage details
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.shopping_bag,
                                        size: 16,
                                        color: Colors.grey.shade500,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Check-In: ',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        resultFlightData[0]
                                        ['Baggage'],
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),

                                  // Row with A30 and View More/View Less button
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      // Left side: A30 text
                                      Text(
                                        'A30',
                                        style: TextStyle(
                                            color: Colors.black54),
                                      ),

                                      // Right side: View More/View Less text with orange color
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            isExpanded =
                                            !isExpanded;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              isExpanded
                                                  ? 'View Less'
                                                  : 'View More',
                                              style: TextStyle(
                                                  color: Colors
                                                      .orange),
                                            ),
                                            Icon(
                                              isExpanded
                                                  ? Icons
                                                  .keyboard_arrow_up
                                                  : Icons
                                                  .keyboard_arrow_down,
                                              color: Colors
                                                  .orange, // Arrow icon color
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Expanded content if isExpanded is true
                                  if (isExpanded)
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                                Icons
                                                    .signal_cellular_off,
                                                size: 16),
                                            SizedBox(width: 5),
                                            Text('Narrow'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.wifi_off,
                                                size: 16),
                                            SizedBox(width: 5),
                                            Text('No WiFi'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.fastfood,
                                                size: 16),
                                            SizedBox(width: 5),
                                            Text('Fresh Food'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.power,
                                                size: 16),
                                            SizedBox(width: 5),
                                            Text('Outlet'),
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
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade100,
                    // Light grey color for the starting horizontal line
                    width: 2, // Thickness of the line
                  ),
                ),
              ),
              height: 80,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 10.0, top: 8),
                        child: Text(
                          resultFlightData[0]["Currency"] +
                              " " +
                              resultFlightData[0]["TotalPrice"],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 10.0, top: 8),
                        child: ElevatedButton(
                          onPressed: submitAdivahaFlightBooking,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFCF3D30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Container(
                            width: 95,
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              'Book Flight',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
