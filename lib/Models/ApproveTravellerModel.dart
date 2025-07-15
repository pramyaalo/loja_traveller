class ApproveTravellerModel {
  String rownumber;
  String UDFirstName;
  String UDMiddName;
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
  String UDPhone_CC;
  String UDPhone_AC;
  String UDPhone_No;
  String City;
  String UDEMailID;
  ApproveTravellerModel({
    required this.rownumber,
    required this.UDFirstName,
    required this.UDMiddName,
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
    required this.UDPhone_CC,
    required this.UDPhone_AC,
    required this.UDPhone_No,
    required this.City,
    required this.UDEMailID,
  });

  factory ApproveTravellerModel.fromJson(Map<String, dynamic> json) {
    return ApproveTravellerModel(
      rownumber: json['rownumber'].toString(),
      UDFirstName: json['UDFirstName'].toString(),
      UDMiddName: json['UDMiddName'].toString(),
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
      UDPhone_CC: json['UDPhone_CC'].toString(),
      UDPhone_AC: json['UDPhone_AC'].toString(),
      UDPhone_No: json['UDPhone_No'].toString(),
      City: json['City'].toString(),
      UDEMailID: json['UDEMailID'].toString(),
    );
  }
}
