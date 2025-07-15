class Table49ClientInvoiceFareModel {
  String totalTax;

  Table49ClientInvoiceFareModel({required this.totalTax});

  factory Table49ClientInvoiceFareModel.fromJson(Map<String, dynamic> json) {
    return Table49ClientInvoiceFareModel(totalTax: json['TotalTax'].toString());
  }
}
