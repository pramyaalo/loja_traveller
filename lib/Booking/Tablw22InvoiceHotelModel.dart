class Tablw22InvoiceHotelModel {
  final String Currency;
  final String totalFare;
  final String gstPercent;
  final String gstAmount;
  final String serviceTaxPercent;
  final String serviceTaxAmount;
  final String discountAmount;
  final String grandTotal;

  Tablw22InvoiceHotelModel({
    required this.Currency,
    required this.totalFare,
    required this.gstPercent,
    required this.gstAmount,
    required this.serviceTaxPercent,
    required this.serviceTaxAmount,
    required this.discountAmount,
    required this.grandTotal,
  });

  factory Tablw22InvoiceHotelModel.fromJson(Map<String, dynamic> json) {
    return Tablw22InvoiceHotelModel(
      Currency: json['Currency'].toString(),
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
