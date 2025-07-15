class CreditNoteFlightTaxModel {
  String totalTax;

  CreditNoteFlightTaxModel({required this.totalTax});

  factory CreditNoteFlightTaxModel.fromJson(Map<String, dynamic> json) {
    return CreditNoteFlightTaxModel(totalTax: json['TotalTax'].toString());
  }
}
