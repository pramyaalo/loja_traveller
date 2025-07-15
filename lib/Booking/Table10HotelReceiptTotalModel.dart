class Table10HotelReceiptTotalModel {
  final String totalFare;
  final String gstPercent;
  final String gstAmount;
  final String serviceTaxPercent;
  final String serviceTaxAmount;
  final String grandTotal;
  final String Currency;

  Table10HotelReceiptTotalModel({
    required this.totalFare,
    required this.gstPercent,
    required this.gstAmount,
    required this.serviceTaxPercent,
    required this.serviceTaxAmount,
    required this.grandTotal,
    required this.Currency,
  });

  factory Table10HotelReceiptTotalModel.fromJson(Map<String, dynamic> json) {
    return Table10HotelReceiptTotalModel(
      totalFare: json['TotalFare'].toString(),
      gstPercent: json['GSTPercent'].toString(),
      gstAmount: json['GSTAmount'].toString(),
      serviceTaxPercent: json['ServiceTaxPercent'].toString(),
      serviceTaxAmount: json['ServiceTaxAmount'].toString(),
      grandTotal: json['GrandTotal'].toString(),
        Currency:json['Currency'].toString(),
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

  @override
  String toString() {
    return 'TotalFare: $totalFare, GSTPercent: $gstPercent, GSTAmount: $gstAmount, ServiceTaxPercent: $serviceTaxPercent, ServiceTaxAmount: $serviceTaxAmount, GrandTotal: $grandTotal';
  }
}
