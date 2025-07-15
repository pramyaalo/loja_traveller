class ViewMarkupBusfareModel {
  final String id;
  final String userTypeId;
  final String userId;
  final String fromFare;
  final String toFare;
  final String markupTypeId;
  final String markupType;
  final String value;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String userType;
  final String currency;
  final String fullName;
  final String currency1;

  ViewMarkupBusfareModel({
    required this.id,
    required this.userTypeId,
    required this.userId,
    required this.fromFare,
    required this.toFare,
    required this.markupTypeId,
    required this.markupType,
    required this.value,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.userType,
    required this.currency,
    required this.fullName,
    required this.currency1,
  });

  // Factory method to create an instance from JSON
  factory ViewMarkupBusfareModel.fromJson(Map<String, dynamic> json) {
    return ViewMarkupBusfareModel(
      id: json['Id'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      fromFare: json['FromFare'].toString(),
      toFare: json['ToFare'].toString(),
      markupTypeId: json['MarkupTypeId'].toString(),
      markupType: json['MarkupType'].toString(),
      value: json['Value'].toString(),
      markupValue: json['Markupvalue'].toString(),
      status: json['Status'].toString(),
      dateCreated: json['datecreated'].toString(),
      userType: json['UserType'].toString(),
      currency: json['Currency'].toString(),
      fullName: json['FullName'].toString(),
      currency1: json['Currency1'].toString(),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserTypeId': userTypeId,
      'UserId': userId,
      'FromFare': fromFare,
      'ToFare': toFare,
      'MarkupTypeId': markupTypeId,
      'MarkupType': markupType,
      'Value': value,
      'Markupvalue': markupValue,
      'Status': status,
      'datecreated': dateCreated,
      'UserType': userType,
      'Currency': currency,
      'FullName': fullName,
      'Currency1': currency1,
    };
  }


}
