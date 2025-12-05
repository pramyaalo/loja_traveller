
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';





class AddTravellerScreen extends StatefulWidget {

  @override
  _MyRechargePageState createState() => _MyRechargePageState();
}

class _MyRechargePageState extends State<AddTravellerScreen> {
  String checkboxStatus = "0";
  String genderValue = "Male";
  String? selectedTitle = 'Mr'; // Default value for Title
  String? dependentTitle = 'Mr';
  String? selectedSmokingPreference;
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController loyaltyNumberController = TextEditingController(); // Controller for loyalty number
  final TextEditingController facilitiesController = TextEditingController();
  final TextEditingController membershipNumberController =
  TextEditingController();
  String? selectedDocument; // Holds the selected document type
  String? selectedIssuingCountry; // Holds the selected issuing country
  DateTime selectedExpiryDate = DateTime.now();
  DateTime dependentselectedExpiryDate = DateTime.now();
  DateTime selectedDateOfIssue  = DateTime.now();
  DateTime dependentExpiryDate  = DateTime.now();
  DateTime dependentselectedDateOfIssue  = DateTime.now();// Default to current date
  DateTime VisaExpiryDate  = DateTime.now();// Default to current date
  List<String> dependentCountryofvisa = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Comoros",
    "Congo",
    "Costa Rica",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Eswatini",
    "Ethiopia",
    "Fiji",
    "Finland",
    "France",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Grenada",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Korea (North)",
    "Korea (South)",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Micronesia",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Myanmar (Burma)",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "North Macedonia",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Qatar",
    "Romania",
    "Russia",
    "Rwanda",
    "Saint Kitts and Nevis",
    "Saint Lucia",
    "Saint Vincent and the Grenadines",
    "Samoa",
    "San Marino",
    "Sao Tome and Principe",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Timor-Leste",
    "Togo",
    "Tonga",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Vatican City",
    "Venezuela",
    "Vietnam",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];
  String? DependentCountryofvisa;
  TextEditingController airlineController = TextEditingController();
  String? selectedDocumentType;  // This is the variable for storing the selected document type
// Declare documentTypes list
  final List<String> documentTypes = [
    "Document",
    "Image"
  ];
  String? selectedRoomPreference;
  String? selectedFileName; // Variable to store the selected file's name

  // Function to pick a file
  Future<void> _pickFile() async {
    // Open file picker
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // File picked successfully, get the file name
      setState(() {
        selectedFileName = result.files.single.name;
      });
    } else {
      // User canceled file picking
      setState(() {
        selectedFileName = null;
      });
    }
  }
  List<String> dependentIssuepassportCountries = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Comoros",
    "Congo",
    "Costa Rica",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Eswatini",
    "Ethiopia",
    "Fiji",
    "Finland",
    "France",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Grenada",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Korea (North)",
    "Korea (South)",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Micronesia",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Myanmar (Burma)",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "North Macedonia",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Qatar",
    "Romania",
    "Russia",
    "Rwanda",
    "Saint Kitts and Nevis",
    "Saint Lucia",
    "Saint Vincent and the Grenadines",
    "Samoa",
    "San Marino",
    "Sao Tome and Principe",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Timor-Leste",
    "Togo",
    "Tonga",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Vatican City",
    "Venezuela",
    "Vietnam",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];

  String? selectedTravelClass; // Variable to store the selected travel class

  // Static list of travel classes
  final List<String> travelClasses = [
    'Select Travel Class', // Default option
    'Economy Class',
    'Premium Economy',
    'Business Class',
  ];
  String? selectedStopOver; // Selected value for Stop Over Preference

  // List of stop-over options
  final List<String> stopOverOptions = [
    'Select Stop Over', // Default option
    'One Stop',
    'Two Stops',
    'Three Stops',
  ];
  String? selectedMealPreference; // Selected meal preference

  // List of meal preference options
  final List<String> mealPreferenceOptions = [
    'Select Meal Preference', // Default option
    'Meal Preference A',
    'Meal Preference B',
    'Meal Preference C',
  ];
  // Simulate loading travel class options (you can replace this with real async data)
  Future<List<String>> _loadTravelClasses() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return ['Economy Class', 'Premium Economy', 'Business Class'];


  }
