class Table8CarReceiptModel {
  final String receiptNo;
  final String allocatedAmount;
  final String status;
  final String createdDatedt;

  Table8CarReceiptModel({
    required this.receiptNo,
    required this.allocatedAmount,
    required this.status,
    required this.createdDatedt,
  });

  factory Table8CarReceiptModel.fromJson(Map<String, dynamic> json) {
    return Table8CarReceiptModel(
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
