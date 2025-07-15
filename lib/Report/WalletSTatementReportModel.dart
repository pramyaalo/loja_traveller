class WalletSTatementReportModel {
  final String id;
  final String createDate;
  final String rolePKId;
  final String customerId;
  final String slNo;
  final String id1;
  final String credit;
  final String debit;
  final String balance;
  final String profit;
  final String message;
  final String rolePKId1;
  final String customerId1;
  final String dateCreated;
  final String currency;
  final String outstandingBalance;
  final String customerType;
  final String customerName;

  WalletSTatementReportModel({
    required this.id,
    required this.createDate,
    required this.rolePKId,
    required this.customerId,
    required this.slNo,
    required this.id1,
    required this.credit,
    required this.debit,
    required this.balance,
    required this.profit,
    required this.message,
    required this.rolePKId1,
    required this.customerId1,
    required this.dateCreated,
    required this.currency,
    required this.outstandingBalance,
    required this.customerType,
    required this.customerName,
  });

  factory WalletSTatementReportModel.fromJson(Map<String, dynamic> json) {
    return WalletSTatementReportModel(
      id: json['Id'].toString(),
      createDate: json['CreateDate'].toString(),
      rolePKId: json['RolePKId'].toString(),
      customerId: json['CustomerId'].toString(),
      slNo: json['SlNo'].toString(),
      id1: json['Id1'].toString(),
      credit: json['Credit'].toString(),
      debit: json['Debit'] .toString(),
      balance: json['Balance'].toString(),
      profit: json['Profit'].toString(),
      message: json['Message'].toString(),
      rolePKId1: json['RolePKId1'].toString(),
      customerId1: json['CustomerId1'].toString(),
      dateCreated: json['Datecreated'].toString(),
      currency: json['Currency'].toString(),
      outstandingBalance: json['OutstandingBalance'].toString(),
      customerType: json['customertype'].toString(),
      customerName: json['customername'].toString(),
    );
  }
}
