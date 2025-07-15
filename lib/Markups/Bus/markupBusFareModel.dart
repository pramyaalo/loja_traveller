class markupBusFareModel {
  final String id;
  final String fromFare;
  final String toFare;
  final String markupTypeId;
  final String markupType;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String customerType;
  final String customerName;
  final String currency;

  markupBusFareModel({
    required this.id,
    required this.fromFare,
    required this.toFare,
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
  factory markupBusFareModel.fromJson(Map<String, dynamic> json) {
    return markupBusFareModel(
      id: json['Id'].toString(),
      fromFare: json['FromFare'].toString(),
      toFare: json['ToFare'] .toString(),
      markupTypeId: json['MarkupTypeId'].toString(),
      markupType: json['MarkupType'].toString(),
      markupValue: json['MarkupValue'].toString(),
      status: json['Status'].toString(),
      dateCreated: json['datecreated'].toString(),
      customerType: json['CustomerType'].toString(),
      customerName: json['CustomerName'].toString(),
      currency: json['Currency'] .toString(),
    );
  }



}
