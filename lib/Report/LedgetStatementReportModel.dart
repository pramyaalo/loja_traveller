class LedgetStatementReportModel {
  final String bookFlightId;
  final String id;
  final String userTypeId;
  final String userId;
  final String dateCreated;
  final String slNo;
  final String id1;
  final String credit;
  final String debit;
  final String totalAmount;
  final String balance;
  final String customerName;
  final String profit;
  final String message;
  final String dateCreated1;
  final String bookingId;
  final String currency;
  final String bookingRef;
  final String credit1;
  final String debit1;
  final String outstandingBalance;

  LedgetStatementReportModel({
    required this.bookFlightId,
    required this.id,
    required this.userTypeId,
    required this.userId,
    required this.dateCreated,
    required this.slNo,
    required this.id1,
    required this.credit,
    required this.debit,
    required this.totalAmount,
    required this.balance,
    required this.customerName,
    required this.profit,
    required this.message,
    required this.dateCreated1,
    required this.bookingId,
    required this.currency,
    required this.bookingRef,
    required this.credit1,
    required this.debit1,
    required this.outstandingBalance,
  });

  factory LedgetStatementReportModel.fromJson(Map<String, dynamic> json) {
    return LedgetStatementReportModel(
      bookFlightId: json['BookFlightId'].toString(),
      id: json['Id'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      dateCreated: json['DateCreated'].toString(),
      slNo: json['SlNo'].toString(),
      id1: json['Id1'].toString(),
      credit: json['Credit'].toString(),
      debit: json['Debit'].toString(),
      totalAmount: json['TotalAmount'].toString(),
      balance: json['Balance'].toString(),
      customerName: json['CustomerName'].toString(),
      profit: json['Profit'].toString(),
      message: json['Message'].toString(),
      dateCreated1: json['Datecreated1'].toString(),
      bookingId: json['BookingId'].toString(),
      currency: json['Currency'].toString(),
      bookingRef: json['BookingRef'].toString(),
      credit1: json['Credit1'].toString(),
      debit1: json['Debit1'].toString(),
      outstandingBalance: json['OutstandingBalance'].toString(),
    );
  }
}
