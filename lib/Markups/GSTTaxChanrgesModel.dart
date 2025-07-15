class GSTTaxChanrgesModel {
  final String id;
  final String userId;
  final String gstPercent;
  final String gstAmount;
  final String gstType;
  final String userTypeId;

  GSTTaxChanrgesModel({
    required this.id,
    required this.userId,
    required this.gstPercent,
    required this.gstAmount,
    required this.gstType,
    required this.userTypeId,
  });

  factory GSTTaxChanrgesModel.fromJson(Map<String, dynamic> json) {
    return GSTTaxChanrgesModel(
      id: json['ID'].toString(),
      userId: json['UserId'].toString(),
      gstPercent: json['GSTPercent'] .toString(),
      gstAmount: json['GSTAmount'] .toString(),
      gstType: json['GSTType'].toString(),
      userTypeId: json['UserTypeId'].toString(),
    );
  }
}
