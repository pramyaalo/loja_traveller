class PendingPaymentListGet {
  String SlNo,
      BookFlightId,
      BookingId,
      BookedOnDt,
      BookingType,
      UserType,
      FullName,
      BookCardPassenger,
      BookCardServiceDt,
      BookingCardServiceDate,
      BookingAmount,
      Currency,
      PaidAmount,
      PendingPayment,
      DueDate;

//<editor-fold desc="Data Methods">
  PendingPaymentListGet({
    required this.SlNo,
    required this.BookFlightId,
    required this.BookingId,
    required this.BookedOnDt,
    required this.BookingType,
    required this.UserType,
    required this.FullName,
    required this.BookCardPassenger,
    required this.BookCardServiceDt,
    required this.BookingCardServiceDate,
    required this.BookingAmount,
    required this.Currency,
    required this.PaidAmount,
    required this.PendingPayment,
    required this.DueDate,
  });

  factory PendingPaymentListGet.fromJson(Map<String, dynamic> json) {
    return PendingPaymentListGet(
      SlNo: json['SlNo'].toString() as String,
      BookFlightId: json['BookFlightId'].toString() as String,
      BookingId: json['BookingId'].toString() as String,
      BookedOnDt: json['BookedOnDt'].toString() as String,
      BookingType: json['BookingType'].toString() as String,
      UserType: json['UserType'].toString() as String,
      FullName: json['FullName'].toString() as String,
      BookCardPassenger: json['BookCardPassenger'].toString() as String,
      BookCardServiceDt: json['BookCardServiceDt'].toString() as String,
      BookingCardServiceDate:
          json['BookingCardServiceDate'].toString() as String,
      BookingAmount: json['BookingAmount'].toString() as String,
      Currency: json['Currency'].toString() as String,
      PaidAmount: json['PaidAmount'].toString() as String,
      PendingPayment: json['PendingPayment'].toString() as String,
      DueDate: json['DueDate'].toString() as String,
    );
  }

//</editor-fold>
}
