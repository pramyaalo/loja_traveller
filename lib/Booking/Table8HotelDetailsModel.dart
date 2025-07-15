class Table8HotelDetailsModel {
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
  final String additionalReffNo;
  final String checkInDt;
  final String checkOutDt;
  final String checkInDtt;
  final String checkOutDtt;
  final String roomType;
  final String Count;
  final String bookingStatus;

  Table8HotelDetailsModel({
    required this.thhBookFlightId,
    required this.hotelName,
    required this.starCategory,
    required this.hotelAddress,
    required this.noOfNights,
    required this.rateCode,
    required this.cityCode,
    required this.phone,
    required this.email,
    required this.supplierRefNo,
    required this.confirmationNo,
    required this.additionalReffNo,
    required this.checkInDt,
    required this.checkOutDt,
    required this.checkInDtt,
    required this.checkOutDtt,
    required this.roomType,
    required this.Count,
    required this.bookingStatus,
  });

  factory Table8HotelDetailsModel.fromJson(Map<String, dynamic> json) {
    return Table8HotelDetailsModel(
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
      additionalReffNo: json['AdditionalReffNo'].toString(),
      checkInDt: json['CheckInDt'].toString(),
      checkOutDt: json['CheckOutDt'].toString(),
      checkInDtt: json['CheckInDtt'].toString(),
      checkOutDtt: json['CheckOutDtt'].toString(),
      roomType: json['RoomType'].toString(),
        Count:json['Count'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
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
      'AdditionalReffNo': additionalReffNo,
      'CheckInDt': checkInDt,
      'CheckOutDt': checkOutDt,
      'CheckInDtt': checkInDtt,
      'CheckOutDtt': checkOutDtt,
      'RoomType': roomType,
      'BookingStatus': bookingStatus,
    };
  }
}
