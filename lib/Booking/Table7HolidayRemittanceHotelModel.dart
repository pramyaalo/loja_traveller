class Table7HolidayRemittanceHotelModel {
  final String passenger;
  final String bookingNumber;
  final String name;
  final String totalNett;
  final String checkOutDtt;

  Table7HolidayRemittanceHotelModel({
    required this.passenger,
    required this.bookingNumber,
    required this.name,
    required this.totalNett,
    required this.checkOutDtt,
  });

  factory Table7HolidayRemittanceHotelModel.fromJson(Map<String, dynamic> json) {
    return Table7HolidayRemittanceHotelModel(
      passenger: json['Passenger'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      name: json['Name'].toString(),
      totalNett: json['TotalNett'].toString(),
      checkOutDtt: json['CheckOutDtt'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Passenger': passenger,
      'BookingNumber': bookingNumber,
      'Name': name,
      'TotalNett': totalNett,
      'CheckOutDtt': checkOutDtt,
    };
  }
}
