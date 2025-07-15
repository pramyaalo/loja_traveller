class Table0FlightTicketVoucherModel {
  final String bookFlightId;
  final String bookingId;
  final String bookingItemId;
  final String bookingNumber;
  final String bookingType;
  final String bookingStatus;
  final String ticketCode;
  final String ticketNo;
  final String bookingCreator;
  final String dueDate;
  final String tripType;
  final String agencyBranchName;
  final String bookedOnDt;
  final String authorizedBy;
  final String bookingDate;
  final String salesChannel;
  final String bookingTotalAmount;
  final String bookingNumber1;
  final String currentDt;
  final String documentStatus;
  final String requestStatus;
  final String payStatus;

  Table0FlightTicketVoucherModel({
    required this.bookFlightId,
    required this.bookingId,
    required this.bookingItemId,
    required this.bookingNumber,
    required this.bookingType,
    required this.bookingStatus,
    required this.ticketCode,
    required this.ticketNo,
    required this.bookingCreator,
    required this.dueDate,
    required this.tripType,
    required this.agencyBranchName,
    required this.bookedOnDt,
    required this.authorizedBy,
    required this.bookingDate,
    required this.salesChannel,
    required this.bookingTotalAmount,
    required this.bookingNumber1,
    required this.currentDt,
    required this.documentStatus,
    required this.requestStatus,
    required this.payStatus,
  });

  factory Table0FlightTicketVoucherModel.fromJson(Map<String, dynamic> json) {
    return Table0FlightTicketVoucherModel(
      bookFlightId: json['BookFlightId'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingItemId: json['BookingItemId'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      bookingType: json['BookingType'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      ticketCode: json['TicketCode'].toString(),
      ticketNo: json['TicketNo'].toString(),
      bookingCreator: json['BookingCreator'].toString(),
      dueDate: json['DueDate'].toString(),
      tripType: json['TripType'].toString(),
      agencyBranchName: json['AgencyBranchName'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      authorizedBy: json['AuthorizedBy'].toString(),
      bookingDate: json['BookingDate'].toString(),
      salesChannel: json['SalesChannel'].toString(),
      bookingTotalAmount: json['BookingTotalAmount'].toString(),
      bookingNumber1: json['BookingNumber1'].toString(),
      currentDt: json['CurrentDt'].toString(),
      documentStatus: json['DocumentStatus'].toString(),
      requestStatus: json['RequestStatus'].toString(),
      payStatus: json['PayStatus'].toString(),
    );
  }
}
