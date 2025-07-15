class Table10InvoiceHotelfareBreakdownListModel {
  String fareBreakdownID;
  String fbBookFlightId;
  String balanceDueDate;
  String inputTax;
  String outputTax;
  String totalSales;
  String totalNett;
  String totalProfit;
  String currency;
  String balanceDueDt;

  Table10InvoiceHotelfareBreakdownListModel({
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

  factory Table10InvoiceHotelfareBreakdownListModel.fromJson(
      Map<String, dynamic> json) {
    return Table10InvoiceHotelfareBreakdownListModel(
      fareBreakdownID: json['FareBreakdowID'].toString(),
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
