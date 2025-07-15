class Table50ClientInvoiceFlightReceiptModel {
  String name;
  String outputTax;
  String inputTax;
  String totalSales;
  String totalNett;

  Table50ClientInvoiceFlightReceiptModel({
    required this.name,
    required this.outputTax,
    required this.inputTax,
    required this.totalSales,
    required this.totalNett,
  });

  factory Table50ClientInvoiceFlightReceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table50ClientInvoiceFlightReceiptModel(
      name: json['Name'].toString(),
      outputTax: json['OutputTax'].toString(),
      inputTax: json['InputTax'].toString(),
      totalSales: json['TotalSales'].toString(),
      totalNett: json['TotalNett'].toString(),
    );
  }
}
