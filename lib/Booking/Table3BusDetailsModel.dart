class   Table3BusDetailsModel {
  String busHeadId;
  String travelName;
  String busType;
  String originCityLocation;
  String destinationCityLocation;
  String originCityTime;
  String destinationCityTime;
  String originCityName;
  String destinationCityName;
  String originCityDate;
  String destinationCityDate;
  String availableSeats;

  Table3BusDetailsModel({
    required this.busHeadId,
    required this.travelName,
    required this.busType,
    required this.originCityLocation,
    required this.destinationCityLocation,
    required this.originCityTime,
    required this.destinationCityTime,
    required this.originCityName,
    required this.destinationCityName,
    required this.originCityDate,
    required this.destinationCityDate,
    required this.availableSeats,
  });

  factory Table3BusDetailsModel.fromJson(Map<String, dynamic> json) {
    return Table3BusDetailsModel(
      busHeadId: json['BusHeadID'].toString(),
      travelName: json['TravelName'].toString(),
      busType: json['Bustype'].toString(),
      originCityLocation: json['OriginCityLocation'].toString(),
      destinationCityLocation: json['DestinationCityLocation'].toString(),
      originCityTime: json['OriginCityTime'].toString(),
      destinationCityTime: json['DestinationCityTime'].toString(),
      originCityName: json['OriginCityName'].toString(),
      destinationCityName: json['DestinationCityName'].toString(),
      originCityDate: json['OriginCityDate'].toString(),
      destinationCityDate: json['DestinationCityDate'].toString(),
      availableSeats: json['AvailableSeats'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BusHeadID': busHeadId,
      'TravelName': travelName,
      'Bustype': busType,
      'OriginCityLocation': originCityLocation,
      'DestinationCityLocation': destinationCityLocation,
      'OriginCityTime': originCityTime,
      'DestinationCityTime': destinationCityTime,
      'OriginCityName': originCityName,
      'DestinationCityName': destinationCityName,
      'OriginCityDate': originCityDate,
      'DestinationCityDate': destinationCityDate,
      'AvailableSeats': availableSeats,
    };
  }
}
