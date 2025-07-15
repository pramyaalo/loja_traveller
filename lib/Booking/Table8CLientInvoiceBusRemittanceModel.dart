class Table8CLientInvoiceBusRemittanceModel {
  final String passenger;
  final String bookingId;
  final String dropoffDate;
  final String name;
  final String totalNett;

  Table8CLientInvoiceBusRemittanceModel({
    required this.passenger,
    required this.bookingId,
    required this.dropoffDate,
    required this.name,
    required this.totalNett,
  });

  factory Table8CLientInvoiceBusRemittanceModel.fromJson(Map<String, dynamic> json) {
    return Table8CLientInvoiceBusRemittanceModel(
      passenger: json['Passenger'].toString(),
      bookingId: json['BookingNumber'].toString(),
      dropoffDate: json['DestinationCityDate'].toString(),
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
