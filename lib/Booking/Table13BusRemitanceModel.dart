class Table13BusRemitanceModel {
  String passenger;
  String ticketNo;
  String destinationCityDate;
  String name;
  String grandTotal;

  Table13BusRemitanceModel({
    required this.passenger,
    required this.ticketNo,
    required this.destinationCityDate,
    required this.name,
    required this.grandTotal,
  });

  factory Table13BusRemitanceModel.fromJson(Map<String, dynamic> json) {
    return Table13BusRemitanceModel(
      passenger: json['Passenger'].toString(),
      ticketNo: json['TicketNo'].toString(),
      destinationCityDate: json['DestinationCityDate'].toString(),
      name: json['Name'].toString(),
      grandTotal: json['GrandTotal'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Passenger': passenger,
      'TicketNo': ticketNo,
      'DestinationCityDate': destinationCityDate,
      'Name': name,
      'GrandTotal': grandTotal,
    };
  }
}
