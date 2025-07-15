class HotelTaxModel {
  String totalTax;

  HotelTaxModel({required this.totalTax});

  factory HotelTaxModel.fromJson(Map<String, dynamic> json) {
    return HotelTaxModel(totalTax: json['TotalTax'].toString());
  }
}
