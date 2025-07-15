class ViewAssetEntryModel {
  String assetEntryId;
  String company;
  String assetName;
  String assetType;
  String serialNo;
  String referenceNo;
  String assetOwner;
  String financeYearId;
  String financeYear;
  String postingDate;
  String purchaseInvoice;
  String availableForUseDate;
  String grossPurchaseAmount;
  String purchaseDate;
  String notes;
  String totalAmount;
  int status;
  String createdDate;
  String companyName; // Change the type if it's not nullable
  String assetTypeName;
  String userTypeId;
  String userId;
  String userType;
  String userName;
  String currencyCode;

  ViewAssetEntryModel({
    required this.assetEntryId,
    required this.company,
    required this.assetName,
    required this.assetType,
    required this.serialNo,
    required this.referenceNo,
    required this.assetOwner,
    required this.financeYearId,
    required this.financeYear,
    required this.postingDate,
    required this.purchaseInvoice,
    required this.availableForUseDate,
    required this.grossPurchaseAmount,
    required this.purchaseDate,
    required this.notes,
    required this.totalAmount,
    required this.status,
    required this.createdDate,
    required this.companyName,
    required this.assetTypeName,
    required this.userTypeId,
    required this.userId,
    required this.userType,
    required this.userName,
    required this.currencyCode,
  });

  factory ViewAssetEntryModel.fromJson(Map<String, dynamic> json) {
    return ViewAssetEntryModel(
      assetEntryId: json['AssetEntryId'].toString(),
      company: json['Company'].toString(),
      assetName: json['AssetName'].toString(),
      assetType: json['AssetType'].toString(),
      serialNo: json['SerialNo'].toString(),
      referenceNo: json['ReferenceNo'].toString(),
      assetOwner: json['AssetOwner'].toString(),
      financeYearId: json['FinanceYearId'].toString(),
      financeYear: json['FinanceYear'].toString(),
      postingDate: json['PostingDate'].toString(),
      purchaseInvoice: json['PurchaseInvoice'].toString(),
      availableForUseDate: json['Available_for_useDate'].toString(),
      grossPurchaseAmount: json['GrossPurchaseAmount'].toString(),
      purchaseDate: json['PurchaseDate'].toString(),
      notes: json['Notes'].toString(),
      totalAmount: json['TotalAmount'].toString(),
      status: json['Status'],
      createdDate: json['CreatedDate'].toString(),
      companyName: json['CompanyName'].toString(),
      assetTypeName: json['AssetTypeName'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      userType: json['UserType'].toString(),
      userName: json['UserName'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
    );
  }
}
