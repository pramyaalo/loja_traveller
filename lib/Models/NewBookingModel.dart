class NewBookingModel {
  String slNo;
  String bookingId;
  String bookingNumber;
  String BookingCode;
  String BookedOn;
  String ticketNo;
  String BookingType;
  String AuthorizedStatus;
  String InvoiceAmount;
  String BookingStatus;

  NewBookingModel({
    required this.slNo,
    required this.bookingId,
    required this.bookingNumber,
    required this.BookingCode,
    required this.BookedOn,
    required this.ticketNo,
    required this.BookingType,
    required this.AuthorizedStatus,
    required this.InvoiceAmount,
    required this.BookingStatus,
  });

  factory NewBookingModel.fromJson(Map<String, dynamic> json) {
    return NewBookingModel(
      slNo: json['SlNo'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      BookingCode: json['BookingCode'].toString(),
      BookedOn: json['BookedOn'].toString(),
      ticketNo: json['TicketNo'].toString(),
      BookingType: json['BookingType'].toString(),
      AuthorizedStatus: json['AuthorizedStatus'].toString(),
      InvoiceAmount: json['InvoiceAmount'].toString(),
      BookingStatus: json['BookingStatus'].toString(),
    );
  }
}
