class UnBlockSubAgencyModel {
  String slNo;
  String subAgentId;
  String name;
  String dateOfOperation;
  String emailAddress;
  String mobile;
  String city;
  String country;
  String currencyCode;
  String dateCreated;
  String statusName;
  String status;

  UnBlockSubAgencyModel({
    required this.slNo,
    required this.subAgentId,
    required this.name,
    required this.dateOfOperation,
    required this.emailAddress,
    required this.mobile,
    required this.city,
    required this.country,
    required this.currencyCode,
    required this.dateCreated,
    required this.statusName,
    required this.status,
  });

  factory UnBlockSubAgencyModel.fromJson(Map<String, dynamic> json) {
    return UnBlockSubAgencyModel(
      slNo: json['SlNo'].toString(),
      subAgentId: json['SubAgentId'].toString(),
      name: json['Name'].toString(),
      dateOfOperation: json['DateofOperation'].toString(),
      emailAddress: json['EmailAddress'].toString(),
      mobile: json['Mobile'].toString(),
      city: json['City'].toString(),
      country: json['Country'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
      dateCreated: json['datecreated'].toString(),
      statusName: json['statusName'].toString(),
      status: json['Status'].toString(),
    );
  }
}
