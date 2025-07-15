
class ViewMarkupFlightDestinationModel {
  final String id;
  final String userTypeId;
  final String userId;
  final String fromAirport;
  final String toAirport;
  final String fromAirportName;
  final String toAirportName;
  final String markupTypeId;
  final String markupType;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String userType;
  final String currency;
  final String fullName;

  ViewMarkupFlightDestinationModel({
    required this.id,
    required this.userTypeId,
    required this.userId,
    required this.fromAirport,
    required this.toAirport,
    required this.fromAirportName,
    required this.toAirportName,
    required this.markupTypeId,
    required this.markupType,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.userType,
    required this.currency,
    required this.fullName,
  });

  // Factory method to create an instance from a JSON map
  factory ViewMarkupFlightDestinationModel.fromJson(Map<String, dynamic> json) {
    return ViewMarkupFlightDestinationModel(
      id: json["Id"].toString(),
      userTypeId: json["UserTypeId"].toString(),
      userId: json["UserId"].toString(),
      fromAirport: json["FromAirport"].toString(),
      toAirport:  json["ToAirport"].toString(),
      fromAirportName: json["FromAirportName"].toString(),
      toAirportName: json["ToAirportName"].toString(),
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

  // Method to convert an instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "UserTypeId": userTypeId,
      "UserId": userId,
      "FromAirport": fromAirport,
      "ToAirport": toAirport ?? "null",
      "FromAirportName": fromAirportName,
      "ToAirportName": toAirportName,
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

