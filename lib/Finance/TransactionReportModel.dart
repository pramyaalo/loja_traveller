class TransactionReportModel {
  String slNo;
  String company;
  String journalEntryId;
  String name;
  String transactionDate;
  String accountTypeName;
  String financeYear;
  String credit;
  String debit;
  String amount;
  String userType;
  String currencyCode;
  String userName;

  TransactionReportModel({
    required this.slNo,
    required this.company,
    required this.journalEntryId,
    required this.name,
    required this.transactionDate,
    required this.accountTypeName,
    required this.financeYear,
    required this.credit,
    required this.debit,
    required this.amount,
    required this.userType,
    required this.currencyCode,
    required this.userName,
  });

  factory TransactionReportModel.fromJson(Map<String, dynamic> json) {
    return TransactionReportModel(
      slNo: json['SlNo'].toString(),
      company: json['Company'].toString(),
      journalEntryId: json['JournalEntryId'].toString(),
      name: json['Name'].toString(),
      transactionDate: json['TransactionDate'].toString(),
      accountTypeName: json['AccountTypeName'].toString(),
      financeYear: json['FinanceYear'].toString(),
      credit: json['Credit'].toString(),
      debit: json['Debit'].toString(),
      amount: json['Amount'].toString(),
      userType: json['UserType'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
      userName: json['UserName'].toString(),
    );
  }
}
