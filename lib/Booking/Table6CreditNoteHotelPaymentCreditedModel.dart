class Table6CreditNoteHotelPaymentCreditedModel {
  final String receiptNo;
  final String allocatedAmount;
  final String status;
  final String createdDatedt;

  Table6CreditNoteHotelPaymentCreditedModel({
    required this.receiptNo,
    required this.allocatedAmount,
    required this.status,
    required this.createdDatedt,
  });

  factory Table6CreditNoteHotelPaymentCreditedModel.fromJson(Map<String, dynamic> json) {
    return Table6CreditNoteHotelPaymentCreditedModel(
      receiptNo: json['ReceiptNo'].toString(),
      allocatedAmount: json['AllocatedAmount'].toString(),
      status: json['Status'].toString(),
      createdDatedt: json['createdDatedt'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ReceiptNo': receiptNo,
      'AllocatedAmount': allocatedAmount,
      'Status': status,
      'createdDatedt': createdDatedt,
    };
  }
}
