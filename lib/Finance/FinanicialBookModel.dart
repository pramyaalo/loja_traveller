class FinanicialBookModel {
  String slNo;
  String serialNo;
  String date;
  String notes;
  String accountTypeName;
  String credit;
  String debit;
  String userType;
  String userTypeId;
  String userId;
  String userName;
  String currencyCode;

  FinanicialBookModel({
    required this.slNo,
    required this.serialNo,
    required this.date,
    required this.notes,
    required this.accountTypeName,
    required this.credit,
    required this.debit,
    required this.userType,
    required this.userTypeId,
    required this.userId,
    required this.userName,
    required this.currencyCode,
  });

  factory FinanicialBookModel.fromJson(Map<String, dynamic> json) {
    return FinanicialBookModel(
      slNo: json['SlNo'].toString(),
      serialNo: json['SerialNo'].toString(),
      date: json['Date'].toString(),
      notes: json['Notes'].toString(),
      accountTypeName: json['AccountTypeName'].toString(),
      credit: json['Credit'].toString(),
      debit: json['Debit'].toString(),
      userType: json['UserType'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      userName: json['UserName'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
    );
  }
}
