class table34PayamentTransactionbalanceModel {
  final String custPaymentID;
  final String cpBookFlightId;
  final String currency;
  final String dateOfPayment;
  final String allocatedAmount;
  final String balanceAmount;
  final String refundDate;
  final String createdDate;
  final String refundAmount;
  final String refundServiceAmount;
  final String refundType;
  final String refundStatus;
  final String totalRefund;
  final String paymentMode;
  final String bookingAmount;

  table34PayamentTransactionbalanceModel({
    required this.custPaymentID,
    required this.cpBookFlightId,
    required this.currency,
    required this.dateOfPayment,
    required this.allocatedAmount,
    required this.balanceAmount,
    required this.refundDate,
    required this.createdDate,
    required this.refundAmount,
    required this.refundServiceAmount,
    required this.refundType,
    required this.refundStatus,
    required this.totalRefund,
    required this.paymentMode,
    required this.bookingAmount,
  });

  factory table34PayamentTransactionbalanceModel.fromJson(Map<String, dynamic> json) {
    return table34PayamentTransactionbalanceModel(
      custPaymentID: json['CustPaymentID'].toString(),
      cpBookFlightId: json['CPBookFlightId'].toString(),
      currency: json['Currency'].toString(),
      dateOfPayment: json['DateOfPayment'].toString(),
      allocatedAmount: json['AllocatedAmount'].toString(),
      balanceAmount: json['BalanceAmount'].toString(),
      refundDate: json['RefundDate'].toString(),
      createdDate: json['CreatedDate'].toString(),
      refundAmount: json['RefundAmount'].toString(),
      refundServiceAmount: json['RefundServiceAmount'].toString(),
      refundType: json['RefundType'].toString(),
      refundStatus: json['RefundStatus'].toString(),
      totalRefund: json['TotalRefund'].toString(),
      paymentMode: json['PaymentMode'].toString(),
      bookingAmount: json['BookingAmount'].toString(),
    );
  }

}
