class Table6ClientInvoiceHolidayReceiptModel {
  String receiptNo;
  String allocatedAmount;
  String status;
  String createdDatedt;

  Table6ClientInvoiceHolidayReceiptModel({
    required this.receiptNo,
    required this.allocatedAmount,
    required this.status,
    required this.createdDatedt,
  });

  factory Table6ClientInvoiceHolidayReceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table6ClientInvoiceHolidayReceiptModel(
      receiptNo: json['ReceiptNo'].toString(),
      allocatedAmount: json['AllocatedAmount'].toString(),
      status: json['Status'].toString(),
      createdDatedt: json['createdDatedt'].toString(),
    );
  }
}
