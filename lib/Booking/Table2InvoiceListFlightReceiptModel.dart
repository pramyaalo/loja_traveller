
class Table2InvoiceListFlightReceiptModel {
  final String type;
  final String passenger;
  final String pnr;
  final String passengerID;
  final String ticketNo;
  final String age;
  final String tfpIdentityType;
  final String tfpPhoneNo;
  final String tfpEmail;
  final String gender;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String countryName;
  final String mailId;

  Table2InvoiceListFlightReceiptModel({
    required this.type,
    required this.passenger,
    required this.pnr,
    required this.passengerID,
    required this.ticketNo,
    required this.age,
    required this.tfpIdentityType,
    required this.tfpPhoneNo,
    required this.tfpEmail,
    required this.gender,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.countryName,
    required this.mailId,
  });

  factory Table2InvoiceListFlightReceiptModel.fromJson(Map<String, dynamic> json) {
    return Table2InvoiceListFlightReceiptModel(
      type: json['Type'].toString(),
      passenger: json['Passenger'].toString(),
      pnr: json['PNR'].toString(),
      passengerID: json['PassengerID'].toString(),
      ticketNo: json['TicketNo'].toString(),
      age: json['Age'].toString(),
      tfpIdentityType: json['TFPIdentityType'].toString(),
      tfpPhoneNo: json['TFPPhoneNo'].toString(),
      tfpEmail: json['TFPEmail'].toString(),
      gender: json['Gender'].toString(),
      addressLine1: json['AddressLine1'].toString(),
      addressLine2: json['AddressLine2'].toString(),
      city: json['City'].toString(),
      countryName: json['CountryName'].toString(),
      mailId: json['MailId'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Type': type,
      'Passenger': passenger,
      'PNR': pnr,
      'PassengerID': passengerID,
      'TicketNo': ticketNo,
      'Age': age,
      'TFPIdentityType': tfpIdentityType,
      'TFPPhoneNo': tfpPhoneNo,
      'TFPEmail': tfpEmail,
      'Gender': gender,
      'AddressLine1': addressLine1,
      'AddressLine2': addressLine2,
      'City': city,
      'CountryName': countryName,
      'MailId': mailId,
    };
  }
}

