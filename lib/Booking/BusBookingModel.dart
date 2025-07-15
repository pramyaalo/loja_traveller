class BusBookingModel {
  final String busHeadID;
  final String travelName;
  final String busType;
  final String originCityLocation;
  final String destinationCityLocation;
  final String originCityTime;
  final String destinationCityTime;
  final String originCityDate;
  final String destinationCityDate;
  final String availableSeats;
  final String Nos;
  final String TotalAmount;

  BusBookingModel({
    required this.busHeadID,
    required this.travelName,
    required this.busType,
    required this.originCityLocation,
    required this.destinationCityLocation,
    required this.originCityTime,
    required this.destinationCityTime,
    required this.originCityDate,
    required this.destinationCityDate,
    required this.availableSeats,
    required this.Nos,
    required this.TotalAmount,
  });

  factory BusBookingModel.fromJson(Map<String, dynamic> json) {
    return BusBookingModel(
      busHeadID: json['BusHeadID'].toString(),
      travelName: json['TravelName'].toString(),
      busType: json['Bustype'].toString(),
      originCityLocation: json['OriginCityLocation'].toString(),
      destinationCityLocation: json['DestinationCityLocation'].toString(),
      originCityTime: json['OriginCityTime'].toString(),
      destinationCityTime:json['DestinationCityTime'].toString(),
      originCityDate: json['OriginCityDate'].toString(),
      destinationCityDate: json['DestinationCityDate'].toString(),
      availableSeats: json['AvailableSeats'].toString(),
      Nos:json['Nos'].toString(),
      TotalAmount:json['TotalAmount'].toString(),
    );
  }

}

