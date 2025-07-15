class Table5HotelReceiptPaymentDetailsModel {
  final String fareBreakdownId;
  final String fbBookFlightId;
  final String balanceDueDate;
  final String inputTax;
  final String outputTax;
  final String totalSales;
  final String totalNett;
  final String totalProfit;
  final String currency;
  final String balanceDueDt;
  final String currency1;
  final String defaultCurrency;
  final String inputTax1;
  final String outputTax1;
  final String totalSales1;
  final String totalNett1;
  final String totalReceivedAmount;
  final String passenger;

  Table5HotelReceiptPaymentDetailsModel({
    required this.fareBreakdownId,
    required this.fbBookFlightId,
    required this.balanceDueDate,
    required this.inputTax,
    required this.outputTax,
    required this.totalSales,
    required this.totalNett,
    required this.totalProfit,
    required this.currency,
    required this.balanceDueDt,
    required this.currency1,
    required this.defaultCurrency,
    required this.inputTax1,
    required this.outputTax1,
    required this.totalSales1,
    required this.totalNett1,
    required this.totalReceivedAmount,
    required this.passenger,
  });

  factory Table5HotelReceiptPaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    return Table5HotelReceiptPaymentDetailsModel(
      fareBreakdownId: json['FareBreakdowID'].toString(),
      fbBookFlightId: json['FBBookFlightId'].toString(),
      balanceDueDate: json['BalanceDueDate'].toString(),
      inputTax: json['InputTax'].toString(),
      outputTax: json['OutputTax'].toString(),
      totalSales: json['TotalSales'].toString(),
      totalNett: json['TotalNett'].toString(),
      totalProfit: json['TotalProfit'].toString(),
      currency: json['Currency'].toString(),
      balanceDueDt: json['BalanceDueDt'].toString(),
      currency1: json['Currency1'].toString(),
      defaultCurrency: json['DefaultCurrency'].toString(),
      inputTax1: json['InputTax1'].toString(),
      outputTax1: json['OutputTax1'].toString(),
      totalSales1: json['TotalSales1'].toString(),
      totalNett1: json['TotalNett1'].toString(),
      totalReceivedAmount: json['TotalReceivedAmount'].toString(),
      passenger: json['Passenger'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FareBreakdowID': fareBreakdownId,
      'FBBookFlightId': fbBookFlightId,
      'BalanceDueDate': balanceDueDate,
      'InputTax': inputTax,
      'OutputTax': outputTax,
      'TotalSales': totalSales,
      'TotalNett': totalNett,
      'TotalProfit': totalProfit,
      'Currency': currency,
      'BalanceDueDt': balanceDueDt,
      'Currency1': currency1,
      'DefaultCurrency': defaultCurrency,
      'InputTax1': inputTax1,
      'OutputTax1': outputTax1,
      'TotalSales1': totalSales1,
      'TotalNett1': totalNett1,
      'TotalReceivedAmount': totalReceivedAmount,
      'Passenger': passenger,
    };
  }
}
