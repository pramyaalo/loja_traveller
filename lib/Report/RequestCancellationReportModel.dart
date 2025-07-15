class RequestCancellationReportModel {
  String slNo;
  String bookingFlightCancellId;
  String bookFlightId;
  String bookingId;
  String requestNumber;
  String requestTime;
  String status;
  String type;
  String requestAction;
  String attachment;
  String requestDetails;
  String createdDate;

  RequestCancellationReportModel({
    required this.slNo,
    required this.bookingFlightCancellId,
    required this.bookFlightId,
    required this.bookingId,
    required this.requestNumber,
    required this.requestTime,
    required this.status,
    required this.type,
    required this.requestAction,
    required this.attachment,
    required this.requestDetails,
    required this.createdDate,
  });

  factory RequestCancellationReportModel.fromJson(Map<String, dynamic> json) {
    return RequestCancellationReportModel(
      slNo: json['SlNo'].toString(),
      bookingFlightCancellId: json['BookingFlightCancellId'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      bookingId: json['BookingId'].toString(),
      requestNumber: json['RequestNumber'].toString(),
      requestTime: json['RequestTime'].toString(),
      status: json['Status'].toString(),
      type: json['Type'].toString(),
      requestAction: json['Requestaction'].toString(),
      attachment: json['Attachment'].toString(),
      requestDetails: json['RequestDetails'].toString(),
      createdDate: json['CreatedDate'].toString(),
    );
  }
}
