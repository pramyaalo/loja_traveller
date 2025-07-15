class PaymentCollectionReportModel {
  String slNo;
  String bookingId;
  String bookingStatus;
  String bookFlightId;
  String bookedOnDt;
  String ticketCode;
  String ticketNo;
  String tripDate;
  String originDestination;
  String passenger;
  String bookedProduct;
  String journeyType;
  String totalAmt;
  String tripType;
  String modeOfPayment;
  String bookingAmount;
  String status;

  PaymentCollectionReportModel({
    required this.slNo,
    required this.bookingId,
    required this.bookingStatus,
    required this.bookFlightId,
    required this.bookedOnDt,
    required this.ticketCode,
    required this.ticketNo,
    required this.tripDate,
    required this.originDestination,
    required this.passenger,
    required this.bookedProduct,
    required this.journeyType,
    required this.totalAmt,
    required this.tripType,
    required this.modeOfPayment,
    required this.bookingAmount,
    required this.status,
  });

  factory PaymentCollectionReportModel.fromJson(Map<String, dynamic> json) {
    return PaymentCollectionReportModel(
      slNo: json['SlNo'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      ticketCode: json['TicketCode'].toString(),
      ticketNo: json['TicketNo'].toString(),
      tripDate: json['TripDate'].toString(),
      originDestination: json['OriginDestination'].toString(),
      passenger: json['Passenger'].toString(),
      bookedProduct: json['BookedProduct'].toString(),
      journeyType: json['JourneyType'].toString(),
      totalAmt: json['TotalAmt'].toString(),
      tripType: json['TripType'].toString(),
      modeOfPayment: json['ModeofPayment'].toString(),
      bookingAmount: json['BookingAmount'].toString(),
      status: json['Status'].toString(),
    );
  }
}
