class Table14CarPassengerDataModel {
  final String bftCarPID;
  final String type;
  final String tfpIdentityNo;
  final String passenger;
  final String tfpDOB;
  final String tfpPhoneNo;
  final String age;
  final String tfpBookFlightId;
  final String tfpPassengerTypeId;
  final String tfpLeadPox;
  final String tfpTitleId;
  final String tfpFirstName;
  final String tfpMiddleName;
  final String tfpLastName;
  final String tfpDOB1;
  final String tfpPhoneNo1;
  final String tfpEmail;
  final String travellerId;
  final String mailId;
  final String city;
  final String countryName;
  final String state;
  final String address;
  final String gender;

  Table14CarPassengerDataModel({
    required this.bftCarPID,
    required this.type,
    required this.tfpIdentityNo,
    required this.passenger,
    required this.tfpDOB,
    required this.tfpPhoneNo,
    required this.age,
    required this.tfpBookFlightId,
    required this.tfpPassengerTypeId,
    required this.tfpLeadPox,
    required this.tfpTitleId,
    required this.tfpFirstName,
    required this.tfpMiddleName,
    required this.tfpLastName,
    required this.tfpDOB1,
    required this.tfpPhoneNo1,
    required this.tfpEmail,
    required this.travellerId,
    required this.mailId,
    required this.city,
    required this.countryName,
    required this.state,
    required this.address,
    required this.gender,
  });

  factory Table14CarPassengerDataModel.fromJson(Map<String, dynamic> json) {
    return Table14CarPassengerDataModel(
      bftCarPID: json['BFTCarPID'].toString(),
      type: json['Type'].toString(),
      tfpIdentityNo: json['TFPIdentityNo'].toString(),
      passenger: json['Passenger'].toString(),
      tfpDOB: json['TFPDOB'].toString(),
      tfpPhoneNo: json['TFPPhoneNo'].toString(),
      age: json['Age'].toString(),
      tfpBookFlightId: json['TFPBookFlightId'].toString(),
      tfpPassengerTypeId: json['TFPPassengerTypeID'].toString(),
      tfpLeadPox: json['TFPLeadPox'].toString(),
      tfpTitleId: json['TFPTitleID'].toString(),
      tfpFirstName: json['TFPFirstName'].toString(),
      tfpMiddleName: json['TFPMiddleName'].toString(),
      tfpLastName: json['TFPLastName'].toString(),
      tfpDOB1: json['TFPDOB1'].toString(),
      tfpPhoneNo1: json['TFPPhoneNo1'].toString(),
      tfpEmail: json['TFPEmail'].toString(),
      travellerId: json['TravellerId'].toString(),
      mailId: json['MailId'].toString(),
      city: json['City'].toString(),
      countryName: json['CountryName'].toString(),
      state: json['State'].toString(),
      address: json['Address'].toString(),
      gender: json['Gender'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BFTCarPID': bftCarPID,
      'Type': type,
      'TFPIdentityNo': tfpIdentityNo,
      'Passenger': passenger,
      'TFPDOB': tfpDOB,
      'TFPPhoneNo': tfpPhoneNo,
      'Age': age,
      'TFPBookFlightId': tfpBookFlightId,
      'TFPPassengerTypeID': tfpPassengerTypeId,
      'TFPLeadPox': tfpLeadPox,
      'TFPTitleID': tfpTitleId,
      'TFPFirstName': tfpFirstName,
      'TFPMiddleName': tfpMiddleName,
      'TFPLastName': tfpLastName,
      'TFPDOB1': tfpDOB1,
      'TFPPhoneNo1': tfpPhoneNo1,
      'TFPEmail': tfpEmail,
      'TravellerId': travellerId,
      'MailId': mailId,
      'City': city,
      'CountryName': countryName,
      'State': state,
      'Address': address,
      'Gender': gender,
    };
  }
}
