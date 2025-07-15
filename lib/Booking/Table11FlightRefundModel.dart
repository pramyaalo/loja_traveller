class Table11FlightRefundModel {
  final String receiptNo;
  final String refundAmount;
  final String refundServiceAmount;
  final String refundStatus;
  final String createdDatedt;

  Table11FlightRefundModel({
    required this.receiptNo,
    required this.refundAmount,
    required this.refundServiceAmount,
    required this.refundStatus,
    required this.createdDatedt,
  });

  factory Table11FlightRefundModel.fromJson(Map<String, dynamic> json) {
    return Table11FlightRefundModel(
      receiptNo: json['ReceiptNo'].toString(),
      refundAmount: json['RefundAmount'].toString(),
      refundServiceAmount: json['RefundServiceAmount'].toString(),
      refundStatus: json['RefundStatus'].toString(),
      createdDatedt: json['createdDatedt'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ReceiptNo': receiptNo,
      'RefundAmount': refundAmount,
      'RefundServiceAmount': refundServiceAmount,
      'RefundStatus': refundStatus,
      'createdDatedt': createdDatedt,
    };
  }

  @override
  String toString() {
    return 'ReceiptNo: $receiptNo, RefundAmount: $refundAmount, RefundServiceAmount: $refundServiceAmount, RefundStatus: $refundStatus, Date: $createdDatedt';
  }
}
