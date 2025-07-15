class MarkupFlight_AirlineModel {
  final String id;
  final String airlineName;
  final String markupTypeId;
  final String markupType;
  final String markupValue;
  final String status;
  final String airlineId;
  final String dateCreated;
  final String customerType;
  final String customerName;
  final String currency;

  MarkupFlight_AirlineModel({
    required this.id,
    required this.airlineName,
    required this.markupTypeId,
    required this.markupType,
    required this.markupValue,
    required this.status,
    required this.airlineId,
    required this.dateCreated,
    required this.customerType,
    required this.customerName,
    required this.currency,
  });

  factory MarkupFlight_AirlineModel.fromJson(Map<String, dynamic> json) {
    return MarkupFlight_AirlineModel(
      id: json['Id'].toString(),
      airlineName: json['AirlineName'].toString(),
      markupTypeId: json['MarkupTypeId'].toString(),
      markupType: json['MarkupType'].toString(),
      markupValue: json['MarkupValue'].toString(),
      status: json['Status'].toString(),
      airlineId: json['AirlineId'].toString(),
      dateCreated: json['datecreated'].toString(),
      customerType: json['CustomerType'].toString(),
      customerName: json['CustomerName'].toString(),
      currency: json['Currency'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'AirlineName': airlineName,
      'MarkupTypeId': markupTypeId,
      'MarkupType': markupType,
      'MarkupValue': markupValue,
      'Status': status,
      'AirlineId': airlineId,
      'datecreated': dateCreated,
      'CustomerType': customerType,
      'CustomerName': customerName,
      'Currency': currency,
    };
  }
}
