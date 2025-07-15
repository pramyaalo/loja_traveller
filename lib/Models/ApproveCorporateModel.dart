class ApproveCorporateModel {
  String rowNumber;
  String corporateId;
  String accountId;
  String corporateName;
  String username;
  String operationDate;
  String countryId;
  String city;
  String registrationDate;
  String currency;
  String isActive;
  String approveStatus;

  ApproveCorporateModel({
    required this.rowNumber,
    required this.corporateId,
    required this.accountId,
    required this.corporateName,
    required this.username,
    required this.operationDate,
    required this.countryId,
    required this.city,
    required this.registrationDate,
    required this.currency,
    required this.isActive,
    required this.approveStatus,
  });

  factory ApproveCorporateModel.fromJson(Map<String, dynamic> json) {
    return ApproveCorporateModel(
      rowNumber: json['rownumber'].toString(),
      corporateId: json['CorporateId'].toString(),
      accountId: json['AccountID'].toString(),
      corporateName: json['Corporate Name'].toString(),
      username: json['Username'].toString(),
      operationDate: json['OperationDt'].toString(),
      countryId: json['CountryId'].toString(),
      city: json['City'].toString(),
      registrationDate: json['RegnDate'].toString(),
      currency: json['Currency'].toString(),
      isActive: json['IsActive'].toString(),
      approveStatus: json['ApproveStatus'].toString(),
    );
  }
}