// Variable to hold the selected country (renamed to dependentSelectedIssuingCountry)
  String? dependentSelectedIssuingCountry;
  void _selectExpiryDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedExpiryDate, // Initial date to show
      firstDate: DateTime(1900), // Earliest possible date
      lastDate: DateTime(2101), // Latest possible date
    );

    if (picked != null && picked != selectedExpiryDate) {
      setState(() {
        selectedExpiryDate = picked; // Update the selected date
        expiryDateController.text = "${selectedExpiryDate.toLocal()}".split(' ')[0]; // Format date to display
      });
    }
  }

  void _dependentselectExpiryDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dependentselectedExpiryDate, // Initial date to show
      firstDate: DateTime(1900), // Earliest possible date
      lastDate: DateTime(2101), // Latest possible date
    );

    if (picked != null && picked != dependentselectedExpiryDate) {
      setState(() {
        dependentselectedExpiryDate = picked; // Update the selected date
        dependentExpiryController.text = "${dependentselectedExpiryDate.toLocal()}".split(' ')[0]; // Format date to display
      });
    }
  }
  //dependentExpiryController
  bool isChecked = false; // To hold checkbox state
  List<String> dependentCountries = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Comoros",
    "Congo",
    "Costa Rica",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Eswatini",
    "Ethiopia",
    "Fiji",
    "Finland",
    "France",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Grenada",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Korea (North)",
    "Korea (South)",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Micronesia",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Myanmar (Burma)",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "North Macedonia",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Qatar",
    "Romania",
    "Russia",
    "Rwanda",
    "Saint Kitts and Nevis",
    "Saint Lucia",
    "Saint Vincent and the Grenadines",
    "Samoa",
    "San Marino",
    "Sao Tome and Principe",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Timor-Leste",
    "Togo",
    "Tonga",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Vatican City",
    "Venezuela",
    "Vietnam",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];

