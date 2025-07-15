class Table19HolidayPassengerDetailsModel {
  final String holidayPID;
  final String holidayPID1;
  final String type;
  final String tfpIdentityNo;
  final String passenger;
  final String dob;
  final String phoneNo;
  final String email;
  final String pnr;
  final String age;
  final String email1;
  final String phoneNo1;

  Table19HolidayPassengerDetailsModel({
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

  factory Table19HolidayPassengerDetailsModel.fromJson(Map<String, dynamic> json) {
    return Table19HolidayPassengerDetailsModel(
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

  Map<String, dynamic> toJson() {
    return {
      'HolidayPID': holidayPID,
      'HolidayPID1': holidayPID1,
      'Type': type,
      'TFPIdentityNo': tfpIdentityNo,
      'Passenger': passenger,
      'DOB': dob,
      'PhoneNo': phoneNo,
      'Email': email,
      'PNR': pnr,
      'Age': age,
      'Email1': email1,
      'PhoneNo1': phoneNo1,
    };
  }
}
