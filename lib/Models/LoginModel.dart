class LoginModel {
  final String userType;
  final String userTypeId;
  final String userId;
  final String username;
  final String name;
  final String password;
  final String transactionPassword;
  final String contactEmail;
  final String approveStatus;
  final String mobile;
  final String timein;
  final String timeout;
  final String isActive;
  final String two;
  final String photo;
  final String paypal;
  final String dateCreated;
  final dynamic currency;

  LoginModel({
    required this.userType,
    required this.userTypeId,
    required this.userId,
    required this.username,
    required this.name,
    required this.password,
    required this.transactionPassword,
    required this.contactEmail,
    required this.approveStatus,
    required this.mobile,
    required this.timein,
    required this.timeout,
    required this.isActive,
    required this.two,
    required this.photo,
    required this.paypal,
    required this.dateCreated,
    required this.currency,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userType: json['UserType'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserID'].toString(),
      username: json['Username'].toString(),
      name: json['Name'].toString(),
      password: json['Password'].toString(),
      transactionPassword: json['TransactionPassword'].toString(),
      contactEmail: json['ContactEmail'].toString(),
      approveStatus: json['ApproveStatus'].toString(),
      mobile: json['Mobile'].toString(),
      timein: json['Timein'].toString(),
      timeout: json['Timeout'].toString(),
      isActive: json['IsActive'].toString(),
      two: json['Two'].toString(),
      photo: json['Photo'].toString(),
      paypal: json['Paypal'].toString(),
      dateCreated: json['Datecreated'].toString(),
      currency: json['Currency'].toString(),
    );
  }
}

class Table1Model {
  final String symbol;
  final String code;
  final String countryId;

  Table1Model({
    required this.symbol,
    required this.code,
    required this.countryId,
  });

  factory Table1Model.fromJson(Map<String, dynamic> json) {
    return Table1Model(
      symbol: json['Symbol'].toString(),
      code: json['Code'].toString(),
      countryId: json['CountryID'].toString(),
    );
  }
}
