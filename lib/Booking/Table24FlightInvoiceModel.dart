class Table24FlightInvoiceModel {
  String name;
  double inputTax;
  double outputTax;
  double totalSales;
  double totalNett;

  Table24FlightInvoiceModel({
    required this.name,
    required this.inputTax,
    required this.outputTax,
    required this.totalSales,
    required this.totalNett,
  });

  // Factory method to create an instance from JSON
  factory Table24FlightInvoiceModel.fromJson(Map<String, dynamic> json) {
    return Table24FlightInvoiceModel(
      name: json['Name'] ?? '',
      inputTax: (json['InputTax'] ?? 0).toDouble(),
      outputTax: (json['OutputTax'] ?? 0).toDouble(),
      totalSales: (json['TotalSales'] ?? 0).toDouble(),
      totalNett: (json['TotalNett'] ?? 0).toDouble(),
    );
  }

  // Convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'InputTax': inputTax,
      'OutputTax': outputTax,
      'TotalSales': totalSales,
      'TotalNett': totalNett,
    };
  }
}
