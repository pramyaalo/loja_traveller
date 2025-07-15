class Table50InvoiceFlightReceiptModel {
  String name;
  String outputTax;
  String inputTax;
  String totalSales;
  String totalNett;

  Table50InvoiceFlightReceiptModel({
    required this.name,
    required this.outputTax,
    required this.inputTax,
    required this.totalSales,
    required this.totalNett,
  });

  factory Table50InvoiceFlightReceiptModel.fromJson(Map<String, dynamic> json) {
    return Table50InvoiceFlightReceiptModel(
      name: json['Name'].toString(),
      outputTax: json['OutputTax'].toString(),
      inputTax: json['InputTax'].toString(),
      totalSales: json['TotalSales'].toString(),
      totalNett: json['TotalNett'].toString(),
    );
  }
}
