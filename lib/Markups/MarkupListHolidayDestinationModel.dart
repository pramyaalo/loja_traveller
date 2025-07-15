class MarkupListHolidayDestinationModel {
  final String slNo;
  final String id;
  final String holidayCityName;
  final String markupTypeId;
  final String markupType;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String customerType;
  final String customerName;
  final String currency;

  MarkupListHolidayDestinationModel({
    required this.slNo,
    required this.id,
    required this.holidayCityName,
    required this.markupTypeId,
    required this.markupType,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.customerType,
    required this.customerName,
    required this.currency,
  });

  factory MarkupListHolidayDestinationModel.fromJson(Map<String, dynamic> json) {
    return MarkupListHolidayDestinationModel(
      slNo: json['SlNo'].toString(),
      id: json['Id'].toString(),
      holidayCityName: json['HolidayCityName'].toString(),
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
      'HolidayCityName': holidayCityName,
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

