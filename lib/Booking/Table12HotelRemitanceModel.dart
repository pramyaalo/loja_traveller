class Table12HotelRemitanceModel {
  final String passenger;
  final String bookingNumber;
  final String checkOutDt;
  final String name;
  final String grandTotal;

  Table12HotelRemitanceModel({
    required this.passenger,
    required this.bookingNumber,
    required this.checkOutDt,
    required this.name,
    required this.grandTotal,
  });

  factory Table12HotelRemitanceModel.fromJson(Map<String, dynamic> json) {
    return Table12HotelRemitanceModel(
      passenger: json['Passenger'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      checkOutDt: json['CheckOutDtt'].toString(),
      name: json['Name'].toString(),
      grandTotal: json['TotalNett'].toString(),
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
