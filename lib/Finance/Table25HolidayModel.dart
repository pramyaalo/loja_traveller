class Table25HolidayModel {
  String receiptNo;
  String allocatedAmount;
  String status;
  String createdDate;

  Table25HolidayModel({
    required this.receiptNo,
    required this.allocatedAmount,
    required this.status,
    required this.createdDate,
  });

  factory Table25HolidayModel.fromJson(Map<String, dynamic> json) {
    return Table25HolidayModel(
      receiptNo: json['ReceiptNo'].toString(),
      allocatedAmount: json['AllocatedAmount'].toDouble().toString(),
      status: json['Status'].toString(),
      createdDate: json['createdDatedt'].toString(),
    );
  }
}
