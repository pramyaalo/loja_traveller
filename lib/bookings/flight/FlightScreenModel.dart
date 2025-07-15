class FlightScreenModel {
  final String id;
  final String name;
  final String municipality;
  final String iso_country;

  FlightScreenModel(
      {required this.id,
      required this.name,
      required this.municipality,
      required this.iso_country});

  factory FlightScreenModel.fromJson(Map<String, dynamic> json) {
    return FlightScreenModel(
      id: json['Id'] ?? '',
      name: json['Name'] ?? '',
      municipality: json['municipality'] ?? '',
      iso_country: json['iso_country'] ?? '',
    );
  }
}
