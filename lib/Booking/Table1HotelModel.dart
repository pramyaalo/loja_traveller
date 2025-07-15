class Table1HotelModel {
  final String bookFlightId;
  final String bookedOnDt;
  final String ticketCode;
  final String ticketNo;
  final String bookingNumber;
  final String bookingStatus;
  final String bookingId;
  final String bookingType;
  final String passenger;
  final String billDt;
  final String billYr;
  final String policyStatus;
  final String isRefundable;
  final String deadline;
  final String tripType;
  final String isApprovalRequest;
  final String issueTicketStatus;
  final String confirmStatus;

  Table1HotelModel({
    required this.bookFlightId,
    required this.bookedOnDt,
    required this.ticketCode,
    required this.ticketNo,
    required this.bookingNumber,
    required this.bookingStatus,
    required this.bookingId,
    required this.bookingType,
    required this.passenger,
    required this.billDt,
    required this.billYr,
    required this.policyStatus,
    required this.isRefundable,
    required this.deadline,
    required this.tripType,
    required this.isApprovalRequest,
    required  this.issueTicketStatus,
    required this.confirmStatus,
  });

  factory Table1HotelModel.fromJson(Map<String, dynamic> json) {
    return Table1HotelModel(
      bookFlightId: json['BookFlightId'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      ticketCode: json['TicketCode'].toString(),
      ticketNo: json['TicketNo'].toString(),
      bookingNumber: json['Bookingnumber'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingType: json['BookingType'].toString(),
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

  Map<String, dynamic> toJson() {
    return {
      'BookFlightId': bookFlightId,
      'BookedOnDt': bookedOnDt,
      'TicketCode': ticketCode,
      'TicketNo': ticketNo,
      'Bookingnumber': bookingNumber,
      'BookingStatus': bookingStatus,
      'BookingId': bookingId,
      'BookingType': bookingType,
      'Passenger': passenger,
      'BillDt': billDt,
      'BillYr': billYr,
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
