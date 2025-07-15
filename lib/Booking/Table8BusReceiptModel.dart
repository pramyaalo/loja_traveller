class Table8BusReceiptModel {
  final String receiptNo;
  final String allocatedAmount;
  final String status;
  final String createdDatedt;

  Table8BusReceiptModel({
    required this.receiptNo,
    required this.allocatedAmount,
    required this.status,
    required this.createdDatedt,
  });

  factory Table8BusReceiptModel.fromJson(Map<String, dynamic> json) {
    return Table8BusReceiptModel(
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
