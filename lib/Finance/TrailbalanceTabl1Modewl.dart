class TrailbalanceTabl1Modewl {
  String mainCompanyName;
  String imageName;
  String phone1;
  String email;
  String website;
  String address;

  TrailbalanceTabl1Modewl({
    required this.mainCompanyName,
    required this.imageName,
    required this.phone1,
    required this.email,
    required this.website,
    required this.address,
  });

  factory TrailbalanceTabl1Modewl.fromJson(Map<String, dynamic> json) {
    return TrailbalanceTabl1Modewl(
      mainCompanyName: json['MaincompanyName'],
      imageName: json['ImageName'],
      phone1: json['Phone1'],
      email: json['Email'],
      website: json['Website'],
      address: json['Address'],
    );
  }
}
