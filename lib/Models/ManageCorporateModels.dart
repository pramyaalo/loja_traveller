class ManageCorporateModels {
  String rowNumber;
  String corporateId;
  String userTypeId;
  String userId;
  String accountId;
  String corporateName;
  String username;
  String operationDate;
  String city;
  String currencyCode;
  String registrationDate;
  String currency;
  String isActive;
  String approveStatus;
  String name;

  ManageCorporateModels({
    required this.rowNumber,
    required this.corporateId,
    required this.userTypeId,
    required this.userId,
    required this.accountId,
    required this.corporateName,
    required this.username,
    required this.operationDate,
    required this.city,
    required this.currencyCode,
    required this.registrationDate,
    required this.currency,
    required this.isActive,
    required this.approveStatus,
    required this.name,
  });

  factory ManageCorporateModels.fromJson(Map<String, dynamic> json) {
    return ManageCorporateModels(
      rowNumber: json['rownumber'].toString(),
      corporateId: json['CorporateId'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      accountId: json['AccountID'].toString(),
      corporateName: json['Corporate Name'].toString(),
      username: json['Username'].toString(),
      operationDate: json['OperationDt'].toString(),
      city: json['City'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
      registrationDate: json['RegnDate'].toString(),
      currency: json['Currency'].toString(),
      isActive: json['IsActive'].toString(),
      approveStatus: json['ApproveStatus'].toString(),
      name: json['Name'].toString(),
    );
  }
}
