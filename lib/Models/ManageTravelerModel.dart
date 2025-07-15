class ManageTravelerModel {
  String rowNumber;
  String udFirstName;
  String udMiddleName;
  String udLastName;
  String streetAddress;
  String state;
  String postCode;
  String udUserName;
  String userTypeId;
  String userId;
  String travellerId;
  String udEmployeeCode;
  String udTitleId;
  String name;
  String isActive;
  String approveStatus;
  String gender;
  String phone;
  String city;
  String udEmailId;
  String joinedDate;

  ManageTravelerModel({
    required this.rowNumber,
    required this.udFirstName,
    required this.udMiddleName,
    required this.udLastName,
    required this.streetAddress,
    required this.state,
    required this.postCode,
    required this.udUserName,
    required this.userTypeId,
    required this.userId,
    required this.travellerId,
    required this.udEmployeeCode,
    required this.udTitleId,
    required this.name,
    required this.isActive,
    required this.approveStatus,
    required this.gender,
    required this.phone,
    required this.city,
    required this.udEmailId,
    required this.joinedDate,
  });

  factory ManageTravelerModel.fromJson(Map<String, dynamic> json) {
    return ManageTravelerModel(
      rowNumber: json['rownumber'].toString(),
      udFirstName: json['UDFirstName'].toString(),
      udMiddleName: json['UDMiddName'].toString(),
      udLastName: json['UDLastName'].toString(),
      streetAddress: json['StreetAddress'].toString(),
      state: json['State'].toString(),
      postCode: json['PostCode'].toString(),
      udUserName: json['UDUserName'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      travellerId: json['TravellerId'].toString(),
      udEmployeeCode: json['UDEmployeeCode'].toString(),
      udTitleId: json['UDTitleID'].toString(),
      name: json['Name'].toString(),
      isActive: json['IsActive'].toString(),
      approveStatus: json['ApproveStatus'].toString(),
      gender: json['Gender'].toString(),
      phone: json['Phone'].toString(),
      city: json['City'].toString(),
      udEmailId: json['UDEMailID'].toString(),
      joinedDate: json['JoinedDate'].toString(),
    );
  }
}
