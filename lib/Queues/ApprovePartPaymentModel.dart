class ApprovePartPaymentModel {
  String slNo;
  String bookFlightId;
  String bookingId;
  String custPaymentId;
  String bookedOnDt;
  String bookingType;
  String userType;
  String fullName;
  String dateOfPayment;
  String bookCardPassenger;
  String bookCardDiscription;
  String bookCardServiceDt;
  String bookingAmount;
  String bookingCardServiceDate;
  String partPayment;
  String currency;
  String dueDate;

  ApprovePartPaymentModel({
    required this.slNo,
    required this.bookFlightId,
    required this.bookingId,
    required this.custPaymentId,
    required this.bookedOnDt,
    required this.bookingType,
    required this.userType,
    required this.fullName,
    required this.dateOfPayment,
    required this.bookCardPassenger,
    required this.bookCardDiscription,
    required this.bookCardServiceDt,
    required this.bookingAmount,
    required this.bookingCardServiceDate,
    required this.partPayment,
    required this.currency,
    required this.dueDate,
  });

  factory ApprovePartPaymentModel.fromJson(Map<String, dynamic> json) {
    return ApprovePartPaymentModel(
      slNo: json['SlNo'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      bookingId: json['BookingId'].toString(),
      custPaymentId: json['CustPaymentId'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      bookingType: json['BookingType'].toString(),
      userType: json['UserType'].toString(),
      fullName: json['FullName'].toString(),
      dateOfPayment: json['DateOfPayment'].toString(),
      bookCardPassenger: json['BookCardPassenger'].toString(),
      bookCardDiscription: json['BookCardDiscription'].toString(),
      bookCardServiceDt: json['BookCardServiceDt'].toString(),
      bookingAmount: json['BookingAmount'].toString(),
      bookingCardServiceDate: json['BookingCardServiceDate'].toString(),
      partPayment: json['PartPayment'].toString(),
      currency: json['Currency'].toString(),
      dueDate: json['DueDate'].toString(),
    );
  }
}
