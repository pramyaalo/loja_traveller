class Table3FLightPassengerListModel {
  final String bftfPlightID;
  final String passengerID;
  final String pnr;
  final String ticketNo;
  final String type;
  final String refundStatus;
  final String passenger;
  final String tfpDOB;
  final String tfpIdentityNo;
  final String tfpPhoneNo;
  final String tfpEmail;
  final String cancellStatus;
  final String custPhone;
  final String custEmail;
  final String age;

  Table3FLightPassengerListModel({
    required this.bftfPlightID,
    required this.passengerID,
    required this.pnr,
    required this.ticketNo,
    required this.type,
    required this.refundStatus,
    required this.passenger,
    required this.tfpDOB,
    required this.tfpIdentityNo,
    required this.tfpPhoneNo,
    required this.tfpEmail,
    required this.cancellStatus,
    required this.custPhone,
    required this.custEmail,
    required this.age,
  });

  factory Table3FLightPassengerListModel.fromJson(Map<String, dynamic> json) {
    return Table3FLightPassengerListModel(
      bftfPlightID: json['BFTFPlightID'].toString(),
      passengerID: json['PassengerID'].toString(),
      pnr: json['PNR'].toString(),
      ticketNo: json['TicketNo'].toString(),
      type: json['Type'].toString(),
      refundStatus: json['RefundStatus'].toString(),
      passenger: json['Passenger'].toString(),
      tfpDOB: json['TFPDOB'].toString(),
      tfpIdentityNo: json['TFPIdentityNo'].toString(),
      tfpPhoneNo: json['PhoneNo'].toString(),
      tfpEmail: json['Email'].toString(),
      cancellStatus: json['CancellStatus'].toString(),
      custPhone: json['CustPhone'].toString(),
      custEmail: json['CustEmail'].toString(),
      age: json['Age'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BFTFPlightID': bftfPlightID,
      'PassengerID': passengerID,
      'PNR': pnr,
      'TicketNo': ticketNo,
      'Type': type,
      'RefundStatus': refundStatus,
      'Passenger': passenger,
      'TFPDOB': tfpDOB,
      'TFPIdentityNo': tfpIdentityNo,
      'TFPPhoneNo': tfpPhoneNo,
      'TFPEmail': tfpEmail,
      'CancellStatus': cancellStatus,
      'CustPhone': custPhone,
      'CustEmail': custEmail,
      'Age': age,
    };
  }
}
