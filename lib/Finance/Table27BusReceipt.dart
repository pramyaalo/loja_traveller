class Table27BusReceipt {
  String busHeadId;
  String travelName;
  String busType;
  String originCityLocation;
  String destinationCityLocation;
  String originCityTime;
  String destinationCityTime;
  String ticketCode;
  String originCityDate;
  String destinationCityDate;
  String availableSeats;

  Table27BusReceipt({
    required this.busHeadId,
    required this.travelName,
    required this.busType,
    required this.originCityLocation,
    required this.destinationCityLocation,
    required this.originCityTime,
    required this.destinationCityTime,
    required this.ticketCode,
    required this.originCityDate,
    required this.destinationCityDate,
    required this.availableSeats,
  });

  factory Table27BusReceipt.fromJson(Map<String, dynamic> json) {
    return Table27BusReceipt(
      busHeadId: json['BusHeadID'].toString(),
      travelName: json['TravelName'].toString(),
      busType: json['Bustype'].toString(),
      originCityLocation: json['OriginCityLocation'].toString(),
      destinationCityLocation: json['DestinationCityLocation'].toString(),
      originCityTime: json['OriginCityTime'].toString(),
      destinationCityTime: json['DestinationCityTime'].toString(),
      ticketCode: json['TicketCode'].toString(),
      originCityDate: json['OriginCityDate'].toString(),
      destinationCityDate: json['DestinationCityDate'].toString(),
      availableSeats: json['AvailableSeats'].toString(),
    );
  }
}
