class Table2HotelReceiptHotelDetailModel {
  final String thhBookFlightId;
  final String hotelName;
  final String starCategory;
  final String hotelAddress;
  final String noOfNights;
  final String rateCode;
  final String cityCode;
  final String phone;
  final String email;
  final String supplierRefNo;
  final String confirmationNo;
  final String additionalRefNo;
  final String checkInDt;
  final String checkOutDt;
  final String checkInDtt;
  final String checkOutDtt;
  final String roomType;

  Table2HotelReceiptHotelDetailModel({
    required this.thhBookFlightId,
    required this.hotelName,
    required this.starCategory,
    required this.hotelAddress,
    required this.noOfNights,
    required this.rateCode,
    required this.cityCode,
    required this.phone,
    required this.email,
    required  this.supplierRefNo,
    required this.confirmationNo,
    required this.additionalRefNo,
    required this.checkInDt,
    required this.checkOutDt,
    required this.checkInDtt,
    required this.checkOutDtt,
    required this.roomType,
  });

  factory Table2HotelReceiptHotelDetailModel.fromJson(Map<String, dynamic> json) {
    return Table2HotelReceiptHotelDetailModel(
      thhBookFlightId: json['THHBookFlightId'].toString(),
      hotelName: json['HotelName'].toString(),
      starCategory: json['StarCategory'].toString(),
      hotelAddress: json['HotelAddress'].toString(),
      noOfNights: json['NoofNights'].toString(),
      rateCode: json['RateCode'].toString(),
      cityCode: json['CityCode'].toString(),
      phone: json['Phone'].toString(),
      email: json['Email'].toString(),
      supplierRefNo: json['SupplierRefNo'].toString(),
      confirmationNo: json['ConfirmationNo'].toString(),
      additionalRefNo: json['AdditionalReffNo'].toString(),
      checkInDt: json['CheckInDt'].toString(),
      checkOutDt: json['CheckOutDt'].toString(),
      checkInDtt: json['CheckInDtt'].toString(),
      checkOutDtt: json['CheckOutDtt'].toString(),
      roomType: json['RoomType'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'THHBookFlightId': thhBookFlightId,
      'HotelName': hotelName,
      'StarCategory': starCategory,
      'HotelAddress': hotelAddress,
      'NoofNights': noOfNights,
      'RateCode': rateCode,
      'CityCode': cityCode,
      'Phone': phone,
      'Email': email,
      'SupplierRefNo': supplierRefNo,
      'ConfirmationNo': confirmationNo,
      'AdditionalReffNo': additionalRefNo,
      'CheckInDt': checkInDt,
      'CheckOutDt': checkOutDt,
      'CheckInDtt': checkInDtt,
      'CheckOutDtt': checkOutDtt,
      'RoomType': roomType,
    };
  }
}
