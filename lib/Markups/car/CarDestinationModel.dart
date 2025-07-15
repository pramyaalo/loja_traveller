class CarDestinationModel {
  final String id;
  final String name;
  final String municipality;
  final String isoCountry;

  CarDestinationModel({
    required this.id,
    required this.name,
    required this.municipality,
    required this.isoCountry,
  });

  factory CarDestinationModel.fromJson(Map<String, dynamic> json) {
    return CarDestinationModel(
      id: json["Id"].toString(),
      name: json["Name"].toString(),
      municipality: json["municipality"].toString(),
      isoCountry: json["iso_country"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "Name": name,
      "municipality": municipality,
      "iso_country": isoCountry,
    };
  }
}
