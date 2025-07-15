class Table6HotelReceiptModel {
  final String receiptNo;
  final String allocatedAmount;
  final String status;
  final String createdDate;

  Table6HotelReceiptModel({
    required this.receiptNo,
    required this.allocatedAmount,
    required this.status,
    required this.createdDate,
  });

    factory Table6HotelReceiptModel.fromJson(Map<String, dynamic> json) {
    return Table6HotelReceiptModel(
      receiptNo: json['ReceiptNo'].toString(),
      allocatedAmount: json['AllocatedAmount'].toString(),
      status: json['Status'].toString(),
      createdDate:json['createdDatedt'].toString(),
    );
  }




}
