class ActiveTravellerModel {
  String slNo;
  String TravellerId;
  String Name;
  String UDMobile_No;
  String EmailID;
  String UserName;
  String City;
  String State;
  String createddate;
  String IsActive;
  String ApproveStatus;
  String UDEmployeeCode;
  String Phone;
  String Gender;

  ActiveTravellerModel({
    required this.slNo,
    required this.TravellerId,
    required this.Name,
    required this.UDMobile_No,
    required this.EmailID,
    required this.UserName,
    required this.City,
    required this.State,
    required this.createddate,
    required this.IsActive,
    required this.ApproveStatus,
    required this.UDEmployeeCode,
    required this.Phone,
    required this.Gender,
  });

  factory ActiveTravellerModel.fromJson(Map<String, dynamic> json) {
    return ActiveTravellerModel(
      slNo: json['SlNo'].toString(),
      TravellerId: json['TravellerId'].toString(),
      Name: json['Name'].toString(),
      UDMobile_No: json['UDMobile_No'].toString(),
      EmailID: json['EmailID'].toString(),
      UserName: json['UserName'].toString(),
      City: json['City'].toString(),
      State: json['State'].toString(),
      createddate: json['createddate'].toString(),
      IsActive: json['IsActive'].toString(),
      ApproveStatus: json['ApproveStatus'].toString(),
      UDEmployeeCode: json['UDEmployeeCode'].toString(),
      Phone: json['Phone'].toString(),
      Gender: json['Gender'].toString(),
    );
  }
}
