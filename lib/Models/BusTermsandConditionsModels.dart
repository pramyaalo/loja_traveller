class BusTermsandConditionsModels {
  String id;
  String bookFlightId;
  String traceID;
  String resultIndexID;
  String cancellationCharge;
  String cancellationChargeType;
  String policyString;
  String timeBeforeDept;
  String fromDate;
  String toDate;
  String createdDate;
  String createdBy;

  BusTermsandConditionsModels({
    required this.id,
    required this.bookFlightId,
    required this.traceID,
    required this.resultIndexID,
    required this.cancellationCharge,
    required this.cancellationChargeType,
    required this.policyString,
    required this.timeBeforeDept,
    required this.fromDate,
    required this.toDate,
    required this.createdDate,
    required this.createdBy,
  });

  factory BusTermsandConditionsModels.fromJson(Map<String, dynamic> json) {
    return BusTermsandConditionsModels(
      id: json['ID'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      traceID: json['TraceID'].toString(),
      resultIndexID: json['ResultIndexID'].toString(),
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
