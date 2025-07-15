class MarkupAIrlineNameModel {
  final String id;
  final String name;
  final String Airlinetype;

  MarkupAIrlineNameModel({
    required this.id,
    required this.name,
    required this.Airlinetype,
  });

  factory MarkupAIrlineNameModel.fromJson(Map<String, dynamic> json) {
    return MarkupAIrlineNameModel(
      id: json['Id'].toString(),
      name: json['Name'].toString(),
      Airlinetype: json['AirlineType'].toString(),
    );
  }
}

