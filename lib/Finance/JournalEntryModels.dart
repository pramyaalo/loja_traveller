
class JournalEntryModels {
  String company;
  String journalEntryId;
  String serialNo;
  String referenceNo;
  String name;
  String journalDate;
  String accountTypeName;
  String financeYear;
  String amount;
  String status;
  String credit;
  String debit;
  String currencyCode;
  String journalCheck;

  JournalEntryModels({
    required this.company,
    required this.journalEntryId,
    required this.serialNo,
    required this.referenceNo,
    required this.name,
    required this.journalDate,
    required this.accountTypeName,
    required this.financeYear,
    required this.amount,
    required this.status,
    required this.credit,
    required this.debit,
    required this.currencyCode,
    required this.journalCheck,
  });

  /// Factory constructor to create an instance from JSON
  factory JournalEntryModels.fromJson(Map<String, dynamic> json) {
    return JournalEntryModels(
      company: json['Company'].toString(),
      journalEntryId: json['JournalEntryId'].toString(),
      serialNo: json['SerialNo'].toString(),
      referenceNo: json['ReferenceNo'].toString(),
      name: json['Name'].toString(),
      journalDate: json['JournalDate'].toString(),
      accountTypeName: json['AccountTypeName'].toString(),
      financeYear: json['FinanceYear'].toString(),
      amount: json['Amount'].toString(),
      status: json['Status'].toString(),
      credit: json['Credit'].toString(),
      debit: json['Debit'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
      journalCheck: json['JournalCheck'].toString(),
    );
  }

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'Company': company,
      'JournalEntryId': journalEntryId,
      'SerialNo': serialNo,
      'ReferenceNo': referenceNo,
      'Name': name,
      'JournalDate': journalDate,
      'AccountTypeName': accountTypeName,
      'FinanceYear': financeYear,
      'Amount': amount,
      'Status': status,
      'Credit': credit,
      'Debit': debit,
      'CurrencyCode': currencyCode,
      'JournalCheck': journalCheck,
    };
  }
}
