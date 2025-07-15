class Table4HotelPaymentModel {
  final String fareBreakdowID;
  final String fbBookFlightId;
  final String balanceDueDate;
  final String inputTax;
  final String outputTax;
  final String totalSales;
  final String totalNett;
  final String totalProfit;
  final String currency;
  final String balanceDueDt;
  final String baseFare;
  final String gstAmount;
  final String serviceTaxAmount;
  final String gstPercent;
  final String serviceTaxPercent;
  final String discountAmount;
  final String grandTotal;
  final String grandTotal1;

  Table4HotelPaymentModel({
    required this.fareBreakdowID,
    required this.fbBookFlightId,
    required this.balanceDueDate,
    required this.inputTax,
    required this.outputTax,
    required this.totalSales,
    required this.totalNett,
    required this.totalProfit,
    required this.currency,
    required this.balanceDueDt,
    required this.baseFare,
    required this.gstAmount,
    required this.serviceTaxAmount,
    required this.gstPercent,
    required this.serviceTaxPercent,
    required this.discountAmount,
    required this.grandTotal,
    required this.grandTotal1,
  });

  factory Table4HotelPaymentModel.fromJson(Map<String, dynamic> json) {
    return Table4HotelPaymentModel(
      fareBreakdowID: json['FareBreakdowID'].toString(),
      fbBookFlightId: json['FBBookFlightId'].toString(),
      balanceDueDate: json['BalanceDueDate'].toString(),
      inputTax: json['InputTax'].toString(),
      outputTax: json['OutputTax'].toString(),
      totalSales: json['TotalSales'].toString(),
      totalNett: json['TotalNett'] .toString(),
      totalProfit: json['TotalProfit'].toString(),
      currency: json['Currency'].toString(),
      balanceDueDt: json['BalanceDueDt'].toString(),
      baseFare: json['BaseFare'].toString(),
      gstAmount: json['GSTAmount'].toString(),
      serviceTaxAmount: json['ServiceTaxAmount'].toString(),
      gstPercent: json['GSTPercent'].toString(),
      serviceTaxPercent: json['ServiceTaxPercent'].toString(),
      discountAmount: json['DiscountAmount'].toString(),
      grandTotal: json['GrandTotal'] .toString(),
      grandTotal1: json['GrandTotal1'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FareBreakdowID': fareBreakdowID,
      'FBBookFlightId': fbBookFlightId,
      'BalanceDueDate': balanceDueDate,
      'InputTax': inputTax,
      'OutputTax': outputTax,
      'TotalSales': totalSales,
      'TotalNett': totalNett,
      'TotalProfit': totalProfit,
      'Currency': currency,
      'BalanceDueDt': balanceDueDt,
      'BaseFare': baseFare,
      'GSTAmount': gstAmount,
      'ServiceTaxAmount': serviceTaxAmount,
      'GSTPercent': gstPercent,
      'ServiceTaxPercent': serviceTaxPercent,
      'DiscountAmount': discountAmount,
      'GrandTotal': grandTotal,
      'GrandTotal1': grandTotal1,
    };
  }
}
