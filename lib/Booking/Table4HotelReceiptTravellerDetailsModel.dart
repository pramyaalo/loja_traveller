class Table4HotelReceiptTravellerDetailsModel {
  final String type;
  final String passenger;
  final String tfpDob;
  final String tfpPhoneNo;
  final String age;
  final String mailId;
  final String tfpEmail;
  final String city;
  final String countryName;
  final String udResistance;
  final String state;
  final String address;
  final String gender;
  final String pnr;

  Table4HotelReceiptTravellerDetailsModel({
    required this.type,
    required this.passenger,
    required this.tfpDob,
    required this.tfpPhoneNo,
    required this.age,
    required this.mailId,
    required this.tfpEmail,
    required this.city,
    required this.countryName,
    required this.udResistance,
    required this.state,
    required this.address,
    required this.gender,
    required this.pnr,
  });

  factory Table4HotelReceiptTravellerDetailsModel.fromJson(Map<String, dynamic> json) {
    return Table4HotelReceiptTravellerDetailsModel(
      type: json['Type'].toString(),
      passenger: json['Passenger'].toString(),
      tfpDob: json['TFPDOB'].toString(),
      tfpPhoneNo: json['TFPPhoneNo'].toString(),
      age: json['Age'].toString(),
      mailId: json['MailId'].toString(),
      tfpEmail: json['TFPEmail'].toString(),
      city: json['City'].toString(),
      countryName: json['CountryName'].toString(),
      udResistance: json['UDResistance'].toString(),
      state: json['State'].toString(),
      address: json['Address'].toString(),
      gender: json['Gender'].toString(),
      pnr: json['PNR'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Type': type,
      'Passenger': passenger,
      'TFPDOB': tfpDob,
      'TFPPhoneNo': tfpPhoneNo,
      'Age': age,
      'MailId': mailId,
      'TFPEmail': tfpEmail,
      'City': city,
      'CountryName': countryName,
      'UDResistance': udResistance,
      'State': state,
      'Address': address,
      'Gender': gender,
      'PNR': pnr,
    };
  }
}
