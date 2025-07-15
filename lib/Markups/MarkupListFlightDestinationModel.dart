class MarkupListFlightDestinationModel {
  final String slNo;
  final String id;
  final String fromAirport;
  final String toAirport;
  final String fromAirportName;
  final String toAirportName;
  final String markupTypeId;
  final String markupType;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String customerType;
  final String customerName;
  final String currency;

  MarkupListFlightDestinationModel({
    required this.slNo,
    required this.id,
    required this.fromAirport,
    required this.toAirport,
    required this.fromAirportName,
    required this.toAirportName,
    required this.markupTypeId,
    required this.markupType,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.customerType,
    required this.customerName,
    required this.currency,
  });

  factory MarkupListFlightDestinationModel.fromJson(Map<String, dynamic> json) {
    return MarkupListFlightDestinationModel(
      slNo: json['SlNo'].toString(),
      id: json['Id'].toString(),
      fromAirport: json['FromAirport'].toString(),
      toAirport: json['ToAirport'].toString(),
      fromAirportName: json['FromAirportName'].toString(),
      toAirportName: json['ToAirportName'].toString(),
      markupTypeId: json['MarkupTypeId'].toString(),
      markupType: json['MarkupType'].toString(),
      markupValue: json['MarkupValue'].toString(),
      status: json['Status'].toString(),
      dateCreated: json['datecreated'].toString(),
      customerType: json['CustomerType'].toString(),
      customerName: json['CustomerName'].toString(),
      currency: json['Currency'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SlNo': slNo,
      'Id': id,
      'FromAirport': fromAirport,
      'ToAirport': toAirport,
      'FromAirportName': fromAirportName,
      'ToAirportName': toAirportName,
      'MarkupTypeId': markupTypeId,
      'MarkupType': markupType,
      'MarkupValue': markupValue,
      'Status': status,
      'datecreated': dateCreated,
      'CustomerType': customerType,
      'CustomerName': customerName,
      'Currency': currency,
    };
  }
}
