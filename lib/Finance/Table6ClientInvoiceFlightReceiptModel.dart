class Table6ClientInvoiceFlightReceiptModel {
  String receiptNo;
  String allocatedAmount;
  String status;
  String createdDatedt;

  Table6ClientInvoiceFlightReceiptModel({
    required this.receiptNo,
    required this.allocatedAmount,
    required this.status,
    required this.createdDatedt,
  });

  factory Table6ClientInvoiceFlightReceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table6ClientInvoiceFlightReceiptModel(
      receiptNo: json['ReceiptNo'].toString(),
      allocatedAmount: json['AllocatedAmount'].toString(),
      status: json['Status'].toString(),
      createdDatedt: json['createdDatedt'].toString(),
    );
  }
}
