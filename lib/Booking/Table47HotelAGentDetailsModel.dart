class Table47HotelAGentDetailsModel {
  final String corporateId;
  final String corporateName;
  final String addressLine1;
  final String addressLine2;
  final String addressLine3;
  final String city;
  final String postCode;
  final String phone;
  final String email;
  final String username;

  Table47HotelAGentDetailsModel({
    required this.corporateId,
    required this.corporateName,
    required this.addressLine1,
    required this.addressLine2,
    required this.addressLine3,
    required this.city,
    required this.postCode,
    required this.phone,
    required this.email,
    required this.username,
  });

  factory Table47HotelAGentDetailsModel.fromJson(Map<String, dynamic> json) {
    return Table47HotelAGentDetailsModel(
      corporateId: json['CorporateId'].toString(),
      corporateName: json['Corporate Name'].toString(),
      addressLine1: json['AddressLine1'].toString(),
      addressLine2: json['AddressLine2'].toString(),
      addressLine3: json['AddressLine3'].toString(),
      city: json['City'].toString(),
      postCode: json['PostCode'].toString(),
      phone: json['Phone'].toString(),
      email: json['Email'].toString(),
      username: json['Username'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CorporateId': corporateId,
      'Corporate Name': corporateName,
      'AddressLine1': addressLine1,
      'AddressLine2': addressLine2,
      'AddressLine3': addressLine3,
      'City': city,
      'PostCode': postCode,
      'Phone': phone,
      'Email': email,
      'Username': username,
    };
  }
}
