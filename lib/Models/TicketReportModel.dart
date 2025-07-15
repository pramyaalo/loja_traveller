class TicketReportModel {
  String SlNo;
  String UserTypeId;
  String UserId;
  String BookFlightId;
  String BookingId;
  String BookingNumber;
  String BookingStatus;
  String BookedOnDt;
  String TripDate;
  String OriginDestination;
  String Passenger;
  String TicketNo;
  String ClassName;
  String BookCardAmount;
  String PaidStatus;
  String PayMode;
  String BookedProduct;
  String JourneyType;

  TicketReportModel({
    required this.SlNo,
    required this.UserTypeId,
    required this.UserId,
    required this.BookFlightId,
    required this.BookingId,
    required this.BookingNumber,
    required this.BookingStatus,
    required this.BookedOnDt,
    required this.TripDate,
    required this.OriginDestination,
    required this.Passenger,
    required this.TicketNo,
    required this.ClassName,
    required this.BookCardAmount,
    required this.PaidStatus,
    required this.PayMode,
    required this.BookedProduct,
    required this.JourneyType,
  });

  factory TicketReportModel.fromJson(Map<String, dynamic> json) {
    return TicketReportModel(
      SlNo: json['SlNo'].toString(),
      UserTypeId: json['UserTypeId'].toString(),
      UserId: json['UserId'].toString(),
      BookFlightId: json['BookFlightId'].toString(),
      BookingId: json['BookingId'].toString(),
      BookingNumber: json['BookingNumber'].toString(),
      BookingStatus: json['BookingStatus'].toString(),
      BookedOnDt: json['BookedOnDt'].toString(),
      TripDate: json['TripDate'].toString(),
      OriginDestination: json['OriginDestination'].toString(),
      Passenger: json['Passenger'].toString(),
      TicketNo: json['TicketNo'].toString(),
      ClassName: json['ClassName'].toString(),
      BookCardAmount: json['BookCardAmount'].toString(),
      PaidStatus: json['PaidStatus'].toString(),
      PayMode: json['PayMode'].toString(),
      BookedProduct: json['BookedProduct'].toString(),
      JourneyType: json['JourneyType'].toString(),
    );
  }
}
