class HolidayPassengerModel {
  String holidayPID;
  String holidayPID1;
  String type;
  String tfpIdentityNo;
  String passenger;
  String dob;
  String phoneNo;
  String email;
  String pnr;
  String age;
  String email1;
  String phoneNo1;

  HolidayPassengerModel({
    required this.holidayPID,
    required this.holidayPID1,
    required this.type,
    required this.tfpIdentityNo,
    required this.passenger,
    required this.dob,
    required this.phoneNo,
    required this.email,
    required this.pnr,
    required this.age,
    required this.email1,
    required this.phoneNo1,
  });

  factory HolidayPassengerModel.fromJson(Map<String, dynamic> json) {
    return HolidayPassengerModel(
      holidayPID: json['HolidayPID'].toString(),
      holidayPID1: json['HolidayPID1'].toString(),
      type: json['Type'].toString(),
      tfpIdentityNo: json['TFPIdentityNo'].toString(),
      passenger: json['Passenger'].toString(),
      dob: json['DOB'].toString(),
      phoneNo: json['PhoneNo'].toString(),
      email: json['Email'].toString(),
      pnr: json['PNR'].toString(),
      age: json['Age'].toString(),
      email1: json['Email1'].toString(),
      phoneNo1: json['PhoneNo1'].toString(),
    );
  }
}
