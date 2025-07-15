class OpenBookingModel {
  String slNo;
  String BookFlightId;
  String bookingId;
  String bookingNumber;
  String BookingCode;
  String BookedOn;
  String TicketCode;
  String ticketNo;
  String BookingType;
  String AuthorizedStatus;
  String InvoiceAmount;
  String BookingStatus;

  OpenBookingModel({
    required this.slNo,
    required this.BookFlightId,
    required this.bookingId,
    required this.bookingNumber,
    required this.BookingCode,
    required this.BookedOn,
    required this.TicketCode,
    required this.ticketNo,
    required this.BookingType,
    required this.AuthorizedStatus,
    required this.InvoiceAmount,
    required this.BookingStatus,
  });

  factory OpenBookingModel.fromJson(Map<String, dynamic> json) {
    return OpenBookingModel(
      slNo: json['SlNo'].toString(),
      BookFlightId: json['BookFlightId'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      BookingCode: json['BookingCode'].toString(),
      BookedOn: json['BookedOn'].toString(),
      TicketCode: json['TicketCode'].toString(),
      ticketNo: json['TicketNo'].toString(),
      BookingType: json['BookingType'].toString(),
      AuthorizedStatus: json['AuthorizedStatus'].toString(),
      InvoiceAmount: json['InvoiceAmount'].toString(),
      BookingStatus: json['BookingStatus'].toString(),
    );
  }
}
