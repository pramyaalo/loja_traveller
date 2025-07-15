class Table10HotelPassengerListModel {
  final String bftHotelPID;
  final String bftHotelPID1;
  final String type;
  final String tfpIdentityNo;
  final String passenger;
  final String tfpDOB;
  final String tfpPhoneNo;
  final String tfpEmail;
  final String pnr;
  final String age;

  Table10HotelPassengerListModel({
    required this.bftHotelPID,
    required this.bftHotelPID1,
    required this.type,
    required this.tfpIdentityNo,
    required this.passenger,
    required this.tfpDOB,
    required this.tfpPhoneNo,
    required this.tfpEmail,
    required this.pnr,
    required this.age,
  });

  factory Table10HotelPassengerListModel.fromJson(Map<String, dynamic> json) {
    return Table10HotelPassengerListModel(
      bftHotelPID: json['BFTHotelPID'].toString(),
      bftHotelPID1: json['BFTHotelPID1'].toString(),
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

  Map<String, dynamic> toJson() {
    return {
      'BFTHotelPID': bftHotelPID,
      'BFTHotelPID1': bftHotelPID1,
      'Type': type,
      'TFPIdentityNo': tfpIdentityNo,
      'Passenger': passenger,
      'TFPDOB': tfpDOB,
      'TFPPhoneNo': tfpPhoneNo,
      'TFPEmail': tfpEmail,
      'PNR': pnr,
      'Age': age,
    };
  }
}
