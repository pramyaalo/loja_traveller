class Table4BusTravellerDetailModel {
  final String busPassengerID;
  final String type;
  final String idNumber;
  final String passenger;
  final String dob;
  final String email;
  final String phoneNo;
  final String age;
  final String bookFlightId;
  final String passengerID;
  final String firstName;
  final String lastName;
  final String pnr;
  final String idNumber1;
  final String seatColumnNo;
  final String genderName;

  Table4BusTravellerDetailModel({
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
    required this.idNumber1,
    required this.seatColumnNo,
    required this.genderName,
  });

  factory Table4BusTravellerDetailModel.fromJson(Map<String, dynamic> json) {
    return Table4BusTravellerDetailModel(
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
      idNumber1: json['IDNumber1'].toString(),
      seatColumnNo: json['SeatColumnNo'].toString(),
      genderName: json['GenderName'].toString(),
    );
  }

}
