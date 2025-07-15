class InvoiceListFlighttaxModel {
  String totalTax;

  InvoiceListFlighttaxModel({required this.totalTax});

  factory InvoiceListFlighttaxModel.fromJson(Map<String, dynamic> json) {
    return InvoiceListFlighttaxModel(totalTax: json['TotalTax'].toString());
  }
}
