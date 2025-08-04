class TravellerDetailsModel {
  final String id;
  final String name;

  TravellerDetailsModel({
    required this.id,
    required this.name,
  });

  factory TravellerDetailsModel.fromJson(Map<String, dynamic> json) {
    return TravellerDetailsModel(
      id: json['Id'].toString(),
      name: json['Name'].toString(),
    );
  }
}
