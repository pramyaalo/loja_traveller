class Table49ClientInvoiceHolidayaxModel {
  String totalTax;

  Table49ClientInvoiceHolidayaxModel({required this.totalTax});

  factory Table49ClientInvoiceHolidayaxModel.fromJson(
      Map<String, dynamic> json) {
    return Table49ClientInvoiceHolidayaxModel(
        totalTax: json['TotalTax'].toString());
  }
}
