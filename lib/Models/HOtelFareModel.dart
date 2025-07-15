class HOtelFareModel {
  String totalFare;

  HOtelFareModel({required this.totalFare});

  factory HOtelFareModel.fromJson(Map<String, dynamic> json) {
    return HOtelFareModel(totalFare: json['TotalFare'].toString());
  }
}
