class EarningTypeListModel {
  String slNo;
  String UserTypeId;
  String UserId;
  String EarningTypeId;
  String StaffName;
  String EarningsTitle;
  String EarningAmount;
  String EarningDate;
  String StaffId;
  String Status;
  String CreatedDate;
  String Currency;

  EarningTypeListModel({
    required this.slNo,
    required this.UserTypeId,
    required this.UserId,
    required this.EarningTypeId,
    required this.StaffName,
    required this.EarningsTitle,
    required this.EarningAmount,
    required this.EarningDate,
    required this.StaffId,
    required this.Status,
    required this.CreatedDate,
    required this.Currency,
  });

  factory EarningTypeListModel.fromJson(Map<String, dynamic> json) {
    return EarningTypeListModel(
      slNo: json['SlNo'].toString(),
      UserTypeId: json['UserTypeId'].toString(),
      UserId: json['UserId'].toString(),
      EarningTypeId: json['EarningTypeId'].toString(),
      StaffName: json['StaffName'].toString(),
      EarningsTitle: json['EarningsTitle'].toString(),
      EarningAmount: json['EarningAmount'].toString(),
      EarningDate: json['EarningDate'].toString(),
      StaffId: json['StaffId'].toString(),
      Status: json['Status'].toString(),
      CreatedDate: json['CreatedDate'].toString(),
      Currency: json['Currency'].toString(),
    );
  }
}
