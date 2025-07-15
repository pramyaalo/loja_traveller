class ManageBranchModel {
  String slNo;
  String AgencyBranchId;
  String AgencyBranchCode;
  String AgencyBranchName;
  String AgencyBranchHead;
  String AgencyBranchLogo;
  String Status;
  String CreatedDate;
  String UserName;
  String UserTypename;
  String City;
  String Country;
  String Mobile;
  String Email;
  String ApproveStatus;
  String AccountBalance;

  ManageBranchModel({
    required this.slNo,
    required this.AgencyBranchId,
    required this.AgencyBranchCode,
    required this.AgencyBranchName,
    required this.AgencyBranchHead,
    required this.AgencyBranchLogo,
    required this.Status,
    required this.CreatedDate,
    required this.UserName,
    required this.UserTypename,
    required this.City,
    required this.Country,
    required this.Mobile,
    required this.Email,
    required this.ApproveStatus,
    required this.AccountBalance,
  });

  factory ManageBranchModel.fromJson(Map<String, dynamic> json) {
    return ManageBranchModel(
      slNo: json['SlNo'].toString(),
      AgencyBranchId: json['AgencyBranchId'].toString(),
      AgencyBranchCode: json['AgencyBranchCode'].toString(),
      AgencyBranchName: json['AgencyBranchName'].toString(),
      AgencyBranchHead: json['AgencyBranchHead'].toString(),
      AgencyBranchLogo: json['AgencyBranchLogo'].toString(),
      Status: json['Status'].toString(),
      CreatedDate: json['CreatedDate'].toString(),
      UserName: json['UserName'].toString(),
      UserTypename: json['UserTypename'].toString(),
      City: json['City'].toString(),
      Country: json['Country'].toString(),
      Mobile: json['Mobile'].toString(),
      Email: json['Email'].toString(),
      ApproveStatus: json['ApproveStatus'].toString(),
      AccountBalance: json['AccountBalance'].toString(),
    );
  }
}
