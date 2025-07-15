class FareBreakdownModel {
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
  final String totalFare;
  final String gstPercent;
  final String gstAmount;
  final String serviceTaxPercent;
  final String serviceTaxAmount;
  final String discountAmount;
  final String grandTotal;
  final String grandTotal1;

  FareBreakdownModel({
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
    required this.totalFare,
    required this.gstPercent,
    required this.gstAmount,
    required this.serviceTaxPercent,
    required this.serviceTaxAmount,
    required this.discountAmount,
    required this.grandTotal,
    required this.grandTotal1,
  });

  factory FareBreakdownModel.fromJson(Map<String, dynamic> json) {
    return FareBreakdownModel(
      fareBreakdowID: json['FareBreakdowID'].toString(),
      fbBookFlightId: json['FBBookFlightId'].toString(),
      balanceDueDate: json['BalanceDueDate'].toString(),
      inputTax: json['InputTax'].toString(),
      outputTax: json['OutputTax'].toString(),
      totalSales: json['TotalSales'] .toString(),
      totalNett: json['TotalNett'] .toString(),
      totalProfit: json['TotalProfit'] .toString(),
      currency: json['Currency'].toString(),
      balanceDueDt: json['BalanceDueDt'].toString(),
      baseFare: json['BaseFare'] .toString(),
      totalFare: json['TotalFare'].toString(),
      gstPercent: json['GSTPercent'] .toString(),
      gstAmount: json['GSTAmount'].toString(),
      serviceTaxPercent: json['ServiceTaxPercent'].toString(),
      serviceTaxAmount: json['ServiceTaxAmount'] .toString(),
      discountAmount: json['DiscountAmount'] .toString(),
      grandTotal: json['GrandTotal'] .toString(),
      grandTotal1: json['GrandTotal1'] .toString(),
    );
  }


}

