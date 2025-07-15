class ViewCreditBalanceRequestModel {
  String manageDepositId;
  String paymentModeId;
  String paymentMode;
  String paymentType;
  String currency;
  String depositAmount;
  String authorizedBy;
  String transactionNo;
  String dateCreated;
  String corporateName;
  String payment;
  String status;
  String authorizedName;
  String add1;
  String add2;
  String city;
  String phone;
  String slipFile;
  String currencyCode;
  String userType;
  String userTypeId;
  String userId;
  String issuedBankName;
  String issuedBranchName;
  String issueDate;
  String accountNo;
  String remarks;
  String name;

  ViewCreditBalanceRequestModel({
    required this.manageDepositId,
    required this.paymentModeId,
    required this.paymentMode,
    required this.paymentType,
    required this.currency,
    required this.depositAmount,
    required this.authorizedBy,
    required this.transactionNo,
    required this.dateCreated,
    required this.corporateName,
    required this.payment,
    required this.status,
    required this.authorizedName,
    required this.add1,
    required this.add2,
    required this.city,
    required this.phone,
    required this.slipFile,
    required this.currencyCode,
    required this.userType,
    required this.userTypeId,
    required this.userId,
    required this.issuedBankName,
    required this.issuedBranchName,
    required this.issueDate,
    required this.accountNo,
    required this.remarks,
    required this.name,
  });

  factory ViewCreditBalanceRequestModel.fromJson(Map<String, dynamic> json) {
    return ViewCreditBalanceRequestModel(
      manageDepositId: json['ManageDepositId'].toString(),
      paymentModeId: json['PaymentModeId'].toString(),
      paymentMode: json['PaymentMode'].toString(),
      paymentType: json['PaymentType'].toString(),
      currency: json['Currency'].toString(),
      depositAmount: json['DepositAmount'].toString(),
      authorizedBy: json['AuthorizedBy'].toString(),
      transactionNo: json['TransactionNo'].toString(),
      dateCreated: json['Datecreated'].toString(),
      corporateName: json['CorporateName'].toString(),
      payment: json['Payment'].toString(),
      status: json['Status'].toString(),
      authorizedName: json['AuthorizedName'].toString(),
      add1: json['Add1'].toString(),
      add2: json['Add2'].toString(),
      city: json['City'].toString(),
      phone: json['Phone'].toString(),
      slipFile: json['SlipFile'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
      userType: json['UserType'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      issuedBankName: json['IssuedBankName'].toString(),
      issuedBranchName: json['IssuedBranchName'].toString(),
      issueDate: json['IssueDate'].toString(),
      accountNo: json['AccountNo'].toString(),
      remarks: json['Remarks'].toString(),
      name: json['Name'].toString(),
    );
  }
}
