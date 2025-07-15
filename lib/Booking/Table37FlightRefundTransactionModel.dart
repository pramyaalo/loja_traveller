class Table37FlightRefundTransactionModel {
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
  final String bookingAmount;
  final String cancellStatus;

  Table37FlightRefundTransactionModel({
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
    required this.bookingAmount,
    required this.cancellStatus,
  });

  factory Table37FlightRefundTransactionModel.fromJson(Map<String, dynamic> json) {
    return Table37FlightRefundTransactionModel(
      custPaymentID: json['CustPaymentID'].toString(),
      cpBookFlightId: json['CPBookFlightId'].toString(),
      currency: json['Currency'].toString(),
      dateOfPayment: json['DateOfPayment'].toString(),
      allocatedAmount: json['AllocatedAmount'].toString(),
      balanceAmount: json['BalanceAmount'] .toString(),
      refundDate: json['RefundDate'].toString(),
      createdDate: json['CreatedDate'].toString(),
      refundAmount: json['RefundAmount'].toString(),
      refundServiceAmount: json['RefundServiceAmount'].toString(),
      refundType: json['RefundType'].toString(),
      refundStatus: json['RefundStatus'].toString(),
      totalRefund: json['TotalRefund'].toString(),
      bookingAmount: json['BookingAmount'].toString(),
      cancellStatus: json['CancellStatus'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CustPaymentID': custPaymentID,
      'CPBookFlightId': cpBookFlightId,
      'Currency': currency,
      'DateOfPayment': dateOfPayment,
      'AllocatedAmount': allocatedAmount,
      'BalanceAmount': balanceAmount,
      'RefundDate': refundDate,
      'CreatedDate': createdDate,
      'RefundAmount': refundAmount,
      'RefundServiceAmount': refundServiceAmount,
      'RefundType': refundType,
      'RefundStatus': refundStatus,
      'TotalRefund': totalRefund,
      'BookingAmount': bookingAmount,
      'CancellStatus': cancellStatus,
    };
  }
}
