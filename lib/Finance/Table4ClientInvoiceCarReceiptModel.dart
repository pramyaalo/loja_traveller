class Table4ClientInvoiceCarReceiptModel {
  final String fareBreakdownID;
  final String fbBookFlightId;
  final String balanceDueDate;
  final String inputTax;
  final String outputTax;
  final String totalSales;
  final String totalNett;
  final String totalProfit;
  final String currency;
  final String balanceDueDt;

  Table4ClientInvoiceCarReceiptModel({
    required this.fareBreakdownID,
    required this.fbBookFlightId,
    required this.balanceDueDate,
    required this.inputTax,
    required this.outputTax,
    required this.totalSales,
    required this.totalNett,
    required this.totalProfit,
    required this.currency,
    required this.balanceDueDt,
  });

  // Factory constructor to create a FareBreakdown object from JSON
  factory Table4ClientInvoiceCarReceiptModel.fromJson(Map<String, dynamic> json) {
    return Table4ClientInvoiceCarReceiptModel(
      fareBreakdownID: json["FareBreakdowID"].toString(),
      fbBookFlightId: json["FBBookFlightId"].toString(),
      balanceDueDate:json["BalanceDueDate"].toString(),
      inputTax: json["InputTax"].toString(),
      outputTax: json["OutputTax"].toString(),
      totalSales: json["TotalSales"].toString(),
      totalNett: json["TotalNett"] .toString(),
      totalProfit: json["TotalProfit"].toString(),
      currency: json["Currency"].toString(),
      balanceDueDt: json["BalanceDueDt"].toString(),
    );
  }


}
