class ClientInvoiceReportModel {
  String slNo;
  String bookFlightId;
  String ticketNo;
  String bookingId;
  String bookingNumber;
  String bookedOnDt;
  String bookingType;
  String passenger;
  String passengerList;
  String totalAmount;
  String bookingStatus;
  String bookingAmount;

  ClientInvoiceReportModel({
    required this.slNo,
    required this.bookFlightId,
    required this.ticketNo,
    required this.bookingId,
    required this.bookingNumber,
    required this.bookedOnDt,
    required this.bookingType,
    required this.passenger,
    required this.passengerList,
    required this.totalAmount,
    required this.bookingStatus,
    required this.bookingAmount,
  });

  factory ClientInvoiceReportModel.fromJson(Map<String, dynamic> json) {
    return ClientInvoiceReportModel(
      slNo: json['SlNo'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      ticketNo: json['Ticketno'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      bookingType: json['BookingType'].toString(),
      passenger: json['Passenger'].toString(),
      passengerList: json['PassengerList'].toString(),
      totalAmount: json['TotalAmt'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      bookingAmount: json['BookingAmount'].toString(),
    );
  }
}
