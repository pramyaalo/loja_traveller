class Table12hotelRemitanceModeldub {
  final String passenger;
  final String bookingNumber;
  final String checkOutDt;
  final String name;
  final String grandTotal;

  Table12hotelRemitanceModeldub({
    required this.passenger,
    required this.bookingNumber,
    required this.checkOutDt,
    required this.name,
    required this.grandTotal,
  });

  factory Table12hotelRemitanceModeldub.fromJson(Map<String, dynamic> json) {
    return Table12hotelRemitanceModeldub(
      passenger: json['Passenger'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      checkOutDt: json['CheckOutDt'].toString(),
      name: json['Name'].toString(),
      grandTotal: json['GrandTotal'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Passenger': passenger,
      'BookingNumber': bookingNumber,
      'CheckOutDt': checkOutDt,
      'Name': name,
      'GrandTotal': grandTotal,
    };
  }
}
