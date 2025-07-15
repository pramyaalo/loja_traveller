class Table2BusDetailModel {
  final String busHeadID;
  final String travelName;
  final String busType;
  final String originCityLocation;
  final String destinationCityLocation;
  final String originCityTime;
  final String destinationCityTime;
  final String ticketCode;
  final String originCityDate;
  final String destinationCityDate;
  final String availableSeats;

  Table2BusDetailModel({
    required this.busHeadID,
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

  factory Table2BusDetailModel.fromJson(Map<String, dynamic> json) {
    return Table2BusDetailModel(
      busHeadID: json['BusHeadID'].toString(),
      travelName: json['TravelName'] .toString(),
      busType: json['Bustype'] .toString(),
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
