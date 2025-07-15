  class Table6FlightReceiptModel {
  final String receiptNo;
  final String allocatedAmount;
  final String status;
  final String createdDate;

  Table6FlightReceiptModel({
    required this.receiptNo,
    required this.allocatedAmount,
    required this.status,
    required this.createdDate,
  });

  // Factory method to create an instance from JSON
  factory Table6FlightReceiptModel.fromJson(Map<String, dynamic> json) {
    return Table6FlightReceiptModel(
      receiptNo: json['ReceiptNo'].toString(),
      allocatedAmount: json['AllocatedAmount'].toString(),
      status: json['Status'].toString(),
      createdDate: json['createdDatedt'].toString(),
    );
  }

  // Convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'ReceiptNo': receiptNo,
      'AllocatedAmount': allocatedAmount,
      'Status': status,
      'createdDatedt': createdDate,
    };
  }
}
