class Table20CreditNoteHolidayListModel {
  String bookFlightId;
  String hotelName;
  String starCategory;
  String hotelAddress;
  String noOfNights;
  String rateCode;
  String cityCode;
  String phone;
  String email;
  String supplierRefNo;
  String confirmationNo;
  String additionalRefNo;
  String checkInDt;
  String checkOutDt;
  String ticketCode;
  String checkInDtt;
  String checkOutDtt;
  String productId;
  String roomType;
  String startDate;
  String endDate;
  String dateType;
  String rateDescription;
  String saleQuantityRule;
  String statusText;
  String barcodeData;
  String componentKey;

  Table20CreditNoteHolidayListModel({
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
    required this.additionalRefNo,
    required this.checkInDt,
    required this.checkOutDt,
    required this.ticketCode,
    required this.checkInDtt,
    required this.checkOutDtt,
    required this.productId,
    required this.roomType,
    required this.startDate,
    required this.endDate,
    required this.dateType,
    required this.rateDescription,
    required this.saleQuantityRule,
    required this.statusText,
    required this.barcodeData,
    required this.componentKey,
  });

  factory Table20CreditNoteHolidayListModel.fromJson(
      Map<String, dynamic> json) {
    return Table20CreditNoteHolidayListModel(
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
      additionalRefNo: json['AdditionalReffNo'].toString(),
      checkInDt: json['CheckInDt'].toString(),
      checkOutDt: json['CheckOutDt'].toString(),
      ticketCode: json['TicketCode'].toString(),
      checkInDtt: json['CheckInDtt'].toString(),
      checkOutDtt: json['CheckOutDtt'].toString(),
      productId: json['ProductId'].toString(),
      roomType: json['RoomType'].toString(),
      startDate: json['StartDate'].toString(),
      endDate: json['EndDate'].toString(),
      dateType: json['DateType'].toString(),
      rateDescription: json['RateDescription'].toString(),
      saleQuantityRule: json['SaleQuantityRule'].toString(),
      statusText: json['StatusText'].toString(),
      barcodeData: json['BarcodeData'].toString(),
      componentKey: json['ComponentKey'].toString(),
    );
  }
}
