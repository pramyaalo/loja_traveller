class Table9HolidayInvoiceTotalModel {
  final String totalFare;
  final String gstPercent;
  final String gstAmount;
  final String serviceTaxPercent;
  final String serviceTaxAmount;
  final String grandTotal;

  Table9HolidayInvoiceTotalModel({
    required this.totalFare,
    required this.gstPercent,
    required this.gstAmount,
    required this.serviceTaxPercent,
    required this.serviceTaxAmount,
    required this.grandTotal,
  });

  factory Table9HolidayInvoiceTotalModel.fromJson(Map<String, dynamic> json) {
    return Table9HolidayInvoiceTotalModel(
      totalFare: json['TotalFare'].toString(),
      gstPercent: json['GSTPercent'].toString(),
      gstAmount: json['GSTAmount'].toString(),
      serviceTaxPercent: json['ServiceTaxPercent'].toString(),
      serviceTaxAmount: json['ServiceTaxAmount'].toString(),
      grandTotal: json['GrandTotal'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TotalFare': totalFare,
      'GSTPercent': gstPercent,
      'GSTAmount': gstAmount,
      'ServiceTaxPercent': serviceTaxPercent,
      'ServiceTaxAmount': serviceTaxAmount,
      'GrandTotal': grandTotal,
    };
  }
}
