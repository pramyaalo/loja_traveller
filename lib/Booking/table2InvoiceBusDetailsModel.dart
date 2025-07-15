class table2InvoiceBusDetailsModel {
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

  table2InvoiceBusDetailsModel({
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

  factory table2InvoiceBusDetailsModel.fromJson(Map<String, dynamic> json) {
    return table2InvoiceBusDetailsModel(
      busHeadID: json['BusHeadID'].toString(),
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

  Map<String, dynamic> toJson() {
    return {
      'BusHeadID': busHeadID,
      'TravelName': travelName,
      'Bustype': busType,
      'OriginCityLocation': originCityLocation,
      'DestinationCityLocation': destinationCityLocation,
      'OriginCityTime': originCityTime,
      'DestinationCityTime': destinationCityTime,
      'TicketCode': ticketCode,
      'OriginCityDate': originCityDate,
      'DestinationCityDate': destinationCityDate,
      'AvailableSeats': availableSeats,
    };
  }
}
