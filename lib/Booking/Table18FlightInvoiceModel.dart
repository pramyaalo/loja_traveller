class Table18FlightInvoiceModel {
  final String passenger;
  final String bookingId;
  final String tfsDepDate;
  final String name;
  final String grandTotal;

  Table18FlightInvoiceModel({
    required this.passenger,
    required this.bookingId,
    required this.tfsDepDate,
    required this.name,
    required this.grandTotal,
  });

  factory Table18FlightInvoiceModel.fromJson(Map<String, dynamic> json) {
    return Table18FlightInvoiceModel(
      passenger: json['Passenger'].toString(),
      bookingId: json['BookingId'].toString(),
      tfsDepDate: json['TFSDepDatedt'].toString(),
      name: json['Name'].toString(),
      grandTotal: json['GrandTotal'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Passenger': passenger,
      'BookingId': bookingId,
      'TFSDepDatedt': tfsDepDate,
      'Name': name,
      'GrandTotal': grandTotal,
    };
  }
}
