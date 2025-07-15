class ViewholidayDestinationModel {
  final String id;
  final String userTypeId;
  final String userId;
  final String holidayCityId;
  final String holidayCityName;
  final String markupTypeId;
  final String markupType;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String userType;
  final String currency;
  final String fullName;

  ViewholidayDestinationModel({
    required this.id,
    required this.userTypeId,
    required this.userId,
    required this.holidayCityId,
    required this.holidayCityName,
    required this.markupTypeId,
    required this.markupType,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.userType,
    required this.currency,
    required this.fullName,
  });

  factory ViewholidayDestinationModel.fromJson(Map<String, dynamic> json) {
    return ViewholidayDestinationModel(
      id: json["Id"].toString(),
      userTypeId: json["UserTypeId"].toString(),
      userId: json["UserId"].toString(),
      holidayCityId: json["HolidayCityId"].toString(),
      holidayCityName: json["HolidayCityName"].toString(),
      markupTypeId: json["MarkupTypeId"].toString(),
      markupType: json["MarkupType"].toString(),
      markupValue: json["MarkupValue"].toString(),
      status: json["Status"].toString(),
      dateCreated: json["datecreated"].toString(),
      userType: json["UserType"].toString(),
      currency: json["Currency"].toString(),
      fullName: json["FullName"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "UserTypeId": userTypeId,
      "UserId": userId,
      "HolidayCityId": holidayCityId,
      "HolidayCityName": holidayCityName,
      "MarkupTypeId": markupTypeId,
      "MarkupType": markupType,
      "MarkupValue": markupValue,
      "Status": status,
      "datecreated": dateCreated,
      "UserType": userType,
      "Currency": currency,
      "FullName": fullName,
    };
  }
}
