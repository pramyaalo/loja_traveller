class SalesReportModel {
  String slNo;
  String bookFlightId;
  String bookingID;
  String bookedOnDt;
  String ticketCode;
  String ticketNo;
  String originDestination;
  String passenger;
  String bookedProduct;
  String journeyType;
  String totalAmt;
  String tripType;
  String bookingAmount;

  SalesReportModel({
    required this.slNo,
    required this.bookFlightId,
    required this.bookingID,
    required this.bookedOnDt,
    required this.ticketCode,
    required this.ticketNo,
    required this.originDestination,
    required this.passenger,
    required this.bookedProduct,
    required this.journeyType,
    required this.totalAmt,
    required this.tripType,
    required this.bookingAmount,
  });

  factory SalesReportModel.fromJson(Map<String, dynamic> json) {
    return SalesReportModel(
      slNo: json['SlNo'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      bookingID: json['BookingID'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      ticketCode: json['TicketCode'].toString(),
      ticketNo: json['TicketNo'].toString(),
      originDestination: json['OriginDestination'].toString(),
      passenger: json['Passenger'].toString(),
      bookedProduct: json['BookedProduct'].toString(),
      journeyType: json['JourneyType'].toString(),
      totalAmt: json['TotalAmount'].toString(),
      tripType: json['TripType'].toString(),
      bookingAmount: json['BookingAmount'].toString(),
    );
  }
}
