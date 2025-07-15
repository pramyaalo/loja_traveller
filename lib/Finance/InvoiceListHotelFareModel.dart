class InvoiceListHotelFareModel {
  String totalFare;

  InvoiceListHotelFareModel({required this.totalFare});

  factory InvoiceListHotelFareModel.fromJson(Map<String, dynamic> json) {
    return InvoiceListHotelFareModel(totalFare: json['TotalFare'].toString());
  }
}
