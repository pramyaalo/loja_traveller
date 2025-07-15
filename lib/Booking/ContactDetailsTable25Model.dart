class ContactDetailsTable25Model {
  final String corporateId;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String username;

  ContactDetailsTable25Model({
    required this.corporateId,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.username,
  });

  factory ContactDetailsTable25Model.fromJson(Map<String, dynamic> json) {
    return ContactDetailsTable25Model(
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
