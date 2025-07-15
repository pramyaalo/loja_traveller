class HotelPassengerModel {
  String bfthotelPID;
  String bfthotelPID1;
  String type;
  String tfpIdentityNo;
  String passenger;
  String tfpDOB;
  String tfpPhoneNo;
  String tfpEmail;
  String pnr;
  String age;

  HotelPassengerModel({
    required this.bfthotelPID,
    required this.bfthotelPID1,
    required this.type,
    required this.tfpIdentityNo,
    required this.passenger,
    required this.tfpDOB,
    required this.tfpPhoneNo,
    required this.tfpEmail,
    required this.pnr,
    required this.age,
  });

  factory HotelPassengerModel.fromJson(Map<String, dynamic> json) {
    return HotelPassengerModel(
      bfthotelPID: json['BFTHotelPID'].toString(),
      bfthotelPID1: json['BFTHotelPID1'].toString(),
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
