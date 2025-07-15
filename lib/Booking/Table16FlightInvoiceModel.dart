class Table16FlightInvoiceMode {
  String totalFare;
  String Currency;
  String gstPercent;
  String gstAmount;
  String serviceTaxPercent;
  String serviceTaxAmount;
  String discountAmount;
  String grandTotal;

  Table16FlightInvoiceMode({
    required this.totalFare,
    required this.Currency,
    required this.gstPercent,
    required this.gstAmount,
    required this.serviceTaxPercent,
    required this.serviceTaxAmount,
    required this.discountAmount,
    required this.grandTotal,
  });

  // Factory method to create an instance from JSON
  factory Table16FlightInvoiceMode.fromJson(Map<String, dynamic> json) {
    return Table16FlightInvoiceMode(
      totalFare: json['TotalFare'].toString(),
        Currency:json["Currency"].toString(),
      gstPercent: json['GSTPercent'].toString(),
      gstAmount: json['GSTAmount'].toString(),
      serviceTaxPercent: json['ServiceTaxPercent'].toString(),
      serviceTaxAmount: json['ServiceTaxAmount'].toString(),
      discountAmount: json['DiscountAmount'].toString(),
      grandTotal: json['GrandTotal'].toString(),
    );
  }

  // Convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'TotalFare': totalFare,
      'GSTPercent': gstPercent,
      'GSTAmount': gstAmount,
      'ServiceTaxPercent': serviceTaxPercent,
      'ServiceTaxAmount': serviceTaxAmount,
      'DiscountAmount': discountAmount,
      'GrandTotal': grandTotal,
    };
  }
}
