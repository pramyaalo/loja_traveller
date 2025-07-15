class BusPassengerModel {
  String busPassengerID;
  String type;
  String idNumber;
  String passenger;
  String dob;
  String email;
  String phoneNo;
  String age;
  String bookFlightId;
  String passengerID;
  String firstName;
  String lastName;
  String pnr;

  BusPassengerModel({
    required this.busPassengerID,
    required this.type,
    required this.idNumber,
    required this.passenger,
    required this.dob,
    required this.email,
    required this.phoneNo,
    required this.age,
    required this.bookFlightId,
    required this.passengerID,
    required this.firstName,
    required this.lastName,
    required this.pnr,
  });

  factory BusPassengerModel.fromJson(Map<String, dynamic> json) {
    return BusPassengerModel(
      busPassengerID: json['BusPassengerID'].toString(),
      type: json['Type'].toString(),
      idNumber: json['IDNumber'].toString(),
      passenger: json['Passenger'].toString(),
      dob: json['DOB'].toString(),
      email: json['Email'].toString(),
      phoneNo: json['PhoneNo'].toString(),
      age: json['Age'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      passengerID: json['PassengerID'].toString(),
      firstName: json['FirstName'].toString(),
      lastName: json['LastName'].toString(),
      pnr: json['PNR'].toString(),
    );
  }
}
