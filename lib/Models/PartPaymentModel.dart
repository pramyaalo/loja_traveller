class PartPaymentModel {
  String SlNo,
      BookFlightId,
      BookingId,
      CustPaymentId,
      BookedOnDt,
      BookingType,
      UserType,
      FullName,
      DateOfPayment,
      BookCardPassenger,
      BookCardDiscription,
      BookCardServiceDt,
      BookingAmount,
      BookingCardServiceDate,
      PartPayment,
      Currency,
      DueDate;

  PartPaymentModel({
    required this.SlNo,
    required this.BookFlightId,
    required this.BookingId,
    required this.CustPaymentId,
    required this.BookedOnDt,
    required this.BookingType,
    required this.UserType,
    required this.FullName,
    required this.DateOfPayment,
    required this.BookCardPassenger,
    required this.BookCardDiscription,
    required this.BookCardServiceDt,
    required this.BookingAmount,
    required this.BookingCardServiceDate,
    required this.PartPayment,
    required this.Currency,
    required this.DueDate,
  });

  factory PartPaymentModel.fromJson(Map<String, dynamic> json) {
    return PartPaymentModel(
      SlNo: json['SlNo'].toString() as String,
      BookFlightId: json['BookFlightId'].toString() as String,
      BookingId: json['BookingId'].toString() as String,
      CustPaymentId: json['CustPaymentId'].toString() as String,
      BookedOnDt: json['BookedOnDt'].toString() as String,
      BookingType: json['BookingType'].toString() as String,
      UserType: json['UserType'].toString() as String,
      FullName: json['FullName'].toString() as String,
      DateOfPayment: json['DateOfPayment'].toString() as String,
      BookCardPassenger: json['BookCardPassenger'].toString() as String,
      BookCardDiscription: json['BookCardDiscription'].toString(),
      BookCardServiceDt: json['BookCardServiceDt'].toString() as String,
      BookingAmount: json['BookingAmount'].toString() as String,
      BookingCardServiceDate:
          json['BookingCardServiceDate'].toString() as String,
      PartPayment: json['PartPayment'].toString() as String,
      Currency: json['Currency'].toString() as String,
      DueDate: json['DueDate'].toString() as String,
    );
  }

//</editor-fold>
}
