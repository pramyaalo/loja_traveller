class DeductionTypeListModel {
  String slNo;
  String DeductionTypeId;
  String StaffName;
  String DeductionTitle;
  String StaffId;
  String DeductionAmount;
  String DeductionDate;
  String Status;
  String CreatedDate;
  String Currency;

  DeductionTypeListModel({
    required this.slNo,
    required this.DeductionTypeId,
    required this.StaffName,
    required this.DeductionTitle,
    required this.StaffId,
    required this.DeductionAmount,
    required this.DeductionDate,
    required this.Status,
    required this.CreatedDate,
    required this.Currency,
  });

  factory DeductionTypeListModel.fromJson(Map<String, dynamic> json) {
    return DeductionTypeListModel(
      slNo: json['SlNo'].toString(),
      DeductionTypeId: json['DeductionTypeId'].toString(),
      StaffName: json['StaffName'].toString(),
      DeductionTitle: json['DeductionTitle'].toString(),
      StaffId: json['StaffId'].toString(),
      DeductionAmount: json['DeductionAmount'].toString(),
      DeductionDate: json['DeductionDate'].toString(),
      Status: json['Status'].toString(),
      CreatedDate: json['CreatedDate'].toString(),
      Currency: json['Currency'].toString(),
    );
  }
}
