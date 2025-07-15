class ChangingRequestReportModel {
  String slNo;
  String bookingFlightChangeId;
  String bookingId;
  String bookFlightId;
  String requestNumber;
  String arrivalDate;
  String departureDate;
  String preferredClass;
  String request;
  String attachment;
  String message;
  String createdDate;

  ChangingRequestReportModel({
    required this.slNo,
    required this.bookingFlightChangeId,
    required this.bookingId,
    required this.bookFlightId,
    required this.requestNumber,
    required this.arrivalDate,
    required this.departureDate,
    required this.preferredClass,
    required this.request,
    required this.attachment,
    required this.message,
    required this.createdDate,
  });

  factory ChangingRequestReportModel.fromJson(Map<String, dynamic> json) {
    return ChangingRequestReportModel(
      slNo: json['SlNo'].toString(),
      bookingFlightChangeId: json['BookingFlightChangeId'].toString(),
      bookingId: json['BookingId'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      requestNumber: json['RequestNumber'].toString(),
      arrivalDate: json['ArrivalDate'].toString(),
      departureDate: json['DepartureDate'].toString(),
      preferredClass: json['PreferredClass'].toString(),
      request: json['Request'].toString(),
      attachment: json['Attachment'].toString(),
      message: json['Message'].toString(),
      createdDate: json['CreatedDate'].toString(),
    );
  }
}
