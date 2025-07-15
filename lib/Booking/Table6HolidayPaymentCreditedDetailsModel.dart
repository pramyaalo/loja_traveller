class Table6HolidayPaymentCreditedDetailsModel {
  final String receiptNo;
  final String allocatedAmount;
  final String status;
  final String createdDateDt;

  Table6HolidayPaymentCreditedDetailsModel({
    required this.receiptNo,
    required this.allocatedAmount,
    required this.status,
    required this.createdDateDt,
  });

  factory Table6HolidayPaymentCreditedDetailsModel.fromJson(Map<String, dynamic> json) {
    return Table6HolidayPaymentCreditedDetailsModel(
      receiptNo: json['ReceiptNo'].toString(),
      allocatedAmount: json['AllocatedAmount'].toString(),
      status: json['Status'].toString(),
      createdDateDt: json['createdDatedt'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ReceiptNo': receiptNo,
      'AllocatedAmount': allocatedAmount,
      'Status': status,
      'createdDatedt': createdDateDt,
    };
  }
}
