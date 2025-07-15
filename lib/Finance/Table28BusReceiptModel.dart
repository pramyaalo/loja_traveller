class Table28BusReceiptModel {
  String busPassengerId;
  String type;
  String idNumber;
  String passenger;
  String dob;
  String email;
  String phoneNo;
  String age;
  String genderName;
  String bookFlightId;
  String passengerId;
  String firstName;
  String lastName;
  String pnr;
  String loginType;

  Table28BusReceiptModel({
    required this.busPassengerId,
    required this.type,
    required this.idNumber,
    required this.passenger,
    required this.dob,
    required this.email,
    required this.phoneNo,
    required this.age,
    required this.genderName,
    required this.bookFlightId,
    required this.passengerId,
    required this.firstName,
    required this.lastName,
    required this.pnr,
    required this.loginType,
  });

  factory Table28BusReceiptModel.fromJson(Map<String, dynamic> json) {
    return Table28BusReceiptModel(
      busPassengerId: json['BusPassengerID'].toString(),
      type: json['Type'].toString(),
      idNumber: json['IDNumber'].toString(),
      passenger: json['Passenger'].toString(),
      dob: json['DOB'].toString(),
      email: json['Email'].toString(),
      phoneNo: json['PhoneNo'].toString(),
      age: json['Age'].toString(),
      genderName: json['GenderName'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      passengerId: json['PassengerID'].toString(),
      firstName: json['FirstName'].toString(),
      lastName: json['LastName'].toString(),
      pnr: json['PNR'].toString(),
      loginType: json['LoginType'].toString(),
    );
  }
}
