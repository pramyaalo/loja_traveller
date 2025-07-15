class Table22HolidayReceipt {
  String holidayPid;
  String holidayPid1;
  String type;
  String tfpIdentityNo;
  String passenger;
  String dob;
  String phoneNo;
  String email;
  String pnr;
  String age;

  Table22HolidayReceipt({
    required this.holidayPid,
    required this.holidayPid1,
    required this.type,
    required this.tfpIdentityNo,
    required this.passenger,
    required this.dob,
    required this.phoneNo,
    required this.email,
    required this.pnr,
    required this.age,
  });

  factory Table22HolidayReceipt.fromJson(Map<String, dynamic> json) {
    return Table22HolidayReceipt(
      holidayPid: json['HolidayPID'].toString(),
      holidayPid1: json['HolidayPID1'].toString(),
      type: json['Type'].toString(),
      tfpIdentityNo: json['TFPIdentityNo'].toString(),
      passenger: json['Passenger'].toString(),
      dob: json['DOB'].toString(),
      phoneNo: json['PhoneNo'].toString(),
      email: json['Email'].toString(),
      pnr: json['PNR'].toString(),
      age: json['Age'].toString(),
    );
  }
}
