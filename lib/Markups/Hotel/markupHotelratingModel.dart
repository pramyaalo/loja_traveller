class markupHotelratingModel {
  final String id;
  final String hotelRating;
  final String markupTypeId;
  final String markupType;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String customerType;
  final String customerName;
  final String currency;

  markupHotelratingModel({
    required this.id,
    required this.hotelRating,
    required this.markupTypeId,
    required this.markupType,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.customerType,
    required this.customerName,
    required this.currency,
  });

  factory markupHotelratingModel.fromJson(Map<String, dynamic> json) {
    return markupHotelratingModel(
      id: json['Id'].toString(),
      hotelRating: json['HotelRating'].toString(),
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
      'Id': id,
      'HotelRating': hotelRating,
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
