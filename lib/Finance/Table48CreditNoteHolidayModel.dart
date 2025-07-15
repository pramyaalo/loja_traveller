class Table48CreditNoteHolidayModel {
  String totalFare;

  Table48CreditNoteHolidayModel({required this.totalFare});

  factory Table48CreditNoteHolidayModel.fromJson(Map<String, dynamic> json) {
    return Table48CreditNoteHolidayModel(
        totalFare: json['TotalFare'].toString());
  }
}
