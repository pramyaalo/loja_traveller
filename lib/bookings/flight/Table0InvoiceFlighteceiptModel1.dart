class Table0InvoiceFlighteceiptModel1 {
  final String bookFlightId;
  final String bookedOnDt;
  final String bookingStatus;
  final String billDt;
  final String billYr;
  final String ticketCode;
  final String ticketNo;
  final String bookingNumber;
  final String userTypeId;
  final String userId;
  final String bookingId;
  final String policyStatus;
  final String isRefundable;
  final String deadline;
  final String tripType;
  final String isApprovalRequest;
  final String issueTicketStatus;
  final String confirmStatus;

  Table0InvoiceFlighteceiptModel1({
    required this.bookFlightId,
    required this.bookedOnDt,
    required this.bookingStatus,
    required this.billDt,
    required this.billYr,
    required this.ticketCode,
    required this.ticketNo,
    required this.bookingNumber,
    required this.userTypeId,
    required this.userId,
    required this.bookingId,
    required this.policyStatus,
    required this.isRefundable,
    required this.deadline,
    required this.tripType,
    required this.isApprovalRequest,
    required this.issueTicketStatus,
    required this.confirmStatus,
  });

  factory Table0InvoiceFlighteceiptModel1.fromJson(Map<String, dynamic> json) {
    return Table0InvoiceFlighteceiptModel1(
      bookFlightId: json['BookFlightId'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      billDt: json['BillDt'].toString(),
      billYr: json['BillYr'].toString(),
      ticketCode: json['TicketCode'].toString(),
      ticketNo: json['TicketNo'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      bookingId: json['BookingId'].toString(),
      policyStatus: json['PolicyStatus'].toString(),
      isRefundable: json['IsRefundable'].toString(),
      deadline: json['Deadline'].toString(),
      tripType: json['TripType'].toString(),
      isApprovalRequest: json['IsApprovalRequest'].toString(),
      issueTicketStatus: json['IssueTicketStatus'].toString(),
      confirmStatus: json['ConfirmStatus'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BookFlightId': bookFlightId,
      'BookedOnDt': bookedOnDt,
      'BookingStatus': bookingStatus,
      'BillDt': billDt,
      'BillYr': billYr,
      'TicketCode': ticketCode,
      'TicketNo': ticketNo,
      'BookingNumber': bookingNumber,
      'UserTypeId': userTypeId,
      'UserId': userId,
      'BookingId': bookingId,
      'PolicyStatus': policyStatus,
      'IsRefundable': isRefundable,
      'Deadline': deadline,
      'TripType': tripType,
      'IsApprovalRequest': isApprovalRequest,
      'IssueTicketStatus': issueTicketStatus,
      'ConfirmStatus': confirmStatus,
    };
  }
}
