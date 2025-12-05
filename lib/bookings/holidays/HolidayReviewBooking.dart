import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Booking/HolidayDatabaseHelper.dart';
import '../../Booking/HotelAddAdultScreen.dart';
import '../../Booking/HotelChildrendatabasehelper.dart';
import '../../HolidayAdultScreen.dart';
import '../../utils/response_handler.dart';
import '../../utils/shared_preferences.dart';
import '../flight/TravellerDetailsModel.dart';
import 'package:xml/xml.dart' as xml;

import 'HolidayAddChildrenScreen.dart';
import 'HolidayChildrenDatabaseHelper.dart';

class HolidayReviewBooking extends StatefulWidget {
  final holidayName,
      touraddress,
      CheckinDate,
      RoomCount,
      adultCount,
      Tourcode,
      featuresInclusion,
      featuresExclusion,
      price,
      modalities_rateKey,
      ModalitiesCode,
      childrenCount,
      imageurl;

  const HolidayReviewBooking({
    super.key,
    required this.holidayName,
    required this.touraddress,
    required this.CheckinDate,
    required this.RoomCount,
    required this.adultCount,
    required this.Tourcode,
    required this.featuresInclusion,
    required this.featuresExclusion,
    required this.price,
    required this.modalities_rateKey,
    required this.ModalitiesCode,
    required this.childrenCount,
    required this.imageurl,
  });

  @override
  State<HolidayReviewBooking> createState() => _HotelDescriptionState();
}

class _HotelDescriptionState extends State<HolidayReviewBooking> {
  bool isDetailsLoading = false;
  var hotelResult = [];
  List<Map<String, dynamic>> _adultsList = [];
  List<Map<String, dynamic>> _childrenList = [];
  bool isEditAdult = false;
  bool isEditChild = false;
  var RoomResult = [];
  String AdultName1 = '',
      AdultTravellerId1 = '',
      AdultName2 = '',
      AdultTravellerId2 = '',
      AdultName3 = '',
      AdultTravellerId3 = '',
      AdultName4 = '',
      AdultTravellerId4 = '';
  int Status = 2;

