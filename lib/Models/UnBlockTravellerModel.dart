class UnBlockTravellerModel {
  String SlNo;
  String UDFirstName;
  String UDLastName;
  String StreetAddress;
  String State;
  String PostCode;
  String UDUserName;
  String UserTypeId;
  String UserId;
  String TravellerId;
  String UDEmployeeCode;
  String UDTitleID;
  String Name;
  String IsActive;
  String ApproveStatus;
  String UDMobile_No;
  String Gender;
  String Phone;
  String City;
  String UDEMailID;
  UnBlockTravellerModel({
    required this.SlNo,
    required this.UDFirstName,
    required this.UDLastName,
    required this.StreetAddress,
    required this.State,
    required this.PostCode,
    required this.UDUserName,
    required this.UserTypeId,
    required this.UserId,
    required this.TravellerId,
    required this.UDEmployeeCode,
    required this.UDTitleID,
    required this.Name,
    required this.IsActive,
    required this.ApproveStatus,
    required this.UDMobile_No,
    required this.Gender,
    required this.Phone,
    required this.City,
    required this.UDEMailID,
  });

  factory UnBlockTravellerModel.fromJson(Map<String, dynamic> json) {
    return UnBlockTravellerModel(
      SlNo: json['SlNo'].toString(),
      UDFirstName: json['UDFirstName'].toString(),
      UDLastName: json['UDLastName'].toString(),
      StreetAddress: json['StreetAddress'].toString(),
      State: json['State'].toString(),
      PostCode: json['PostCode'].toString(),
      UDUserName: json['UDUserName'].toString(),
      UserTypeId: json['UserTypeId'].toString(),
      UserId: json['UserId'].toString(),
      TravellerId: json['TravellerId'].toString(),
      UDEmployeeCode: json['UDEmployeeCode'].toString(),
      UDTitleID: json['UDTitleID'].toString(),
      Name: json['Name'].toString(),
      IsActive: json['IsActive'].toString(),
      ApproveStatus: json['ApproveStatus'].toString(),
      UDMobile_No: json['UDMobile_No'].toString(),
      Gender: json['Gender'].toString(),
      Phone: json['Phone'].toString(),
      City: json['City'].toString(),
      UDEMailID: json['UDEMailID'].toString(),
    );
  }
}
