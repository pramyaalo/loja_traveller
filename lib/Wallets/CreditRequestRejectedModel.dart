class CreditRequestRejectedModel {
  String slNo;
  String userTypeId;
  String userId;
  String manageDepositId;
  String paymentType;
  String payment;
  String currency;
  String depositAmount;
  String authorizedBy;
  String transactionNo;
  String paymentDate;
  String status;
  String authorizedName;
  String approval;
  String currencyCode;
  String userType;
  String name;

  CreditRequestRejectedModel({
    required this.slNo,
    required this.userTypeId,
    required this.userId,
    required this.manageDepositId,
    required this.paymentType,
    required this.payment,
    required this.currency,
    required this.depositAmount,
    required this.authorizedBy,
    required this.transactionNo,
    required this.paymentDate,
    required this.status,
    required this.authorizedName,
    required this.approval,
    required this.currencyCode,
    required this.userType,
    required this.name,
  });

  factory CreditRequestRejectedModel.fromJson(Map<String, dynamic> json) {
    return CreditRequestRejectedModel(
      slNo: json['SlNo'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      manageDepositId: json['ManageDepositId'].toString(),
      paymentType: json['PaymentType'].toString(),
      payment: json['Payment'].toString(),
      currency: json['Currency'].toString(),
      depositAmount: json['DepositAmount'].toString(),
      authorizedBy: json['AuthorizedBy'].toString(),
      transactionNo: json['TransactionNo'].toString(),
      paymentDate: json['PaymentDate'].toString(),
      status: json['Status'].toString(),
      authorizedName: json['AuthorizedName'].toString(),
      approval: json['Approval'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
      userType: json['UserType'].toString(),
      name: json['Name'].toString(),
    );
  }
}
