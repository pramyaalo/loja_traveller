class ProductAccess {
  int corpPACIID;
  int corporateId;
  int productAccessId;
  String productAccessName;

  ProductAccess({
    required this.corpPACIID,
    required this.corporateId,
    required this.productAccessId,
    required this.productAccessName,
  });

  factory ProductAccess.fromJson(Map<String, dynamic> json) {
    return ProductAccess(
      corpPACIID: json['CorpPACIID'],
      corporateId: json['CorporateId'],
      productAccessId: json['ProductAccessId'],
      productAccessName: json['ProductAccessname'],
    );
  }
}
