class Table1HotelDetailsModel {
  String thhBookFlightId;
  String hotelName;
  String starCategory;
  String hotelAddress;
  String noofNights;
  String rateCode;
  String cityCode;
  String phone;
  String email;
  String supplierRefNo;
  String confirmationNo;
  String additionalReffNo;
  String checkInDt;
  String checkOutDt;
  String checkInDtt;
  String checkOutDtt;
  String confirmationNo1;
  String roomType;

  Table1HotelDetailsModel({
    required this.thhBookFlightId,
    required this.hotelName,
    required this.starCategory,
    required this.hotelAddress,
    required this.noofNights,
    required this.rateCode,
    required this.cityCode,
    required this.phone,
    required this.email,
    required  this.supplierRefNo,
    required this.confirmationNo,
    required this.additionalReffNo,
    required this.checkInDt,
    required this.checkOutDt,
    required this.checkInDtt,
    required this.checkOutDtt,
    required this.confirmationNo1,
    required this.roomType,
  });

  factory Table1HotelDetailsModel.fromJson(Map<String, dynamic> json) {
    return Table1HotelDetailsModel(
      thhBookFlightId: json['THHBookFlightId'].toString(),
      hotelName: json['HotelName'].toString(),
      starCategory: json['StarCategory'].toString(),
      hotelAddress: json['HotelAddress'].toString(),
      noofNights: json['NoofNights'].toString(),
      rateCode: json['RateCode'].toString(),
      cityCode: json['CityCode'].toString(),
      phone: json['Phone'].toString(),
      email: json['Email'].toString(),
      supplierRefNo: json['SupplierRefNo'].toString(),
      confirmationNo: json['ConfirmationNo'].toString(),
      additionalReffNo: json['AdditionalReffNo'].toString(),
      checkInDt: json['CheckInDt'].toString(),
      checkOutDt: json['CheckOutDt'].toString(),
      checkInDtt: json['CheckInDtt'].toString(),
      checkOutDtt: json['CheckOutDtt'].toString(),
      confirmationNo1: json['ConfirmationNo1'].toString(),
      roomType: json['RoomType'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'THHBookFlightId': thhBookFlightId,
    'HotelName': hotelName,
    'StarCategory': starCategory,
    'HotelAddress': hotelAddress,
    'NoofNights': noofNights,
    'RateCode': rateCode,
    'CityCode': cityCode,
    'Phone': phone,
    'Email': email,
    'SupplierRefNo': supplierRefNo,
    'ConfirmationNo': confirmationNo,
    'AdditionalReffNo': additionalReffNo,
    'CheckInDt': checkInDt,
    'CheckOutDt': checkOutDt,
    'CheckInDtt': checkInDtt,
    'CheckOutDtt': checkOutDtt,
    'ConfirmationNo1': confirmationNo1,
    'RoomType': roomType,
  };
}
