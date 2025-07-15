class OInvoiceListHoteltaxModel {
  String totalTax;

  OInvoiceListHoteltaxModel({required this.totalTax});

  factory OInvoiceListHoteltaxModel.fromJson(Map<String, dynamic> json) {
    return OInvoiceListHoteltaxModel(totalTax: json['TotalTax'].toString());
  }
}
