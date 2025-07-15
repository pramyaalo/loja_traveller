class MarkupListHotelDestinationModel {
  final String slNo;
  final String id;
  final String hotelCityId;
  final String hotelCityName;
  final String markupTypeId;
  final String markupType;
  final String markupValue;
  final String status;
  final String dateCreated;
  final String customerType;
  final String customerName;
  final String currency;

  MarkupListHotelDestinationModel({
    required this.slNo,
    required this.id,
    required this.hotelCityId,
    required this.hotelCityName,
    required this.markupTypeId,
    required this.markupType,
    required this.markupValue,
    required this.status,
    required this.dateCreated,
    required this.customerType,
    required this.customerName,
    required this.currency,
  });

  factory MarkupListHotelDestinationModel.fromJson(Map<String, dynamic> json) {
    return MarkupListHotelDestinationModel(
      slNo: json['SlNo'].toString(),
      id: json['Id'].toString(),
      hotelCityId: json['HotelCityId'].toString(),
      hotelCityName: json['HotelCityName'].toString(),
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
      'HotelCityId': hotelCityId,
      'HotelCityName': hotelCityName,
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
