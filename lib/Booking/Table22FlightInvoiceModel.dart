class Table22FlightInvoiceModel {
  double totalFare;
  double gstPercent;
  double gstAmount;
  double serviceTaxPercent;
  double serviceTaxAmount;
  double discountAmount;
  double grandTotal;

  Table22FlightInvoiceModel({
    required this.totalFare,
    required this.gstPercent,
    required this.gstAmount,
    required this.serviceTaxPercent,
    required this.serviceTaxAmount,
    required this.discountAmount,
    required this.grandTotal,
  });

  // Factory method to create an instance from JSON
  factory Table22FlightInvoiceModel.fromJson(Map<String, dynamic> json) {
    return Table22FlightInvoiceModel(
      totalFare: (json['TotalFare'] ?? 0).toDouble(),
      gstPercent: (json['GSTPercent'] ?? 0).toDouble(),
      gstAmount: (json['GSTAmount'] ?? 0).toDouble(),
      serviceTaxPercent: (json['ServiceTaxPercent'] ?? 0).toDouble(),
      serviceTaxAmount: (json['ServiceTaxAmount'] ?? 0).toDouble(),
      discountAmount: (json['DiscountAmount'] ?? 0).toDouble(),
      grandTotal: (json['GrandTotal'] ?? 0).toDouble(),
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
