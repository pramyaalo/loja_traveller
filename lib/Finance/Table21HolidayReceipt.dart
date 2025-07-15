class Table21HolidayReceipt {
  String specialRequest;
  String noteToBePrintedOnInvoice;
  String noteToBePrintedOnHotelVoucher;
  String cancellationConditions;
  String packagePrice;
  String serviceDescriptions1;
  String quantity1;
  String netAmount1;
  String crossAmount1;
  String serviceDescriptions2;
  String quantity2;
  String netAmount2;
  String crossAmount2;
  String serviceDescriptions3;
  String quantity3;
  String netAmount3;
  String crossAmount3;
  String serviceDescriptions4;
  String quantity4;
  String netAmount4;
  String crossAmount4;
  String totalNet;
  String totalCross;
  String netTotal;
  String crossTotal;
  String taxTotal;
  String mode;

  Table21HolidayReceipt({
    required this.specialRequest,
    required this.noteToBePrintedOnInvoice,
    required this.noteToBePrintedOnHotelVoucher,
    required this.cancellationConditions,
    required this.packagePrice,
    required this.serviceDescriptions1,
    required this.quantity1,
    required this.netAmount1,
    required this.crossAmount1,
    required this.serviceDescriptions2,
    required this.quantity2,
    required this.netAmount2,
    required this.crossAmount2,
    required this.serviceDescriptions3,
    required this.quantity3,
    required this.netAmount3,
    required this.crossAmount3,
    required this.serviceDescriptions4,
    required this.quantity4,
    required this.netAmount4,
    required this.crossAmount4,
    required this.totalNet,
    required this.totalCross,
    required this.netTotal,
    required this.crossTotal,
    required this.taxTotal,
    required this.mode,
  });

  factory Table21HolidayReceipt.fromJson(Map<String, dynamic> json) {
    return Table21HolidayReceipt(
      specialRequest: json['SpecialRequest'].toString(),
      noteToBePrintedOnInvoice: json['NotetobeprintedonInvoice'].toString(),
      noteToBePrintedOnHotelVoucher:
          json['NotetobeprintedonhotelVoucher'].toString(),
      cancellationConditions: json['CancellationConditions'].toString(),
      packagePrice: json['PackagePrice'].toString(),
      serviceDescriptions1: json['ServiceDescriptions_1'].toString(),
      quantity1: json['Quantity_1'].toString(),
      netAmount1: json['NetAmount_1'].toString(),
      crossAmount1: json['CrossAmount_1'].toString(),
      serviceDescriptions2: json['ServiceDescriptions_2'].toString(),
      quantity2: json['Quantity_2'].toString(),
      netAmount2: json['NetAmount_2'].toString(),
      crossAmount2: json['CrossAmount_2'].toString(),
      serviceDescriptions3: json['ServiceDescriptions_3'].toString(),
      quantity3: json['Quantity_3'].toString(),
      netAmount3: json['NetAmount_3'].toString(),
      crossAmount3: json['CrossAmount_3'].toString(),
      serviceDescriptions4: json['ServiceDescriptions_4'].toString(),
      quantity4: json['Quantity_4'].toString(),
      netAmount4: json['NetAmount_4'].toString(),
      crossAmount4: json['CrossAmount_4'].toString(),
      totalNet: json['TotalNet'].toString(),
      totalCross: json['TotalCross'].toString(),
      netTotal: json['NetTotal'].toString(),
      crossTotal: json['CrossTotal'].toString(),
      taxTotal: json['TaxTotal'].toString(),
      mode: json['Mode'].toString(),
    );
  }
}
