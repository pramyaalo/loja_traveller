

class Table10HotelInvoiceTotalModel {
  final String totalFare;
  final String gstPercent;
  final String currency;
  final String gstAmount;
  final String serviceTaxPercent;
  final String serviceTaxAmount;
  final String grandTotal;

  Table10HotelInvoiceTotalModel({
    required this.totalFare,
    required this.gstPercent,
    required this.currency,
    required this.gstAmount,
    required this.serviceTaxPercent,
    required this.serviceTaxAmount,
    required this.grandTotal,
  });

  factory Table10HotelInvoiceTotalModel.fromJson(Map<String, dynamic> json) {
    return Table10HotelInvoiceTotalModel(
      totalFare: json['TotalFare'].toString(),
      gstPercent: json['GSTPercent'].toString(),
      currency: json['Currency'],
      gstAmount: json['GSTAmount'].toString(),
      serviceTaxPercent: json['ServiceTaxPercent'].toString(),
      serviceTaxAmount: json['ServiceTaxAmount'].toString(),
      grandTotal: json['GrandTotal'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TotalFare': totalFare,
      'GSTPercent': gstPercent,
      'Currency': currency,
      'GSTAmount': gstAmount,
      'ServiceTaxPercent': serviceTaxPercent,
      'ServiceTaxAmount': serviceTaxAmount,
      'GrandTotal': grandTotal,
    };
  }
}

