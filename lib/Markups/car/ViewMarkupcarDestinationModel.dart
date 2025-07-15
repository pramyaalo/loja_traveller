class ViewMarkupcarDestinationModel {
  final String id;
  final String userTypeId;
  final String userId;
  final String fromAirport;
  final String toAirport;
  final String fromAirportName;
  final String toAirportName;
  final String markupTypeId;
  final String markupType;
  final String currency;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String userType;
  final String fullName;

  ViewMarkupcarDestinationModel({
    required this.id,
    required this.userTypeId,
    required this.userId,
    required this.fromAirport,
    required this.toAirport,
    required this.fromAirportName,
    required this.toAirportName,
    required this.markupTypeId,
    required this.markupType,
    required this.currency,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.userType,
    required this.fullName,
  });

  factory ViewMarkupcarDestinationModel.fromJson(Map<String, dynamic> json) {
    return ViewMarkupcarDestinationModel(
      id: json["Id"].toString(),
      userTypeId: json["UserTypeId"].toString(),
      userId: json["UserId"].toString(),
      fromAirport: json["FromAirport"].toString(),
      toAirport: json["ToAirport"].toString(),
      fromAirportName: json["FromAirportName"].toString(),
      toAirportName: json["ToAirportName"].toString(),
      markupTypeId: json["MarkupTypeId"].toString(),
      markupType: json["MarkupType"] .toString(), // Handle null case if missing
      currency: json["Currency"].toString(),
      markupValue: json["MarkupValue"].toString(),
      status: json["Status"].toString(),
      dateCreated: json["datecreated"].toString(),
      userType: json["UserType"].toString(),
      fullName: json["FullName"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "UserTypeId": userTypeId,
      "UserId": userId,
      "FromAirport": fromAirport,
      "ToAirport": toAirport,
      "FromAirportName": fromAirportName,
      "ToAirportName": toAirportName,
      "MarkupTypeId": markupTypeId,
      "MarkupType": markupType,
      "Currency": currency,
      "MarkupValue": markupValue,
      "Status": status,
      "datecreated": dateCreated,
      "UserType": userType,
      "FullName": fullName,
    };
  }
}
