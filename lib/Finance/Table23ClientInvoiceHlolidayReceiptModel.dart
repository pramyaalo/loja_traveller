class Table23ClientInvoiceHlolidayReceiptModel {
  String fareBreakdowID;
  String fbBookFlightId;
  String balanceDueDate;
  String inputTax;
  String outputTax;
  String totalSales;
  String totalNett;
  String totalProfit;
  String currency;
  String balanceDueDt;

  Table23ClientInvoiceHlolidayReceiptModel({
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
  });

  factory Table23ClientInvoiceHlolidayReceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table23ClientInvoiceHlolidayReceiptModel(
      fareBreakdowID: json['FareBreakdowID'].toString(),
      fbBookFlightId: json['FBBookFlightId'].toString(),
      balanceDueDate: json['BalanceDueDate'].toString(),
      inputTax: json['InputTax'].toString(),
      outputTax: json['OutputTax'].toString(),
      totalSales: json['TotalSales'].toString(),
      totalNett: json['TotalNett'].toString(),
      totalProfit: json['TotalProfit'].toString(),
      currency: json['Currency'].toString(),
      balanceDueDt: json['BalanceDueDt'].toString(),
    );
  }
}
