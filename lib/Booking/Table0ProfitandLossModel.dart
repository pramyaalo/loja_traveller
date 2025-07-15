class Table0ProfitandLossModel {
  String mainCompanyName;
  String imageName;
  String phone1;
  String email;
  String website;
  String address;

  Table0ProfitandLossModel({
    required this.mainCompanyName,
    required this.imageName,
    required this.phone1,
    required this.email,
    required this.website,
    required this.address,
  });

  factory Table0ProfitandLossModel.fromJson(Map<String, dynamic> json) {
    return Table0ProfitandLossModel(
      mainCompanyName: json['MaincompanyName'].toString(),
      imageName: json['ImageName'].toString(),
      phone1: json['Phone1'].toString(),
      email: json['Email'].toString(),
      website: json['Website'].toString(),
      address: json['Address'].toString(),
    );
  }
}
