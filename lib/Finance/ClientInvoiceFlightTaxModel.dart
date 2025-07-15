class ClientInvoiceFlightTaxModel {
  String totalTax;

  ClientInvoiceFlightTaxModel({required this.totalTax});

  factory ClientInvoiceFlightTaxModel.fromJson(Map<String, dynamic> json) {
    return ClientInvoiceFlightTaxModel(totalTax: json['TotalTax'].toString());
  }
}
