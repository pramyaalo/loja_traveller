class   Table17HolidayDescriptionModel {
  final String bookFlightId;
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
  final String productId;
  final String roomType;
  final String nos;
  final String voucherNo;
  final String ticketNo;
  final String totalAmount;
  final String confirmStatus;

  Table17HolidayDescriptionModel({
    required this.bookFlightId,
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
    required this.productId,
    required this.roomType,
    required this.nos,
    required this.voucherNo,
    required this.ticketNo,
    required this.totalAmount,
    required this.confirmStatus,
  });

  factory Table17HolidayDescriptionModel.fromJson(Map<String, dynamic> json) {
    return Table17HolidayDescriptionModel(
      bookFlightId: json['BookFlightId'].toString(),
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
      productId: json['ProductId'].toString(),
      roomType: json['RoomType'].toString(),
      nos: json['Nos'].toString(),
      voucherNo: json['VoucherNo'].toString(),
      ticketNo: json['TicketNo'].toString(),
      totalAmount: json['TotalAmount'].toString(),
      confirmStatus: json['ConfirmStatus'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BookFlightId': bookFlightId,
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
      'ProductId': productId,
      'RoomType': roomType,
      'Nos': nos,
      'VoucherNo': voucherNo,
      'TicketNo': ticketNo,
      'TotalAmount': totalAmount,
      'ConfirmStatus': confirmStatus,
    };
  }
}
