class table3VoucherHotelreceiptModel {
  final String bfTHotelPID;
  final String bfTHotelPID1;
  final String type;
  final String tfpIdentityNo;
  final String passenger;
  final String tfpDOB;
  final String tfpPhoneNo;
  final String tfpEmail;
  final String pnr;
  final String age;

  table3VoucherHotelreceiptModel({
    required this.bfTHotelPID,
    required this.bfTHotelPID1,
    required this.type,
    required this.tfpIdentityNo,
    required this.passenger,
    required this.tfpDOB,
    required this.tfpPhoneNo,
    required this.tfpEmail,
    required this.pnr,
    required this.age,
  });

  factory table3VoucherHotelreceiptModel.fromJson(Map<String, dynamic> json) {
    return table3VoucherHotelreceiptModel(
      bfTHotelPID: json['BFTHotelPID'].toString(),
      bfTHotelPID1: json['BFTHotelPID1'].toString(),
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
      'BFTHotelPID': bfTHotelPID,
      'BFTHotelPID1': bfTHotelPID1,
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
