class CarPassengerModel {
  String bftCarPID;
  String type;
  String tfpIdentityNo;
  String passenger;
  String tfpDOB;
  String tfpPhoneNo;
  String age;
  String tfpBookFlightId;
  String tfpPassengerTypeID;
  String tfpLeadPox;
  String tfpTitleID;
  String tfpFirstName;
  String tfpMiddleName;
  String tfpLastName;
  String tfpDOB1;
  String tfpPhoneNo1;
  String tfpEmail;
  String travellerId;
  String pnr;
  String mailId;

  CarPassengerModel({
    required this.bftCarPID,
    required this.type,
    required this.tfpIdentityNo,
    required this.passenger,
    required this.tfpDOB,
    required this.tfpPhoneNo,
    required this.age,
    required this.tfpBookFlightId,
    required this.tfpPassengerTypeID,
    required this.tfpLeadPox,
    required this.tfpTitleID,
    required this.tfpFirstName,
    required this.tfpMiddleName,
    required this.tfpLastName,
    required this.tfpDOB1,
    required this.tfpPhoneNo1,
    required this.tfpEmail,
    required this.travellerId,
    required this.pnr,
    required this.mailId,
  });

  factory CarPassengerModel.fromJson(Map<String, dynamic> json) {
    return CarPassengerModel(
      bftCarPID: json['BFTCarPID'].toString(),
      type: json['Type'].toString(),
      tfpIdentityNo: json['TFPIdentityNo'].toString(),
      passenger: json['Passenger'].toString(),
      tfpDOB: json['TFPDOB'].toString(),
      tfpPhoneNo: json['TFPPhoneNo'].toString(),
      age: json['Age'].toString(),
      tfpBookFlightId: json['TFPBookFlightId'].toString(),
      tfpPassengerTypeID: json['TFPPassengerTypeID'].toString(),
      tfpLeadPox: json['TFPLeadPox'].toString(),
      tfpTitleID: json['TFPTitleID'].toString(),
      tfpFirstName: json['TFPFirstName'].toString(),
      tfpMiddleName: json['TFPMiddleName'].toString(),
      tfpLastName: json['TFPLastName'].toString(),
      tfpDOB1: json['TFPDOB1'].toString(),
      tfpPhoneNo1: json['TFPPhoneNo1'].toString(),
      tfpEmail: json['TFPEmail'].toString(),
      travellerId: json['TravellerId'].toString(),
      pnr: json['PNR'].toString(),
      mailId: json['MailId'].toString(),
    );
  }
}
