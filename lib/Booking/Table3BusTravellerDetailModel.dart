class Table3BusTravellerDetailModel {
  final String busPassengerID;
  final String type;
  final String idNumber;
  final String seatColumnNo;
  final String seatRowNo;
  final String seatName;
  final String passenger;
  final String dob;
  final String email;
  final String phoneNo;
  final String age;
  final String genderName;
  final String bookFlightId;
  final String passengerID;
  final String firstName;
  final String lastName;
  final String pnr;
  final String loginType;

  Table3BusTravellerDetailModel({
    required this.busPassengerID,
    required this.type,
    required this.idNumber,
    required this.seatColumnNo,
    required this.seatRowNo,
    required this.seatName,
    required this.passenger,
    required this.dob,
    required this.email,
    required this.phoneNo,
    required this.age,
    required this.genderName,
    required this.bookFlightId,
    required this.passengerID,
    required this.firstName,
    required this.lastName,
    required this.pnr,
    required this.loginType,
  });

  factory Table3BusTravellerDetailModel.fromJson(Map<String, dynamic> json) {
    return Table3BusTravellerDetailModel(
      busPassengerID: json['BusPassengerID'].toString(),
      type: json['Type'].toString(),
      idNumber: json['IDNumber'].toString(),
      seatColumnNo: json['SeatColumnNo'].toString(),
      seatRowNo: json['SeatRowNo'].toString(),
      seatName: json['SeatName'].toString(),
      passenger: json['Passenger'].toString(),
      dob: json['DOB'].toString(),
      email: json['Email'].toString(),
      phoneNo: json['PhoneNo'].toString(),
      age: json['Age'].toString(),
      genderName: json['GenderName'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      passengerID: json['PassengerID'].toString(),
      firstName: json['FirstName'].toString(),
      lastName: json['LastName'].toString(),
      pnr: json['PNR'].toString(),
      loginType: json['LoginType'].toString(),
    );
  }


}
