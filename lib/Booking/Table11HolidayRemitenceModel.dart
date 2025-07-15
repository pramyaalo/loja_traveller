class Table11HolidayRemitenceModel {
  final String passenger;
  final String ticketNo;
  final String endDate;
  final String name;
  final String grandTotal;

  Table11HolidayRemitenceModel({
    required this.passenger,
    required this.ticketNo,
    required this.endDate,
    required this.name,
    required this.grandTotal,
  });

  factory Table11HolidayRemitenceModel.fromJson(Map<String, dynamic> json) {
    return Table11HolidayRemitenceModel(
      passenger: json['Passenger'].toString(),
      ticketNo: json['TicketNo'].toString(),
      endDate: json['EndDate'].toString(),
      name: json['Name'].toString(),
      grandTotal: json['GrandTotal'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Passenger': passenger,
      'TicketNo': ticketNo,
      'EndDate': endDate,
      'Name': name,
      'GrandTotal': grandTotal,
    };
  }
}
