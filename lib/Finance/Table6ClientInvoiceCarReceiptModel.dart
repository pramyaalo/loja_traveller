class Table6ClientInvoiceCarReceiptModel {
  String receiptNo;
  String allocatedAmount;
  String status;
  String createdDatedt;

  Table6ClientInvoiceCarReceiptModel({
    required this.receiptNo,
    required this.allocatedAmount,
    required this.status,
    required this.createdDatedt,
  });

  factory Table6ClientInvoiceCarReceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table6ClientInvoiceCarReceiptModel(
      receiptNo: json['ReceiptNo'].toString(),
      allocatedAmount: json['AllocatedAmount'].toString(),
      status: json['Status'].toString(),
      createdDatedt: json['createdDatedt'].toString(),
    );
  }
}
