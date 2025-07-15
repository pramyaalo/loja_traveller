class BookedItemViewModel {
  String bookFlightId;
  String bookingId;
  String bookingItemId;
  String bookingType;
  String bookingStatus;
  String ticketCode;
  String ticketNo;
  String bookingCreator;
  String dueDate;
  String agencyBranchName;
  String bookedOnDt;
  String authorizedBy;
  String salesChannel;
  String bookingTotalAmount;
  String bookingAPI;
  String bookingNumber;
  String currentDt;
  String documentStatus;
  String requestStatus;
  String payStatus;

  BookedItemViewModel({
    required this.bookFlightId,
    required this.bookingId,
    required this.bookingItemId,
    required this.bookingType,
    required this.bookingStatus,
    required this.ticketCode,
    required this.ticketNo,
    required this.bookingCreator,
    required this.dueDate,
    required this.agencyBranchName,
    required this.bookedOnDt,
    required this.authorizedBy,
    required this.salesChannel,
    required this.bookingTotalAmount,
    required this.bookingAPI,
    required this.bookingNumber,
    required this.currentDt,
    required this.documentStatus,
    required this.requestStatus,
    required this.payStatus,
  });

  factory BookedItemViewModel.fromJson(Map<String, dynamic> json) {
    return BookedItemViewModel(
      bookFlightId: json['BookFlightId'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingItemId: json['BookingItemId'].toString(),
      bookingType: json['BookingType'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      ticketCode: json['TicketCode'].toString(),
      ticketNo: json['TicketNo'].toString(),
      bookingCreator: json['BookingCreator'].toString(),
      dueDate: json['DueDate'].toString(),
      agencyBranchName: json['AgencyBranchName'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      authorizedBy: json['AuthorizedBy'].toString(),
      salesChannel: json['SalesChannel'].toString(),
      bookingTotalAmount: json['BookingTotalAmount'].toString(),
      bookingAPI: json['BookingAPI'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      currentDt: json['CurrentDt'].toString(),
      documentStatus: json['DocumentStatus'].toString(),
      requestStatus: json['RequestStatus'].toString(),
      payStatus: json['PayStatus'].toString(),
    );
  }
}
