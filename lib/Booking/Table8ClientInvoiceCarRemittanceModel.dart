class Table8ClientInvoiceCarRemittanceModel {
  final String passenger;
  final String bookingId;
  final String dropoffDate;
  final String name;
  final String totalNett;

  Table8ClientInvoiceCarRemittanceModel({
    required this.passenger,
    required this.bookingId,
    required this.dropoffDate,
    required this.name,
    required this.totalNett,
  });

  factory Table8ClientInvoiceCarRemittanceModel.fromJson(Map<String, dynamic> json) {
    return Table8ClientInvoiceCarRemittanceModel(
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

  @override
  String toString() {
    return 'Passenger: $passenger, BookingId: $bookingId, DropoffDate: $dropoffDate, Name: $name, TotalNett: $totalNett';
  }
}
