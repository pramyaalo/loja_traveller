class Table24ClientInvoiceFlightReceiptModel {
  final String name;
  final String inputTax;
  final String outputTax;
  final String totalSales;
  final String totalNett;

  Table24ClientInvoiceFlightReceiptModel({
    required this.name,
    required this.inputTax,
    required this.outputTax,
    required this.totalSales,
    required this.totalNett,
  });

  // Factory method to create an object from JSON
  factory Table24ClientInvoiceFlightReceiptModel.fromJson(Map<String, dynamic> json) {
    return Table24ClientInvoiceFlightReceiptModel(
      name: json["Name"] .toString(),
      inputTax: json["InputTax"] .toString(),
      outputTax: json["OutputTax"] .toString(),
      totalSales: json["TotalSales"] .toString(),
      totalNett: json["TotalNett"] .toString(),
    );
  }

  // Method to convert an object to JSON
  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "InputTax": inputTax,
      "OutputTax": outputTax,
      "TotalSales": totalSales,
      "TotalNett": totalNett,
    };
  }
}
