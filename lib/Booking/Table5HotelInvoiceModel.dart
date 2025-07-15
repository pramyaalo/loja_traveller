class Table5HotelInvoiceModel {
  final String corporateId;
  final String corporateName;
  final String corporateAddress1;
  final String addressLine3;
  final String corporateAddress2;
  final String PostCode;
  final String phone;
  final String email;
  final String billDt;
  final String billYr;

  Table5HotelInvoiceModel({
    required this.corporateId,
    required this.corporateName,
    required this.corporateAddress1,
    required this.addressLine3,
    required this.corporateAddress2,
    required this.PostCode,
    required this.phone,
    required this.email,
    required this.billDt,
    required this.billYr,
  });

  factory Table5HotelInvoiceModel.fromJson(Map<String, dynamic> json) {
    return Table5HotelInvoiceModel(
      corporateId: json['CorporateId'].toString(),
      corporateName: json['Corporate Name'].toString(),
      corporateAddress1: json['AddressLine1'].toString(),
      addressLine3: json['AddressLine3'].toString(),
      corporateAddress2: json['AddressLine2'].toString(),
        PostCode:json['PostCode'].toString(),
      phone: json['Phone'].toString(),
      email: json['EMail'].toString(),
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
