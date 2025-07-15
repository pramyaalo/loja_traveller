class ApproveRefundOnHoldModel {
  String slNo;
  String bookFlightId;
  String bookingId;
  String bookedOnDt;
  String bookingType;
  String userType;
  String fullName;
  String bookCardDiscription;
  String bookCardPassenger;
  String bookCardServiceDt;
  String bookingAmount;
  String bookingCardServiceDate;
  String totalRefund;
  String currency;
  String paidAmount;

  ApproveRefundOnHoldModel({
    required this.slNo,
    required this.bookFlightId,
    required this.bookingId,
    required this.bookedOnDt,
    required this.bookingType,
    required this.userType,
    required this.fullName,
    required this.bookCardDiscription,
    required this.bookCardPassenger,
    required this.bookCardServiceDt,
    required this.bookingAmount,
    required this.bookingCardServiceDate,
    required this.totalRefund,
    required this.currency,
    required this.paidAmount,
  });

  factory ApproveRefundOnHoldModel.fromJson(Map<String, dynamic> json) {
    return ApproveRefundOnHoldModel(
      slNo: json['SlNo'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      bookingId: json['BookingId'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      bookingType: json['BookingType'].toString(),
      userType: json['UserType'].toString(),
      fullName: json['FullName'].toString(),
      bookCardDiscription: json['BookCardDiscription'].toString(),
      bookCardPassenger: json['BookCardPassenger'].toString(),
      bookCardServiceDt: json['BookCardServiceDt'].toString(),
      bookingAmount: json['BookingAmount'].toString(),
      bookingCardServiceDate: json['BookingCardServiceDate'].toString(),
      totalRefund: json['TotalRefund'].toString(),
      currency: json['Currency'].toString(),
      paidAmount: json['PaidAmount'].toString(),
    );
  }
}
