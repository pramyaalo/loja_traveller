class ViewJournalEntryModel {
  final String journalEntryId;
  final String journalEntryTypeId;
  final String serialNo;
  final String referenceNo;
  final String company;
  final String financeYear;
  final String journalDate;
  final String accountTypeId;
  final String subAccountTypeId;
  final String superAccountTypeId;
  final String type;
  final String name;
  final String amount;
  final String debit;
  final String credit;
  final String status;
  final String notes;
  final String createdDate;
  final String journalEntry;
  final String journalDate1;
  final String accountTypeName;
  final String status1;
  final String type1;
  final String createdDate1;
  final String companyId;
  final String financeYearId;
  final String subAccountTypeName;
  final String superAccountTypeName;
  final String userTypeId;
  final String userId;
  final String userType;
  final String userName;
  final String currencyCode;
  final String journalCheck;

  ViewJournalEntryModel({
    required this.journalEntryId,
    required this.journalEntryTypeId,
    required this.serialNo,
    required this.referenceNo,
    required this.company,
    required this.financeYear,
    required this.journalDate,
    required this.accountTypeId,
    required this.subAccountTypeId,
    required this.superAccountTypeId,
    required this.type,
    required this.name,
    required this.amount,
    required this.debit,
    required this.credit,
    required this.status,
    required this.notes,
    required this.createdDate,
    required this.journalEntry,
    required this.journalDate1,
    required this.accountTypeName,
    required this.status1,
    required this.type1,
    required this.createdDate1,
    required this.companyId,
    required this.financeYearId,
    required this.subAccountTypeName,
    required this.superAccountTypeName,
    required this.userTypeId,
    required this.userId,
    required this.userType,
    required this.userName,
    required this.currencyCode,
    required this.journalCheck,
  });

  factory ViewJournalEntryModel.fromJson(Map<String, dynamic> json) {
    return ViewJournalEntryModel(
      journalEntryId: json['JournalEntryId'].toString(),
      journalEntryTypeId: json['JournalEntryTypeId'].toString(),
      serialNo: json['SerialNo'].toString(),
      referenceNo: json['ReferenceNo'].toString(),
      company: json['Company'] ?? "".toString(),
      financeYear: json['FinanceYear'].toString(),
      journalDate: json['JournalDate'].toString(),
      accountTypeId: json['AccountTypeId'].toString(),
      subAccountTypeId: json['SubAccountTypeId'].toString(),
      superAccountTypeId: json['SuperAccountTypeId'].toString(),
      type: json['Type'].toString(),
      name: json['Name'].toString(),
      amount: json['Amount'].toString(),
      debit: json['Debit'] .toString(),
      credit: json['Credit'].toString(),
      status: json['Status'].toString(),
      notes: json['Notes'].toString(),
      createdDate: json['CreatedDate'].toString(),
      journalEntry: json['JournalEntry'].toString(),
      journalDate1: json['JournalDate1'].toString(),
      accountTypeName: json['AccountTypeName'].toString(),
      status1: json['Status1'].toString(),
      type1: json['Type1'].toString(),
      createdDate1: json['CreatedDate1'].toString(),
      companyId: json['CompanyId'].toString(),
      financeYearId: json['FinanceYearId'].toString(),
      subAccountTypeName: json['SubAccountTypeName'].toString(),
      superAccountTypeName: json['SuperAccountTypeName'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      userType: json['UserType'].toString(),
      userName: json['UserName'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
      journalCheck: json['JournalCheck'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'JournalEntryId': journalEntryId,
      'JournalEntryTypeId': journalEntryTypeId,
      'SerialNo': serialNo,
      'ReferenceNo': referenceNo,
      'Company': company,
      'FinanceYear': financeYear,
      'JournalDate': journalDate,
      'AccountTypeId': accountTypeId,
      'SubAccountTypeId': subAccountTypeId,
      'SuperAccountTypeId': superAccountTypeId,
      'Type': type,
      'Name': name,
      'Amount': amount,
      'Debit': debit,
      'Credit': credit,
      'Status': status,
      'Notes': notes,
      'CreatedDate': createdDate,
      'JournalEntry': journalEntry,
      'JournalDate1': journalDate1,
      'AccountTypeName': accountTypeName,
      'Status1': status1,
      'Type1': type1,
      'CreatedDate1': createdDate1,
      'CompanyId': companyId,
      'FinanceYearId': financeYearId,
      'SubAccountTypeName': subAccountTypeName,
      'SuperAccountTypeName': superAccountTypeName,
      'UserTypeId': userTypeId,
      'UserId': userId,
      'UserType': userType,
      'UserName': userName,
      'CurrencyCode': currencyCode,
      'JournalCheck': journalCheck,
    };
  }
}

