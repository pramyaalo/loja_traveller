class CreditUsageModel {
  String creditLeft;
  String usedCredit;
  String totalCredit;
  String ledgerUsedCredit;
  String todayUsage;

  CreditUsageModel({
    required this.creditLeft,
    required this.usedCredit,
    required this.totalCredit,
    required this.ledgerUsedCredit,
    required this.todayUsage,
  });

  factory CreditUsageModel.fromJson(Map<String, dynamic> json) {
    return CreditUsageModel(
      creditLeft: json['CreditLeft'].toString(),
      usedCredit: json['UsedCredit'].toString(),
      totalCredit: json['TotalCredit'].toString(),
      ledgerUsedCredit: json['LedgerUsedCredit'].toString(),
      todayUsage: json['TodayUsage'].toString(),
    );
  }
}
