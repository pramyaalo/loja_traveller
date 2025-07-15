class Tablr8InvoiceListCarReceiptModel {
  final String passenger;
  final String bookingId;
  final String dropoffDate;
  final String name;
  final String totalNett;

  Tablr8InvoiceListCarReceiptModel({
    required this.passenger,
    required this.bookingId,
    required this.dropoffDate,
    required this.name,
    required this.totalNett,
  });

  factory Tablr8InvoiceListCarReceiptModel.fromJson(Map<String, dynamic> json) {
    return Tablr8InvoiceListCarReceiptModel(
      passenger: json['Passenger'].toString(),
      bookingId: json['BookingId'].toString(),
      dropoffDate: json['DropoffDate'].toString(),
      name: json['Name'].toString(),
      totalNett: json['TotalNett'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Passenger': passenger,
      'BookingId': bookingId,
      'DropoffDate': dropoffDate,
      'Name': name,
      'TotalNett': totalNett,
    };
  }
}
