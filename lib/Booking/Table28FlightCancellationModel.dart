class Table28FlightCancellationModel {
  final String bookingFlightChangeId;
  final String bookingFlightId;
  final String requestNumber;
  final String arrivalDate;
  final String departureDate;
  final String reservationCode;
  final String eticketNumbers;
  final String departureCode;
  final String arrivalCode;
  final String preferredClass;
  final String request;
  final String attachment;
  final String message;
  final String createdDate;
  final String requestStatus;

  Table28FlightCancellationModel({
    required this.bookingFlightChangeId,
    required this.bookingFlightId,
    required this.requestNumber,
    required this.arrivalDate,
    required this.departureDate,
    required this.reservationCode,
    required this.eticketNumbers,
    required this.departureCode,
    required  this.arrivalCode,
    required this.preferredClass,
    required this.request,
    required this.attachment,
    required this.message,
    required this.createdDate,
    required this.requestStatus,
  });

  factory Table28FlightCancellationModel.fromJson(Map<String, dynamic> json) {
    return Table28FlightCancellationModel(
      bookingFlightChangeId: json['BookingFlightChangeId'].toString(),
      bookingFlightId: json['BookingFlightID'].toString(),
      requestNumber: json['RequestNumber'].toString(),
      arrivalDate: json['ArrivalDate'].toString(),
      departureDate: json['DepartureDate'].toString(),
      reservationCode: json['ReservationCode'].toString(),
      eticketNumbers: json['EticketNumbers'].toString(),
      departureCode: json['DepartureCode'].toString(),
      arrivalCode: json['ArrivalCode'].toString(),
      preferredClass: json['PreferredClass'].toString(),
      request: json['Request'].toString(),
      attachment: json['Attachment'].toString(),
      message: json['Message'].toString(),
      createdDate: json['CreatedDate'].toString(),
      requestStatus: json['RequestStatus'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BookingFlightChangeId': bookingFlightChangeId,
      'BookingFlightID': bookingFlightId,
      'RequestNumber': requestNumber,
      'ArrivalDate': arrivalDate,
      'DepartureDate': departureDate,
      'ReservationCode': reservationCode,
      'EticketNumbers': eticketNumbers,
      'DepartureCode': departureCode,
      'ArrivalCode': arrivalCode,
      'PreferredClass': preferredClass,
      'Request': request,
      'Attachment': attachment,
      'Message': message,
      'CreatedDate': createdDate,
      'RequestStatus': requestStatus,
    };
  }
}
