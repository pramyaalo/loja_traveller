class InvoiceListHolidayTaxModel {
  String totalTax;

  InvoiceListHolidayTaxModel({required this.totalTax});

  factory InvoiceListHolidayTaxModel.fromJson(Map<String, dynamic> json) {
    return InvoiceListHolidayTaxModel(totalTax: json['TotalTax'].toString());
  }
}
