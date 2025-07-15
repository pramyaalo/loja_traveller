class Tabe48CreditNoteFareModel {
  String totalFare;

  Tabe48CreditNoteFareModel({required this.totalFare});

  factory Tabe48CreditNoteFareModel.fromJson(Map<String, dynamic> json) {
    return Tabe48CreditNoteFareModel(totalFare: json['TotalFare'].toString());
  }
}
