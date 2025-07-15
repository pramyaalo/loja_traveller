class AutofilHotelModel {
  final String latinFullName;
  final String regionId;
  final String countryCode;
  final String category;
  final String className;
  final String searchType;

  AutofilHotelModel({
    required this.latinFullName,
    required this.regionId,
    required this.countryCode,
    required this.category,
    required this.className,
    required this.searchType,
  });
  factory AutofilHotelModel.fromJson(Map<String, dynamic> json) {
    return AutofilHotelModel(
      latinFullName: json['latinFullName'] ?? '',
      regionId: json['regionid'] ?? '',
      countryCode: json['CountryCode'] ?? '',
      category: json['category'] ?? '',
      className: json['class_Name'] ?? '',
      searchType: json['search_type'] ?? '',
    );
  }
}
