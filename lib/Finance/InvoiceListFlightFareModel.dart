class InvoiceListFlightFareModel {
  String totalFare;

  InvoiceListFlightFareModel({required this.totalFare});

  factory InvoiceListFlightFareModel.fromJson(Map<String, dynamic> json) {
    return InvoiceListFlightFareModel(totalFare: json['TotalFare'].toString());
  }
}
