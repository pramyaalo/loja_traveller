class ServiceRequestModel {
  String slNo;
  String bookFlightId;
  String bookingId;
  String bookingCode;
  String ticketCode;
  String ticketNo;
  String bookingNumber;
  String bookingStatus;
  String bookingDt;
  String bookingReff;
  String bookingCreator;
  String passenger;
  String bookedProduct;
  String journeyType;
  String totalAmt;
  String tripType;

  ServiceRequestModel({
    required this.slNo,
    required this.bookFlightId,
    required this.bookingId,
    required this.bookingCode,
    required this.ticketCode,
    required this.ticketNo,
    required this.bookingNumber,
    required this.bookingStatus,
    required this.bookingDt,
    required this.bookingReff,
    required this.bookingCreator,
    required this.passenger,
    required this.bookedProduct,
    required this.journeyType,
    required this.totalAmt,
    required this.tripType,
  });

  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestModel(
      slNo: json['SlNo'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingCode: json['BookingCode'].toString(),
      ticketCode: json['TicketCode'].toString(),
      ticketNo: json['TicketNo'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      bookingDt: json['BookingDt'].toString(),
      bookingReff: json['BookingReff'].toString(),
      bookingCreator: json['BookingCreator'].toString(),
      passenger: json['Passenger'].toString(),
      bookedProduct: json['BookedProduct'].toString(),
      journeyType: json['JourneyType'].toString(),
      totalAmt: json['TotalAmt'].toString(),
      tripType: json['TripType'].toString(),
    );
  }
}
