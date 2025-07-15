class FundReceivedHistoryModel {
  String slNo;
  String id;
  String credit;
  String debit;
  String balance;
  String customerName;
  String dateCreated;
  String message;
  String currency;
  String bank;
  String credit1;
  String debit1;

  FundReceivedHistoryModel({
    required this.slNo,
    required this.id,
    required this.credit,
    required this.debit,
    required this.balance,
    required this.customerName,
    required this.dateCreated,
    required this.message,
    required this.currency,
    required this.bank,
    required this.credit1,
    required this.debit1,
  });

  factory FundReceivedHistoryModel.fromJson(Map<String, dynamic> json) {
    return FundReceivedHistoryModel(
      slNo: json['SlNo'].toString(),
      id: json['Id'].toString(),
      credit: json['Credit'].toString(),
      debit: json['Debit'].toString(),
      balance: json['Balance'].toString(),
      customerName: json['CustomerName'].toString(),
      dateCreated: json['Datecreated'].toString(),
      message: json['Message'].toString(),
      currency: json['Currency'].toString(),
      bank: json['Bank'].toString(),
      credit1: json['Credit1'].toString(),
      debit1: json['Debit1'].toString(),
    );
  }
}
