class DebtorAgingReportModel {
  String slNo;
  String bookFlightId;
  String bookingID;
  String bookedOnDt;
  String totalAmt;
  String paidAmount;
  String outstandingAmount;
  String currency;
  String outstandingAmount1;
  String outstandingAmount2;
  String outstandingAmount3;
  String outstandingAmount4;

  DebtorAgingReportModel({
    required this.slNo,
    required this.bookFlightId,
    required this.bookingID,
    required this.bookedOnDt,
    required this.totalAmt,
    required this.paidAmount,
    required this.outstandingAmount,
    required this.currency,
    required this.outstandingAmount1,
    required this.outstandingAmount2,
    required this.outstandingAmount3,
    required this.outstandingAmount4,
  });

  factory DebtorAgingReportModel.fromJson(Map<String, dynamic> json) {
    return DebtorAgingReportModel(
      slNo: json['SlNo'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      bookingID: json['BookingID'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      totalAmt: json['TotalAmt'].toString(),
      paidAmount: json['PaidAmount'].toString(),
      outstandingAmount: json['OutstandingAmount'].toString(),
      currency: json['Currency'].toString(),
      outstandingAmount1: json['OutstandingAmount1'].toString(),
      outstandingAmount2: json['OutstandingAmount2'].toString(),
      outstandingAmount3: json['OutstandingAmount3'].toString(),
      outstandingAmount4: json['OutstandingAmount4'].toString(),
    );
  }
}
