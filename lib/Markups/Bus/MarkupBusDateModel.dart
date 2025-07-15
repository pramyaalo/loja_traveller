class MarkupBusDateModel {
  final String id;
  final String fromDate;
  final String toDate;
  final String markupTypeId;
  final String markupType;
  final String markupValue; // Keeping it dynamic since "d" is an invalid number
  final String status;
  final String dateCreated;
  final String customerType;
  final String customerName;
  final String currency;

  MarkupBusDateModel({
    required this.id,
    required this.fromDate,
    required this.toDate,
    required this.markupTypeId,
    required this.markupType,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.customerType,
    required this.customerName,
    required this.currency,
  });

  // Factory method to create an instance from JSON
  factory MarkupBusDateModel.fromJson(Map<String, dynamic> json) {
    return MarkupBusDateModel(
      id: json['Id'].toString(),
      fromDate: json['FromDate'].toString(),
      toDate: json['ToDate'].toString(),
      markupTypeId: json['MarkupTypeId'].toString(),
      markupType: json['MarkupType'].toString(),
      markupValue: json['MarkupValue'], // Keeping it dynamic
      status: json['Status'].toString(),
      dateCreated: json['datecreated'].toString(),
      customerType: json['CustomerType'].toString(),
      customerName: json['CustomerName'].toString(),
      currency: json['Currency'].toString(),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'FromDate': fromDate,
      'ToDate': toDate,
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
