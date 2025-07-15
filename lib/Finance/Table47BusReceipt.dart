class Table47BusReceipt {
  String id;
  String bookFlightId;
  String traceId;
  String resultIndexId;
  String cancellationCharge;
  String cancellationChargeType;
  String policyString;
  String timeBeforeDept;
  String fromDate;
  String toDate;
  String createdDate;
  String createdBy;

  Table47BusReceipt({
    required this.id,
    required this.bookFlightId,
    required this.traceId,
    required this.resultIndexId,
    required this.cancellationCharge,
    required this.cancellationChargeType,
    required this.policyString,
    required this.timeBeforeDept,
    required this.fromDate,
    required this.toDate,
    required this.createdDate,
    required this.createdBy,
  });

  factory Table47BusReceipt.fromJson(Map<String, dynamic> json) {
    return Table47BusReceipt(
      id: json['ID'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      traceId: json['TraceID'].toString(),
      resultIndexId: json['ResultIndexID'].toString(),
      cancellationCharge: json['CancellationCharge'].toString(),
      cancellationChargeType: json['CancellationChargeType'].toString(),
      policyString: json['PolicyString'].toString(),
      timeBeforeDept: json['TimeBeforeDept'].toString(),
      fromDate: json['FromDate'].toString(),
      toDate: json['ToDate'].toString(),
      createdDate: json['CreatedDate'].toString(),
      createdBy: json['CreatedBy'].toString(),
    );
  }
}
