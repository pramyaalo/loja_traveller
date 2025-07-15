class Table6CreditNoteFlightReceiptModel {
  String receiptNo;
  String allocatedAmount;
  String status;
  String createdDate;

  Table6CreditNoteFlightReceiptModel({
    required this.receiptNo,
    required this.allocatedAmount,
    required this.status,
    required this.createdDate,
  });

  factory Table6CreditNoteFlightReceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table6CreditNoteFlightReceiptModel(
      receiptNo: json['ReceiptNo'].toString(),
      allocatedAmount: json['AllocatedAmount'].toString(),
      status: json['Status'].toString(),
      createdDate: json['createdDatedt'].toString(),
    );
  }
}
