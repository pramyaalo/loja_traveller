class table7FlightRemittanceModel {
  final String passenger;
  final String bookingId;
  final String name;
  final String totalNett;
  final String tfsDepDatedt;
  final String tfsArrDatedt;
  final String tripType;

  table7FlightRemittanceModel({
    required this.passenger,
    required this.bookingId,
    required this.name,
    required this.totalNett,
    required this.tfsDepDatedt,
    required this.tfsArrDatedt,
    required this.tripType,
  });

  factory table7FlightRemittanceModel.fromJson(Map<String, dynamic> json) {
    return table7FlightRemittanceModel(
      passenger: json['Passenger'].toString(),
      bookingId: json['BookingId'].toString(),
      name: json['Name'].toString(),
      totalNett: json['TotalNett'].toString(),
      tfsDepDatedt: json['TFSDepDatedt'].toString(),
      tfsArrDatedt: json['TFSArrDatedt'].toString(),
      tripType: json['TripType'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Passenger': passenger,
      'BookingId': bookingId,
      'Name': name,
      'TotalNett': totalNett,
      'TFSDepDatedt': tfsDepDatedt,
      'TFSArrDatedt': tfsArrDatedt,
      'TripType': tripType,
    };
  }
}
