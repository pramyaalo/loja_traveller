class FlightTicketListModel {
  final String bookFlightId;
  final String bookingType;
  final String ticketNo;
  final String bookedOnDt;
  final String product;
  final String originDestination;
  final String passenger;
  final String journey;
  final String totalAmount;
  final String bookingId;
  final String bookingNumber;
  final String totalFare;
  final String gstAmount;
  final String serviceTaxAmount;
  final String currency;
  final String bookingStatus;
  final String userTypeId;
  final String userId;
  final String passengerId;
  final String rn;

  FlightTicketListModel({
    required this.bookFlightId,
    required this.bookingType,
    required this.ticketNo,
    required this.bookedOnDt,
    required this.product,
    required this.originDestination,
    required this.passenger,
    required this.journey,
    required this.totalAmount,
    required this.bookingId,
    required this.bookingNumber,
    required this.totalFare,
    required this.gstAmount,
    required this.serviceTaxAmount,
    required this.currency,
    required this.bookingStatus,
    required this.userTypeId,
    required this.userId,
    required this.passengerId,
    required this.rn,
  });

  factory FlightTicketListModel.fromJson(Map<String, dynamic> json) {
    return FlightTicketListModel(
      bookFlightId: json['BookFlightId'].toString(),
      bookingType: json['BookingType'].toString(),
      ticketNo: json['TicketNo'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      product: json['Product'].toString(),
      originDestination: json['OriginDestination'].toString(),
      passenger: json['Passenger'].toString(),
      journey: json['Journey'].toString(),
      totalAmount: json['TotalAmount'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      totalFare: json['TotalFare'].toString(),
      gstAmount: json['GSTAmount'].toString(),
      serviceTaxAmount: json['ServiceTaxAmount'].toString(),
      currency: json['Currency'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      passengerId: json['PassengerId'].toString(),
      rn: json['rn'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BookFlightId': bookFlightId,
      'BookingType': bookingType,
      'TicketNo': ticketNo,
      'BookedOnDt': bookedOnDt,
      'Product': product,
      'OriginDestination': originDestination,
      'Passenger': passenger,
      'Journey': journey,
      'TotalAmount': totalAmount,
      'BookingId': bookingId,
      'BookingNumber': bookingNumber,
      'TotalFare': totalFare,
      'GSTAmount': gstAmount,
      'ServiceTaxAmount': serviceTaxAmount,
      'Currency': currency,
      'BookingStatus': bookingStatus,
      'UserTypeId': userTypeId,
      'UserId': userId,
      'PassengerId': passengerId,
      'rn': rn,
    };
  }
}
