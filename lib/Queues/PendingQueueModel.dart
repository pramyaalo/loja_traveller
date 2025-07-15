class PendingQueueModel {
  String slNo;
  String tripId; // Use the appropriate type based on your data
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
  String bookingAmount;
  String totalAmount;
  String currency;
  String paidAmount;
  String pendingPayment;
  String bookingStatus;
  String bookingDate;
  String bookingCardServiceDate;

  PendingQueueModel({
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
    required this.bookingAmount,
    required this.totalAmount,
    required this.currency,
    required this.paidAmount,
    required this.pendingPayment,
    required this.bookingStatus,
    required this.bookingDate,
    required this.bookingCardServiceDate,
  });

  factory PendingQueueModel.fromJson(Map<String, dynamic> json) {
    return PendingQueueModel(
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
      bookingAmount: json['BookingAmount'].toString(),
      totalAmount: json['TotalAmount'].toString(),
      currency: json['Currency'].toString(),
      paidAmount: json['PaidAmount'].toString(),
      pendingPayment: json['PendingPayment'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      bookingDate: json['BookinDate'].toString(),
      bookingCardServiceDate: json['BookingCardServiceDate'].toString(),
    );
  }
}
