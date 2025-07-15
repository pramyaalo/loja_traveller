class MarkupAirportNameModel {
  final String id;
  final String name;
  final String municipality;
  final String isoCountry;

  MarkupAirportNameModel({
    required this.id,
    required this.name,
    required this.municipality,
    required this.isoCountry,
  });

  factory MarkupAirportNameModel.fromJson(Map<String, dynamic> json) {
    return MarkupAirportNameModel(
      id: json['Id'].toString(),
      name: json['Name'].toString(),
      municipality: json['municipality'].toString(),
      isoCountry: json['iso_country'].toString(),
    );
  }
}

