class ViewMarkupFlightFareModel {
  final String id;
  final String userTypeId;
  final String userId;
  final String fromFare;
  final String toFare;
  final String markupTypeId;
  final String markupType;
  final String currency;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String userType;
  final String fullName;
  final String currency1;

  ViewMarkupFlightFareModel({
    required this.id,
    required this.userTypeId,
    required this.userId,
    required this.fromFare,
    required this.toFare,
    required this.markupTypeId,
    required this.markupType,
    required this.currency,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.userType,
    required this.fullName,
    required this.currency1,
  });

  // Factory method to create an object from JSON
  factory ViewMarkupFlightFareModel.fromJson(Map<String, dynamic> json) {
    return ViewMarkupFlightFareModel(
      id: json['Id'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      fromFare: json['FromFare'].toDouble().toString(),
      toFare: json['ToFare'].toDouble().toString(),
      markupTypeId: json['MarkupTypeId'].toString(),
      markupType: json['MarkupType'].toString(),
      currency: json['Currency'].toString(),
      markupValue: json['MarkupValue'].toString(), // Assuming it’s always a string
      status: json['Status'].toString(),
      dateCreated: json['datecreated'].toString(),
      userType: json['UserType'].toString(),
      fullName: json['FullName'].toString(),
      currency1: json['Currency1'].toString(),
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserTypeId': userTypeId,
      'UserId': userId,
      'FromFare': fromFare,
      'ToFare': toFare,
      'MarkupTypeId': markupTypeId,
      'MarkupType': markupType,
      'Currency': currency,
      'MarkupValue': markupValue,
      'Status': status,
      'datecreated': dateCreated,
      'UserType': userType,
      'FullName': fullName,
      'Currency1': currency1,
    };
  }
}
