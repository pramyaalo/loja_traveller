class ApproveSubAgencyModel {
  String slNo;
  String subAgentId;
  String agentName;
  String emailAddress;
  String mobile;
  String city;
  String country;
  String status;
  String dateOfOperation;
  String currencyCode;
  String statusName;
  String approveStatus;

  ApproveSubAgencyModel({
    required this.slNo,
    required this.subAgentId,
    required this.agentName,
    required this.emailAddress,
    required this.mobile,
    required this.city,
    required this.country,
    required this.status,
    required this.dateOfOperation,
    required this.currencyCode,
    required this.statusName,
    required this.approveStatus,
  });

  factory ApproveSubAgencyModel.fromJson(Map<String, dynamic> json) {
    return ApproveSubAgencyModel(
      slNo: json['SlNo'].toString(),
      subAgentId: json['SubAgentId'].toString(),
      agentName: json['AgentName'].toString(),
      emailAddress: json['EmailAddress'].toString(),
      mobile: json['Mobile'].toString(),
      city: json['City'].toString(),
      country: json['Country'].toString(),
      status: json['Status'].toString(),
      dateOfOperation: json['DateofOperation'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
      statusName: json['statusName'].toString(),
      approveStatus: json['ApproveStatus'].toString(),
    );
  }
}
