class Table11BusInvoiceTotalModel {
  String totalFare;
  String gstPercent;
  String gstAmount;
  String serviceTaxPercent;
  String serviceTaxAmount;
  String grandTotal;

  Table11BusInvoiceTotalModel({
    required this.totalFare,
    required this.gstPercent,
    required this.gstAmount,
    required this.serviceTaxPercent,
    required this.serviceTaxAmount,
    required this.grandTotal,
  });

  factory Table11BusInvoiceTotalModel.fromJson(Map<String, dynamic> json) {
    return Table11BusInvoiceTotalModel(
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
