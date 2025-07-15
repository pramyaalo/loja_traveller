class Table4HotelModel {
  String type;
  String passenger;
  String tfpDob;
  String tfpPhoneNo;
  String age;
  String mailId;
  String tfpEmail;
  String city;
  String countryName;
  String udResistance;
  String state;
  String address;
  String gender;
  String pnr;

  Table4HotelModel({
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

  factory Table4HotelModel.fromJson(Map<String, dynamic> json) {
    return Table4HotelModel(
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
