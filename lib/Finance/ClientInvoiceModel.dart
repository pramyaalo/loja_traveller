
class ClientInvoiceModel {
  final String bookFlightId;
  final String bookingType;
  final String bookingType1;
  final String journey;
  final String bookingId;
  final String bookingNumber;
  final String bookingStatus;
  final String userTypeId;
  final String userId;
  final String roundDomesticTrip;
  final String bookedOnDt;
  final String ticketNo;
  final String originDestination;
  final String passenger;
  final String totalAmount;
  final String totalFare;
  final String gst;
  final String serviceTax;
  final String currency;
  final String bookingStatus1;

  ClientInvoiceModel({
    required this.bookFlightId,
    required this.bookingType,
    required this.bookingType1,
    required this.journey,
    required this.bookingId,
    required this.bookingNumber,
    required this.bookingStatus,
    required this.userTypeId,
    required this.userId,
    required this.roundDomesticTrip,
    required this.bookedOnDt,
    required this.ticketNo,
    required this.originDestination,
    required this.passenger,
    required this.totalAmount,
    required this.totalFare,
    required this.gst,
    required this.serviceTax,
    required this.currency,
    required this.bookingStatus1,
  });

  factory ClientInvoiceModel.fromJson(Map<String, dynamic> json) {
    return ClientInvoiceModel(
      bookFlightId: json['BookFlightId'].toString(),
      bookingType: json['BookingType'].toString(),
      bookingType1: json['BookingType1'].toString(),
      journey: json['Journey'].toString(),
      bookingId: json['BookingId'].toString(),
      bookingNumber: json['BookingNumber'].toString(),
      bookingStatus: json['BookingStatus'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      roundDomesticTrip: json['RoundDomesticTrip'].toString(),
      bookedOnDt: json['BookedOnDt'].toString(),
      ticketNo: json['TicketNo'].toString(),
      originDestination: json['OriginDestination'].toString(),
      passenger: json['Passenger'].toString(),
      totalAmount: json['TotalAmount'].toString(),
      totalFare: json['TotalFare'].toString(),
      gst: json['GST'].toString(),
      serviceTax: json['ServiceTax'].toString(),
      currency: json['Currency'].toString(),
      bookingStatus1: json['BookingStatus1'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BookFlightId': bookFlightId,
      'BookingType': bookingType,
      'BookingType1': bookingType1,
      'Journey': journey,
      'BookingId': bookingId,
      'BookingNumber': bookingNumber,
      'BookingStatus': bookingStatus,
      'UserTypeId': userTypeId,
      'UserId': userId,
      'RoundDomesticTrip': roundDomesticTrip,
      'BookedOnDt': bookedOnDt,
      'TicketNo': ticketNo,
      'OriginDestination': originDestination,
      'Passenger': passenger,
      'TotalAmount': totalAmount,
      'TotalFare': totalFare,
      'GST': gst,
      'ServiceTax': serviceTax,
      'Currency': currency,
      'BookingStatus1': bookingStatus1,
    };
  }
}

