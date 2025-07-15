class Table23HotelInvoiceTotalModel {
  String currency;
  String totalFare;
  String gstPercent;
  String gstAmount;
  String serviceTaxPercent;
  String serviceTaxAmount;
  String discountAmount;
  String grandTotal;

  Table23HotelInvoiceTotalModel({
    required this.currency,
    required this.totalFare,
    required this.gstPercent,
    required this.gstAmount,
    required this.serviceTaxPercent,
    required this.serviceTaxAmount,
    required this.discountAmount,
    required this.grandTotal,
  });

  factory Table23HotelInvoiceTotalModel.fromJson(Map<String, dynamic> json) {
    return Table23HotelInvoiceTotalModel(
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

  Map<String, dynamic> toJson() => {
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
