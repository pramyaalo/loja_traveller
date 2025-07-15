class TrailBalanceTable2model {
  String accountTypeId;
  String name;
  String debit;
  String credit;

  TrailBalanceTable2model({
    required this.accountTypeId,
    required this.name,
    required this.debit,
    required this.credit,
  });

  factory TrailBalanceTable2model.fromJson(Map<String, dynamic> json) {
    return TrailBalanceTable2model(
      accountTypeId: json['AccountTypeId'].toString(),
      name: json['Name'].toString(),
      debit: json['Debit'].toString(),
      credit: json['Credit'].toString(),
    );
  }
}
