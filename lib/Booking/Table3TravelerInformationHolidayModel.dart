class Table3TravelerInformationHolidayModel {
  final String bftCarPID;
  final String type;
  final String tfpIdentityNo;
  final String passenger;
  final String tfpDob;
  final String tfpPhoneNo;
  final String age;
  final String tfpBookFlightId;
  final String tfpPassengerTypeId;
  final String tfpLeadPox;
  final String tfpTitleId;
  final String tfpFirstName;
  final String tfpMiddleName;
  final String tfpLastName;
  final String tfpDob1;
  final String tfpPhoneNo1;
  final String tfpEmail;
  final String travellerId;
  final String pnr;
  final String mailId;

  Table3TravelerInformationHolidayModel({
    required this.bftCarPID,
    required this.type,
    required  this.tfpIdentityNo,
    required this.passenger,
    required this.tfpDob,
    required this.tfpPhoneNo,
    required this.age,
    required this.tfpBookFlightId,
    required this.tfpPassengerTypeId,
    required this.tfpLeadPox,
    required this.tfpTitleId,
    required this.tfpFirstName,
    required this.tfpMiddleName,
    required this.tfpLastName,
    required this.tfpDob1,
    required this.tfpPhoneNo1,
    required this.tfpEmail,
    required this.travellerId,
    required this.pnr,
    required this.mailId,
  });

  factory Table3TravelerInformationHolidayModel.fromJson(Map<String, dynamic> json) {
    return Table3TravelerInformationHolidayModel(
      bftCarPID: json['BFTCarPID'].toString(),
      type: json['Type'].toString(),
      tfpIdentityNo: json['TFPIdentityNo'].toString(),
      passenger: json['Passenger'].toString(),
      tfpDob: json['TFPDOB'].toString(),
      tfpPhoneNo: json['TFPPhoneNo'].toString(),
      age: json['Age'].toString(),
      tfpBookFlightId: json['TFPBookFlightId'].toString(),
      tfpPassengerTypeId: json['TFPPassengerTypeID'].toString(),
      tfpLeadPox: json['TFPLeadPox'].toString(),
      tfpTitleId: json['TFPTitleID'].toString(),
      tfpFirstName: json['TFPFirstName'].toString(),
      tfpMiddleName: json['TFPMiddleName'].toString(),
      tfpLastName: json['TFPLastName'].toString(),
      tfpDob1: json['TFPDOB1'].toString(),
      tfpPhoneNo1: json['TFPPhoneNo1'].toString(),
      tfpEmail: json['TFPEmail'].toString(),
      travellerId: json['TravellerId'].toString(),
      pnr: json['PNR'].toString(),
      mailId: json['MailId'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BFTCarPID': bftCarPID,
      'Type': type,
      'TFPIdentityNo': tfpIdentityNo,
      'Passenger': passenger,
      'TFPDOB': tfpDob,
      'TFPPhoneNo': tfpPhoneNo,
      'Age': age,
      'TFPBookFlightId': tfpBookFlightId,
      'TFPPassengerTypeID': tfpPassengerTypeId,
      'TFPLeadPox': tfpLeadPox,
      'TFPTitleID': tfpTitleId,
      'TFPFirstName': tfpFirstName,
      'TFPMiddleName': tfpMiddleName,
      'TFPLastName': tfpLastName,
      'TFPDOB1': tfpDob1,
      'TFPPhoneNo1': tfpPhoneNo1,
      'TFPEmail': tfpEmail,
      'TravellerId': travellerId,
      'PNR': pnr,
      'MailId': mailId,
    };
  }
}
