enum SeatStatus {
  available,
  booked,
  femaleOnly,
  maleOnly,
}

class Seat {
  final String seatNo;
  final bool isUpper;
  final bool isSleeper;
  final double price;

  final SeatStatus status;
  bool isSelected;

  Seat({
    required this.seatNo,
    required this.isUpper,
    required this.isSleeper,
    required this.price,
    required this.status,
    this.isSelected = false,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    final bool isAvailable = json['SeatStatus'] == "True";
    final bool isLadies = json['IsLadiesSeat'] == true;
    final bool isMale = json['IsMalesSeat'] == true;

    SeatStatus seatStatus;
    if (!isAvailable) {
      seatStatus = SeatStatus.booked;
    } else if (isLadies) {
      seatStatus = SeatStatus.femaleOnly;
    } else if (isMale) {
      seatStatus = SeatStatus.maleOnly;
    } else {
      seatStatus = SeatStatus.available;
    }

    return Seat(
      seatNo: json['SeatName'].toString(),
      isUpper: json['IsUpper'] ?? false,
      isSleeper: json['SeatType'] == 1,
      price: (json['OfferedPrice'] ?? 0).toDouble(),
      status: seatStatus,
    );
  }
}
