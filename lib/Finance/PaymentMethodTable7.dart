class PaymentMethod {
  int paymentMethodId;
  int corporateId;
  String fopName;
  int fopChecked;
  int cardId;
  int defaultt;

  PaymentMethod({
    required this.paymentMethodId,
    required this.corporateId,
    required this.fopName,
    required this.fopChecked,
    required this.cardId,
    required this.defaultt,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      paymentMethodId: json['PaymentMethodId'],
      corporateId: json['CorporateId'],
      fopName: json['FOPName'],
      fopChecked: json['FOPChecked'],
      cardId: json['CardId'],
      defaultt: json['Defaultt'],
    );
  }
}
