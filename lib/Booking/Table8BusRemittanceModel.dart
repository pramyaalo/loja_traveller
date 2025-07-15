class Table8BusRemittanceModel {
  final String passenger;
  final String bookingNumber;
  final String name;
  final String totalNett;
  final String destinationCityDate;

  Table8BusRemittanceModel({
    required this.passenger,
    required this.bookingNumber,
    required this.name,
    required this.totalNett,
    required this.destinationCityDate,
  });

  factory Table8BusRemittanceModel.fromJson(Map<String, dynamic> json) {
    return Table8BusRemittanceModel(
      passenger: json['Passenger'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      name: json['Name'].toString(),
      totalNett: json['TotalNett'].toString(),
      destinationCityDate: json['DestinationCityDate'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Passenger': passenger,
      'BookingNumber': bookingNumber,
      'Name': name,
      'TotalNett': totalNett,
      'DestinationCityDate': destinationCityDate,
    };
  }
}
