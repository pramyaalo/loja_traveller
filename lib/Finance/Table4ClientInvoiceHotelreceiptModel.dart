class Table4ClientInvoiceHotelreceiptModel {
  final String fareBreakdownID;
  final String fbBookFlightId;
  final String balanceDueDate;
  final String inputTax;
  final String outputTax;
  final String totalSales;
  final String totalNett;
  final String totalProfit;
  final String defaultCurrency;
  final String currency;
  final String balanceDueDt;

  Table4ClientInvoiceHotelreceiptModel({
    required this.fareBreakdownID,
    required this.fbBookFlightId,
    required this.balanceDueDate,
    required this.inputTax,
    required this.outputTax,
    required this.totalSales,
    required this.totalNett,
    required this.totalProfit,
    required  this.defaultCurrency,
    required this.currency,
    required this.balanceDueDt,
  });

  // Factory method to create an object from JSON
  factory Table4ClientInvoiceHotelreceiptModel.fromJson(Map<String, dynamic> json) {
    return Table4ClientInvoiceHotelreceiptModel(
      fareBreakdownID: json["FareBreakdowID"].toString(),
      fbBookFlightId: json["FBBookFlightId"].toString(),
      balanceDueDate: json["BalanceDueDate"].toString(),
      inputTax: json["InputTax"].toString(),
      outputTax: json["OutputTax"].toString(),
      totalSales: json["TotalSales"].toString(),
      totalNett: json["TotalNett"].toString(),
      totalProfit: json["TotalProfit"].toString(),
      defaultCurrency: json["DefaultCurrency"].toString(),
      currency: json["Currency"].toString(),
      balanceDueDt: json["BalanceDueDt"].toString(),
    );
  }

  // Method to convert an object to JSON
  Map<String, dynamic> toJson() {
    return {
      "FareBreakdowID": fareBreakdownID,
      "FBBookFlightId": fbBookFlightId,
      "BalanceDueDate": balanceDueDate,
      "InputTax": inputTax,
      "OutputTax": outputTax,
      "TotalSales": totalSales,
      "TotalNett": totalNett,
      "TotalProfit": totalProfit,
      "DefaultCurrency": defaultCurrency,
      "Currency": currency,
      "BalanceDueDt": balanceDueDt,
    };
  }
}
