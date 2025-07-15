class Table13ClientInvoiceHotelReceiptModel {
  String bookFlightId;
  String bookedOnDt;
  String ticketCode;
  String ticketNo;
  String bookingNumber;
  String bookingStatus;
  String bookingId;
  String passenger;
  String billDt;
  String billYr;
  String policyStatus;
  String isRefundable;
  String deadline;
  String tripType;
  String isApprovalRequest;
  String issueTicketStatus;
  String confirmStatus;

  Table13ClientInvoiceHotelReceiptModel({
    required this.bookFlightId,
    required this.bookedOnDt,
    required this.ticketCode,
    required this.ticketNo,
    required this.bookingNumber,
    required this.bookingStatus,
    required this.bookingId,
    required this.passenger,
    required this.billDt,
    required this.billYr,
    required this.policyStatus,
    required this.isRefundable,
    required this.deadline,
    required this.tripType,
    required this.isApprovalRequest,
    required this.issueTicketStatus,
    required this.confirmStatus,
  });

  factory Table13ClientInvoiceHotelReceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table13ClientInvoiceHotelReceiptModel(
      bookFlightId: json['BookFlightId'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      ticketCode: json['TicketCode'].toString(),
      ticketNo: json['TicketNo'].toString(),
      bookingNumber: json['Bookingnumber'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      bookingId: json['BookingId'].toString(),
      passenger: json['Passenger'].toString(),
      billDt: json['BillDt'].toString(),
      billYr: json['BillYr'].toString(),
      policyStatus: json['PolicyStatus'].toString(),
      isRefundable: json['IsRefundable'].toString(),
      deadline: json['Deadline'].toString(),
      tripType: json['TripType'].toString(),
      isApprovalRequest: json['IsApprovalRequest'].toString(),
      issueTicketStatus: json['IssueTicketStatus'].toString(),
      confirmStatus: json['ConfirmStatus'].toString(),
    );
  }
}
