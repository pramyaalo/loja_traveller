class Table2InvoiceListFlightReceiptModel {
  String bftfPlightID;
  String type;
  String passenger;
  String tfpDOB;
  String tfpIdentityNo;
  String tfpPhoneNo;
  String tfpEmail;
  String pnr;
  String ticketNo;
  String custPhone;
  String custEmail;
  String age;
  String addressLine1;
  String addressLine2;
  String city;
  String countryName;
  String passengerID;

  Table2InvoiceListFlightReceiptModel({
    required this.bftfPlightID,
    required this.type,
    required this.passenger,
    required this.tfpDOB,
    required this.tfpIdentityNo,
    required this.tfpPhoneNo,
    required this.tfpEmail,
    required this.pnr,
    required this.ticketNo,
    required this.custPhone,
    required this.custEmail,
    required this.age,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.countryName,
    required this.passengerID,
  });

  factory Table2InvoiceListFlightReceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table2InvoiceListFlightReceiptModel(
      bftfPlightID: json['BFTFPlightID'].toString(),
      type: json['Type'].toString(),
      passenger: json['Passenger'].toString(),
      tfpDOB: json['TFPDOB'].toString(),
      tfpIdentityNo: json['TFPIdentityNo'].toString(),
      tfpPhoneNo: json['TFPPhoneNo'].toString(),
      tfpEmail: json['TFPEmail'].toString(),
      pnr: json['PNR'].toString(),
      ticketNo: json['TicketNo'].toString(),
      custPhone: json['CustPhone'].toString(),
      custEmail: json['CustEmail'].toString(),
      age: json['Age'].toString(),
      addressLine1: json['AddressLine1'].toString(),
      addressLine2: json['AddressLine2'].toString(),
      city: json['City'].toString(),
      countryName: json['CountryName'].toString(),
      passengerID: json['PassengerID'].toString(),
    );
  }
}
