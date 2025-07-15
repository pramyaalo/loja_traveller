class AutoFillHolidayModel {
  final String countryCode;
  final String country;
  final String latinFullName;
  final String fullName;
  final String city;
  final String locationId;

  AutoFillHolidayModel({
    required this.countryCode,
    required this.country,
    required this.latinFullName,
    required this.fullName,
    required this.city,
    required this.locationId,
  });

  factory AutoFillHolidayModel.fromJson(Map<String, dynamic> json) {
    return AutoFillHolidayModel(
      countryCode: json['countryCode'],
      country: json['country'],
      latinFullName: json['latinFullName'],
      fullName: json['fullname'],
      city: json['city'],
      locationId: json['locationId'],
    );
  }
}
