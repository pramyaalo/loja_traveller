class Table5InvoiceFlightlistDub {
  String corporateId;
  String corporateName;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String city;
  String postCode;
  String phone;
  String email;

  Table5InvoiceFlightlistDub({
    required this.corporateId,
    required this.corporateName,
    required this.addressLine1,
    required this.addressLine2,
    required this.addressLine3,
    required this.city,
    required this.postCode,
    required this.phone,
    required this.email,
  });

  factory Table5InvoiceFlightlistDub.fromJson(
      Map<String, dynamic> json) {
    return Table5InvoiceFlightlistDub(
      corporateId: json['CorporateId'].toString(),
      corporateName: json['CorporateName'].toString(),
      addressLine1: json['CorporateAddress1'].toString(),
      addressLine2: json['CorporateAddress2'].toString(),
      addressLine3: json['AddressLine3'].toString(),
      city: json['City'].toString(),
      postCode: json['PostCode'].toString(),
      phone: json['Phone'].toString(),
      email: json['Email'].toString(),
    );
  }
}
