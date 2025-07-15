class HotelRoomBookingModel {
  final String roomTypeName;
  final String ratePlanName;
  final String roomPromotion;
  final String roomPrice;
  final String roomTypeCode;
  final String roomIndex;
  final String cancellationPolicy;
  final String inclusion;

  HotelRoomBookingModel({
    required this.roomTypeName,
    required this.ratePlanName,
    required this.roomPromotion,
    required this.roomPrice,
    required this.roomTypeCode,
    required this.roomIndex,
    required this.cancellationPolicy,
    required this.inclusion,
  });

  factory HotelRoomBookingModel.fromJson(Map<String, dynamic> json) {
    return HotelRoomBookingModel(
      roomTypeName: json['RoomTypeName'],
      ratePlanName: json['RatePlanName'],
      roomPromotion: json['RoomPromotion'],
      roomPrice: json['RoomPrice'],
      roomTypeCode: json['RoomTypeCode'],
      roomIndex: json['RoomIndex'],
      cancellationPolicy: json['CancellationPolicy'],
      inclusion: json['Inclusion'],
    );
  }
}
