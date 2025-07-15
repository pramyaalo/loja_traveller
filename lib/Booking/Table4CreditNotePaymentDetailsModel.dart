
class Table4CreditNotePaymentDetailsModel {
  final String fareBreakdowID;
  final String fbBookFlightId;
  final String balanceDueDate; // If needed, convert to DateTime
  final String inputTax;
  final String outputTax;
  final String totalSales;
  final String totalNett;
  final String totalProfit;
  final String currency;
  final String balanceDueDt;
  final String passenger;
  final String name;

  Table4CreditNotePaymentDetailsModel({
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
    required this.name,
  });

  factory Table4CreditNotePaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    return Table4CreditNotePaymentDetailsModel(
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
      name: json['Name'].toString(),
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
      'Passenger': passenger,
      'Name': name,
    };
  }
}

