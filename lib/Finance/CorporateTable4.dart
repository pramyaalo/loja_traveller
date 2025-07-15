class CorporateLogo {
  int corpPADBSID;
  int corporateId;
  int productAccessId;
  String productAccessName;

  CorporateLogo({
    required this.corpPADBSID,
    required this.corporateId,
    required this.productAccessId,
    required this.productAccessName,
  });

  factory CorporateLogo.fromJson(Map<String, dynamic> json) {
    return CorporateLogo(
      corpPADBSID: json['CorpPADBSID'],
      corporateId: json['CorporateId'],
      productAccessId: json['ProductAccessId'],
      productAccessName: json['ProductAccessname'],
    );
  }
}
