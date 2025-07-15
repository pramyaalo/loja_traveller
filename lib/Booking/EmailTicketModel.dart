class EmailTicketModel {
  final String bookFlightId;
  final String bookingType;
  final String bookingId;
  final String createdBy;
  final String userTypeId;
  final String userId;
  final String bookedOn;
  final String tripId;
  final String bookingNumber;
  final String bookedOnDt;
  final String bookFlightId1;
  final String bookingType1;
  final String bookingId1;
  final String bookingItemId;
  final String bookCardPassenger;
  final String bookCardServiceDt;
  final String bookCardDescription;
  final String bookCardAmount;
  final String payMode;
  final String bookingAmount;
  final String bookingStatus;
  final String docView;
  final String bookinDate;
  final String bookingCardServiceDate;
  final String paidStatus;

  EmailTicketModel({
    required this.bookFlightId,
    required this.bookingType,
    required this.bookingId,
    required this.createdBy,
    required this.userTypeId,
    required this.userId,
    required this.bookedOn,
    required this.tripId,
    required this.bookingNumber,
    required this.bookedOnDt,
    required this.bookFlightId1,
    required this.bookingType1,
    required this.bookingId1,
    required this.bookingItemId,
    required this.bookCardPassenger,
    required this.bookCardServiceDt,
    required this.bookCardDescription,
    required this.bookCardAmount,
    required this.payMode,
    required this.bookingAmount,
    required this.bookingStatus,
    required this.docView,
    required this.bookinDate,
    required this.bookingCardServiceDate,
    required this.paidStatus,
  });

  factory EmailTicketModel.fromJson(Map<String, dynamic> json) {
    return EmailTicketModel(
      bookFlightId: json['BookFlightId'].toString(),
      bookingType: json['BookingType'].toString(),
      bookingId: json['BookingId'].toString(),
      createdBy: json['Createdby'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      bookedOn: json['BookedOn'].toString(),
      tripId: json['TripId'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      bookFlightId1: json['BookFlightId1'].toString(),
      bookingType1: json['BookingType1'].toString(),
      bookingId1: json['BookingId1'].toString(),
      bookingItemId: json['BookingItemId'].toString(),
      bookCardPassenger: json['BookCardPassenger'].toString(),
      bookCardServiceDt: json['BookCardServiceDt'].toString(),
      bookCardDescription: json['BookCardDiscription'].toString(),
      bookCardAmount: json['BookCardAmount'].toString(),
      payMode: json['PayMode'].toString(),
      bookingAmount: json['BookingAmount'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      docView: json['DocView'].toString(),
      bookinDate: json['BookinDate'].toString(),
      bookingCardServiceDate: json['BookingCardServiceDate'].toString(),
      paidStatus: json['PaidStatus'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BookFlightId': bookFlightId,
      'BookingType': bookingType,
      'BookingId': bookingId,
      'Createdby': createdBy,
      'UserTypeId': userTypeId,
      'UserId': userId,
      'BookedOn': bookedOn,
      'TripId': tripId,
      'BookingNumber': bookingNumber,
      'BookedOnDt': bookedOnDt,
      'BookFlightId1': bookFlightId1,
      'BookingType1': bookingType1,
      'BookingId1': bookingId1,
      'BookingItemId': bookingItemId,
      'BookCardPassenger': bookCardPassenger,
      'BookCardServiceDt': bookCardServiceDt,
      'BookCardDiscription': bookCardDescription,
      'BookCardAmount': bookCardAmount,
      'PayMode': payMode,
      'BookingAmount': bookingAmount,
      'BookingStatus': bookingStatus,
      'DocView': docView,
      'BookinDate': bookinDate,
      'BookingCardServiceDate': bookingCardServiceDate,
      'PaidStatus': paidStatus,
    };
  }
}
