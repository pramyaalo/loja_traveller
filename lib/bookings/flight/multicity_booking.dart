import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as developer;

import '../../Booking/CommonUtils.dart';
import '../../DatabseHelper.dart';
import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';
import '../AddAdultScreen.dart';
import 'AddChildScreen.dart';
import 'AddInfantScreen.dart';
import 'Children_DatabaseHelper.dart';
import 'InfantDatabaseHelper.dart';
import 'MultiCityBookFlightNow.dart';
import 'Oneway_ConfirmationScreen.dart';

class MultiCityBooking extends StatefulWidget {
  final dynamic TPToken,flightDetailsList,
      flightDetails,
      departuredatefirst,
      departuredateSecond,
      departuredatethird,
      departuredatefourth,
      departCityNameSecond,
      departCityNameThird,
      departCityNameFourth,
      arriveCityNameFirst,
      arriveCityNameSecond,
      arriveCityNameThird,
      arriveCityNameFourth,
      refundable,
      adultCount,
      childrenCount,
      infantCount,
      StopCountFirst,
      StopCountSecond,
      StopCountThird,
      TotalPrice,
      TokenValue;

  const MultiCityBooking(
      {super.key,
        required this.TPToken,
        required this.flightDetailsList,
        required this.flightDetails,
        required this.departuredatefirst,
        required this.departuredateSecond,
        required this.departuredatethird,
        required this.departuredatefourth,
        required this.departCityNameSecond,
        required this.departCityNameThird,
        required this.departCityNameFourth,
        required this.arriveCityNameFirst,
        required this.arriveCityNameSecond,
        required this.arriveCityNameThird,
        required this.arriveCityNameFourth,
        required this.refundable,
        required this.infantCount,
        required this.childrenCount,
        required this.adultCount,
        required this.StopCountFirst,
        required this.StopCountSecond,
        required this.StopCountThird,
        required this.TotalPrice,
        required this.TokenValue});

  @override
  State<MultiCityBooking> createState() => _TwoWayBookingState();
}

class _TwoWayBookingState extends State<MultiCityBooking> {
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

  var resultFlightData = [];
  bool isBookingLoading = false;
  bool isLoading = false;
  List<Map<String, dynamic>> _adultsList = [];
  List<Map<String, dynamic>> _childrenList = [];
  List<Map<String, dynamic>> _infantList = [];
  bool isEditAdult = false;
  bool isEditChild = false;
  bool isEditInfant = false;
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController CityController = TextEditingController();
  TextEditingController StreetNoController = TextEditingController();
  TextEditingController HouseNoController = TextEditingController();
  TextEditingController MobileNoController = TextEditingController();
  TextEditingController EmailController = TextEditingController();


