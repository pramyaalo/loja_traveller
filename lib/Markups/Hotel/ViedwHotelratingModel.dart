class ViedwHotelratingModel {
  final String id;
  final String userTypeId;
  final String userId;
  final String hotelRating;
  final String markupTypeId;
  final String markupType;
  final String currency;
  final String markupvValue;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String userType;
  final String fullName;

  ViedwHotelratingModel({
    required this.id,
    required this.userTypeId,
    required this.userId,
    required this.hotelRating,
    required this.markupTypeId,
    required this.markupType,
    required this.currency,
    required this.markupvValue,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.userType,
    required this.fullName,
  });

  factory ViedwHotelratingModel.fromJson(Map<String, dynamic> json) {
    return ViedwHotelratingModel(
      id: json['Id'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      hotelRating: json['HotelRating'].toString(),
      markupTypeId: json['MarkupTypeId'].toString(),
      markupType: json['MarkupType'].toString(),
      currency: json['Currency'].toString(),
      markupvValue: json['MarkupvValue'].toString(),
      markupValue: json['MarkupValue'].toString(),
      status: json['Status'].toString(),
      dateCreated: json['datecreated'].toString(),
      userType: json['UserType'].toString(),
      fullName: json['FullName'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserTypeId': userTypeId,
      'UserId': userId,
      'HotelRating': hotelRating,
      'MarkupTypeId': markupTypeId,
      'MarkupType': markupType,
      'Currency': currency,
      'MarkupvValue': markupvValue,
      'MarkupValue': markupValue,
      'Status': status,
      'datecreated': dateCreated,
      'UserType': userType,
      'FullName': fullName,
    };
  }
}
