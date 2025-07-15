class BusDestinationModel {
  final String cityName;
  final String category;
  final String searchType;
  final String cityId;

  BusDestinationModel({
    required this.cityName,
    required this.category,
    required this.searchType,
    required this.cityId,
  });

  factory BusDestinationModel.fromJson(Map<String, dynamic> json) {
    return BusDestinationModel(
      cityName: json['CityName'].toString(),
      category: json['category'].toString(),
      searchType: json['search_type'].toString(),
      cityId: json['CityId'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "CityName": cityName,
      "category": category,
      "search_type": searchType,
      "CityId": cityId,
    };
  }
}