  TextEditingController contactMobileController = new TextEditingController();
  TextEditingController contactAddressController = new TextEditingController();
  TextEditingController _CountryController = new TextEditingController();
  TextEditingController Documentype_controller = new TextEditingController();
  TextEditingController Documentnumber_controller = new TextEditingController();
  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';
  bool isExpanded = false;
  bool isExpanded1 = false;
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
    print('StopCountFirst:${widget.StopCountFirst}');
    print('StopCountSecond:${widget.StopCountSecond}');
    print('StopCountThird:${widget.StopCountThird}');

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
  Future<void> _deleteChild(int index) async {
    final dbHelper = ChildrenDatabaseHelper
        .instance; // Ensure you have a database helper instance
    if (_childrenList.length > index) {
      await dbHelper.deleteChildrens(_childrenList[index]
      ['id']); // Use the appropriate method to delete from your database
      _fetchChildren(); // Refresh the list of adults after deletion
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
  String convertDuration(String duration) {
    // Example input: PT1H25M
    final regex = RegExp(r'PT(\d+H)?(\d+M)?');
    final match = regex.firstMatch(duration);

    if (match != null) {
      final hours = match.group(1)?.replaceAll('H', '') ?? '0';
      final minutes = match.group(2)?.replaceAll('M', '') ?? '0';

      String result = '';
      if (hours != '0') result += '${int.parse(hours)}h ';
      if (minutes != '0') result += '${int.parse(minutes)}m';
      return result.trim();
    }

    return duration; // Fallback
  }
  String Final_DepartureFirstDate = '',Final_DepartureSecondDate='',Final_DepartureThirdDate='',
      Final_DepartureFourthDate='';
  String convertDate(String inputDate) {
    try {
      // Parse "16 April 1997"
      DateTime parsedDate = DateFormat("d MMMM yyyy").parse(inputDate);

      // Format to "1997-16-04"
      String formattedDate = DateFormat("yyyy-dd-MM").format(parsedDate);

      return formattedDate;
    } catch (e) {
      print("Date parse error: $e");
      return inputDate;
    }
  }
  Future<void> submitAdivahaFlightBooking() async {
    final url = Uri.parse(
        'https://boqoltravel.com/app/b2badminapi.asmx/TPFlight_AddBookingDetails');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    String fullCountry = selectedCountry.toString(); // e.g. "India - IN"
    String onlyCountryName = fullCountry.split(' - ').first;
    String formattedDateTime1 = widget.departuredatefirst.toString();
    String formattedDateTime2 = widget.departuredateSecond.toString();
    String formattedDateTime3 = widget.departuredatethird.toString();
    String formattedDateTime4 = widget.departuredatefourth.toString();

    // Extract the date part using substring
    Final_DepartureFirstDate = formattedDateTime1.substring(0, 10);
    Final_DepartureSecondDate = formattedDateTime2.substring(0, 10);

    Final_DepartureThirdDate = formattedDateTime3.substring(0, 10);

    Final_DepartureFourthDate = formattedDateTime4.substring(0, 10);


    // Print the formatted date
    print(Final_DepartureFirstDate);


    var reqBody = {
      'TitleAdult1': TitleAdult1,
      'FNameAdult1': FNameAdult1,
      'MNameAdult1': MNameAdult1,
      'LNameAdult1': LNameAdult1,
      'LDOBAdult1': convertDate(LDOBAdult1),
      'GenderAdult1': GenderAdult1,
      'DocNumAdult1': DocNumAdult1,
      'IssueDateAdult1': issueDateAdult1,
      'ExpDateAdult1': expDateAdult1,
      'TitleAdult2': TitleAdult2,
      'FNameAdult2': FNameAdult2,
      'MNameAdult2': MNameAdult2,
      'LNameAdult2': LNameAdult2,
      'LDOBAdult2': LDOBAdult2,
      'GenderAdult2': GenderAdult2,
      'DocNumAdult2': DocNumAdult2,
      'IssueDateAdult2': IssueDateAdult2,
      'ExpDateAdult2': ExpDateAdult2,
      'TitleAdult3': TitleAdult3,
      'FNameAdult3': FNameAdult3,
      'MNameAdult3': MNameAdult3,
      'LNameAdult3': LNameAdult3,
      'LDOBAdult3': LDOBAdult3,
      'GenderAdult3': GenderAdult3,
      'DocNumAdult3': DocNumAdult3,
      'IssueDateAdult3': IssueDateAdult3,
      'ExpDateAdult3': ExpDateAdult3,
      'TitleAdult4': TitleAdult4,
      'FNameAdult4': FNameAdult4,
      'MNameAdult4': MNameAdult4,
      'LNameAdult4': LNameAdult4,
      'LDOBAdult4': LDOBAdult4,
      'GenderAdult4': GenderAdult4,
      'DocNumAdult4': DocNumAdult4,
      'IssueDateAdult4': IssueDateAdult4,
      'ExpDateAdult4': ExpDateAdult4,
      'TitleAdult5': TitleAdult5,
      'FNameAdult5': FNameAdult5,
      'MNameAdult5': MNameAdult5,
      'LNameAdult5': LNameAdult5,
      'LDOBAdult5': LDOBAdult5,
      'GenderAdult5': GenderAdult5,
      'DocNumAdult5': DocNumAdult5,
      'IssueDateAdult5': IssueDateAdult5,
      'ExpDateAdult5': ExpDateAdult5,
      'TitleAdult6': TitleAdult6,
      'FNameAdult6': FNameAdult6,
      'MNameAdult6': MNameAdult6,
      'LNameAdult6': LNameAdult6,
      'LDOBAdult6': LDOBAdult6,
      'GenderAdult6': GenderAdult6,
      'DocNumAdult6': DocNumAdult6,
      'IssueDateAdult6': IssueDateAdult6,
      'ExpDateAdult6': ExpDateAdult6,
      'TitleAdult7': TitleAdult7,
      'FNameAdult7': FNameAdult7,
      'MNameAdult7': MNameAdult7,
      'LNameAdult7': LNameAdult7,
      'LDOBAdult7': LDOBAdult7,
      'GenderAdult7': GenderAdult7,
      'DocNumAdult7': DocNumAdult7,
      'IssueDateAdult7': IssueDateAdult7,
      'ExpDateAdult7': ExpDateAdult7,
      'TitleAdult8': TitleAdult8,
      'FNameAdult8': FNameAdult8,
      'MNameAdult8': MNameAdult8,
      'LNameAdult8': LNameAdult8,
      'LDOBAdult8': LDOBAdult8,
      'GenderAdult8': GenderAdult8,
      'DocNumAdult8': DocNumAdult8,
      'IssueDateAdult8': IssueDateAdult8,
      'ExpDateAdult8': ExpDateAdult8,
      'TitleAdult9': TitleAdult9,
      'FNameAdult9': FNameAdult9,
      'MNameAdult9': MNameAdult9,
      'LNameAdult9': LNameAdult9,
      'LDOBAdult9': LDOBAdult9,
      'GenderAdult9': GenderAdult9,
      'DocNumAdult9': DocNumAdult9,
      'IssueDateAdult9': IssueDateAdult9,
      'ExpDateAdult9': ExpDateAdult9,
      'TitleAdult10': TitleAdult10,
      'FNameAdult10': FNameAdult10,
      'MNameAdult10': MNameAdult10,
      'LNameAdult10': LNameAdult10,
      'LDOBAdult10': LDOBAdult10,
      'GenderAdult10': GenderAdult10,
      'DocNumAdult10': DocNumAdult10,
      'IssueDateAdult10': IssueDateAdult10,
      'ExpDateAdult10': ExpDateAdult10,
      'TitleChild1': TitleChild1,
      'FNameChild1': FNameChild1,
      'MNameChild1': MNameChild1,
      'LNameChild1': LNameChild1,
      'LDOBChild1': LDOBChild1,
      'GenderChild1': GenderChild1,
      'DocNumChild1': DocNumChild1,
      'IssueDateChild1': IssueDateChild1,
      'ExpDateChild1': ExpDateChild1,
      'TitleChild2': TitleChild2,
      'FNameChild2': FNameChild2,
      'MNameChild2': MNameChild2,
      'LNameChild2': LNameChild2,
      'LDOBChild2': LDOBChild2,
      'GenderChild2': GenderChild2,
      'DocNumChild2': DocNumChild2,
      'IssueDateChild2': IssueDateChild2,
      'ExpDateChild2': ExpDateChild2,
      'TitleChild3': TitleChild3,
      'FNameChild3': FNameChild3,
      'MNameChild3': MNameChild3,
      'LNameChild3': LNameChild3,
      'LDOBChild3': LDOBChild3,
      'GenderChild3': GenderChild3,
      'DocNumChild3': DocNumChild3,
      'IssueDateChild3': IssueDateChild3,
      'ExpDateChild3': ExpDateChild3,
      'TitleChild4': TitleChild4,
      'FNameChild4': FNameChild4,
      'MNameChild4': MNameChild4,
      'LNameChild4': LNameChild4,
      'LDOBChild4': LDOBChild4,
      'GenderChild4': GenderChild4,
      'DocNumChild4': DocNumChild4,
      'IssueDateChild4': IssueDateChild4,
      'ExpDateChild4': ExpDateChild4,
      'TitleChild5': TitleChild5,
      'FNameChild5': FNameChild5,
      'MNameChild5': MNameChild5,
      'LNameChild5': LNameChild5,
      'LDOBChild5': LDOBChild5,
      'GenderChild5': GenderChild5,
      'DocNumChild5': DocNumChild5,
      'IssueDateChild5': IssueDateChild5,
      'ExpDateChild5': ExpDateChild5,
      'TitleInfant1': TitleInfant1,
      'FNameInfant1': FNameInfant1,
      'MNameInfant1': MNameInfant1,
      'LNameInfant1': LNameInfant1,
      'LDOBInfant1': LDOBInfant1,
      'GenderInfant1': GenderInfant1,
      'DocNumInfant1': DocNumInfant1,
      'IssueDateInfant1': IssueDateInfant1,
      'ExpDateInfant1': ExpDateInfant1, // Infant 2
      'TitleInfant2': TitleInfant2,
      'FNameInfant2': FNameInfant2,
      'MNameInfant2': MNameInfant2,
      'LNameInfant2': LNameInfant2,
      'LDOBInfant2': LDOBInfant2,
      'GenderInfant2': GenderInfant2,
      'DocNumInfant2': DocNumInfant2,
      'IssueDateInfant2': IssueDateInfant2,
      'ExpDateInfant2': ExpDateInfant2, // Infant 3
      'TitleInfant3': TitleInfant3,
      'FNameInfant3': FNameInfant3,
      'MNameInfant3': MNameInfant3,
      'LNameInfant3': LNameInfant3,
      'LDOBInfant3': LDOBInfant3,
      'GenderInfant3': GenderInfant3,
      'DocNumInfant3': DocNumInfant3,
      'IssueDateInfant3': IssueDateInfant3,
      'ExpDateInfant3': ExpDateInfant3, // Infant 4
      'TitleInfant4': TitleInfant4,
      'FNameInfant4': FNameInfant4,
      'MNameInfant4': MNameInfant4,
      'LNameInfant4': LNameInfant4,
      'LDOBInfant4': LDOBInfant4,
      'GenderInfant4': GenderInfant4,
      'DocNumInfant4': DocNumInfant4,
      'IssueDateInfant4': IssueDateInfant4,
      'ExpDateInfant4': ExpDateInfant4, // Infant 5
      'TitleInfant5': TitleInfant5,
      'FNameInfant5': FNameInfant5,
      'MNameInfant5': MNameInfant5,
      'LNameInfant5': LNameInfant5,
      'LDOBInfant5': LDOBInfant5,
      'GenderInfant5': GenderInfant5,
      'DocNumInfant5': DocNumInfant5,
      'IssueDateInfant5': IssueDateInfant5,
      'ExpDateInfant5': ExpDateInfant5,
      'HouseNo': HouseNoController.text.trim(),
      'Address': StreetNoController.text.toString(),
      'City': CityController.text.toString(),
      'Zipcode': zipCodeController.text.trim(),
      'CountryCode':selectedCountryCode.toString(),
      'CountryName': onlyCountryName.toString(),
      'CountryPhoneCode': selectedPhoneCode.toString(),
      'MobileNumber': MobileNoController.text.toString(),
      'Email': EmailController.text.toString(),
      'TPToken': widget.TPToken,
      'TripType': 'Multicity',
      'Jsonstring': json.encode(widget.flightDetailsList),
      'AdultCount': widget.adultCount,
      'ChildCount': widget.childrenCount,
      'InfantCount': widget.infantCount,
      'RoomCount': '0',
      'Refundable': widget.refundable == "Refundable" ? true : false,
      'UserRoleId': userTypeID,
      'UserId': userID,
      'OnlineCurrencyValue': '1',
      'FlightMarkup': '0',
      'MainCurrencyCode': 'ETB',
      'MainCurrencyValue': '1',
      'OfferDiscount': '0',
      'MarkupAmt': '0',
      'GSTPercent': '0',
      'GSTAmt': '0',
      'ServiceChargePercent': '0',
      'ServiceCharge  ': '0',
      'GrandTotal': resultFlightData[0]["TotalPrice"],
      'FrontCurrencyCode': 'ETB',
      'FrontCurrencyValue': '1',
      'Origin1': widget.departuredatefirst,
      'Destination1': widget.arriveCityNameFirst,
      'DepartDate1': Final_DepartureFirstDate.toString(),
      'Origin2': widget.departCityNameSecond,
      'Destination2': widget.arriveCityNameSecond,
      'DepartDate2': Final_DepartureSecondDate.toString(),
      'Origin3': widget.departCityNameThird,
      'Destination3': widget.arriveCityNameThird,
      'DepartDate3  ': Final_DepartureThirdDate,
      'Origin4': widget.departCityNameFourth,
      'Destination4': widget.arriveCityNameFourth,
      'DepartDate4': Final_DepartureFourthDate,
      'DefaultCurrencyValue': '1',
      'DefaultCurrencyCode':  resultFlightData[0]["Currency"],
      'CarrierCode1': resultFlightData[0]["CarrierCodeFirst"],
      'CarrierCode2': resultFlightData[0]['CarrierCodeSecond'],
      'CarrierCode3':  resultFlightData[0]['CarrierCodeThird'],
      'CarrierCode4':  resultFlightData[0]['CarrierCodeFourth'],
      'UserTypeId': userTypeID,
      'MemberId': userTypeID
    };

    print('================= Request Body Start =================');
    reqBody.forEach((key, value) {
      print('$key: $value');
    });
    print('================= Request Body End =================');
    try {
      setState(() {
        isBookingLoading = true;
      });
      //developer.log(reqBody.toString());
      final response = await http.post(
        url,
        headers: headers,
        body: reqBody,
      );

      //developer.log(reqBody.toString());

      setState(() {
        isBookingLoading = false;
      });
      if (response.statusCode == 200) {
        print("asdfsgg${response.body}");
        handleBookingResponse(response.body);
      }
      else {
        print(
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Server error. Try again later.'),
                backgroundColor: Colors.red,
              ),
            ));
        // Handle the failure scenario
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
        const SnackBar(content: Text('Booking failed, please verify your data..')),
      );
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

  Future<void> _deleteAdult(int index) async {
    final dbHelper =
        DatabaseHelper.instance; // Ensure you have a database helper instance
    if (_adultsList.length > index) {
      await dbHelper.deleteAdults(_adultsList[index]
      ['id']); // Use the appropriate method to delete from your database
      _fetchAdults(); // Refresh the list of adults after deletion
    }
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
      print('Currency: $userID');
      // Call sendFlightSearchRequest() here after SharedPreferences values are retrieved
      getAdivahaFlightDetails();
    });
  }

