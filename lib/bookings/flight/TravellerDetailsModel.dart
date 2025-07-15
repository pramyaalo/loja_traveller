class TravellerDetailsModel {
  final int id;
  final String name;

  TravellerDetailsModel({required this.id, required this.name});

  factory TravellerDetailsModel.fromJson(Map<String, dynamic> json) {
    return TravellerDetailsModel(
      id: json['Id'] ?? 0,
      name: json['Name']?.trim() ?? '',
    );
  }

  @override
  String toString() => name;
}
