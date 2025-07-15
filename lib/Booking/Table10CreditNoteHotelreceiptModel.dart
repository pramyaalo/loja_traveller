class Table10CreditNoteHotelreceiptModel {
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

  Table10CreditNoteHotelreceiptModel({
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

  factory Table10CreditNoteHotelreceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table10CreditNoteHotelreceiptModel(
      fareBreakdownID: json['FareBreakdowID'].toString(),
      fbBookFlightId: json['FBBookFlightId'].toString(),
      balanceDueDate: json['BalanceDueDate'].toString(),
      inputTax: json['InputTax'].toDouble().toString(),
      outputTax: json['OutputTax'].toDouble().toString(),
      totalSales: json['TotalSales'].toDouble().toString(),
      totalNett: json['TotalNett'].toDouble().toString(),
      totalProfit: json['TotalProfit'].toDouble().toString(),
      currency: json['Currency'].toString(),
      balanceDueDt: json['BalanceDueDt'].toString(),
    );
  }
}
