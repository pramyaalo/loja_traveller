class CorporateInformation {
  int corpAInforID;
  int corporateId;
  String keyName;
  String keyValue;
  String status;

  CorporateInformation({
    required this.corpAInforID,
    required this.corporateId,
    required this.keyName,
    required this.keyValue,
    required this.status,
  });

  factory CorporateInformation.fromJson(Map<String, dynamic> json) {
    return CorporateInformation(
      corpAInforID: json['CorpAInforID'],
      corporateId: json['CorporateId'],
      keyName: json['KeyName'],
      keyValue: json['KeyValue'],
      status: json['Status'],
    );
  }
}
