
class Table7HotelReceiptModel {
  final String custPaymentID;
  final String cpBookFlightId;
  final String transactionDate;
  final String transactionAmount;
  final String modeOfPayment;
  final String receiptNoTransId;
  final String status;
  final String paymentReversal;
  final String reconciled;
  final String currency;

  Table7HotelReceiptModel({
    required this.custPaymentID,
    required this.cpBookFlightId,
    required this.transactionDate,
    required this.transactionAmount,
    required this.modeOfPayment,
    required this.receiptNoTransId,
    required this.status,
    required  this.paymentReversal,
    required this.reconciled,
    required this.currency,
  });

  factory Table7HotelReceiptModel.fromJson(Map<String, dynamic> json) {
    return Table7HotelReceiptModel(
      custPaymentID: json['CustPaymentID'].toString(),
      cpBookFlightId: json['CPBookFlightId'].toString(),
      transactionDate: json['TransactionDate'].toString(),
      transactionAmount: json['TransactionAmount'].toString(),
      modeOfPayment: json['ModeofPayment'].toString(),
      receiptNoTransId: json['ReceiptNo_TransId'].toString(),
      status: json['Status'].toString(),
      paymentReversal: json['PaymentReversal'].toString(),
      reconciled: json['Reconciled'].toString(),
      currency: json['Currency'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CustPaymentID': custPaymentID,
      'CPBookFlightId': cpBookFlightId,
      'TransactionDate': transactionDate,
      'TransactionAmount': transactionAmount,
      'ModeofPayment': modeOfPayment,
      'ReceiptNo_TransId': receiptNoTransId,
      'Status': status,
      'PaymentReversal': paymentReversal,
      'Reconciled': reconciled,
      'Currency': currency,
    };
  }
}
