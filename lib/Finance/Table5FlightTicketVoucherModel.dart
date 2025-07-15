class Table5FlightTicketVoucherModel {
  final String currency;
  final String totalFare;
  final String totalTax;
  final String gstPercent;
  final String gstAmount;
  final String serviceTaxPercent;
  final String serviceTaxAmount;
  final String discountAmount;
  final String grandTotal;

  Table5FlightTicketVoucherModel({
    required this.currency,
    required this.totalFare,
    required this.totalTax,
    required this.gstPercent,
    required this.gstAmount,
    required this.serviceTaxPercent,
    required this.serviceTaxAmount,
    required this.discountAmount,
    required this.grandTotal,
  });

  factory Table5FlightTicketVoucherModel.fromJson(Map<String, dynamic> json) {
    return Table5FlightTicketVoucherModel(
      currency: json['Currency'].toString(),
      totalFare: json['TotalFare'].toString(),
      totalTax: json['TotalTax'].toString(),
      gstPercent: json['GSTPercent'].toString(),
      gstAmount: json['GSTAmount'].toString(),
      serviceTaxPercent: json['ServiceTaxPercent'].toString(),
      serviceTaxAmount: json['ServiceTaxAmount'].toString(),
      discountAmount: json['DiscountAmount'].toString(),
      grandTotal: json['GrandTotal'].toString(),
    );
  }
}
