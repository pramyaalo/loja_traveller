class Table50CreditMoteFlightReceiptModel {
  String name;
  String outputTax;
  String inputTax;
  String totalSales;
  String totalNett;

  Table50CreditMoteFlightReceiptModel({
    required this.name,
    required this.outputTax,
    required this.inputTax,
    required this.totalSales,
    required this.totalNett,
  });

  factory Table50CreditMoteFlightReceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table50CreditMoteFlightReceiptModel(
      name: json['Name'].toString(),
      outputTax: json['OutputTax'].toString(),
      inputTax: json['InputTax'].toString(),
      totalSales: json['TotalSales'].toString(),
      totalNett: json['TotalNett'].toString(),
    );
  }
}
