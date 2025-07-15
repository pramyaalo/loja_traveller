class Table11CarInvoiceTotalModel {
  String totalFare;
  String gstPercent;
  String gstAmount;
  String serviceTaxPercent;
  String serviceTaxAmount;
  String grandTotal;
  String Currency;

  Table11CarInvoiceTotalModel({
    required this.totalFare,
    required this.gstPercent,
    required this.gstAmount,
    required this.serviceTaxPercent,
    required this.serviceTaxAmount,
    required this.grandTotal,
    required this.Currency,
  });

  factory Table11CarInvoiceTotalModel.fromJson(Map<String, dynamic> json) {
    return Table11CarInvoiceTotalModel(
      totalFare: json['TotalFare'].toString(),
      gstPercent: json['GSTPercent'].toString(),
      gstAmount: json['GSTAmount'].toString(),
      serviceTaxPercent: json['ServiceTaxPercent'].toString(),
      serviceTaxAmount: json['ServiceTaxAmount'].toString(),
      grandTotal: json['GrandTotal'].toString(),
        Currency: json['Currency'].toString(),
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
