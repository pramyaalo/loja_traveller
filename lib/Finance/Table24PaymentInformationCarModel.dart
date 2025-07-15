class Table24PaymentInformationCarModel {
  final String currency;
  final String totalFare;
  final String gstPercent;
  final String gstAmount;
  final String serviceTaxPercent;
  final String serviceTaxAmount;
  final String discountAmount;
  final String grandTotal;

  Table24PaymentInformationCarModel({
    required this.currency,
    required this.totalFare,
    required this.gstPercent,
    required this.gstAmount,
    required this.serviceTaxPercent,
    required this.serviceTaxAmount,
    required this.discountAmount,
    required this.grandTotal,
  });

  factory Table24PaymentInformationCarModel.fromJson(Map<String, dynamic> json) {
    return Table24PaymentInformationCarModel(
      currency: json['Currency'].toString(),
      totalFare: json['TotalFare'].toString(),
      gstPercent: json['GSTPercent'].toString(),
      gstAmount: json['GSTAmount'].toString(),
      serviceTaxPercent: json['ServiceTaxPercent'].toString(),
      serviceTaxAmount: json['ServiceTaxAmount'].toString(),
      discountAmount: json['DiscountAmount'].toString(),
      grandTotal: json['GrandTotal'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Currency': currency,
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
