class Table3VouchersCarReceiptModel {
  final String bftCarPID;
  final String type;
  final String tfpIdentityNo;
  final String passenger;
  final String tfpDOB;
  final String tfpPhoneNo;
  final String age;
  final String tfpBookFlightId;
  final String tfpPassengerTypeID;
  final String tfpLeadPox;
  final String tfpTitleID;
  final String tfpFirstName;
  final String tfpMiddleName;
  final String tfpLastName;
  final String tfpDOB1;
  final String tfpPhoneNo1;
  final String tfpEmail;
  final String travellerId;
  final String pnr;
  final String mailId;

  Table3VouchersCarReceiptModel({
    required this.bftCarPID,
    required this.type,
    required  this.tfpIdentityNo,
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

  // Factory constructor to create a Passenger object from JSON
  factory Table3VouchersCarReceiptModel.fromJson(Map<String, dynamic> json) {
    return Table3VouchersCarReceiptModel(
      bftCarPID: json["BFTCarPID"].toString(),
      type: json["Type"].toString(),
      tfpIdentityNo: json["TFPIdentityNo"].toString(),
      passenger: json["Passenger"].toString(),
      tfpDOB: json["TFPDOB"].toString(),
      tfpPhoneNo: json["TFPPhoneNo"].toString(),
      age: json["Age"].toString(),
      tfpBookFlightId: json["TFPBookFlightId"].toString(),
      tfpPassengerTypeID: json["TFPPassengerTypeID"].toString(),
      tfpLeadPox: json["TFPLeadPox"].toString(),
      tfpTitleID: json["TFPTitleID"].toString(),
      tfpFirstName: json["TFPFirstName"].toString(),
      tfpMiddleName: json["TFPMiddleName"].toString(),
      tfpLastName: json["TFPLastName"].toString(),
      tfpDOB1: json["TFPDOB1"].toString(),
      tfpPhoneNo1: json["TFPPhoneNo1"].toString(),
      tfpEmail: json["TFPEmail"].toString(),
      travellerId: json["TravellerId"].toString(),
      pnr: json["PNR"].toString(),
      mailId: json["MailId"].toString(),
    );
  }


}
