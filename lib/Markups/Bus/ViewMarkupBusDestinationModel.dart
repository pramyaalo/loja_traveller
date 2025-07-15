class ViewMarkupBusDestinationModel {
  final String id;
  final String userTypeId;
  final String userId;
  final String fromBusStationId;
  final String toBusStationId;
  final String fromBusStation;
  final String toBusStation;
  final String markupTypeId;
  final String markupType;
  final String value;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String userType;
  final String currency;
  final String fullName;

  ViewMarkupBusDestinationModel({
    required this.id,
    required this.userTypeId,
    required this.userId,
    required this.fromBusStationId,
    required this.toBusStationId,
    required this.fromBusStation,
    required this.toBusStation,
    required this.markupTypeId,
    required this.markupType,
    required this.value,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.userType,
    required this.currency,
    required this.fullName,
  });

  factory ViewMarkupBusDestinationModel.fromJson(Map<String, dynamic> json) {
    return ViewMarkupBusDestinationModel(
      id: json['Id'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      fromBusStationId: json['FromBusStationId'].toString(),
      toBusStationId: json['ToBusStationId'].toString(),
      fromBusStation: json['FromBusStation'].toString(),
      toBusStation: json['ToBusStation'].toString(),
      markupTypeId: json['MarkupTypeId'].toString(),
      markupType: json['MarkupType'].toString(),
      value: json['Value'].toString(),
      markupValue: json['Markupvalue'].toString(),
      status: json['Status'].toString(),
      dateCreated: json['datecreated'].toString(),
      userType: json['UserType'].toString(),
      currency: json['Currency'].toString(),
      fullName: json['FullName'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "UserTypeId": userTypeId,
      "UserId": userId,
      "FromBusStationId": fromBusStationId,
      "ToBusStationId": toBusStationId,
      "FromBusStation": fromBusStation,
      "ToBusStation": toBusStation,
      "MarkupTypeId": markupTypeId,
      "MarkupType": markupType,
      "Value": value,
      "Markupvalue": markupValue,
      "Status": status,
      "datecreated": dateCreated,
      "UserType": userType,
      "Currency": currency,
      "FullName": fullName,
    };
  }
}
