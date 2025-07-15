class Table48ClientInvoicetotalFareHotelModel {
  String totalFare;

  Table48ClientInvoicetotalFareHotelModel({required this.totalFare});

  factory Table48ClientInvoicetotalFareHotelModel.fromJson(
      Map<String, dynamic> json) {
    return Table48ClientInvoicetotalFareHotelModel(
        totalFare: json['TotalFare'].toString());
  }
}
