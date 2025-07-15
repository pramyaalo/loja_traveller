class Table22InvoiceListHolidayReceiptModel {
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

  Table22InvoiceListHolidayReceiptModel({
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
  });

  factory Table22InvoiceListHolidayReceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table22InvoiceListHolidayReceiptModel(
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
    );
  }
}
