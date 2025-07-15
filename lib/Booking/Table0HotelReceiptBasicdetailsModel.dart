class Table0HotelReceiptBasicdetailsModel {
  final String corporateId;
  final String corporateName;
  final String corporateAddress1;
  final String corporateAddress2;
  final String addressLine3;
  final String phone;
  final String email;

  Table0HotelReceiptBasicdetailsModel({
    required this.corporateId,
    required this.corporateName,
    required this.corporateAddress1,
    required this.corporateAddress2,
    required this.addressLine3,
    required this.phone,
    required this.email,
  });

  factory Table0HotelReceiptBasicdetailsModel.fromJson(
      Map<String, dynamic> json) {
    return Table0HotelReceiptBasicdetailsModel(
      corporateId: json['CorporateId'].toString(),
      corporateName: json['CorporateName'].toString(),
      corporateAddress1: json['CorporateAddress1'].toString(),
      corporateAddress2: json['CorporateAddress2'].toString(),
      addressLine3: json['AddressLine3'].toString(),
      phone: json['Phone'].toString(),
      email: json['EMail'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CorporateId': corporateId,
      'CorporateName': corporateName,
      'CorporateAddress1': corporateAddress1,
      'CorporateAddress2': corporateAddress2,
      'AddressLine3': addressLine3,
      'Phone': phone,
      'EMail': email,
    };
  }
}
