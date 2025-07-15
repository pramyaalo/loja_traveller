class Table0HotelModel {
  final String corporateId;
  final String corporateName;
  final String corporateAddress1;
  final String addressLine3;
  final String corporateAddress2;
  final String phone;
  final String email;
  final String billDt;
  final String billYr;

  Table0HotelModel({
    required this.corporateId,
    required this.corporateName,
    required this.corporateAddress1,
    required this.addressLine3,
    required this.corporateAddress2,
    required this.phone,
    required this.email,
    required this.billDt,
    required this.billYr,
  });

  factory Table0HotelModel.fromJson(Map<String, dynamic> json) {
    return Table0HotelModel(
      corporateId: json['CorporateId'].toString(),
      corporateName: json['CorporateName'].toString(),
      corporateAddress1: json['CorporateAddress1'].toString(),
      addressLine3: json['AddressLine3'].toString(),
      corporateAddress2: json['CorporateAddress2'].toString(),
      phone: json['Phone'].toString(),
      email: json['Email'].toString(),
      billDt: json['BillDt'].toString(),
      billYr: json['BillYr'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CorporateId': corporateId,
      'CorporateName': corporateName,
      'CorporateAddress1': corporateAddress1,
      'AddressLine3': addressLine3,
      'CorporateAddress2': corporateAddress2,
      'Phone': phone,
      'Email': email,
      'BillDt': billDt,
      'BillYr': billYr,
    };
  }
}
