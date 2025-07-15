class PassengerModel {
  String bftfPlightID;
  String type;
  String passenger;
  String tfpDOB;
  String tfpIdentityNo;
  String tfpPhoneNo;
  String tfpEmail;
  String pnr;
  String ticketNo;
  String custPhone;
  String custEmail;
  String age;

  PassengerModel({
    required this.bftfPlightID,
    required this.type,
    required this.passenger,
    required this.tfpDOB,
    required this.tfpIdentityNo,
    required this.tfpPhoneNo,
    required this.tfpEmail,
    required this.pnr,
    required this.ticketNo,
    required this.custPhone,
    required this.custEmail,
    required this.age,
  });

  factory PassengerModel.fromJson(Map<String, dynamic> json) {
    return PassengerModel(
      bftfPlightID: json['BFTFPlightID'].toString(),
      type: json['Type'].toString(),
      passenger: json['Passenger'].toString(),
      tfpDOB: json['TFPDOB'].toString(),
      tfpIdentityNo: json['TFPIdentityNo'].toString(),
      tfpPhoneNo: json['TFPPhoneNo'].toString(),
      tfpEmail: json['TFPEmail'].toString(),
      pnr: json['PNR'].toString(),
      ticketNo: json['TicketNo'].toString(),
      custPhone: json['CustPhone'].toString(),
      custEmail: json['CustEmail'].toString(),
      age: json['Age'].toString(),
    );
  }
}
