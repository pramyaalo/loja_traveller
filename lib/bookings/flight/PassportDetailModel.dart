class PassportDetailModel {
  final int traPassId;
  final int pdTravellerId;
  final String pdPassportNo;
  final String pdDateOfBirth;
  final String pdNationality;
  final String pdIssuingCountry;
  final String pdDateOfExpiry;
  final String pdIsPrimary;
  final String pdDocument;
  final String pdDateOfBirthdt;
  final String pdDateOfExpirydt;

  PassportDetailModel({
    required this.traPassId,
    required this.pdTravellerId,
    required this.pdPassportNo,
    required this.pdDateOfBirth,
    required this.pdNationality,
    required this.pdIssuingCountry,
    required this.pdDateOfExpiry,
    required this.pdIsPrimary,
    required this.pdDocument,
    required this.pdDateOfBirthdt,
    required this.pdDateOfExpirydt,
  });

  factory PassportDetailModel.fromJson(Map<String, dynamic> json) {
    return PassportDetailModel(
      traPassId: json['TraPassID'],
      pdTravellerId: json['PDTravellerId'],
      pdPassportNo: json['PDPassportNo'],
      pdDateOfBirth: json['PDDateofBirth'],
      pdNationality: json['PDNationality'],
      pdIssuingCountry: json['PDIssuingCountry'],
      pdDateOfExpiry: json['PDDateofExpiry'],
      pdIsPrimary: json['PDIsPrimary'],
      pdDocument: json['PDDocument'],
      pdDateOfBirthdt: json['PDDateofBirthdt'],
      pdDateOfExpirydt: json['PDDateofExpirydt'],
    );
  }
}
