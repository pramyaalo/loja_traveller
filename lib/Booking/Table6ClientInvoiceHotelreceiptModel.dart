class Table6ClientInvoiceHotelreceiptModel {
  String receiptNo;
  String allocatedAmount;
  String status;
  String createdDatedt;

  Table6ClientInvoiceHotelreceiptModel({
    required this.receiptNo,
    required this.allocatedAmount,
    required this.status,
    required this.createdDatedt,
  });

  factory Table6ClientInvoiceHotelreceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table6ClientInvoiceHotelreceiptModel(
      receiptNo: json['ReceiptNo'].toString(),
      allocatedAmount: json['AllocatedAmount'].toString(),
      status: json['Status'].toString(),
      createdDatedt: json['createdDatedt'].toString(),
    );
  }
}
