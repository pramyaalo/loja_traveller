class CreditBalanceApprovaalModel {
  String slNo;
  String manageDepositId;
  String userTypeId;
  String userId;
  String payment;
  String currency;
  String currencyCode;
  String depositAmount;
  String authorizedBy;
  String transactionNo;
  String issuedBankName;
  String issuedBranchName;
  String issueDate;
  String accountNo;
  String paymentDate;
  String status;
  String authorizedName;
  String approval;
  String userType;
  String name;

  CreditBalanceApprovaalModel({
    required this.slNo,
    required this.manageDepositId,
    required this.userTypeId,
    required this.userId,
    required this.payment,
    required this.currency,
    required this.currencyCode,
    required this.depositAmount,
    required this.authorizedBy,
    required this.transactionNo,
    required this.issuedBankName,
    required this.issuedBranchName,
    required this.issueDate,
    required this.accountNo,
    required this.paymentDate,
    required this.status,
    required this.authorizedName,
    required this.approval,
    required this.userType,
    required this.name,
  });

  factory CreditBalanceApprovaalModel.fromJson(Map<String, dynamic> json) {
    return CreditBalanceApprovaalModel(
      slNo: json['SlNo'].toString(),
      manageDepositId: json['ManageDepositId'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      payment: json['Payment'].toString(),
      currency: json['Currency'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
      depositAmount: json['DepositAmount'].toString(),
      authorizedBy: json['AuthorizedBy'].toString(),
      transactionNo: json['TransactionNo'].toString(),
      issuedBankName: json['IssuedBankName'].toString(),
      issuedBranchName: json['IssuedBranchName'].toString(),
      issueDate: json['IssueDate'].toString(),
      accountNo: json['AccountNo'].toString(),
      paymentDate: json['PaymentDate'].toString(),
      status: json['Status'].toString(),
      authorizedName: json['AuthorizedName'].toString(),
      approval: json['Approval'].toString(),
      userType: json['UserType'].toString(),
      name: json['Name'].toString(),
    );
  }
}
