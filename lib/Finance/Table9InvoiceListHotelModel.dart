class Table9InvoiceListHotelModel {
  String bftHotelPID;
  String bftHotelPID1;
  String type;
  String tfpIdentityNo;
  String passenger;
  String tfpDOB;
  String tfpPhoneNo;
  String tfpEmail;
  String pnr;
  String age;

  Table9InvoiceListHotelModel({
    required this.bftHotelPID,
    required this.bftHotelPID1,
    required this.type,
    required this.tfpIdentityNo,
    required this.passenger,
    required this.tfpDOB,
    required this.tfpPhoneNo,
    required this.tfpEmail,
    required this.pnr,
    required this.age,
  });

  factory Table9InvoiceListHotelModel.fromJson(Map<String, dynamic> json) {
    return Table9InvoiceListHotelModel(
      bftHotelPID: json['BFTHotelPID'].toString(),
      bftHotelPID1: json['BFTHotelPID1'].toString(),
      type: json['Type'].toString(),
      tfpIdentityNo: json['TFPIdentityNo'].toString(),
      passenger: json['Passenger'].toString(),
      tfpDOB: json['TFPDOB'].toString(),
      tfpPhoneNo: json['TFPPhoneNo'].toString(),
      tfpEmail: json['TFPEmail'].toString(),
      pnr: json['PNR'].toString(),
      age: json['Age'].toString(),
    );
  }
}
