class CreditRequestReceiptModel {
  String slNo;
  String manageDepositId;
  String paymentType;
  String payment;
  String currency;
  String depositAmount;
  String authorizedBy;
  String transactionNo;
  String issuedBankName;
  String issuedBranchName;
  String issueDate;
  String accountNo;
  String paymentDate;
  String currencyCode;
  String status;
  String authorizedName;
  String approval;
  String userType;
  String name;

  CreditRequestReceiptModel({
    required this.slNo,
    required this.manageDepositId,
    required this.paymentType,
    required this.payment,
    required this.currency,
    required this.depositAmount,
    required this.authorizedBy,
    required this.transactionNo,
    required this.issuedBankName,
    required this.issuedBranchName,
    required this.issueDate,
    required this.accountNo,
    required this.paymentDate,
    required this.currencyCode,
    required this.status,
    required this.authorizedName,
    required this.approval,
    required this.userType,
    required this.name,
  });

  factory CreditRequestReceiptModel.fromJson(Map<String, dynamic> json) {
    return CreditRequestReceiptModel(
      slNo: json['SlNo'].toString(),
      manageDepositId: json['ManageDepositId'].toString(),
      paymentType: json['PaymentType'].toString(),
      payment: json['Payment'].toString(),
      currency: json['Currency'].toString(),
      depositAmount: json['DepositAmount'].toString(),
      authorizedBy: json['AuthorizedBy'].toString(),
      transactionNo: json['TransactionNo'].toString(),
      issuedBankName: json['IssuedBankName'].toString(),
      issuedBranchName: json['IssuedBranchName'].toString(),
      issueDate: json['IssueDate'].toString(),
      accountNo: json['AccountNo'].toString(),
      paymentDate: json['PaymentDate'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
      status: json['Status'].toString(),
      authorizedName: json['AuthorizedName'].toString(),
      approval: json['Approval'].toString(),
      userType: json['UserType'].toString(),
      name: json['Name'].toString(),
    );
  }
}
