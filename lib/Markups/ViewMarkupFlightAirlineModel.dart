class ViewMarkupFlightAirlineModel {
  final String id;
  final String userTypeId;
  final String userId;
  final String airlineId;
  final String airlineName;
  final String markupTypeId;
  final String markupType;
  final String currency;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String userType;
  final String fullName;

  ViewMarkupFlightAirlineModel({
    required this.id,
    required this.userTypeId,
    required this.userId,
    required this.airlineId,
    required this.airlineName,
    required this.markupTypeId,
    required this.markupType,
    required this.currency,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.userType,
    required this.fullName,
  });

  factory ViewMarkupFlightAirlineModel.fromJson(Map<String, dynamic> json) {
    return ViewMarkupFlightAirlineModel(
      id: json['Id'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      airlineId: json['AirlineID'].toString(),
      airlineName: json['AirlineName'].toString(),
      markupTypeId: json['MarkupTypeId'].toString(),
      markupType: json['MarkupType'].toString(),
      currency: json['Currency'].toString(),
      markupValue: json['MarkupValue'].toString(), // Ignoring "MarkupvValue" as it's likely a typo
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
      'AirlineID': airlineId,
      'AirlineName': airlineName,
      'MarkupTypeId': markupTypeId,
      'MarkupType': markupType,
      'Currency': currency,
      'MarkupValue': markupValue, // Keeping only the correct key
      'Status': status,
      'datecreated': dateCreated,
      'UserType': userType,
      'FullName': fullName,
    };
  }
}
