class ClientInvoiceHotelModel {
  String totalTax;

  ClientInvoiceHotelModel({required this.totalTax});

  factory ClientInvoiceHotelModel.fromJson(Map<String, dynamic> json) {
    return ClientInvoiceHotelModel(totalTax: json['TotalTax'].toString());
  }
}
