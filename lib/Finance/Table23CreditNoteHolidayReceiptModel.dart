class Table23CreditNoteHolidayReceiptModel {
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

  Table23CreditNoteHolidayReceiptModel({
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

  factory Table23CreditNoteHolidayReceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table23CreditNoteHolidayReceiptModel(
      fareBreakdownID: json['FareBreakdowID'].toString(),
      fbBookFlightId: json['FBBookFlightId'].toString(),
      balanceDueDate: json['BalanceDueDate'].toString(),
      inputTax: json['InputTax'].toString(),
      outputTax: json['OutputTax'].toString(),
      totalSales: json['TotalSales'].toString(),
      totalNett: json['TotalNett'].toString(),
      totalProfit: json['TotalProfit'].toString(),
      currency: json['Currency']
          .toString(), // If the value is null.toString(), you can provide a default value.
      balanceDueDt: json['BalanceDueDt'].toString(),
    );
  }
}
