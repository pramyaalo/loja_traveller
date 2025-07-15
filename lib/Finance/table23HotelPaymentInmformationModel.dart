class table23HotelPaymentInmformationModel {
  final String currency;
  final String totalFare;
  final String gstPercent;
  final String gstAmount;
  final String serviceTaxPercent;
  final String serviceTaxAmount;
  final String discountAmount;
  final String grandTotal;

  table23HotelPaymentInmformationModel({
    required this.currency,
    required this.totalFare,
    required this.gstPercent,
    required this.gstAmount,
    required this.serviceTaxPercent,
    required this.serviceTaxAmount,
    required this.discountAmount,
    required this.grandTotal,
  });

  factory table23HotelPaymentInmformationModel.fromJson(Map<String, dynamic> json) {
    return table23HotelPaymentInmformationModel(
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