// Variable to hold the selected country (renamed to dependentSelectedCountry)
  String? dependentSelectedCountry;
  void _onAddButtonPressed() {
    // Implement the logic for when the 'ADD' button is pressed
    print('Add button pressed');
  }

  final TextEditingController customerTypeController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController  travellerphoneController= TextEditingController();
  final TextEditingController  travellerMobileNumberController= TextEditingController();
  final TextEditingController residencyController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController travellerTypeController = TextEditingController();
  final TextEditingController travellerCodeController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController passportNoController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  TextEditingController visaNumberController = TextEditingController(); // Controller for Visa Number

  String? selectedCountry; // Holds the selected country
  final List<String> countries = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Comoros",
    "Congo",
    "Costa Rica",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Eswatini",
    "Ethiopia",
    "Fiji",
    "Finland",
    "France",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Grenada",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Korea (North)",
    "Korea (South)",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Micronesia",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Myanmar (Burma)",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "North Macedonia",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Qatar",
    "Romania",
    "Russia",
    "Rwanda",
    "Saint Kitts and Nevis",
    "Saint Lucia",
    "Saint Vincent and the Grenadines",
    "Samoa",
    "San Marino",
    "Sao Tome and Principe",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Timor-Leste",
    "Togo",
    "Tonga",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Vatican City",
    "Venezuela",
    "Vietnam",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];
  TextEditingController visaTypeController = TextEditingController();
  TextEditingController dateOfIssueController = TextEditingController();
  TextEditingController dependentdateOfIssueController = TextEditingController();
  TextEditingController dateOfExpiryController = TextEditingController();

  TextEditingController dependentdateOfExpiryController = TextEditingController();

  // Variables for dropdowns
  String selectedCountry1 = 'Select Country';
  String selectedVisaType = 'Select Visa Type';

  // List of countries for the dropdown (use a comprehensive list in production)
  List<String> countries1 = [
    'Afghanistan', 'Albania', 'Algeria', 'Andorra', 'Angola', 'Antigua and Barbuda', 'Argentina', 'Armenia', 'Australia', 'Austria',
    'Azerbaijan', 'Bahamas', 'Bahrain', 'Bangladesh', 'Barbados', 'Belarus', 'Belgium', 'Belize', 'Benin', 'Bhutan',
    'Bolivia', 'Bosnia and Herzegovina', 'Botswana', 'Brazil', 'Brunei', 'Bulgaria', 'Burkina Faso', 'Burundi', 'Cabo Verde',
    'Cambodia', 'Cameroon', 'Canada', 'Central African Republic', 'Chad', 'Chile', 'China', 'Colombia', 'Comoros', 'Congo',
    'Costa Rica', 'Croatia', 'Cuba', 'Cyprus', 'Czech Republic', 'Denmark', 'Djibouti', 'Dominica', 'Dominican Republic',
    'Ecuador', 'Egypt', 'El Salvador', 'Equatorial Guinea', 'Eritrea', 'Estonia', 'Eswatini', 'Ethiopia', 'Fiji', 'Finland',
    'France', 'Gabon', 'Gambia', 'Georgia', 'Germany', 'Ghana', 'Greece', 'Grenada', 'Guatemala', 'Guinea', 'Guinea-Bissau',
    'Guyana', 'Haiti', 'Honduras', 'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq', 'Ireland', 'Israel', 'Italy',
    'Jamaica', 'Japan', 'Jordan', 'Kazakhstan', 'Kenya', 'Kiribati', 'Korea, North', 'Korea, South', 'Kuwait', 'Kyrgyzstan',
    'Laos', 'Latvia', 'Lebanon', 'Lesotho', 'Liberia', 'Libya', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Madagascar',
    'Malawi', 'Malaysia', 'Maldives', 'Mali', 'Malta', 'Marshall Islands', 'Mauritania', 'Mauritius', 'Mexico', 'Micronesia',
    'Moldova', 'Monaco', 'Mongolia', 'Montenegro', 'Morocco', 'Mozambique', 'Myanmar', 'Namibia', 'Nauru', 'Nepal', 'Netherlands',
    'New Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'North Macedonia', 'Norway', 'Oman', 'Pakistan', 'Palau', 'Panama', 'Papua New Guinea',
    'Paraguay', 'Peru', 'Philippines', 'Poland', 'Portugal', 'Qatar', 'Romania', 'Russia', 'Rwanda', 'Saint Kitts and Nevis',
    'Saint Lucia', 'Saint Vincent and the Grenadines', 'Samoa', 'San Marino', 'Sao Tome and Principe', 'Saudi Arabia', 'Senegal',
    'Serbia', 'Seychelles', 'Sierra Leone', 'Singapore', 'Slovakia', 'Slovenia', 'Solomon Islands', 'Somalia', 'South Africa',
    'South Sudan', 'Spain', 'Sri Lanka', 'Sudan', 'Suriname', 'Sweden', 'Switzerland', 'Syria', 'Taiwan', 'Tajikistan', 'Tanzania',
    'Thailand', 'Timor-Leste', 'Togo', 'Tonga', 'Trinidad and Tobago', 'Tunisia', 'Turkey', 'Turkmenistan', 'Tuvalu', 'Uganda',
    'Ukraine', 'United Arab Emirates', 'United Kingdom', 'United States', 'Uruguay', 'Uzbekistan', 'Vanuatu', 'Vatican City',
    'Venezuela', 'Vietnam', 'Yemen', 'Zambia', 'Zimbabwe'
  ];
  List<String> visaTypes = ['Tourist Visa', 'Business Visa', 'Student Visa'];

  // Date formatting
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  void _selectDateOfIssue() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateOfIssue, // Initial date to show
      firstDate: DateTime(1900), // Earliest possible date
      lastDate: DateTime(2101), // Latest possible date
    );

    if (picked != null && picked != selectedDateOfIssue) {
      setState(() {
        selectedDateOfIssue = picked; // Update the selected date
        dateOfIssueController.text = "${selectedDateOfIssue.toLocal()}".split(
            ' ')[0]; // Format date to display
      });
    }
  }
  void _dependentxpirydate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dependentExpiryDate, // Initial date to show
      firstDate: DateTime(1900), // Earliest possible date
      lastDate: DateTime(2101), // Latest possible date
    );

    if (picked != null && picked != dependentExpiryDate) {
      setState(() {
        dependentExpiryDate = picked; // Update the selected date
        dependentdateOfExpiryController.text = "${dependentExpiryDate.toLocal()}".split(
            ' ')[0]; // Format date to display
      });
    }
  }
//dependentdateOfExpiryController
  void _dependentselectDateOfIssue() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dependentselectedDateOfIssue, // Initial date to show
      firstDate: DateTime(1900), // Earliest possible date
      lastDate: DateTime(2101), // Latest possible date
    );

    if (picked != null && picked != dependentselectedDateOfIssue) {
      setState(() {
        dependentselectedDateOfIssue = picked; // Update the selected date
        dependentdateOfIssueController.text = "${dependentselectedDateOfIssue.toLocal()}".split(
            ' ')[0]; // Format date to display
      });
    }
  }
  //dependentdateOfIssueController
  TextEditingController VisaexpiryDateController = TextEditingController();

