class UnTicketReportModel {
  final int bookFlightId;
  final String bookingProduct;
  final String bookingNumber;
  final int userTypeId;
  final int userId;
  final String bookedOn;
  final int slNo;
  final int userTypeId1;
  final int userId1;
  final int bookFlightId1;
  final String bookingId;
  final String bookingNumber1;
  final String bookingStatus;
  final String bookedOnDt;
  final String tripDate;
  final String originDestination;
  final String passenger;
  final String bookedProduct;
  final String journeyType;
  final String totalAmt;
  final String tripType;
  final String ticketNo;
  final String className;
  final String bookCardAmount;
  final String paidStatus;
  final String payMode;

  UnTicketReportModel({
    required this.bookFlightId,
    required this.bookingProduct,
    required this.bookingNumber,
    required this.userTypeId,
    required this.userId,
    required this.bookedOn,
    required this.slNo,
    required this.userTypeId1,
    required this.userId1,
    required this.bookFlightId1,
    required this.bookingId,
    required this.bookingNumber1,
    required this.bookingStatus,
    required this.bookedOnDt,
    required this.tripDate,
    required this.originDestination,
    required this.passenger,
    required this.bookedProduct,
    required this.journeyType,
    required this.totalAmt,
    required this.tripType,
    required this.ticketNo,
    required this.className,
    required this.bookCardAmount,
    required this.paidStatus,
    required this.payMode,
  });

  factory UnTicketReportModel.fromJson(Map<String, dynamic> json) {
    return UnTicketReportModel(
      bookFlightId: json['BookFlightId'] ?? 0,
      bookingProduct: json['BookingProduct'] ?? '',
      bookingNumber: json['BookingNumber'] ?? '',
      userTypeId: json['UserTypeId'] ?? 0,
      userId: json['UserId'] ?? 0,
      bookedOn: json['BookedOn'] ?? '',
      slNo: json['SlNo'] ?? 0,
      userTypeId1: json['UserTypeId1'] ?? 0,
      userId1: json['UserId1'] ?? 0,
      bookFlightId1: json['BookFlightId1'] ?? 0,
      bookingId: json['BookingId'] ?? '',
      bookingNumber1: json['BookingNumber1'] ?? '',
      bookingStatus: json['BookingStatus'] ?? '',
      bookedOnDt: json['BookedOnDt'] ?? '',
      tripDate: json['TripDate'] ?? '',
      originDestination: json['OriginDestination'] ?? '',
      passenger: json['Passenger'] ?? '',
      bookedProduct: json['BookedProduct'] ?? '',
      journeyType: json['JourneyType'] ?? '',
      totalAmt: json['TotalAmt'] ?? '',
      tripType: json['TripType'] ?? '',
      ticketNo: json['TicketNo'] ?? '',
      className: json['ClassName'] ?? '',
      bookCardAmount: json['BookCardAmount'] ?? '',
      paidStatus: json['PaidStatus'] ?? '',
      payMode: json['PayMode'] ?? '',
    );
  }
}
