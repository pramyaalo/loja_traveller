class Table4ProfitandLossModel {
  String profit;

  Table4ProfitandLossModel({
    required this.profit,
  });

  factory Table4ProfitandLossModel.fromJson(Map<String, dynamic> json) {
    return Table4ProfitandLossModel(
      profit: json['Profit'].toString(),
    );
  }
}
