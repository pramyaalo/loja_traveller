class Table1ProfitandLossModel {
  String accountTypeId;
  String name;
  String amount;

  Table1ProfitandLossModel({
    required this.accountTypeId,
    required this.name,
    required this.amount,
  });

  factory Table1ProfitandLossModel.fromJson(Map<String, dynamic> json) {
    return Table1ProfitandLossModel(
      accountTypeId: json['AccountTypeId'].toString(),
      name: json['Name'].toString(),
      amount: json['Amount'].toString(),
    );
  }
}
