enum SeatStatus {
  available,
  booked,
  femaleOnly,
}
class Seat {
  final String seatNo;
  final double price;
  final bool isSleeper;
  SeatStatus status;
  bool isSelected;

  Seat({
    required this.seatNo,
    required this.price,
    this.isSleeper = false,
    this.status = SeatStatus.available,
    this.isSelected = false,
  });
}
