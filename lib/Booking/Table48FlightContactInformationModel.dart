class Table48FlightContactInformationModel {
  final String corporateId;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String username;

  Table48FlightContactInformationModel({
    required this.corporateId,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.username,
  });

  factory Table48FlightContactInformationModel.fromJson(Map<String, dynamic> json) {
    return Table48FlightContactInformationModel(
      corporateId: json['CorporateId'].toString(),
      name: json['Name'].toString(),
      address: json['Address'].toString(),
      phone: json['Phone'].toString(),
      email: json['EMail'].toString(),
      username: json['Username'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CorporateId': corporateId,
      'Name': name,
      'Address': address,
      'Phone': phone,
      'EMail': email,
      'Username': username,
    };
  }
}
