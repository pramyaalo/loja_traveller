class BookingCardModel {
  String slNo;
  String tripId;
  String bookingNumber;
  String bookedOnDt;
  String bookFlightId;
  String bookingType;
  String bookingId;
  String bookingItemId;
  String bookCardDescription;
  String bookCardPassenger;
  String bookCardServiceDt;
  String bookCardAmount;
  String payMode;
  String bookingAmount;
  String bookingStatus;
  String bookingDate;
  String bookingCardServiceDate;

  BookingCardModel({
    required this.slNo,
    required this.tripId,
    required this.bookingNumber,
    required this.bookedOnDt,
    required this.bookFlightId,
    required this.bookingType,
    required this.bookingId,
    required this.bookingItemId,
    required this.bookCardDescription,
    required this.bookCardPassenger,
    required this.bookCardServiceDt,
    required this.bookCardAmount,
    required this.payMode,
    required this.bookingAmount,
    required this.bookingStatus,
    required this.bookingDate,
    required this.bookingCardServiceDate,
  });

  factory BookingCardModel.fromJson(Map<String, dynamic> json) {
    return BookingCardModel(
      slNo: json['SlNo'].toString(),
      tripId: json['TripId'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      bookingType: json['BookingType'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingItemId: json['BookingItemId'].toString(),
      bookCardDescription: json['BookCardDiscription'].toString(),
      bookCardPassenger: json['BookCardPassenger'].toString(),
      bookCardServiceDt: json['BookCardServiceDt'].toString(),
      bookCardAmount: json['BookCardAmount'].toString(),
      payMode: json['PayMode'].toString(),
      bookingAmount: json['BookingAmount'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      bookingDate: json['BookinDate'].toString(),
      bookingCardServiceDate: json['BookingCardServiceDate'].toString(),
    );
  }
}
