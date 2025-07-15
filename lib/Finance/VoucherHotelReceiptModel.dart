class VoucherHotelReceiptModel {
  String bfthotelPid;
  String bfthotelPid1;
  String type;
  String tfpIdentityNo;
  String passenger;
  String tfpDob;
  String tfpPhoneNo;
  String tfpEmail;
  String pnr;
  String age;

  VoucherHotelReceiptModel({
    required this.bfthotelPid,
    required this.bfthotelPid1,
    required this.type,
    required this.tfpIdentityNo,
    required this.passenger,
    required this.tfpDob,
    required this.tfpPhoneNo,
    required this.tfpEmail,
    required this.pnr,
    required this.age,
  });

  factory VoucherHotelReceiptModel.fromJson(Map<String, dynamic> json) {
    return VoucherHotelReceiptModel(
      bfthotelPid: json['BFTHotelPID'].toString(),
      bfthotelPid1: json['BFTHotelPID1'].toString(),
      type: json['Type'].toString(),
      tfpIdentityNo: json['TFPIdentityNo'].toString(),
      passenger: json['Passenger'].toString(),
      tfpDob: json['TFPDOB'].toString(),
      tfpPhoneNo: json['TFPPhoneNo'].toString(),
      tfpEmail: json['TFPEmail'].toString(),
      pnr: json['PNR'].toString(),
      age: json['Age'].toString(),
    );
  }
}
