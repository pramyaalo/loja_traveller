class Table4HotelPaymentDetailsModel {
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
  String passenger;

  Table4HotelPaymentDetailsModel({
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
    required this.passenger,
  });

  factory Table4HotelPaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    return Table4HotelPaymentDetailsModel(
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
      passenger: json['Passenger'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
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
    'Passenger': passenger,
  };
}
