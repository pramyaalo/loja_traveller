class CancelBookingListModel {
  String bookingFlightChangeId;
  String bookingFlightID;
  String requestNumber;
  String arrivalDate;
  String departureDate;
  String preferredClass;
  String request;
  String attachment;
  String message;
  String createdDate;
  String requestStatus;

  CancelBookingListModel({
    required this.bookingFlightChangeId,
    required this.bookingFlightID,
    required this.requestNumber,
    required this.arrivalDate,
    required this.departureDate,
    required this.preferredClass,
    required this.request,
    required this.attachment,
    required this.message,
    required this.createdDate,
    required this.requestStatus,
  });

  factory CancelBookingListModel.fromJson(Map<String, dynamic> json) {
    return CancelBookingListModel(
      bookingFlightChangeId: json['BookingFlightChangeId'].toString(),
      bookingFlightID: json['BookingFlightID'].toString(),
      requestNumber: json['RequestNumber'].toString(),
      arrivalDate: json['ArrivalDate'].toString(),
      departureDate: json['DepartureDate'].toString(),
      preferredClass: json['PreferredClass'].toString(),
      request: json['Request'].toString(),
      attachment: json['Attachment'].toString(),
      message: json['Message'].toString(),
      createdDate: json['CreatedDate'].toString(),
      requestStatus: json['RequestStatus'].toString(),
    );
  }
}
