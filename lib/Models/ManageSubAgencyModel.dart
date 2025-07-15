class ManageSubAgencyModel {
  String slNo;
  String subAgentId;
  String userTypeId;
  String userId;
  String agentName;
  String emailAddress;
  String mobile;
  String city;
  String country;
  String currencyCode;
  String status;
  String dateOfOperation;
  String statusName;
  String approveStatus;

  ManageSubAgencyModel({
    required this.slNo,
    required this.subAgentId,
    required this.userTypeId,
    required this.userId,
    required this.agentName,
    required this.emailAddress,
    required this.mobile,
    required this.city,
    required this.country,
    required this.currencyCode,
    required this.status,
    required this.dateOfOperation,
    required this.statusName,
    required this.approveStatus,
  });

  factory ManageSubAgencyModel.fromJson(Map<String, dynamic> json) {
    return ManageSubAgencyModel(
      slNo: json['SlNo'].toString(),
      subAgentId: json['SubAgentId'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      agentName: json['AgentName'].toString(),
      emailAddress: json['EmailAddress'].toString(),
      mobile: json['Mobile'].toString(),
      city: json['City'].toString(),
      country: json['Country'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
      status: json['Status'].toString(),
      dateOfOperation: json['DateofOperation'].toString(),
      statusName: json['statusName'].toString(),
      approveStatus: json['ApproveStatus'].toString(),
    );
  }
}
