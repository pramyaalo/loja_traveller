class Table13FlightInvoiceModel {
  final String Name;
  final String inputTax;
  final String Currency;
  final String outputTax;
  final String totalSales;
  final String totalNett;

  Table13FlightInvoiceModel({
    required this.Name,
    required this.Currency,
    required this.inputTax,
    required this.outputTax,
    required this.totalSales,
    required this.totalNett,
  });

  factory Table13FlightInvoiceModel.fromJson(Map<String, dynamic> json) {
    return Table13FlightInvoiceModel(
      Name:json['Name'].toString(),
        Currency:json["Currency"].toString(),
      inputTax: json['InputTax'].toString(),
      outputTax: json['OutputTax'].toString(),
      totalSales: json['TotalSales'].toString(),
      totalNett: json['TotalNett'].toString(),
    );
  }


}


