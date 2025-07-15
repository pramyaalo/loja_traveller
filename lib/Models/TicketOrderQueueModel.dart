class TicketOrderQueueModel {
  String slNo;
  String tripId;
  String bookingNumber;
  String bookedOnDt;
  String bookFlightId;
  String bookingType;
  String bookingId;
  String bookingItemId;
  String bookCardDiscription;
  String bookCardPassenger;
  String bookCardServiceDt;
  String bookCardAmount;
  String payMode;
  String bookingStatus;
  String bookinDate;
  String bookingCardServiceDate;

  TicketOrderQueueModel({
    required this.slNo,
    required this.tripId,
    required this.bookingNumber,
    required this.bookedOnDt,
    required this.bookFlightId,
    required this.bookingType,
    required this.bookingId,
    required this.bookingItemId,
    required this.bookCardDiscription,
    required this.bookCardPassenger,
    required this.bookCardServiceDt,
    required this.bookCardAmount,
    required this.payMode,
    required this.bookingStatus,
    required this.bookinDate,
    required this.bookingCardServiceDate,
  });

  factory TicketOrderQueueModel.fromJson(Map<String, dynamic> json) {
    return TicketOrderQueueModel(
      slNo: json['SlNo'].toString(),
      tripId: json['TripId'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      bookingType: json['BookingType'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingItemId: json['BookingItemId'].toString(),
      bookCardDiscription: json['BookCardDiscription'].toString(),
      bookCardPassenger: json['BookCardPassenger'].toString(),
      bookCardServiceDt: json['BookCardServiceDt'].toString(),
      bookCardAmount: json['BookCardAmount'].toString(),
      payMode: json['PayMode'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      bookinDate: json['BookinDate'].toString(),
      bookingCardServiceDate: json['BookingCardServiceDate'].toString(),
    );
  }
}
