class UnconfirmedBookingModel {
  String slNo;
  String bookingId;
  String bookingNumber;
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
  String bookingAmount;

  UnconfirmedBookingModel({
    required this.slNo,
    required this.bookingId,
    required this.bookingNumber,
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
    required this.bookingAmount,
  });

  factory UnconfirmedBookingModel.fromJson(Map<String, dynamic> json) {
    return UnconfirmedBookingModel(
      slNo: json['SlNo'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
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
      bookingAmount: json['BookingAmount'].toString(),
      tripType: json['TripType'].toString(),
    );
  }
}
