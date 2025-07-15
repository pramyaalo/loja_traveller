class Table48ClientInvoiceHolidayModel {
  String totalFare;

  Table48ClientInvoiceHolidayModel({required this.totalFare});

  factory Table48ClientInvoiceHolidayModel.fromJson(Map<String, dynamic> json) {
    return Table48ClientInvoiceHolidayModel(
        totalFare: json['TotalFare'].toString());
  }
}
