class Table24CreditNoteBusTotalPriceModel {
  final String Currency;
  final String totalFare;
  final String gstPercent;
  final String gstAmount;
  final String serviceTaxPercent;
  final String serviceTaxAmount;
  final String discountAmount;
  final String grandTotal;

  Table24CreditNoteBusTotalPriceModel({
    required this.Currency,
    required this.totalFare,
    required this.gstPercent,
    required this.gstAmount,
    required this.serviceTaxPercent,
    required this.serviceTaxAmount,
    required this.discountAmount,
    required this.grandTotal,
  });

  // Factory constructor to create a FareDetails object from JSON
  factory Table24CreditNoteBusTotalPriceModel.fromJson(Map<String, dynamic> json) {
    return Table24CreditNoteBusTotalPriceModel(
      Currency:json['Currency'].toString(),
      totalFare: json["TotalFare"].toString(),
      gstPercent: json["GSTPercent"].toString(),
      gstAmount: json["GSTAmount"].toString(),
      serviceTaxPercent: json["ServiceTaxPercent"].toString(),
      serviceTaxAmount: json["ServiceTaxAmount"].toString(),
      discountAmount: json["DiscountAmount"].toString() ,
      grandTotal: json["GrandTotal"].toString(),
    );
  }

  // Convert FareDetails object to JSON
  Map<String, dynamic> toJson() {
    return {
      "TotalFare": totalFare,
      "GSTPercent": gstPercent,
      "GSTAmount": gstAmount,
      "ServiceTaxPercent": serviceTaxPercent,
      "ServiceTaxAmount": serviceTaxAmount,
      "DiscountAmount": discountAmount.toString(),
      "GrandTotal": grandTotal,
    };
  }
}
