

class DestinationnameModel {
  final String destinationCode;
  final String destinationName;
  final String countryCode;

  DestinationnameModel({
    required this.destinationCode,
    required this.destinationName,
    required this.countryCode,
  });

  factory DestinationnameModel.fromJson(Map<String, dynamic> json) {
    return DestinationnameModel(
      destinationCode: json['destinationCode'].toString(),
      destinationName: json['destinationName'].toString(),
      countryCode: json['countryCode'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destinationCode': destinationCode,
      'destinationName': destinationName,
      'countryCode': countryCode,
    };
  }
}
