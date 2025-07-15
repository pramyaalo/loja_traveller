class Table13CarRemittenceModel {
  final String passenger;
  final String ticketNo;
  final String dropoffDate;
  final String name;
  final String grandTotal;

  Table13CarRemittenceModel({
    required this.passenger,
    required this.ticketNo,
    required this.dropoffDate,
    required this.name,
    required this.grandTotal,
  });

  factory Table13CarRemittenceModel.fromJson(Map<String, dynamic> json) {
    return Table13CarRemittenceModel(
      passenger: json['Passenger'].toString(),
      ticketNo: json['TicketNo'].toString(),
      dropoffDate: json['DropoffDate'].toString(),
      name: json['Name'].toString(),
      grandTotal: json['GrandTotal'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Passenger': passenger,
      'TicketNo': ticketNo,
      'DropoffDate': dropoffDate,
      'Name': name,
      'GrandTotal': grandTotal,
    };
  }
}
