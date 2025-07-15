class ViewMarkupHotelDestinationModel {
  final String id;
  final String userTypeId;
  final String userId;
  final String hotelCityId;
  final String hotelCityName;
  final String markupTypeId;
  final String markupType;
  final String currency;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String userType;
  final String fullName;

  ViewMarkupHotelDestinationModel({
    required this.id,
    required this.userTypeId,
    required this.userId,
    required this.hotelCityId,
    required this.hotelCityName,
    required this.markupTypeId,
    required this.markupType,
    required this.currency,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.userType,
    required this.fullName,
  });

  factory ViewMarkupHotelDestinationModel.fromJson(Map<String, dynamic> json) {
    return ViewMarkupHotelDestinationModel(
      id: json['Id'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      hotelCityId: json['HotelCityId'] .toString(),
      hotelCityName: json['HotelCityName'] .toString(),
      markupTypeId: json['MarkupTypeId'].toString(),
      markupType: json['MarkupType'] .toString(),
      currency: json['Currency'] .toString(),
      markupValue: json['MarkupValue'] .toString(),
      status: json['Status'].toString(),
      dateCreated: json['datecreated'] .toString(),
      userType: json['UserType'] .toString(),
      fullName: json['FullName'] .toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserTypeId': userTypeId,
      'UserId': userId,
      'HotelCityId': hotelCityId,
      'HotelCityName': hotelCityName,
      'MarkupTypeId': markupTypeId,
      'MarkupType': markupType,
      'Currency': currency,
      'MarkupValue': markupValue,
      'Status': status,
      'datecreated': dateCreated,
      'UserType': userType,
      'FullName': fullName,
    };
  }
}
