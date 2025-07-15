class Table11ClientInvoiceHotelModel {
  int corporateId;
  String corporateName;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String city;
  String postCode;
  String phone;
  String email;

  Table11ClientInvoiceHotelModel({
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

  factory Table11ClientInvoiceHotelModel.fromJson(Map<String, dynamic> json) {
    return Table11ClientInvoiceHotelModel(
      corporateId: json['CorporateId'],
      corporateName: json['Corporate Name'],
      addressLine1: json['AddressLine1'],
      addressLine2: json['AddressLine2'],
      addressLine3: json['AddressLine3'],
      city: json['City'],
      postCode: json['PostCode'],
      phone: json['Phone'],
      email: json['EMail'],
    );
  }
}