//
  // Function to open DateTime Picker for Date of Expiry
  void _VisaselectExpiryDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: VisaExpiryDate, // Initial date to show
      firstDate: DateTime(1900), // Earliest possible date
      lastDate: DateTime(2101), // Latest possible date
    );

    if (picked != null && picked != VisaExpiryDate) {
      setState(() {
        VisaExpiryDate = picked; // Update the selected date
        dateOfExpiryController.text = "${VisaExpiryDate.toLocal()}".split(
            ' ')[0]; // Format date to display
      });
    }
  }

  String checkboxStatus1 = "0";

  bool isIssueTicketChecked = false;
  bool isCancelBookingChecked = false;
  late List<dynamic> table0, table1, table2, table3, table4, table5, table6;

  String status = "Active"; // Default value

  String _userImage = '';
  final TextEditingController dependentTitleController = TextEditingController();
  final TextEditingController dependentFirstNameController = TextEditingController();
  final TextEditingController dependentMiddleNameController = TextEditingController();
  final TextEditingController dependentLastNameController = TextEditingController();
  final TextEditingController dependentDobController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController dependentPassportNoController = TextEditingController();
  final TextEditingController dependentExpiryController = TextEditingController();
  final TextEditingController dependentEmailController = TextEditingController();
  final TextEditingController dependentmobileNoController = TextEditingController();
  final TextEditingController dependentVisaTypeController = TextEditingController();
  final TextEditingController filetitleContoller = TextEditingController();
  final TextEditingController passportIssuingCountryController = TextEditingController();
  final TextEditingController visaDateOfIssueController = TextEditingController();
  final TextEditingController visaDateOfExpiryController = TextEditingController();
  String datePart = '';


