class FundTransferHistoryModel {
  String slNo;
  String Id;
  String Credit;
  String Debit;
  String Balance;
  String TransferFrom;
  String TransferTo;
  String Datecreated;
  String Message;
  String Currency;
  String Bank;
  String Credit1;
  String Debit1;

  FundTransferHistoryModel({
    required this.slNo,
    required this.Id,
    required this.Credit,
    required this.Debit,
    required this.Balance,
    required this.TransferFrom,
    required this.TransferTo,
    required this.Datecreated,
    required this.Message,
    required this.Currency,
    required this.Bank,
    required this.Credit1,
    required this.Debit1,
  });

  factory FundTransferHistoryModel.fromJson(Map<String, dynamic> json) {
    return FundTransferHistoryModel(
      slNo: json['SlNo'].toString(),
      Id: json['Id'].toString(),
      Credit: json['Credit'].toString(),
      Debit: json['Debit'].toString(),
      Balance: json['Balance'].toString(),
      TransferFrom: json['TransferFrom'].toString(),
      TransferTo: json['TransferTo'].toString(),
      Datecreated: json['Datecreated'].toString(),
      Message: json['Message'].toString(),
      Currency: json['Currency'].toString(),
      Bank: json['Bank'].toString(),
      Credit1: json['Credit1'].toString(),
      Debit1: json['Debit1'].toString(),
    );
  }
}
