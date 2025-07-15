class Table1HolidayInvoiceReceiptModel {
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
  final String ticketCode;
  final String checkInDtt;
  final String checkOutDtt;
  final String productId;
  final String roomType;
  final String startDate;
  final String endDate;
  final String dateType;
  final String rateDescription;
  final String saleQuantityRule;
  final String statusText;
  final String barcodeData;
  final String componentKey;

  Table1HolidayInvoiceReceiptModel({
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

  // Factory method to create an object from JSON
  factory Table1HolidayInvoiceReceiptModel.fromJson(Map<String, dynamic> json) {
    return Table1HolidayInvoiceReceiptModel(
      bookFlightId: json["BookFlightId"].toString(),
      hotelName: json["HotelName"].toString(),
      starCategory: json["StarCategory"].toString(),
      hotelAddress: json["HotelAddress"].toString(),
      noOfNights: json["NoofNights"].toString(),
      rateCode: json["RateCode"].toString(),
      cityCode: json["CityCode"].toString(),
      phone: json["Phone"].toString(),
      email: json["Email"].toString(),
      supplierRefNo: json["SupplierRefNo"].toString(),
      confirmationNo: json["ConfirmationNo"].toString(),
      additionalReffNo: json["AdditionalReffNo"].toString(),
      checkInDt: json["CheckInDt"].toString(),
      checkOutDt: json["CheckOutDt"].toString(),
      ticketCode: json["TicketCode"].toString(),
      checkInDtt: json["CheckInDtt"].toString(),
      checkOutDtt: json["CheckOutDtt"].toString(),
      productId: json["ProductId"].toString(),
      roomType: json["RoomType"].toString(),
      startDate: json["StartDate"].toString(),
      endDate: json["EndDate"].toString(),
      dateType: json["DateType"].toString(),
      rateDescription: json["RateDescription"].toString(),
      saleQuantityRule: json["SaleQuantityRule"].toString(),
      statusText: json["StatusText"].toString(),
      barcodeData: json["BarcodeData"].toString(),
      componentKey: json["ComponentKey"].toString(),
    );
  }

  // Method to convert an object to JSON
  Map<String, dynamic> toJson() {
    return {
      "BookFlightId": bookFlightId,
      "HotelName": hotelName,
      "StarCategory": starCategory,
      "HotelAddress": hotelAddress,
      "NoofNights": noOfNights,
      "RateCode": rateCode,
      "CityCode": cityCode,
      "Phone": phone,
      "Email": email,
      "SupplierRefNo": supplierRefNo,
      "ConfirmationNo": confirmationNo,
      "AdditionalReffNo": additionalReffNo,
      "CheckInDt": checkInDt,
      "CheckOutDt": checkOutDt,
      "TicketCode": ticketCode,
      "CheckInDtt": checkInDtt,
      "CheckOutDtt": checkOutDtt,
      "ProductId": productId,
      "RoomType": roomType,
      "StartDate": startDate,
      "EndDate": endDate,
      "DateType": dateType,
      "RateDescription": rateDescription,
      "SaleQuantityRule": saleQuantityRule,
      "StatusText": statusText,
      "BarcodeData": barcodeData,
      "ComponentKey": componentKey,
    };
  }
}
