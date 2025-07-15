class CreditNoteHolidayTaxModel {
  String totalTax;

  CreditNoteHolidayTaxModel({required this.totalTax});

  factory CreditNoteHolidayTaxModel.fromJson(Map<String, dynamic> json) {
    return CreditNoteHolidayTaxModel(totalTax: json['TotalTax'].toString());
  }
}