  List<Widget> createIconsForWords(String features) {
    List<String> words = features.split(",");
    List<Widget> icons = [];

    for (String word in words) {
      // Only add the icon and text if the word is not empty or whitespace
      if (word.trim().isNotEmpty) {
        icons.add(
          Row(
            children: [
              Icon(Icons.check, color: Colors.green),
              Container(
                width: MediaQuery.of(context).size.width - 120,
                child: Text(
                  word.trim(), // Trim to remove unnecessary spaces
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        );
      }
    }

    return icons;
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != ExpiryDateController) {
      setState(() {
        ExpiryDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _fetchChildren() async {
    final dbHelper = HolidayChildrenDatabaseHelper.instance;
    final adults =
        await dbHelper.getholidayChildrens(); // Fetch adults from the database
    setState(() {
      _childrenList = adults;
      // Update the list to refresh UI
    });
  }

  Future<void> _deleteAdult(int index) async {
    final dbHelper = HolidayDatabaseHelper
        .instance; // Ensure you have a database helper instance
    if (_adultsList.length > index) {
      await dbHelper.deleteholidayAdults(_adultsList[index]
          ['id']); // Use the appropriate method to delete from your database
      _fetchAdults(); // Refresh the list of adults after deletion
    }
  }

  Future<void> _deleteChild(int index) async {
    final dbHelper = HolidayChildrenDatabaseHelper
        .instance; // Ensure you have a database helper instance
    if (_childrenList.length > index) {
      await dbHelper.deleteholidayChildrens(_childrenList[index]
          ['id']); // Use the appropriate method to delete from your database
      _fetchChildren(); // Refresh the list of adults after deletion
    }
  }

  Future<void> _fetchAdults() async {
    final dbHelper = HolidayDatabaseHelper.instance;
    final adults =
        await dbHelper.getholidayAdults(); // Fetch adults from the database
    setState(() {
      _adultsList = adults;
      // Update the list to refresh UI
    });
  }

  List<Widget> createIconsForWords1(String features) {
    List<String> words = features.split(",");
    List<Widget> icons = [];

    for (String word in words) {
      // Check if the word is not just empty or whitespace
      if (word.trim().isNotEmpty) {
        icons.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check,
                color: Colors.red,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 120,
                child: Text(
                  word.trim(), // Trim to remove leading/trailing whitespace
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      }
    }

    return icons;
  }

  var countryCodes = ['+91'];
  String selectedCountryCode = '+91';
  String selectedTitleAdult1 = 'Mr';
  String selectedTitleAdult2 = 'Mr';
  String selectedTitleAdult3 = 'Mr';
  String selectedTitleAdult4 = 'Mr';
  String selectedTitleAdult5 = 'Mr';

  String selectedTitleChildren1 = 'Mr';
  String selectedTitleChildren2 = 'Mr';
  String selectedTitleChildren3 = 'Mr';
  String selectedTitleChildren4 = 'Mr';
  String selectedTitleChildren5 = 'Mr';

  String selectedTitleInfant1 = 'Mr';
  String selectedTitleInfant2 = 'Mr';
  String selectedTitleInfant3 = 'Mr';
  String selectedTitleInfant4 = 'Mr';
  String selectedTitleInfant5 = 'Mr';

  String selectedGendarAdult1 = 'Male';
  String selectedGendarAdult2 = 'Male';
  String selectedGendarAdult3 = 'Male';
  String selectedGendarAdult4 = 'Male';
  String selectedGendarAdult5 = 'Male';

  String selectedGendarChildren1 = 'Male';
  String selectedGendarChildren2 = 'Male';
  String selectedGendarChildren3 = 'Male';
  String selectedGendarChildren4 = 'Male';
  String selectedGendarChildren5 = 'Male';

  String selectedGendarInfant1 = 'Male';
  String selectedGendarInfant2 = 'Male';
  String selectedGendarInfant3 = 'Male';
  String selectedGendarInfant4 = 'Male';
  String selectedGendarInfant5 = 'Male';

  TextEditingController adultFname_controller = new TextEditingController();
  TextEditingController adultLname_controller = new TextEditingController();

  TextEditingController adult1_Fname_controller = new TextEditingController();
  TextEditingController adult1_Lname_controller = new TextEditingController();

  TextEditingController contactEmailController = new TextEditingController();
  TextEditingController contactMobileController = new TextEditingController();
  TextEditingController contactAddressController = new TextEditingController();
  TextEditingController contactCityController = new TextEditingController();
  TextEditingController CountryController = new TextEditingController();
  TextEditingController adult2_Lname_controller = new TextEditingController();
  TextEditingController adult3_Lname_controller = new TextEditingController();
  TextEditingController adult4_Lname_controller = new TextEditingController();

  var selectedDate = DateTime.now().obs;
  TextEditingController dateControllerAdult1 = TextEditingController();
  TextEditingController dateControllerAdult2 = TextEditingController();
  TextEditingController dateControllerAdult3 = TextEditingController();
  TextEditingController dateControllerAdult4 = TextEditingController();
  TextEditingController dateControllerAdult5 = TextEditingController();
  TextEditingController passengerNameController = new TextEditingController();

  TextEditingController dateControllerChildren1 = TextEditingController();
  TextEditingController dateControllerChildren2 = TextEditingController();
  TextEditingController dateControllerChildren3 = TextEditingController();
  TextEditingController dateControllerChildren4 = TextEditingController();
  TextEditingController dateControllerChildren5 = TextEditingController();

  TextEditingController dateControllerInfant1 = TextEditingController();
  TextEditingController dateControllerInfant2 = TextEditingController();
  TextEditingController dateControllerInfant3 = TextEditingController();
  TextEditingController dateControllerInfant4 = TextEditingController();
  TextEditingController dateControllerInfant5 = TextEditingController();

  TextEditingController Documentype_controller = new TextEditingController();
  TextEditingController ExpiryDateController = TextEditingController();
  TextEditingController Documentnumber_controller = new TextEditingController();

  TextEditingController Documentype_controllerAdult2 =
      new TextEditingController();
  TextEditingController ExpiryDateControllerAdult2 = TextEditingController();
  TextEditingController Documentnumber_controllerAdult2 =
      new TextEditingController();
  TextEditingController Documentype_controllerAdult3 =
      new TextEditingController();
  TextEditingController ExpiryDateControllerAdult3 = TextEditingController();
  TextEditingController Documentnumber_controllerAdult3 =
      new TextEditingController();

  TextEditingController Documentype_controllerAdult4 =
      new TextEditingController();
  TextEditingController ExpiryDateControllerAdult4 = TextEditingController();
  TextEditingController Documentnumber_controllerAdult4 =
      new TextEditingController();

  Future<void> _selectDateAdult1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult1) {
      setState(() {
        dateControllerAdult1.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  String selectedGendarContactDetail = 'Male',
      selectedGendarContactDetailAdult2 = 'Male',
      selectedGendarContactDetailAdult3 = 'Male',
      selectedGendarContactDetailAdult4 = 'Male';

  late String userTypeID = '';
  late String userID = '';
  late String Currency = '';
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController CityController = TextEditingController();
  TextEditingController StreetNoController = TextEditingController();
  TextEditingController HouseNoController = TextEditingController();
  TextEditingController MobileNoController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
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

  List<String> countries = [];
  String? selectedCountry;
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

    setState(() {
      _retrieveSavedValues();
      fetchCountries();
      fetchNationalities();
      print(widget.childrenCount);
    });
  }

  /* Future<void> HotelRoomBooking() async {
    final Uri url = Uri.parse(
        'https://traveldemo.org/travelapp/b2capi.asmx/AdivahaHotelRoomBooking');
    DateTime checkinDateTime = DateTime.parse(widget.Checkindate.toString());
    String finDate = DateFormat('yyyy-MM-dd').format(checkinDateTime);

    DateTime checkoutDateTime = DateTime.parse(widget.CheckoutDate.toString());
    String finDate1 = DateFormat('yyyy-MM-dd').format(checkoutDateTime);

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'UserID': userID.toString(),
          'HotelID': widget.hotelid.toString(),
          'HotelName': widget.hotelname.toString(),
          'HotelAddress': widget.hoteladdress.toString(),
          'HotelImageUrl': widget.imageurl.toString(),
          'Nationality': 'IN',
          'Price': widget.Roomprice.toString(),
          'CheckInDate': finDate,
          'CheckOutDate': finDate1,
          'TotalDays': widget.totaldays.toString(),
          'TotAdultCount': widget.adultCount.toString(),
          'TotChildCount': '1',
          'ResultIndex': widget.resultindex.toString(),
          'TraceId': widget.traceid.toString(),
          'RoomIndex': widget.roomindex.toString(),
          'RoomTypeCode': widget.roomtypecode.toString(),
          'RoomCount': '1',
          'Room1AdultSalu1': '0',
          'Room1AdultFName1': AdultName1.toString(),
          'Room1AdultLName1': adultLname_controller.text.toString(),
          'Room1AdultLDOB1': formattedDate.toString(),
          'Room1AdultTravellerId1': AdultTravellerId1.toString(),
          'Room1AdultSalu2': '',
          'Room1AdultFName2': AdultName2.toString(),
          'Room1AdultLName2': adult2_Lname_controller.text.toString(),
          'Room1AdultLDOB2': formattedDate2.toString(),
          'Room1AdultTravellerId2': AdultTravellerId2.toString(),
          'Room1AdultSalu3': '',
          'Room1AdultFName3': '',
          'Room1AdultLName3': '',
          'Room1AdultLDOB3': '',
          'Room1AdultTravellerId3': '',
          'Room1AdultSalu4': '',
          'Room1AdultFName4': '',
          'Room1AdultLName4': '',
          'Room1AdultLDOB4': '',
          'Room1AdultTravellerId4': '',
          'Room1ChildSalu1': '0',
          'Room1ChildFName1': 'Anu',
          'Room1ChildLName1': 'lal',
          'Room1ChildLDOB1': '2016/02/16',
          'Room1ChildSalu2': '',
          'Room1ChildFName2': '',
          'Room1ChildLName2': '',
          'Room1ChildLDOB2': '',
          'Room2AdultSalu1': '',
          'Room2AdultFName1': '',
          'Room2AdultLName1': '',
          'Room2AdultLDOB1': '',
          'Room2AdultTravellerId1': '',
          'Room2AdultSalu2': '',
          'Room2AdultFName2': '',
          'Room2AdultLName2': '',
          'Room2AdultLDOB2': '',
          'Room2AdultTravellerId2': '',
          'Room2AdultSalu3': '',
          'Room2AdultFName3': '',
          'Room2AdultLName3': '',
          'Room2AdultLDOB3': '',
          'Room2AdultTravellerId3': '',
          'Room2AdultSalu4': '',
          'Room2AdultFName4': '',
          'Room2AdultLName4': '',
          'Room2AdultLDOB4': '',
          'Room2AdultTravellerId4': '',
          'Room2ChildSalu1': '',
          'Room2ChildFName1': '',
          'Room2ChildLName1': '',
          'Room2ChildLDOB1': '',
          'Room2ChildSalu2': '',
          'Room2ChildFName2': '',
          'Room2ChildLName2': '',
          'Room2ChildLDOB2': '',
          'Room3AdultSalu1': '',
          'Room3AdultFName1': '',
          'Room3AdultLName1': '',
          'Room3AdultLDOB1': '',
          'Room3AdultTravellerId1': '',
          'Room3AdultSalu2': '',
          'Room3AdultFName2': '',
          'Room3AdultLName2': '',
          'Room3AdultLDOB2': '',
          'Room3AdultTravellerId2': '',
          'Room3AdultSalu3': '',
          'Room3AdultFName3': '',
          'Room3AdultLName3': '',
          'Room3AdultLDOB3': '',
          'Room3AdultTravellerId3': '',
          'Room3AdultSalu4': '',
          'Room3AdultFName4': '',
          'Room3AdultLName4': '',
          'Room3AdultLDOB4': '',
          'Room3AdultTravellerId4': '',
          'Room3ChildSalu1': '',
          'Room3ChildFName1': '',
          'Room3ChildLName1': '',
          'Room3ChildLDOB1': '',
          'Room3ChildSalu2': '',
          'Room3ChildFName2': '',
          'Room3ChildLName2': '',
          'Room3ChildLDOB2': '',
          'Room4AdultSalu1': '',
          'Room4AdultFName1': '',
          'Room4AdultLName1': '',
          'Room4AdultLDOB1': '',
          'Room4AdultTravellerId1': '',
          'Room4AdultSalu2': '',
          'Room4AdultFName2': '',
          'Room4AdultLName2': '',
          'Room4AdultLDOB2': '',
          'Room4AdultTravellerId2': '',
          'Room4AdultSalu3': '',
          'Room4AdultFName3': '',
          'Room4AdultLName3': '',
          'Room4AdultLDOB3': '',
          'Room4AdultTravellerId3': '',
          'Room4AdultSalu4': '',
          'Room4AdultFName4': '',
          'Room4AdultLName4': '',
          'Room4AdultLDOB4': '',
          'Room4AdultTravellerId4': '',
          'Room4ChildSalu1': '',
          'Room4ChildFName1': '',
          'Room4ChildLName1': '',
          'Room4ChildLDOB1': '',
          'Room4ChildSalu2': '',
          'Room4ChildFName2': '',
          'Room4ChildLName2': '',
          'Room4ChildLDOB2': '',
          'CustomerPhone': contactMobileController.text.toString(),
          'CustomerEmail': contactEmailController.text.toString(),
        },
      );
      print('UserID: ${userID.toString()}');
      print('HotelID: ${widget.hotelid.toString()}');
      print('HotelName: ${widget.hotelname.toString()}');
      print('HotelAddress: ${widget.hoteladdress.toString()}');
      print('HotelImageUrl: ${widget.imageurl.toString()}');
      print('Nationality: IN');
      print('Price: ${widget.Roomprice.toString()}');
      print('CheckInDate: $finDate');
      print('CheckOutDate: $finDate1');
      print('TotalDays: ${widget.totaldays.toString()}');
      print('TotAdultCount: ${widget.adultCount.toString()}');
      print('TotChildCount: 1');
      print('ResultIndex: ${widget.resultindex.toString()}');
      print('TraceId: ${widget.traceid.toString()}');
      print('RoomIndex: ${widget.roomindex.toString()}');
      print('RoomTypeCode: ${widget.roomtypecode.toString()}');
      print('RoomCount: 1');
      print('Room1AdultSalu1: 0');
      print('Room1AdultFName1: ${AdultName1.toString()}');
      print('Room1AdultLName1: ${adultLname_controller.text.toString()}');
      print('Room1AdultLDOB1: ${formattedDate.toString()}');
      print('Room1AdultTravellerId1: ${AdultTravellerId1.toString()}');
      print('Room1ChildSalu1: 0');
      print('Room1ChildFName1: Anu');
      print('Room1ChildLName1: lal');
      print('Room1ChildLDOB1: 2016/02/16');
      print('CustomerPhone: ${contactMobileController.text}');
      print('CustomerEmail: ${contactEmailController.text}');

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (error) {
      print('Error making POST request: $error');
    }
  }*/
  Future<void> callSecondApiAdult2(String id) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellerDetails?TravellerId=$id&UID=35510b94-5342-TDemoB2CAPI-a2e3-2e722772';
    print('object' + id);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = response.body;

      // Parse XML and extract JSON string
      final startTag = '<string xmlns="http://tempuri.org/">';
      final endTag = '</string>';
      final startIndex = responseData.indexOf(startTag) + startTag.length;
      final endIndex = responseData.indexOf(endTag);
      final jsonString = responseData.substring(startIndex, endIndex);

      // Parse JSON string
      final jsonData = json.decode(jsonString);

      // Extract data from Table
      final tableData = jsonData['Table'];
      final table1Data = jsonData['Table1'];

      if (tableData != null &&
          tableData.isNotEmpty &&
          table1Data != null &&
          table1Data.isNotEmpty) {
        final traveller = tableData[0];
        final passportInfo =
            table1Data[0]; // Assuming there's only one entry in Table1

        setState(() {
          adult2_Lname_controller.text = traveller['UDLastName'];
          dateControllerAdult2.text = traveller['UDDOB'];
          String inputDate2 = dateControllerAdult2.text;
          formattedDate2 = convertDate(inputDate2);
          print("formattedDate" + formattedDate2);

          if (traveller['GenderId'] == 0) {
            selectedGendarContactDetailAdult2 = "Male";
          } else if (traveller['GenderId'] == 1) {
            selectedGendarContactDetailAdult2 = "Female";
          }
          // Get data from Table1
          Documentnumber_controllerAdult2.text = passportInfo['PDPassportNo'];

          String dateOfBirth = passportInfo['PDDateofBirth'];
          Documentype_controllerAdult2.text = passportInfo['PDDocument'];
          String issuingCountry = passportInfo['PDIssuingCountry'];
          ExpiryDateControllerAdult2.text = passportInfo['PDDateofExpiry'];
          DateTime checkinDateTime =
              DateTime.parse(ExpiryDateControllerAdult2.text);
          String finDate = DateFormat('yyyy/MM/dd').format(checkinDateTime);

          ExpiryDateControllerAdult2.text = finDate;
          print('finDate' + ExpiryDateControllerAdult2.text.toString());
          // Update other text controllers with relevant fields
        });
      } else {
        throw Exception('Failed to load traveller details');
      }
    }
  }

  Future<void> callSecondApiAdult3(String id) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellerDetails?TravellerId=$id&UID=35510b94-5342-TDemoB2CAPI-a2e3-2e722772';
    print('object' + id);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = response.body;

      // Parse XML and extract JSON string
      final startTag = '<string xmlns="http://tempuri.org/">';
      final endTag = '</string>';
      final startIndex = responseData.indexOf(startTag) + startTag.length;
      final endIndex = responseData.indexOf(endTag);
      final jsonString = responseData.substring(startIndex, endIndex);

      // Parse JSON string
      final jsonData = json.decode(jsonString);

      // Extract data from Table
      final tableData = jsonData['Table'];
      final table1Data = jsonData['Table1'];

      if (tableData != null &&
          tableData.isNotEmpty &&
          table1Data != null &&
          table1Data.isNotEmpty) {
        final traveller = tableData[0];
        final passportInfo =
            table1Data[0]; // Assuming there's only one entry in Table1

        setState(() {
          adult3_Lname_controller.text = traveller['UDLastName'];
          dateControllerAdult3.text = traveller['UDDOB'];
          String inputDate2 = dateControllerAdult3.text;
          formattedDate3 = convertDate(inputDate2);
          print("formattedDate" + formattedDate3);

          if (traveller['GenderId'] == 0) {
            selectedGendarContactDetailAdult3 = "Male";
          } else if (traveller['GenderId'] == 1) {
            selectedGendarContactDetailAdult3 = "Female";
          }
          // Get data from Table1
          Documentnumber_controllerAdult3.text = passportInfo['PDPassportNo'];

          String dateOfBirth = passportInfo['PDDateofBirth'];
          Documentype_controllerAdult3.text = passportInfo['PDDocument'];
          String issuingCountry = passportInfo['PDIssuingCountry'];
          ExpiryDateControllerAdult3.text = passportInfo['PDDateofExpiry'];
          DateTime checkinDateTime =
              DateTime.parse(ExpiryDateControllerAdult3.text);
          String finDate = DateFormat('yyyy/MM/dd').format(checkinDateTime);

          ExpiryDateControllerAdult3.text = finDate;
          print('finDate' + ExpiryDateControllerAdult3.text.toString());
          // Update other text controllers with relevant fields
        });
      } else {
        throw Exception('Failed to load traveller details');
      }
    }
  }

  Future<void> callSecondApiAdult4(String id) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellerDetails?TravellerId=$id&UID=35510b94-5342-TDemoB2CAPI-a2e3-2e722772';
    print('object' + id);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = response.body;

      // Parse XML and extract JSON string
      final startTag = '<string xmlns="http://tempuri.org/">';
      final endTag = '</string>';
      final startIndex = responseData.indexOf(startTag) + startTag.length;
      final endIndex = responseData.indexOf(endTag);
      final jsonString = responseData.substring(startIndex, endIndex);

      // Parse JSON string
      final jsonData = json.decode(jsonString);

      // Extract data from Table
      final tableData = jsonData['Table'];
      final table1Data = jsonData['Table1'];

      if (tableData != null &&
          tableData.isNotEmpty &&
          table1Data != null &&
          table1Data.isNotEmpty) {
        final traveller = tableData[0];
        final passportInfo =
            table1Data[0]; // Assuming there's only one entry in Table1

        setState(() {
          adult4_Lname_controller.text = traveller['UDLastName'];
          dateControllerAdult4.text = traveller['UDDOB'];
          String inputDate2 = dateControllerAdult3.text;
          formattedDate4 = convertDate(inputDate2);
          print("formattedDate" + formattedDate4);

          if (traveller['GenderId'] == 0) {
            selectedGendarContactDetailAdult4 = "Male";
          } else if (traveller['GenderId'] == 1) {
            selectedGendarContactDetailAdult4 = "Female";
          }
          // Get data from Table1
          Documentnumber_controllerAdult4.text = passportInfo['PDPassportNo'];

          Documentype_controllerAdult4.text = passportInfo['PDDocument'];
          String issuingCountry = passportInfo['PDIssuingCountry'];
          ExpiryDateControllerAdult4.text = passportInfo['PDDateofExpiry'];
          DateTime checkinDateTime =
              DateTime.parse(ExpiryDateControllerAdult4.text);
          String finDate = DateFormat('yyyy/MM/dd').format(checkinDateTime);

          ExpiryDateControllerAdult4.text = finDate;
          print('finDate' + ExpiryDateControllerAdult4.text.toString());
          // Update other text controllers with relevant fields
        });
      } else {
        throw Exception('Failed to load traveller details');
      }
    }
  }

  Future<void> _retrieveSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userTypeID = prefs.getString(Prefs.PREFS_USER_TYPE_ID) ?? '';
      userID = prefs.getString(Prefs.PREFS_USER_ID) ?? '';
      Currency = prefs.getString(Prefs.PREFS_CURRENCY) ?? '';
      print('Currency: $Currency');
    });
  }

