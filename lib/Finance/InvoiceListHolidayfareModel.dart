class InvoiceListHolidayfareModel {
  String totalFare;

  InvoiceListHolidayfareModel({required this.totalFare});

  factory InvoiceListHolidayfareModel.fromJson(Map<String, dynamic> json) {
    return InvoiceListHolidayfareModel(totalFare: json['TotalFare'].toString());
  }
}
