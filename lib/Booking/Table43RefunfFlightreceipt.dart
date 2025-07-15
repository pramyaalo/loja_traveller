class Table43RefunfFlightreceipt {
  String paidamount;

  Table43RefunfFlightreceipt({required this.paidamount});

  factory Table43RefunfFlightreceipt.fromJson(
      Map<String, dynamic> json) {
    return Table43RefunfFlightreceipt(
        paidamount: json['PaidAmount'].toString());
  }
}