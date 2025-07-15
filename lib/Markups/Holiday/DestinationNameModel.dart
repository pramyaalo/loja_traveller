class DestinationNameModel {
  final String countryCode;
  final String country;
  final String latinFullName;
  final String fullName;
  final String city;
  final String locationId;

  DestinationNameModel({
    required this.countryCode,
    required this.country,
    required this.latinFullName,
    required this.fullName,
    required this.city,
    required this.locationId,
  });

  factory DestinationNameModel.fromJson(Map<String, dynamic> json) {
    return DestinationNameModel(
      countryCode: json['countryCode'].toString(),
      country: json['country'].toString(),
      latinFullName: json['latinFullName'].toString(),
      fullName: json['fullname'].toString(),
      city: json['city'].toString(),
      locationId: json['locationId'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "countryCode": countryCode,
      "country": country,
      "latinFullName": latinFullName,
      "fullname": fullName,
      "city": city,
      "locationId": locationId,
    };
  }
}