// Date format for DatePicker
  DateFormat dependentDateFormat = DateFormat('yyyy-MM-dd');
  DateTime selectedDOB = DateTime.now();
  DateTime selectedVisaExpiryDate = DateTime.now();
  DateTime selectedVisaIssueDate = DateTime.now();



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
              "Add Employees",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Montserrat", fontSize: 19),
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
        backgroundColor:  Color(0xFF00ADEE),
      ),
      body:

      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [



            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "    Customer Type",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),







            Padding(
              padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
              child: DropdownButtonFormField<String>(
                value: customerTypeController.text.isNotEmpty
                    ? customerTypeController.text
                    : 'Customer (CUS)', // Set default value
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                items: [
                  DropdownMenuItem(value: 'Customer (CUS)', child: Text('Customer (CUS)',style: TextStyle(color: Colors.black))),
                  DropdownMenuItem(value: 'Business (BUS)', child: Text('Business (BUS)',style: TextStyle(color: Colors.black))),
                  DropdownMenuItem(value: 'Other (OTH)', child: Text('Other (OTH)',style: TextStyle(color: Colors.black))),
                ],
                onChanged: (value) {
                  if (value != null) {
                    customerTypeController.text = value; // Update controller with selected value
                  }
                },
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),




            SizedBox(height: 8.0),


            Text(
              "    Customer Name",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
              ),
            ),



            Padding(
              padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                value: customerNameController.text.isNotEmpty
                    ? customerNameController.text
                    : 'Nafula', // Default to Nafuala
                items: [
                  DropdownMenuItem(value: 'Nafula', child: Text('Nafula')),
                  DropdownMenuItem(value: 'John Doe', child: Text('John Doe')),
                  DropdownMenuItem(value: 'Jane Smith', child: Text('Jane Smith')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    customerNameController.text = value; // Update controller with the selected value
                  }
                },
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                  color: Colors.black, // Explicitly set the text color to black
                ),
              ),
            ),




            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                // Title
                Text(
                  "    Title",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    value: titleController.text.isNotEmpty ? titleController.text : 'Mr', // Default to 'Mr'
                    items: [
                      DropdownMenuItem(value: 'Mr', child: Text('Mr')),
                      DropdownMenuItem(value: 'Mrs', child: Text('Mrs')),
                      DropdownMenuItem(value: 'Miss', child: Text('Miss')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        titleController.text = value; // Update the controller with the selected value
                      }
                    },
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      color: Colors.black, // Ensure text color is black
                    ),
                  ),
                ),

                SizedBox(height: 16.0),
                // First Name
                Text(
                  "    First Name",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                  child: TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // Middle Name
                Text(
                  "    Middle Name",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                  child: TextField(
                    controller: middleNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // Last Name
                Text(
                  "    Last Name",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                  child: TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: Text(
                        "Date of Birth",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                      child: TextFormField(
                        controller: genderController, // Use for holding selected date
                        readOnly: true, // Make the field non-editable
                        onTap: () async {
                          // Open the date picker when any part of the field is clicked
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900), // Earliest date
                            lastDate: DateTime.now(), // Latest date
                          );

                          if (pickedDate != null) {
                            // Format the selected date
                            String formattedDate =
                                "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                            genderController.text = formattedDate; // Update the controller
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Date of Birth',
                          prefixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  "    Gender",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),

    Padding(
    padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
    child: Container(
    decoration: BoxDecoration(
    border: Border.all(color: Colors.grey), // Border color
    borderRadius: BorderRadius.circular(4.0), // Rounded corners
    ),
    child: Column(
    children: [
    Row(
    children: [
    Expanded(
    child: RadioListTile<String>(
    title: Text("Male"),
    value: "Male",
    groupValue: genderValue, // Use the string variable as groupValue
    onChanged: (value) {
    setState(() {
    genderValue = value ?? "Male"; // Update the gender value
    genderController.text = genderValue; // Update the text controller
    });
    },
    ),
    ),
    Expanded(
    child: RadioListTile<String>(
    title: Text("Female"),
    value: "Female",
    groupValue: genderValue, // Use the string variable as groupValue
    onChanged: (value) {
    setState(() {
    genderValue = value ?? "Male"; // Update the gender value
    genderController.text = genderValue; // Update the text controller
    });
    },
    ),
    ),
    ],
    ),
    ],
    ),
    ),
    ),


    SizedBox(height: 16.0),
                Text(
                  "    Phone Number",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                  child: TextField(
                    controller: travellerphoneController,
                    keyboardType: TextInputType.phone, // This will show numeric keyboard
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(height: 16.0),
                Text(
                  "    Mobile Number",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                  child: TextField(
                    controller: travellerMobileNumberController,
                    keyboardType: TextInputType.phone, // This will show numeric keyboard
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(height: 16.0),
                Text(
                  "    Email",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // Residency
                Text(
                  "    Residency",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                  child: TextField(
                    controller: residencyController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // Post Code
                Text(
                  "    Post Code",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                  child: TextField(
                    controller: postCodeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // Street Address
                Text(
                  "    Street Address",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                  child: TextField(
                    controller: streetAddressController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // City
                Text(
                  "    City",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                  child: TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // State
                Text(
                  "    State",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                  child: TextField(
                    controller: stateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // Traveller Type

                // Traveller Code
                Text(
                  "    Traveller Code",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                  child: TextField(
                    controller: travellerCodeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Add this below the last field (Traveller Code)
                SizedBox(height: 16.0),
                Text(
                  "    Status",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                value: "Active",
                                groupValue: status,
                                onChanged: (value) {
                                  setState(() {
                                    status = value.toString();
                                  });
                                },
                              ),
                              Text(
                                "Active",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                value: "In-Active",
                                groupValue: status,
                                onChanged: (value) {
                                  setState(() {
                                    status = value.toString();
                                  });
                                },
                              ),
                              Text(
                                "In-Active",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Add this below the Status section
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 10),
                  child: Text(
                    "User Credentials",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),

                SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Username Field
                      Text(
                        "Username",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 16.0),

                      // Password Field
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),


// Add this below the Contact Details section
                SizedBox(height: 16.0),
                Text(
                  "Passport",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),

                SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Document Dropdown Label
                      Text(
                        "Document",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.0),

                      // Document Dropdown
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: DropdownButton<String>(
                          value: selectedDocument,
                          isExpanded: true,
                          underline: SizedBox(), // Removes default underline
                          hint: Text(
                            "Select Document",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          items: [
                            "Passport No",
                            "Iqama No/Local ID No",
                            "National ID No",
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDocument = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

// Add this below the Passport section
                SizedBox(height: 16.0), // Spacing between sections
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Passport No
                      Text(
                        "Passport No",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TextField(
                        controller: passportNoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(height: 16.0), // Spacing between Passport No and Date of Birth

                      // Date of Birth
                      Text(
                        "Date of Birth",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.0),


                      TextFormField(
                        controller: dobController, // Use the controller to hold selected date
                        readOnly: true, // Make the field non-editable directly
                        decoration: InputDecoration(
                          hintText: "DD/MM/YYYY", // Hint text for the user
                          prefixIcon: GestureDetector(
                            onTap: () async {
                              // Open the date picker when the icon is clicked
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900), // Earliest date
                                lastDate: DateTime.now(), // Latest date
                              );

                              if (pickedDate != null) {
                                // Format the selected date as DD/MM/YYYY
                                String formattedDate =
                                    "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                                dobController.text = formattedDate; // Update the controller
                              }
                            },
                            child: Icon(Icons.calendar_today, color: Colors.grey), // Calendar icon
                          ),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                        onTap: () async {
                          // Open the date picker when the field is clicked
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900), // Earliest date
                            lastDate: DateTime.now(), // Latest date
                          );

                          if (pickedDate != null) {
                            // Format the selected date as DD/MM/YYYY
                            String formattedDate =
                                "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                            dobController.text = formattedDate; // Update the controller
                          }
                        },
                      ),


                  ],
                  ),
                ),
// Add this below the Date of Birth section
                SizedBox(height: 16.0), // Spacing between sections
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nationality
                      Text(
                        "Nationality",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      DropdownButtonFormField<String>(
                        value: selectedCountry, // Default selected value
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        items: countries.map((country) {
                          return DropdownMenuItem<String>(
                            value: country,
                            child: Text(
                              country,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCountry = value!;
                          });
                        },
                        hint: Text(
                          "Select Country",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),

// Add this below the Nationality section
            SizedBox(height: 16.0), // Spacing between sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Issuing Country
                  Text(
                    "Issuing Country",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  DropdownButtonFormField<String>(
                    value: selectedIssuingCountry, // Default selected value
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    items: countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(
                          country,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedIssuingCountry = value!;
                      });
                    },
                    hint: Text(
                      "Select Country",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
// Add this below the Issuing Country section
            SizedBox(height: 16.0), // Spacing between sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Expiry Date
                  Text(
                    "Expiry Date",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: _selectExpiryDate, // Trigger date picker
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: expiryDateController,
                        decoration: InputDecoration(
                          hintText: "Expiry Date",
                          suffixIcon: Icon(Icons.calendar_today), // Calendar icon
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
// Add this below the Primary Text section
            SizedBox(height: 16.0), // Spacing between sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Checkbox
                  Checkbox(
                    value: isChecked, // Variable to hold checkbox state
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!; // Update checkbox state
                      });
                    },
                  ),
                  // Primary Text next to checkbox
                  Text(
                    "Primary Text",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 16.0), // Spacing between checkbox text and button

                  // Add Button
                  ElevatedButton(
                    onPressed: _onAddButtonPressed, // Function for button press
                    child: Text('ADD'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink, // Button color
                    ),
                  ),
                ],
              ),
            ),
            // Add this below the existing section for Visa information
            SizedBox(height: 16.0), // Spacing between sections

// Visa Heading
            Text(
              "Visa",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),

            SizedBox(height: 8.0), // Spacing between heading and field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Text(
                "Visa Number",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: TextField(
                controller: visaNumberController, // Controller for Visa Number
                decoration: InputDecoration(
                  labelText: 'Visa Number', // Label for the text field
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Country of Visa Dropdown
                  Text("Country of Visa", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(4.0), // Optional: to make the border rounded
                    ),
                    child: DropdownButton<String>(
                      value: selectedCountry,
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust horizontal padding for hint text
                        child: Text("Select Country"),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedCountry = newValue!;
                        });
                      },
                      items: countries.map((country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Adjust padding inside the item
                            child: Text(country),
                          ),
                        );
                      }).toList(),
                      isExpanded: true, // Ensures the dropdown stretches to fit the container
                      underline: SizedBox(), // Remove the default underline from the dropdown
                      iconSize: 20.0, // Adjust the size of the dropdown icon
                    ),
                  ),

                  SizedBox(height: 16.0),

                  // Type of Visa TextField
                  Text("Type of Visa", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: visaTypeController,
                    decoration: InputDecoration(
                      labelText: "Enter Visa Type",
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      border: OutlineInputBorder(),
                    ),                       // Reduce height inside the border
                  ),
                  SizedBox(height: 16.0),

                  // Date of Issue with icon and DateTime Picker
                  Text("Date of Issue", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),

                  TextField(
                    controller: dateOfIssueController,
                    readOnly: true, // Make the text field non-editable directly
                    decoration: InputDecoration(
                      labelText: "Date of Issue", // Hint text
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0), // Adjusted padding
                      prefixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: _selectDateOfIssue, // Open date picker on icon click
                      ),
                    ),
                  ),

                  SizedBox(height: 16.0),

                  // Date of Expiry with DateTime Picker
                  Text("Date of Expiry", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: dateOfExpiryController,
                          readOnly: true, // Make the text field non-editable directly
                          decoration: InputDecoration(
                            labelText: "Date of Expiry", // Hint text
                            border: OutlineInputBorder(),
                            prefixIcon: GestureDetector(
                              onTap: _selectExpiryDate, // Open date picker on icon click
                              child: Icon(Icons.calendar_today),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0), // Reduce height inside the border
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0), // Optional space between the TextField and the button
                      ElevatedButton(
                        onPressed: () {
                          // Handle Add button action here
                        },
                        child: Text("Add", style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),



                  SizedBox(height: 16.0),
                  Text("Dependent", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,)),
                  SizedBox(height: 16.0),

                       Text("Title", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8.0),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: DropdownButton<String>(
                          value: dependentTitle,
                          onChanged: (newValue) {
                            setState(() {

                              dependentTitle = newValue; // Set Dependent Title to match selected Title
                            });
                          },
                          items: ['Mr', 'Mrs', 'Miss'].map((title) {
                            return DropdownMenuItem<String>(
                              value: title,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(title),
                              ),
                            );
                          }).toList(),
                          isExpanded: true,
                          underline: SizedBox(),
                        ),
                      ),

                      SizedBox(height: 16.0),

                      Text(
                        "    First Name",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                        child: TextField(
                          controller: dependentFirstNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      // Middle Name
                      Text(
                        "    Middle Name",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                        child: TextField(
                          controller: dependentMiddleNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      // Last Name
                      Text(
                        "    Last Name",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                        child: TextField(
                          controller: dependentLastNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 13, right: 13),
                            child: Text(
                              "Date of Birth",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                            child: TextFormField(
                              controller: dependentDobController, // Use for holding selected date
                              readOnly: true, // Make the field non-editable
                              onTap: () async {
                                // Open the date picker when any part of the field is clicked
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900), // Earliest date
                                  lastDate: DateTime.now(), // Latest date
                                );

                                if (pickedDate != null) {
                                  // Format the selected date
                                  String formattedDate =
                                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                  dependentDobController.text = formattedDate; // Update the controller
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Date of Birth',
                                prefixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 16.0),

                  Text(
                    "    Relation",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                    child: TextField(
                      controller: relationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                   Text(
                    "Passport No",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: dependentPassportNoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Text(
                    "Passport Expiry",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: _dependentselectExpiryDate, // Trigger date picker
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: dependentExpiryController,
                        decoration: InputDecoration(
                          hintText: "Passport Expiry",
                          prefixIcon: Icon(Icons.calendar_today), // Calendar icon
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  Text(
                    "Nationality",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  DropdownButtonFormField<String>(
                    value: dependentSelectedCountry, // Default selected value
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    items: dependentCountries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(
                          country,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dependentSelectedCountry = value; // Update the dependent selected country when changed
                      });
                    },
                    hint: Text(
                      "Select Country",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    "Issuing Country",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  DropdownButtonFormField<String>(
                    value: dependentSelectedIssuingCountry, // Default selected value
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    items: dependentIssuepassportCountries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(
                          country,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dependentSelectedIssuingCountry = value!;
                      });
                    },
                    hint: Text(
                      "Select Country",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    "    Email",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                    child: TextField(
                      controller: dependentEmailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    "    Mobile Number",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                    child: TextField(
                      controller: dependentmobileNoController,
                      keyboardType: TextInputType.phone, // This will show numeric keyboard
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Text("Country of Visa", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(4.0), // Optional: to make the border rounded
                    ),
                    child: DropdownButton<String>(
                      value: DependentCountryofvisa,
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust horizontal padding for hint text
                        child: Text("Select Country"),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          DependentCountryofvisa = newValue!;
                        });
                      },
                      items: dependentCountryofvisa.map((country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Adjust padding inside the item
                            child: Text(country),
                          ),
                        );
                      }).toList(),
                      isExpanded: true, // Ensures the dropdown stretches to fit the container
                      underline: SizedBox(), // Remove the default underline from the dropdown
                      iconSize: 20.0, // Adjust the size of the dropdown icon
                    ),
                  ),
                  Text("Type of Visa", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: dependentVisaTypeController,
                    decoration: InputDecoration(
                      labelText: "Enter Visa Type",
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      border: OutlineInputBorder(),
                    ),                       // Reduce height inside the border
                  ),
                  SizedBox(height: 16.0),
                  Text("Date of Issue", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),

                  TextField(
                    controller: dependentdateOfIssueController,
                    readOnly: true, onTap: () {
                    _dependentselectDateOfIssue();
                    },// Make the text field non-editable directly
                    decoration: InputDecoration(
                      hintText: "Date of Issue", // Hint text
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0), // Adjusted padding
                      prefixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: _dependentselectDateOfIssue, // Open date picker on icon click
                      ),
                    ),
                  ),

                  SizedBox(height: 16.0),
                  Text("Date of Expiry", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),

                  TextField(
                    controller: dependentdateOfExpiryController,
                    readOnly: true, onTap: () {
                    _dependentxpirydate();
                  },// Make the text field non-editable directly
                    decoration: InputDecoration(
                      hintText: "Date of Expiry", // Hint text
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0), // Adjusted padding
                      prefixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: _dependentxpirydate, // Open date picker on icon click
                      ),
                    ),
                  ),

                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "Document Details",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                  Text("File Title", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: filetitleContoller,
                    decoration: InputDecoration(
                      labelText: "Filte Title",
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      border: OutlineInputBorder(),
                    ),                       // Reduce height inside the border
                  ),
                  Text("File Type", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,  // Aligns text to the left
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedDocumentType,  // Default selected value
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        items: documentTypes.map((docType) {
                          return DropdownMenuItem<String>(
                            value: docType,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(docType),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDocumentType = value!;
                          });
                        },
                        hint: Text(
                          "Select Document Type",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),  // Optional spacing between Dropdown and image



                    ],
                  ),
                  Column(
                    children: [
                      // Heading
                      Text(
                        "Upload Document",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),

                      // Button to choose file
                      ElevatedButton(
                        onPressed: _pickFile,
                        child: Text("Choose File"),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Display the selected file name or prompt to select
                      Text(
                        selectedFileName != null
                            ? "Selected File: $selectedFileName"
                            : "No file selected",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Text("Preferences", style: TextStyle(fontWeight: FontWeight.bold)),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading Text
                      Text(
                        "Preference",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),

                      // Travel Class Dropdown with Loading Simulation
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Preference",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50, // Set the height of the dropdown
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Border color
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedTravelClass, // Selected value
                      decoration: InputDecoration(
                        border: InputBorder.none, // No additional border
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedTravelClass = newValue!;
                        });
                      },
                      items: travelClasses.map((classType) {
                        return DropdownMenuItem<String>(
                          value: classType,
                          child: Text(
                            classType,
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        'Select Travel Class',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      isExpanded: true, // Ensures dropdown expands to fill width
                    ),
                  ),
                ],

            ),
                      SizedBox(height: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Stop Over Preference",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 50, // Set dropdown height
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey), // Border color
                              borderRadius: BorderRadius.circular(8.0), // Rounded corners
                            ),
                            child: DropdownButtonFormField<String>(
                              value: selectedStopOver, // Default selected value
                              decoration: InputDecoration(
                                border: InputBorder.none, // No additional border
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedStopOver = newValue!; // Update selected value
                                });
                              },
                              items: stopOverOptions.map((option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                'Select Stop Over Preference',
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              isExpanded: true, // Ensures dropdown expands to fit the container
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Meal Preference",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 50, // Set dropdown height
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey), // Border color
                              borderRadius: BorderRadius.circular(8.0), // Rounded corners
                            ),
                            child: DropdownButtonFormField<String>(
                              value: selectedMealPreference, // Default selected value
                              decoration: InputDecoration(
                                border: InputBorder.none, // No additional border
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedMealPreference = newValue!; // Update selected value
                                });
                              },
                              items: mealPreferenceOptions.map((option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                'Select Meal Preference',
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              isExpanded: true, // Ensures dropdown expands to fit the container
                            ),
                          ),
                        ],
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Select Airline",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: airlineController, // Controller for airline input
                        decoration: InputDecoration(
                          hintText: "Select Airlines",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Loyalty Number",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: loyaltyNumberController,
                        keyboardType: TextInputType.number, // Numeric input for loyalty number
                        decoration: InputDecoration(
                          hintText: "Enter Loyalty Number",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Hotel Preference Heading
                          Text(
                            "Hotel Preference",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 20),

                          // Room Preference Heading
                          Text(
                            "Room Preference",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),

                          // Room Preference Dropdown
                          Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: selectedRoomPreference,
                              decoration: InputDecoration(
                                border: InputBorder.none, // Remove default dropdown border
                              ),
                              hint: Text(
                                "Select Room Preference",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              items: ["Classic", "Deluxe", "Family"]
                                  .map((roomType) => DropdownMenuItem<String>(
                                value: roomType,
                                child: Text(
                                  roomType,
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedRoomPreference = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Smoking Preferences Heading
                          Text(
                            "Smoking Preferences",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 20),

                          // Smoking Preferences Dropdown
                          Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: selectedSmokingPreference,
                              decoration: InputDecoration(
                                border: InputBorder.none, // Remove default dropdown border
                              ),
                              hint: Text(
                                "Select Smoking Preference",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              items: ["Yes", "No"]
                                  .map((preference) => DropdownMenuItem<String>(
                                value: preference,
                                child: Text(
                                  preference,
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedSmokingPreference = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Facilities Text
                          Text(
                            "Facilities",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),

                          // Facilities TextField
                          Container(
                            height: 50,
                            child: TextField(
                              controller: facilitiesController,
                              decoration: InputDecoration(
                                hintText: "Facilities",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          // SizedBox
                          SizedBox(height: 16),

                          // Membership Number Text
                          Text(
                            "Membership Number",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),

                          // Membership Number TextField
                          Container(
                            height: 50,
                            child: TextField(
                              controller: membershipNumberController,
                              decoration: InputDecoration(
                                hintText: "Membership Number",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                        SizedBox(height: 24),

                      // Save Button
                      SizedBox(
                        width: double.infinity, // Full width
                        height: 50, // Button height
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your save logic here
                            print("Save button clicked!");
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0), // Rounded corners
                            ),
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
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


    );
  }

}
Widget buildCheckbox(String label, bool value, Function(bool?) onChanged) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3.0), // Adjust the bottom padding
    child: Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(label),
      ],
    ),
  );
}
