class Table0HotelListModel {
  final String bookFlightId;
  final String tripType;
  final String bookingId;
  final String bookingItemId;
  final String bookingType;
  final String bookingStatus;
  final String roundDomesticBookId;
  final String ticketCode;
  final String ticketNo;
  final String bookingCreator;
  final String dueDate;
  final String agencyBranchName;
  final String bookedOnDt;
  final String authorizedBy;
  final String salesChannel;
  final String bookingTotalAmount;
  final String bookingAPI;
  final String bookingNumber;
  final String currentDt;
  final String documentStatus;
  final String requestStatus;
  final String payStatus;
  final String paidStatus;
  final String userTypeId;
  final String userId;

  Table0HotelListModel({
    required this.bookFlightId,
    required this.tripType,
    required this.bookingId,
    required this.bookingItemId,
    required this.bookingType,
    required this.bookingStatus,
    required this.roundDomesticBookId,
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
    required  this.requestStatus,
    required this.payStatus,
    required this.paidStatus,
    required this.userTypeId,
    required this.userId,
  });

  factory Table0HotelListModel.fromJson(Map<String, dynamic> json) {
    return Table0HotelListModel(
      bookFlightId: json['BookFlightId'].toString(),
      tripType: json['TripType'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingItemId: json['BookingItemId'].toString(),
      bookingType: json['BookingType'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      roundDomesticBookId: json['RoundDomesticBookId'].toString(),
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
      paidStatus: json['PaidStatus'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BookFlightId': bookFlightId,
      'TripType': tripType,
      'BookingId': bookingId,
      'BookingItemId': bookingItemId,
      'BookingType': bookingType,
      'BookingStatus': bookingStatus,
      'RoundDomesticBookId': roundDomesticBookId,
      'TicketCode': ticketCode,
      'TicketNo': ticketNo,
      'BookingCreator': bookingCreator,
      'DueDate': dueDate,
      'AgencyBranchName': agencyBranchName,
      'BookedOnDt': bookedOnDt,
      'AuthorizedBy': authorizedBy,
      'SalesChannel': salesChannel,
      'BookingTotalAmount': bookingTotalAmount,
      'BookingAPI': bookingAPI,
      'BookingNumber': bookingNumber,
      'CurrentDt': currentDt,
      'DocumentStatus': documentStatus,
      'RequestStatus': requestStatus,
      'PayStatus': payStatus,
      'PaidStatus': paidStatus,
      'UserTypeId': userTypeId,
      'UserId': userId,
    };
  }
}
