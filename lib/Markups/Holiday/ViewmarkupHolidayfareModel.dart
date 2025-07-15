class ViewmarkupHolidayfareModel {
  final String id;
  final String userTypeId;
  final String userId;
  final String fromFare;
  final String toFare;
  final String markupTypeId;
  final String markupType;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String userType;
  final String fullName;
  final String currency;

  ViewmarkupHolidayfareModel({
    required this.id,
    required this.userTypeId,
    required this.userId,
    required this.fromFare,
    required this.toFare,
    required this.markupTypeId,
    required this.markupType,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.userType,
    required this.fullName,
    required this.currency,
  });

  factory ViewmarkupHolidayfareModel.fromJson(Map<String, dynamic> json) {
    return ViewmarkupHolidayfareModel(
      id: json["Id"].toString(),
      userTypeId: json["UserTypeId"].toString(),
      userId: json["UserId"].toString(),
      fromFare: json["FromFare"].toString(),
      toFare: json["ToFare"].toString(),
      markupTypeId: json["MarkupTypeId"].toString(),
      markupType: json["MarkupType"].toString(),
      markupValue: json["MarkupValue"].toString().toString(), // Ensure string type
      status: json["Status"].toString(),
      dateCreated: json["datecreated"].toString(),
      userType: json["UserType"].toString(),
      fullName: json["FullName"].toString(),
      currency: json["Currency"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "UserTypeId": userTypeId,
      "UserId": userId,
      "FromFare": fromFare,
      "ToFare": toFare,
      "MarkupTypeId": markupTypeId,
      "MarkupType": markupType,
      "MarkupValue": markupValue,
      "Status": status,
      "datecreated": dateCreated,
      "UserType": userType,
      "FullName": fullName,
      "Currency": currency,
    };
  }
}