  Future<void> getAdivahaFlightDetails() async {
    final url = Uri.parse(
        'https://boqoltravel.com/app/b2badminapi.asmx/Multiway_GetPriceDetails');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    try {
      setState(() {
        isLoading = true;
      });

      final requestBody = {
        'MultiwayFlightSegmentJson': json.encode(widget.flightDetailsList),
        'TripType': 'MultiCity',
        'AdultCount': widget.adultCount,
        'ChildrenCount': widget.childrenCount,
        'InfantCount': widget.infantCount,
        'OnlineCurrencyValue': '1',
        'TPToken': widget.TokenValue,
      };

      // 🔍 Log request body completely (even if long)
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

      if (response.statusCode == 200) {
        print('✅ Request successful! Parsing response...');

        // Extract JSON from XML
        var parsedJson = extractJsonFromXml(response.body).toList();

        developer.log('📦 Full API Response:');
        developer.log(parsedJson.toString());

        List<dynamic> finalResultFlightData = [];

        for (var flight in parsedJson) {
          String stopCount = flight['StopCount']?.toString() ?? '0';
          String rowType = flight['RowType']?.toString() ?? '';

          if (stopCount == "0" && rowType == "MainRow") {
            finalResultFlightData.add(flight);
            print('✅ Added MainRow for StopCount == 0');
          } else if (stopCount == "1" && rowType == "SubRow") {
            finalResultFlightData.add(flight);
            print('✅ Added SubRow for StopCount == 1');
          } else if (stopCount == "2" && rowType == "SubRow") {
            finalResultFlightData.add(flight);
            print('✅ Added SubRow for StopCount == 2');
          }
        }

        setState(() {
          resultFlightData = finalResultFlightData;

          if (resultFlightData.isEmpty) {
            print('⚠️ No valid flight data to display');
          } else {
            developer.log('✅ Final Result Flight Data:');
            developer.log(resultFlightData.toString());
          }

          //expandedList = List.generate(resultFlightData.length, (_) => false);
        });
      } else {
        print('❌ Request failed with status: ${response.statusCode}');
        _showErrorMessage('Server error, please try again later.');
      }
    } catch (error) {
      print('❌ Error sending request: $error');
    }
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

  Set<int> expandedIndexes = {};

  @override
  Widget build(BuildContext context) {
    int adultCountInt = int.parse(widget.adultCount);
    int childrenCount = int.parse(widget.childrenCount);
    int InfantCount = int.parse(widget.infantCount);
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
              "Flight Booking",
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
                          itemBuilder: (BuildContext context, int index) {
                            final flight = resultFlightData[index];
                            final isExpanded = expandedIndexes.contains(index);
                            final stopCount = int.tryParse(flight['StopCount'].toString()) ?? 0;

                            DateTime? arrivalDate;
                            DateTime? nextDepartureDate;
                            String? layoverDurationStr;
                            String? layoverAirportCode;

                            if (index + 1 < resultFlightData.length) {
                              arrivalDate = DateTime.parse(resultFlightData[index]['ArrivalDate']);
                              nextDepartureDate = DateTime.parse(resultFlightData[index + 1]['DepartureDate']);

                              final layoverDuration = nextDepartureDate.difference(arrivalDate);
                              final layoverHours = layoverDuration.inHours;
                              final layoverMinutes = layoverDuration.inMinutes.remainder(60);
                              layoverDurationStr = "$layoverHours hr $layoverMinutes min";
                              layoverAirportCode = resultFlightData[index]['ArriveCityCode'];
                            }

                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
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
                                              Text(
                                                  flight['DepartureDate']
                                                      ?.toString()
                                                      .substring(
                                                      0,
                                                      10) ??
                                                      ''),
                                              Text(
                                                CommonUtils
                                                    .convertToFormattedTime(
                                                    flight[
                                                    'DepartureDate']),
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
                                                      color:
                                                      Colors.grey,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Text(
                                                'Terminal ${flight['DepartureTerminal'] ?? ''}',
                                                style: TextStyle(
                                                    color:
                                                    Colors.orange,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),

                                          // Travel Time
                                          Text(

                                            convertDuration(flight['TravelTime']),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),

                                          // Arrival
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .end,
                                            children: [
                                              Text(
                                                  flight['ArrivalDate']
                                                      ?.toString()
                                                      .substring(
                                                      0,
                                                      10) ??
                                                      ''),
                                              Text(
                                                CommonUtils
                                                    .convertToFormattedTime(
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
                                                      color:
                                                      Colors.grey,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Text(
                                                'Terminal ${flight['ArrivalTerminal'] ?? ''}',
                                                style: TextStyle(
                                                    color:
                                                    Colors.orange,
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
                                              flight['Baggage'] ?? '',
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
                                          Text('A30',
                                              style: TextStyle(
                                                  color: Colors
                                                      .black54)),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                if (expandedIndexes
                                                    .contains(
                                                    index)) {
                                                  expandedIndexes
                                                      .remove(index);
                                                } else {
                                                  expandedIndexes
                                                      .add(index);
                                                }
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
                                                            .orange)),
                                                Icon(
                                                  isExpanded
                                                      ? Icons
                                                      .keyboard_arrow_up
                                                      : Icons
                                                      .keyboard_arrow_down,
                                                  color:
                                                  Colors.orange,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Expanded content
                                      if (isExpanded)
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
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
                                Builder(
                                  builder: (context) {
                                    if (index + 1 < resultFlightData.length) {
                                      final current = resultFlightData[index];
                                      final next = resultFlightData[index + 1];

                                      final currentRowType = current['RowType']?.toString() ?? '';
                                      final nextRowType = next['RowType']?.toString() ?? '';
                                      final currentMainRow = current['MainRowNumber']?.toString() ?? '';
                                      final nextMainRow = next['MainRowNumber']?.toString() ?? '';

                                      // ✅ Show layover only between flights of the same MainRow group and if both are SubRows
                                      if (currentMainRow == nextMainRow &&
                                          currentRowType == 'SubRow' &&
                                          nextRowType == 'SubRow') {
                                        DateTime arrivalDate = DateTime.parse(current['ArrivalDate']);
                                        DateTime nextDepartureDate = DateTime.parse(next['DepartureDate']);

                                        Duration layoverDuration = nextDepartureDate.difference(arrivalDate);
                                        String layoverHours = layoverDuration.inHours.toString();
                                        String layoverMinutes = (layoverDuration.inMinutes.remainder(60)).toString();
                                        String layoverAirportCode = current['ArriveCityCode'] ?? '';

                                        return Container( color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 20),
                                            child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .yellow.shade100,
                                                border: Border.all(
                                                    color: Colors.orange),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    6),
                                              ),
                                              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Layover: $layoverHours hr $layoverMinutes min at $layoverAirportCode',
                                                    style: TextStyle(fontSize: 14, color: Colors.black),
                                                  ),
                                                ],
                                              ),
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

                        SizedBox(
                          height: 6,
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
                                    Text(
                                      'View Full Breakup',
                                      style: TextStyle(
                                        color: Color(0xFF00ADEE),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),

                                    // Add other pricing details or components as needed
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 0, left: 0, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        'Base Price',
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        resultFlightData[0]
                                        ["BookingBaseFare"],
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 0,
                                      left: 0,
                                      bottom: 4,
                                      top: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        'Tax Price',
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        resultFlightData[0]
                                        ["BookingTax"],
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 0,
                                      left: 0,
                                      bottom: 5,
                                      top: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        'Total Amount To Be Paid',
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        widget.TotalPrice,
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7,
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
                                    fontSize: 17,
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
                                  bool hasAdultData = _adultsList
                                      .length >
                                      i &&
                                      _adultsList[i] != null &&
                                      _adultsList[i]
                                      ['firstName'] !=
                                          null;
                                  if (hasAdultData) {
                                    switch (i) {
                                      case 0:
                                        TitleAdult1 =
                                            _adultsList[i]
                                            ['title'] ??
                                                '';
                                        FNameAdult1 = _adultsList[
                                        i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult1 = _adultsList[
                                        i][
                                        'middleName'] ??
                                            '';
                                        LNameAdult1 =
                                            _adultsList[i][
                                            'surname'] ??
                                                '';
                                        LDOBAdult1 =
                                            _adultsList[i]
                                            ['dob'] ??
                                                '';
                                        GenderAdult1 =
                                            _adultsList[i][
                                            'gender'] ??
                                                '';
                                        DocNumAdult1 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        issueDateAdult1 =
                                            _adultsList[i][
                                            'issueDate'] ??
                                                '';
                                        expDateAdult1 =
                                            _adultsList[i][
                                            'expiryDate'] ??
                                                '';
                                        break;
                                      case 1:
                                        TitleAdult2 =
                                            _adultsList[i]
                                            ['title'] ??
                                                '';
                                        FNameAdult2 = _adultsList[
                                        i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult2 = _adultsList[
                                        i][
                                        'middleName'] ??
                                            '';
                                        LNameAdult2 =
                                            _adultsList[i][
                                            'surname'] ??
                                                '';
                                        LDOBAdult2 =
                                            _adultsList[i]
                                            ['dob'] ??
                                                '';
                                        GenderAdult2 =
                                            _adultsList[i][
                                            'gender'] ??
                                                '';
                                        DocNumAdult2 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult2 =
                                            _adultsList[i][
                                            'issueDate'] ??
                                                '';
                                        ExpDateAdult2 =
                                            _adultsList[i][
                                            'expiryDate'] ??
                                                '';
                                        break;
                                      case 2:
                                        TitleAdult3 =
                                            _adultsList[i]
                                            ['title'] ??
                                                '';
                                        FNameAdult3 = _adultsList[
                                        i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult3 = _adultsList[
                                        i][
                                        'middleName'] ??
                                            '';
                                        LNameAdult3 =
                                            _adultsList[i][
                                            'surname'] ??
                                                '';
                                        LDOBAdult3 =
                                            _adultsList[i]
                                            ['dob'] ??
                                                '';
                                        GenderAdult3 =
                                            _adultsList[i][
                                            'gender'] ??
                                                '';
                                        DocNumAdult3 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult3 =
                                            _adultsList[i][
                                            'issueDate'] ??
                                                '';
                                        ExpDateAdult3 =
                                            _adultsList[i][
                                            'expiryDate'] ??
                                                '';
                                        break;
                                      case 3:
                                        TitleAdult4 =
                                            _adultsList[i]
                                            ['title'] ??
                                                '';
                                        FNameAdult4 = _adultsList[
                                        i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult4 = _adultsList[
                                        i][
                                        'middleName'] ??
                                            '';
                                        LNameAdult4 =
                                            _adultsList[i][
                                            'surname'] ??
                                                '';
                                        LDOBAdult4 =
                                            _adultsList[i]
                                            ['dob'] ??
                                                '';
                                        GenderAdult4 =
                                            _adultsList[i][
                                            'gender'] ??
                                                '';
                                        DocNumAdult4 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult4 =
                                            _adultsList[i][
                                            'issueDate'] ??
                                                '';
                                        ExpDateAdult4 =
                                            _adultsList[i][
                                            'expiryDate'] ??
                                                '';
                                        break;
                                      case 4:
                                        TitleAdult5 =
                                            _adultsList[i]
                                            ['title'] ??
                                                '';
                                        FNameAdult5 = _adultsList[
                                        i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult5 = _adultsList[
                                        i][
                                        'middleName'] ??
                                            '';
                                        LNameAdult5 =
                                            _adultsList[i][
                                            'surname'] ??
                                                '';
                                        LDOBAdult5 =
                                            _adultsList[i]
                                            ['dob'] ??
                                                '';
                                        GenderAdult5 =
                                            _adultsList[i][
                                            'gender'] ??
                                                '';
                                        DocNumAdult5 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult5 =
                                            _adultsList[i][
                                            'issueDate'] ??
                                                '';
                                        ExpDateAdult5 =
                                            _adultsList[i][
                                            'expiryDate'] ??
                                                '';
                                        break;
                                      case 5:
                                        TitleAdult6 =
                                            _adultsList[i]
                                            ['title'] ??
                                                '';
                                        FNameAdult6 = _adultsList[
                                        i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult6 = _adultsList[
                                        i][
                                        'middleName'] ??
                                            '';
                                        LNameAdult6 =
                                            _adultsList[i][
                                            'surname'] ??
                                                '';
                                        LDOBAdult6 =
                                            _adultsList[i]
                                            ['dob'] ??
                                                '';
                                        GenderAdult6 =
                                            _adultsList[i][
                                            'gender'] ??
                                                '';
                                        DocNumAdult6 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult6 =
                                            _adultsList[i][
                                            'issueDate'] ??
                                                '';
                                        ExpDateAdult6 =
                                            _adultsList[i][
                                            'expiryDate'] ??
                                                '';
                                        break;
                                      case 6:
                                        TitleAdult7 =
                                            _adultsList[i]
                                            ['title'] ??
                                                '';
                                        FNameAdult7 = _adultsList[
                                        i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult7 = _adultsList[
                                        i][
                                        'middleName'] ??
                                            '';
                                        LNameAdult7 =
                                            _adultsList[i][
                                            'surname'] ??
                                                '';
                                        LDOBAdult7 =
                                            _adultsList[i]
                                            ['dob'] ??
                                                '';
                                        GenderAdult7 =
                                            _adultsList[i][
                                            'gender'] ??
                                                '';
                                        DocNumAdult7 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult7 =
                                            _adultsList[i][
                                            'issueDate'] ??
                                                '';
                                        ExpDateAdult7 =
                                            _adultsList[i][
                                            'expiryDate'] ??
                                                '';
                                        break;
                                      case 7:
                                        TitleAdult8 =
                                            _adultsList[i]
                                            ['title'] ??
                                                '';
                                        FNameAdult8 = _adultsList[
                                        i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult8 = _adultsList[
                                        i][
                                        'middleName'] ??
                                            '';
                                        LNameAdult8 =
                                            _adultsList[i][
                                            'surname'] ??
                                                '';
                                        LDOBAdult8 =
                                            _adultsList[i]
                                            ['dob'] ??
                                                '';
                                        GenderAdult8 =
                                            _adultsList[i][
                                            'gender'] ??
                                                '';
                                        DocNumAdult8 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult8 =
                                            _adultsList[i][
                                            'issueDate'] ??
                                                '';
                                        ExpDateAdult8 =
                                            _adultsList[i][
                                            'expiryDate'] ??
                                                '';
                                        break;
                                      case 8:
                                        TitleAdult9 =
                                            _adultsList[i]
                                            ['title'] ??
                                                '';
                                        FNameAdult9 = _adultsList[
                                        i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult9 = _adultsList[
                                        i][
                                        'middleName'] ??
                                            '';
                                        LNameAdult9 =
                                            _adultsList[i][
                                            'surname'] ??
                                                '';
                                        LDOBAdult9 =
                                            _adultsList[i]
                                            ['dob'] ??
                                                '';
                                        GenderAdult9 =
                                            _adultsList[i][
                                            'gender'] ??
                                                '';
                                        DocNumAdult9 = _adultsList[
                                        i][
                                        'documentNumber'] ??
                                            '';
                                        IssueDateAdult9 =
                                            _adultsList[i][
                                            'issueDate'] ??
                                                '';
                                        ExpDateAdult9 =
                                            _adultsList[i][
                                            'expiryDate'] ??
                                                '';
                                        break;
                                      case 9:
                                        TitleAdult10 =
                                            _adultsList[i]
                                            ['title'] ??
                                                '';
                                        FNameAdult10 = _adultsList[
                                        i]
                                        ['firstName'] ??
                                            '';
                                        MNameAdult10 = _adultsList[
                                        i][
                                        'middleName'] ??
                                            '';
                                        LNameAdult10 =
                                            _adultsList[i][
                                            'surname'] ??
                                                '';
                                        LDOBAdult10 =
                                            _adultsList[i]
                                            ['dob'] ??
                                                '';
                                        GenderAdult10 =
                                            _adultsList[i][
                                            'gender'] ??
                                                '';
                                        DocNumAdult10 =
                                            _adultsList[i][
                                            'documentNumber'] ??
                                                '';
                                        IssueDateAdult10 =
                                            _adultsList[i][
                                            'issueDate'] ??
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
                                    padding:
                                    const EdgeInsets.only(
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
                                          child:
                                          GestureDetector(
                                            onTap: !hasAdultData &&
                                                !isEditAdult
                                                ? () {
                                              // Navigate to the page to add an adult if there's no data
                                              Navigator
                                                  .push(
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
                                                      ? Colors
                                                      .black
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
                                            Navigator
                                                .push(
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
                                              : null, // Disable if there is no adult data or isEdit is true
                                        ),
                                        // Delete Button
                                        IconButton(
                                          icon: Icon(
                                              Icons.delete,
                                              color:
                                              Colors.red),
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
                                                  content:
                                                  Text('Are you sure you want to delete this adult?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child:
                                                      Text('No'),
                                                      onPressed:
                                                          () {
                                                        Navigator.of(context).pop(); // Close dialog
                                                      },
                                                    ),
                                                    TextButton(
                                                      child:
                                                      Text('Yes'),
                                                      onPressed:
                                                          () {
                                                        _deleteAdult(i); // Call delete method
                                                        Navigator.of(context).pop(); // Close dialog
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
                                  padding:
                                  const EdgeInsets.only(
                                      left: 15, top: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
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
                                              _childrenList
                                                  .length >
                                                  i &&
                                                  _childrenList[
                                                  i] !=
                                                      null &&
                                                  _childrenList[
                                                  i]
                                                  [
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
                                                  backgroundColor: hasChildData
                                                      ? Colors
                                                      .green
                                                      : Colors
                                                      .grey,
                                                ),
                                                SizedBox(
                                                    width: 10),
                                                Expanded(
                                                  child:
                                                  GestureDetector(
                                                    onTap: !hasChildData &&
                                                        !isEditChild
                                                        ? () {
                                                      // Navigate to the page to add a child if there's no data
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => AddChildScreen(
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
                                                      ).then((_) {
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
                                                            ? Colors.black
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // Edit Button
                                                IconButton(
                                                  icon: Icon(
                                                      Icons
                                                          .edit,
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
                                                        builder: (context) => AddChildScreen(
                                                          isEdit: 'Edit',
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
                                                      : null, // Disable if there is no child data or isEdit is true
                                                ),
                                                // Delete Button
                                                IconButton(
                                                  icon: Icon(
                                                      Icons
                                                          .delete,
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
                                                          (BuildContext context) {
                                                        return AlertDialog(
                                                          title: Text('Confirm Deletion'),
                                                          content: Text('Are you sure you want to delete this child?'),
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
                                  padding:
                                  const EdgeInsets.only(
                                      left: 15, top: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        'Infants',
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight
                                              .w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Column(
                                        children:
                                        List.generate(
                                            InfantCount,
                                                (i) {
                                              // Determine if there is valid child data
                                              bool hasInfantData = _infantList
                                                  .length >
                                                  i &&
                                                  _infantList[
                                                  i] !=
                                                      null &&
                                                  _infantList[i]
                                                  [
                                                  'firstName'] !=
                                                      null;
                                              if (hasInfantData) {
                                                switch (i) {
                                                  case 0:
                                                    TitleInfant1 =
                                                        _infantList[i]['title'] ??
                                                            '';
                                                    FNameInfant1 =
                                                        _infantList[i]['firstName'] ??
                                                            '';
                                                    MNameInfant1 =
                                                        _infantList[i]['middleName'] ??
                                                            '';
                                                    LNameInfant1 =
                                                        _infantList[i]['surname'] ??
                                                            '';
                                                    LDOBInfant1 =
                                                        _infantList[i]['dob'] ??
                                                            '';
                                                    GenderInfant1 =
                                                        _infantList[i]['gender'] ??
                                                            '';
                                                    DocNumInfant1 =
                                                        _infantList[i]['documentNumber'] ??
                                                            '';
                                                    IssueDateInfant1 =
                                                        _infantList[i]['issueDate'] ??
                                                            '';
                                                    ExpDateInfant1 =
                                                        _infantList[i]['expiryDate'] ??
                                                            '';
                                                    break;

                                                  case 1:
                                                    TitleInfant2 =
                                                        _infantList[i]['title'] ??
                                                            '';
                                                    FNameInfant2 =
                                                        _infantList[i]['firstName'] ??
                                                            '';
                                                    MNameInfant2 =
                                                        _infantList[i]['middleName'] ??
                                                            '';
                                                    LNameInfant2 =
                                                        _infantList[i]['surname'] ??
                                                            '';
                                                    LDOBInfant2 =
                                                        _infantList[i]['dob'] ??
                                                            '';
                                                    GenderInfant2 =
                                                        _infantList[i]['gender'] ??
                                                            '';
                                                    DocNumInfant2 =
                                                        _infantList[i]['documentNumber'] ??
                                                            '';
                                                    IssueDateInfant2 =
                                                        _infantList[i]['issueDate'] ??
                                                            '';
                                                    ExpDateInfant2 =
                                                        _infantList[i]['expiryDate'] ??
                                                            '';
                                                    break;

                                                  case 2:
                                                    TitleInfant3 =
                                                        _infantList[i]['title'] ??
                                                            '';
                                                    FNameInfant3 =
                                                        _infantList[i]['firstName'] ??
                                                            '';
                                                    MNameInfant3 =
                                                        _infantList[i]['middleName'] ??
                                                            '';
                                                    LNameInfant3 =
                                                        _infantList[i]['surname'] ??
                                                            '';
                                                    LDOBInfant3 =
                                                        _infantList[i]['dob'] ??
                                                            '';
                                                    GenderInfant3 =
                                                        _infantList[i]['gender'] ??
                                                            '';
                                                    DocNumInfant3 =
                                                        _infantList[i]['documentNumber'] ??
                                                            '';
                                                    IssueDateInfant3 =
                                                        _infantList[i]['issueDate'] ??
                                                            '';
                                                    ExpDateInfant3 =
                                                        _infantList[i]['expiryDate'] ??
                                                            '';
                                                    break;

                                                  case 3:
                                                    TitleInfant4 =
                                                        _infantList[i]['title'] ??
                                                            '';
                                                    FNameInfant4 =
                                                        _infantList[i]['firstName'] ??
                                                            '';
                                                    MNameInfant4 =
                                                        _infantList[i]['middleName'] ??
                                                            '';
                                                    LNameInfant4 =
                                                        _infantList[i]['surname'] ??
                                                            '';
                                                    LDOBInfant4 =
                                                        _infantList[i]['dob'] ??
                                                            '';
                                                    GenderInfant4 =
                                                        _infantList[i]['gender'] ??
                                                            '';
                                                    DocNumInfant4 =
                                                        _infantList[i]['documentNumber'] ??
                                                            '';
                                                    IssueDateInfant4 =
                                                        _infantList[i]['issueDate'] ??
                                                            '';
                                                    ExpDateInfant4 =
                                                        _infantList[i]['expiryDate'] ??
                                                            '';
                                                    break;

                                                  case 4:
                                                    TitleInfant5 =
                                                        _infantList[i]['title'] ??
                                                            '';
                                                    FNameInfant5 =
                                                        _infantList[i]['firstName'] ??
                                                            '';
                                                    MNameInfant5 =
                                                        _infantList[i]['middleName'] ??
                                                            '';
                                                    LNameInfant5 =
                                                        _infantList[i]['surname'] ??
                                                            '';
                                                    LDOBInfant5 =
                                                        _infantList[i]['dob'] ??
                                                            '';
                                                    GenderInfant5 =
                                                        _infantList[i]['gender'] ??
                                                            '';
                                                    DocNumInfant5 =
                                                        _infantList[i]['documentNumber'] ??
                                                            '';
                                                    IssueDateInfant5 =
                                                        _infantList[i]['issueDate'] ??
                                                            '';
                                                    ExpDateInfant5 =
                                                        _infantList[i]['expiryDate'] ??
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
                                                      backgroundColor: hasInfantData
                                                          ? Colors
                                                          .green
                                                          : Colors
                                                          .grey,
                                                    ),
                                                    SizedBox(
                                                        width:
                                                        10),
                                                    Expanded(
                                                      child:
                                                      GestureDetector(
                                                        onTap: !hasInfantData &&
                                                            !isEditInfant
                                                            ? () {
                                                          // Navigate to the page to add a child if there's no data
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => AddInfantScreen(
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
                                                          ).then((_) {
                                                            // Fetch the updated children list when returning to this page
                                                            _fetchInfant();
                                                          });
                                                        }
                                                            : null,
                                                        // Disable if there is child data or isEdit is true
                                                        child:
                                                        Text(
                                                          hasInfantData
                                                              ? '${_infantList[i]['firstName']} ${_infantList[i]['surname']}'
                                                              : 'Select Infant ${i + 1}',
                                                          style:
                                                          TextStyle(
                                                            fontSize:
                                                            16,
                                                            color: hasInfantData
                                                                ? Colors.black
                                                                : Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Edit Button
                                                    IconButton(
                                                      icon: Icon(
                                                          Icons
                                                              .edit,
                                                          color:
                                                          Color(0xFF00ADEE)),
                                                      onPressed: hasInfantData &&
                                                          !isEditInfant
                                                          ? () {
                                                        // Navigate to edit screen if child data exists and not in edit mode
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => AddInfantScreen(
                                                              isEdit: 'Edit',
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
                                                        ).then((_) {
                                                          // Fetch the updated children list when returning to this page
                                                          _fetchInfant();
                                                        });
                                                      }
                                                          : null, // Disable if there is no child data or isEdit is true
                                                    ),
                                                    // Delete Button
                                                    IconButton(
                                                      icon: Icon(
                                                          Icons
                                                              .delete,
                                                          color:
                                                          Colors.red),
                                                      onPressed: hasInfantData &&
                                                          !isEditInfant
                                                          ? () {
                                                        // Show confirmation dialog
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              title: Text('Confirm Deletion'),
                                                              content: Text('Are you sure you want to delete this child?'),
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
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0,vertical: 10),
                                child: Text(
                                  "Contact Details",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Enter Your Email:",
                                  style:
                                  TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding:
                                const EdgeInsets.all(10.0),
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
                                          color: Color(0xFF00ADEE)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Select Country",
                                  style:
                                  TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8),
                                child: Container(
                                  padding: const EdgeInsets
                                      .symmetric(
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
                                    child:
                                    DropdownButton<String>(
                                        value: selectedCountry,
                                        hint: Text(
                                            'Select a country'),
                                        isExpanded: true,
                                        // Optional: makes the dropdown take full width
                                        items: countries.map((String value) {
                                          final parts = value.split(' - ');
                                          final countryName = parts[0].trim();
                                          final countryCode = parts.length > 1 ? parts[1].trim() : '';
                                          final phoneCode = countryPhoneMap[countryName] ?? '';

                                          final displayText = phoneCode.isNotEmpty
                                              ? '$countryName - $countryCode ($phoneCode)'
                                              : '$countryName - $countryCode';

                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(displayText),
                                          );
                                        }).toList(),

                                        onChanged: (newValue) {
                                          final parts = newValue!.split(' - ');
                                          final countryName = parts[0].trim();
                                          final countryCode = parts.length > 1 ? parts[1].trim() : '';
                                          final phoneCode = countryPhoneMap[countryName] ?? '';

                                          setState(() {
                                            selectedCountry = newValue;
                                            selectedCountryCode = countryCode;
                                            selectedPhoneCode = phoneCode;
                                          });

                                          print('Country Code: $selectedCountryCode');
                                          print('Phone Code: $selectedPhoneCode');
                                        }

                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Enter Your Mobile:",
                                  style:
                                  TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.all(10.0),
                                // Padding 10 on all sides
                                child: TextField(
                                  controller:
                                  MobileNoController,
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
                                          color: Color(0xFF00ADEE)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "House No:",
                                  style:
                                  TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.all(10.0),
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
                                          color: Color(0xFF00ADEE)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Street:",
                                  style:
                                  TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.all(10.0),
                                // Padding 10 on all sides
                                child: TextField(
                                  controller:
                                  StreetNoController,
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
                                          color: Color(0xFF00ADEE)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "City:",
                                  style:
                                  TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.all(10.0),
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
                                          color: Color(0xFF00ADEE)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Zip Code:",
                                  style:
                                  TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.all(10.0),
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
                                          color: Color(0xFF00ADEE)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Country",
                                  style:
                                  TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8),
                                child: Container(
                                  padding: const EdgeInsets
                                      .symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey),
                                    borderRadius:
                                    BorderRadius.circular(
                                        8),
                                  ),
                                  child:
                                  DropdownButtonHideUnderline(
                                    child:
                                    DropdownButton<String>(
                                      value:
                                      selectedNationality,
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
                                  Text(
                                    resultFlightData[0]
                                    ['DepartAirportName'],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12),
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

                                  convertDuration(resultFlightData[0]['TravelTime']),
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
                                  Text(
                                    resultFlightData[0]
                                    ['ArrivalAirportName'],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12),
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
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.shopping_bag,
                                    color: Color(0xFF00ADEE),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    resultFlightData[0]['Baggage'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13),
                                  ),
                                  Text(
                                    'CheckIn\n Baggage',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.shopping_bag,
                                    color: Color(0xFF00ADEE),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    resultFlightData[0]
                                    ['CabinBaggage'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13),
                                  ),
                                  Text(
                                    'Cabin Baggage',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.shopping_bag,
                                    color: Color(0xFF00ADEE),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13),
                                  ),
                                  Text(
                                    'Meal',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          )
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
              color: Colors.white,
              height: 80,
              child: Column(
                children: [
                  Divider(color: Colors.grey.shade400),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 10.0, top: 8),
                        child: Text(
                          Currency + widget.TotalPrice,
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
                            backgroundColor: Color(0xFF00ADEE),
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
