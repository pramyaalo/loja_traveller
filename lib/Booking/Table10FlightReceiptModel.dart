class Table10FlightReceiptModel {
  final String receiptNo;
  final String allocatedAmount;
  final String status;
  final String createdDatedt;

  Table10FlightReceiptModel({
    required this.receiptNo,
    required this.allocatedAmount,
    required this.status,
    required this.createdDatedt,
  });

  factory Table10FlightReceiptModel.fromJson(Map<String, dynamic> json) {
    return Table10FlightReceiptModel(
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