  Future<List<TravellerDetailsModel>> fetchAutocompleteData(
      String empName) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellers?UserId=$userID&UserTypeId=$userTypeID&SearchFilter=$empName&UID=35510b94-5342-TDemoB2CAPI-a2e3-2e722772';
    print('userID' + userID);
    print('userTypeID' + userTypeID);
    print('empName' + empName);

    final response = await http.get(Uri.parse(url));
    print('response: ${response.statusCode}');
    if (response.statusCode == 200) {
      final xmlDocument = xml.XmlDocument.parse(response.body);
      final responseData = xmlDocument.findAllElements('string').first.text;

      final decodedData = json.decode(responseData);
      return decodedData
          .map<TravellerDetailsModel>(
              (data) => TravellerDetailsModel.fromJson(data))
          .toList();
    } else {
      print('Failed to load autocomplete data: ${response.statusCode}');
      throw Exception('Failed to load autocomplete data');
    }
  }

  String formattedDate = '',
      formattedDate2 = '',
      formattedDate3 = '',
      formattedDate4 = '';

  Future<void> callSecondApi(String id) async {
    final url =
        'https://traveldemo.org/travelapp/b2capi.asmx/BookingSearchTravellerDetails?TravellerId=$id&UID=35510b94-5342-TDemoB2CAPI-a2e3-2e722772';
    print('object' + id);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = response.body;

      // Parse XML and extract JSON string
      final startTag = '<string xmlns="http://tempuri.org/">';
      final endTag = '</string>';
      final startIndex = responseData.indexOf(startTag) + startTag.length;
      final endIndex = responseData.indexOf(endTag);
      final jsonString = responseData.substring(startIndex, endIndex);

      // Parse JSON string
      final jsonData = json.decode(jsonString);

      // Extract data from Table
      final tableData = jsonData['Table'];
      final table1Data = jsonData['Table1'];

      if (tableData != null &&
          tableData.isNotEmpty &&
          table1Data != null &&
          table1Data.isNotEmpty) {
        final traveller = tableData[0];
        final passportInfo =
            table1Data[0]; // Assuming there's only one entry in Table1

        setState(() {
          String _firstNameController = traveller['UDFirstName'];
          adultLname_controller.text = traveller['UDLastName'];
          dateControllerAdult1.text = traveller['UDDOB'];
          String inputDate = dateControllerAdult1.text;
          formattedDate = convertDate(inputDate);
          print("formattedDate" + formattedDate);

          print('finDate' + dateControllerAdult1.text.toString());
          if (traveller['GenderId'] == 0) {
            selectedGendarContactDetail = "Male";
          } else if (traveller['GenderId'] == 1) {
            selectedGendarContactDetail = "Female";
          }
          // Get data from Table1
          Documentnumber_controller.text = passportInfo['PDPassportNo'];

          String dateOfBirth = passportInfo['PDDateofBirth'];
          Documentype_controller.text = passportInfo['PDDocument'];
          String issuingCountry = passportInfo['PDIssuingCountry'];
          ExpiryDateController.text = passportInfo['PDDateofExpiry'];
          DateTime checkinDateTime = DateTime.parse(ExpiryDateController.text);
          String finDate = DateFormat('yyyy/MM/dd').format(checkinDateTime);

          ExpiryDateController.text = finDate;
          print('finDate' + ExpiryDateController.text.toString());
          // Update other text controllers with relevant fields
        });
      } else {
        throw Exception('Failed to load traveller details');
      }
    }
  }

  String convertDate(String inputDate) {
    // Parse the input date string
    DateTime date = DateFormat('dd MMM yyyy').parse(inputDate);

    // Format the date in the desired format
    String formattedDate = DateFormat('yyyy/MM/dd').format(date);

    return formattedDate;
  }

  Future<void> _selectDateAdult2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult2) {
      setState(() {
        dateControllerAdult2.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateAdult3(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult3) {
      setState(() {
        dateControllerAdult3.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateAdult4(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult4) {
      setState(() {
        dateControllerAdult4.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateAdult5(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerAdult5) {
      setState(() {
        dateControllerAdult5.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateChildren1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren1) {
      setState(() {
        dateControllerChildren1.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateChildren2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren2) {
      setState(() {
        dateControllerChildren2.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateChildren3(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren3) {
      setState(() {
        dateControllerChildren3.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateChildren4(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren4) {
      setState(() {
        dateControllerChildren4.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDateChildren5(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateControllerChildren5) {
      setState(() {
        dateControllerChildren5.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> bookTour() async {
    final Uri url =
        Uri.parse('https://traveldemo.org/travelapp/b2capi.asmx/TourBooking');
    DateTime checkinDateTime = DateTime.parse(widget.CheckinDate);
    String finDate = DateFormat('yyyy-MM-dd').format(checkinDateTime);
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'AmountWithoutTax': widget.price.toString(),
          'TourCurrency': Currency.toString(),
          'StayHotelName': 'stayHotelName',
          'TourRateKey': widget.modalities_rateKey.toString(),
          'FromDate': finDate.toString(),
          'ToDate': finDate.toString(),
          'DefaultCurrency': Currency.toString(),
          'userID': userID.toString(),
          'userTypeID': userTypeID.toString(),
          'AdultCount': widget.adultCount.toString(),
          'ChildCount': widget.childrenCount.toString(),
          'InfantCount': '0',
          'TourCode': widget.Tourcode.toString(),
          'ModalitiesCode': widget.ModalitiesCode.toString(),
          'Adult1Title': '0',
          'Adult1FirstName': AdultName1.toString(),
          'Adult1LastName': adultLname_controller.text.toString(),
          'Adult1DOB': formattedDate.toString(),
          'AdultTravellerId1': AdultTravellerId1.toString(),
          'Adult2Title': '',
          'Adult2FirstName': '',
          'Adult2LastName': '',
          'Adult2DOB': '',
          'AdultTravellerId2': '',
          'Adult3Title': '',
          'Adult3FirstName': '',
          'Adult3LastName': '',
          'Adult3DOB': '',
          'AdultTravellerId3': '',
          'Adult4Title': '',
          'Adult4FirstName': '',
          'Adult4LastName': '',
          'Adult4DOB': '',
          'AdultTravellerId4': '',
          'Adult5Title': '',
          'Adult5FirstName': '',
          'Adult5LastName': '',
          'Adult5DOB': '',
          'AdultTravellerId5': '',
          'Adult6Title': '',
          'Adult6FirstName': '',
          'Adult6LastName': '',
          'Adult6DOB': '',
          'AdultTravellerId6': '',
          'Adult7Title': '',
          'Adult7FirstName': '',
          'Adult7LastName': '',
          'Adult7DOB': '',
          'AdultTravellerId7': '',
          'Adult8Title': '',
          'Adult8FirstName': '',
          'Adult8LastName': '',
          'Adult8DOB': '',
          'AdultTravellerId8': '',
          'Adult9Title': '',
          'Adult9FirstName': '',
          'Adult9LastName': '',
          'Adult9DOB': '',
          'AdultTravellerId9': '',
          'Adult10Title': '',
          'Adult10FirstName': '',
          'Adult10LastName': '',
          'Adult10DOB': '',
          'AdultTravellerId10': '',
          'Child1Title': '0',
          'Child1FirstName': AdultName1.toString(),
          'Child1LastName': adultLname_controller.text.toString(),
          'Child1DOB': formattedDate.toString(),
          'Child2Title': '',
          'Child2FirstName': '',
          'Child2LastName': '',
          'Child2DOB': '',
          'Child3Title': '',
          'Child3FirstName': '',
          'Child3LastName': '',
          'Child3DOB': '',
          'Child4Title': '',
          'Child4FirstName': '',
          'Child4LastName': '',
          'Child4DOB': '',
          'Child5Title': '',
          'Child5FirstName': '',
          'Child5LastName': '',
          'Child5DOB': '',
          'Address': contactAddressController.text.toString(),
          'ZipCode': '629004',
          'Country': CountryController.text.toString(),
          'Email': contactEmailController.text.toString(),
          'Phone': contactMobileController.text.toString(),
        },
      );

      print(response.body);
    } catch (ex) {
      print(ex);
    }
  }

  @override
  Widget build(BuildContext context) {
    int adultCountInt = widget.adultCount;
    int childrenCount = widget.childrenCount;
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
              "Review Booking",
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.grey.shade300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 130,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                // Set corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    // Shadow color
                                    spreadRadius: 2,
                                    // Spread radius
                                    blurRadius: 5,
                                    // Blur radius
                                    offset:
                                        Offset(0, 3), // Offset for the shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                // Ensure the image corners match the container
                                child: Image.network(
                                  widget.imageurl,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.holidayName
                                        .toString(), // Example hotel name
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  RatingBar.builder(
                                    initialRating: 3,
                                    // Example rating value
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  // Hotel address
                                  Text(
                                    widget.touraddress
                                        .toString(), // Example hotel address
                                    style: TextStyle(fontSize: 14),
                                  ),

                                  SizedBox(
                                    height: 5,
                                  ),
                                  /*  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 7),
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '4' + " " + '/5',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 7, bottom: 7),
                            child: Text(
                              'Travel Details',
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Start Date',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ('End Date'),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('E, d MMM').format(DateTime.parse(widget.CheckinDate)), // Formats to Fri, 25 Oct
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  DateFormat('E, d MMM').format(DateTime.parse(widget.CheckinDate)), // Formats to Fri, 25 Oct
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 7, bottom: 7),
                            child: Text(
                              'Guests',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  (widget.adultCount.toString() +
                                      " " +
                                      "Guests"),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Divider(),

                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              'Tour Code : ${widget.Tourcode.toString()}',
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Text(
                                'Inclusions: ',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: Column(
                              children:
                                  createIconsForWords(widget.featuresInclusion),
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              'Exclusions: ',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: Column(
                              children: createIconsForWords1(
                                  widget.featuresExclusion),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Material(
                      elevation: 0,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price Summary',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'View Full Breakup',
                                  style: TextStyle(
                                    color: Color(0xFF152238),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 1, color: Colors.grey.shade200),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Amount To Be Paid',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  Currency + " " + widget.price.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, bottom: 5, top: 5),
                            child: Text(
                              'Travellers',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              'Adults',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Column(
                            children: List.generate(adultCountInt, (i) {
                              // Determine if there is valid adult data
                              bool hasAdultData = _adultsList.length > i &&
                                  _adultsList[i] != null &&
                                  _adultsList[i]['firstName'] != null;

                              print('hasAdultData: ' + hasAdultData.toString());

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: hasAdultData
                                          ? Color(0xFF152238)
                                          : Colors.grey,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: !hasAdultData && !isEditAdult
                                            ? () {
                                                // Navigate to the page to add an adult if there's no data
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HolidayAdultScreen(
                                                      isEdit: 'Add',
                                                      adultIndex: i,
                                                      adultsList: _adultsList,
                                                      flightDetails: '',
                                                      resultFlightData: '',
                                                      infantCount: 0,
                                                      childrenCount: 0,
                                                      adultCount: adultCountInt,
                                                      departdate: '',
                                                      userid: '',
                                                      usertypeid: '',
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
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                    // Edit Button
                                    IconButton(
                                      icon:
                                          Icon(Icons.edit, color: Color(0xFF152238)),
                                      onPressed: hasAdultData && !isEditAdult
                                          ? () {
                                              // Navigate to edit screen if adult data exists and not in edit mode
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HolidayAdultScreen(
                                                    isEdit: 'Edit',
                                                    adultIndex: i,
                                                    adultsList: _adultsList,
                                                    flightDetails: '',
                                                    resultFlightData: '',
                                                    infantCount: 0,
                                                    childrenCount: 0,
                                                    adultCount: adultCountInt,
                                                    departdate: '',
                                                    userid: '',
                                                    usertypeid: '',
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
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: hasAdultData && !isEditAdult
                                          ? () {
                                              // Show confirmation dialog
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Confirm Deletion'),
                                                    content: Text(
                                                        'Are you sure you want to delete this adult?'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text('No'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // Close dialog
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text('Yes'),
                                                        onPressed: () {
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
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Children',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Column(
                                    children: List.generate(childrenCount, (i) {
                                      // Determine if there is valid child data
                                      bool hasChildData = _childrenList.length >
                                              i &&
                                          _childrenList[i] != null &&
                                          _childrenList[i]['firstName'] != null;

                                      print('hasChildData: ' +
                                          hasChildData.toString());

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: hasChildData
                                                  ? Colors.green
                                                  : Colors.grey,
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: !hasChildData &&
                                                        !isEditChild
                                                    ? () {
                                                        // Navigate to the page to add a child if there's no data
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                HolidayAddChildrenScreen(
                                                              isEdit: 'Add',
                                                              childIndex: i,
                                                              childrenList:
                                                                  _childrenList,
                                                              flightDetails: '',
                                                              resultFlightData:
                                                                  '',
                                                              infantCount: 0,
                                                              childrenCount:
                                                                  childrenCount,
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
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: hasChildData
                                                        ? Colors.black
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Edit Button
                                            IconButton(
                                              icon: Icon(Icons.edit,
                                                  color: Color(0xFF152238)),
                                              onPressed: hasChildData &&
                                                      !isEditChild
                                                  ? () {
                                                      // Navigate to edit screen if child data exists and not in edit mode
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              HolidayAddChildrenScreen(
                                                            isEdit: 'Edit',
                                                            childIndex: i,
                                                            childrenList:
                                                                _childrenList,
                                                            flightDetails: '',
                                                            resultFlightData:
                                                                '',
                                                            infantCount: 0,
                                                            childrenCount:
                                                                childrenCount,
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
                                                  : null, // Disable if there is no child data or isEdit is true
                                            ),
                                            // Delete Button
                                            IconButton(
                                              icon: Icon(Icons.delete,
                                                  color: Colors.red),
                                              onPressed: hasChildData &&
                                                      !isEditChild
                                                  ? () {
                                                      // Show confirmation dialog
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Confirm Deletion'),
                                                            content: Text(
                                                                'Are you sure you want to delete this child?'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child:
                                                                    Text('No'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(); // Close dialog
                                                                },
                                                              ),
                                                              TextButton(
                                                                child:
                                                                    Text('Yes'),
                                                                onPressed: () {
                                                                  _deleteChild(
                                                                      i); // Call delete method for child
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(); // Close dialog
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
                      height: 20,
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
                                      color: Colors.blue),
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
                                      color: Colors.blue),
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
                                      color: Colors.blue),
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
                                      color: Colors.blue),
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
                                      color: Colors.blue),
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
                                      color: Colors.blue),
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
                    color: Colors.grey.shade100, // Light grey color for the starting horizontal line
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
                        padding: const EdgeInsets.only(left: 10.0, top: 8),
                        child: Text(
                          Currency +  widget.price,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, top: 8),
                        child: ElevatedButton(
                          onPressed: bookTour,
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
                              'Book Tour',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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

double _getInitialRating(int starCategory) {
  if (starCategory >= 1 && starCategory <= 5) {
    return starCategory.toDouble();
  } else {
    return 1.0; // Set a default of one star if 'StarCategory' is not in the valid range
  }
}
