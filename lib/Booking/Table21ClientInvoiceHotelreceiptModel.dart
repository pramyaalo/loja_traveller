class Table21ClientInvoiceHotelreceiptModel {
  final String hotelRoomDetailsID;
  final String bookFlightId;
  final String availabilityType;
  final String childCount;
  final String requireAllPaxDetails;
  final String roomId;
  final String roomStatus;
  final String roomIndex;
  final String roomTypeCode;
  final String roomDescription;
  final String roomTypeName;
  final String ratePlanCode;
  final String ratePlan;
  final String ratePlanName;
  final String infoSource;
  final String sequenceNo;
  final String isPerStay;
  final String supplierPrice;
  final String priceCurrencyCode;
  final String priceRoomPrice;
  final String priceTax;
  final String priceExtraGuestCharge;
  final String priceChildCharge;
  final String priceOtherCharges;
  final String priceDiscount;
  final String pricePublishedPrice;
  final String pricePublishedPriceRoundedOff;
  final String priceOfferedPrice;
  final String priceOfferedPriceRoundedOff;
  final String priceAgentCommission;
  final String priceAgentMarkUp;
  final String priceServiceTax;
  final String priceTCS;
  final String priceTDS;
  final String priceServiceCharge;
  final String priceTotalGSTAmount;
  final String priceGSTCGSTAmount;
  final String priceGSTCGSTRate;
  final String priceGSTCessAmount;
  final String priceGSTCessRate;
  final String priceGSTIGSTAmount;
  final String priceGSTIGSTRate;
  final String priceGSTSGSTAmount;
  final String priceGSTSGSTRate;
  final String priceGSTTaxableAmount;
  final String roomPromotion;
  final String amenities;
  final String amenity;
  final String smokingPreference;
  final String bedTypes;
  final String hotelSupplements;
  final String lastCancellationDate;
  final String lastVoucherDate;
  final String cancellationPolicy;
  final String inclusion;
  final String isPassportMandatory;
  final String isPANMandatory;
  final String hotelNorms;
  final String hotelPolicyDetail;
  final String gstAllowed;
  final String usersCurrency;
  final String usersCurrencyRate;
  final String usersCurrencyDate;
  final String defaultCurrency;
  final String defaultCurrencyRate;
  final String adminCurrency;
  final String adminCurrencyRate;

  Table21ClientInvoiceHotelreceiptModel({
    required this.hotelRoomDetailsID,
    required this.bookFlightId,
    required this.availabilityType,
    required this.childCount,
    required this.requireAllPaxDetails,
    required this.roomId,
    required this.roomStatus,
    required this.roomIndex,
    required this.roomTypeCode,
    required this.roomDescription,
    required this.roomTypeName,
    required this.ratePlanCode,
    required this.ratePlan,
    required this.ratePlanName,
    required this.infoSource,
    required this.sequenceNo,
    required this.isPerStay,
    required this.supplierPrice,
    required this.priceCurrencyCode,
    required this.priceRoomPrice,
    required this.priceTax,
    required this.priceExtraGuestCharge,
    required this.priceChildCharge,
    required this.priceOtherCharges,
    required this.priceDiscount,
    required this.pricePublishedPrice,
    required this.pricePublishedPriceRoundedOff,
    required this.priceOfferedPrice,
    required this.priceOfferedPriceRoundedOff,
    required this.priceAgentCommission,
    required this.priceAgentMarkUp,
    required this.priceServiceTax,
    required this.priceTCS,
    required this.priceTDS,
    required this.priceServiceCharge,
    required this.priceTotalGSTAmount,
    required this.priceGSTCGSTAmount,
    required this.priceGSTCGSTRate,
    required this.priceGSTCessAmount,
    required this.priceGSTCessRate,
    required this.priceGSTIGSTAmount,
    required this.priceGSTIGSTRate,
    required this.priceGSTSGSTAmount,
    required this.priceGSTSGSTRate,
    required this.priceGSTTaxableAmount,
    required this.roomPromotion,
    required this.amenities,
    required this.amenity,
    required this.smokingPreference,
    required this.bedTypes,
    required this.hotelSupplements,
    required this.lastCancellationDate,
    required this.lastVoucherDate,
    required this.cancellationPolicy,
    required this.inclusion,
    required this.isPassportMandatory,
    required this.isPANMandatory,
    required this.hotelNorms,
    required this.hotelPolicyDetail,
    required this.gstAllowed,
    required this.usersCurrency,
    required this.usersCurrencyRate,
    required this.usersCurrencyDate,
    required this.defaultCurrency,
    required this.defaultCurrencyRate,
    required this.adminCurrency,
    required this.adminCurrencyRate,
  });

  factory Table21ClientInvoiceHotelreceiptModel.fromJson(Map<String, dynamic> json) {
    return Table21ClientInvoiceHotelreceiptModel(
      hotelRoomDetailsID: json['HotelRoomDetailsID'].toString(),
      bookFlightId: json['BookFlightId'].toString(),
      availabilityType: json['AvailabilityType'].toString(),
      childCount: json['ChildCount'].toString(),
      requireAllPaxDetails: json['RequireAllPaxDetails'].toString(),
      roomId: json['RoomId'].toString(),
      roomStatus: json['RoomStatus'].toString(),
      roomIndex: json['RoomIndex'].toString(),
      roomTypeCode: json['RoomTypeCode'].toString(),
      roomDescription: json['RoomDescription'].toString(),
      roomTypeName: json['RoomTypeName'].toString(),
      ratePlanCode: json['RatePlanCode'].toString(),
      ratePlan: json['RatePlan'].toString(),
      ratePlanName: json['RatePlanName'].toString(),
      infoSource: json['InfoSource'].toString(),
      sequenceNo: json['SequenceNo'].toString(),
      isPerStay: json['IsPerStay'].toString(),
      supplierPrice: json['SupplierPrice'].toString(),
      priceCurrencyCode: json['Price_CurrencyCode'].toString(),
      priceRoomPrice: json['Price_RoomPrice'].toString(),
      priceTax: json['Price_Tax'].toString(),
      priceExtraGuestCharge: json['Price_ExtraGuestCharge'].toString(),
      priceChildCharge: json['Price_ChildCharge'].toString(),
      priceOtherCharges: json['Price_OtherCharges'].toString(),
      priceDiscount: json['Price_Discount'].toString(),
      pricePublishedPrice: json['Price_PublishedPrice'].toString(),
      pricePublishedPriceRoundedOff: json['Price_PublishedPriceRoundedOff'].toString(),
      priceOfferedPrice: json['Price_OfferedPrice'].toString(),
      priceOfferedPriceRoundedOff: json['Price_OfferedPriceRoundedOff'].toString(),
      priceAgentCommission: json['Price_AgentCommission'].toString(),
      priceAgentMarkUp: json['Price_AgentMarkUp'].toString(),
      priceServiceTax: json['Price_ServiceTax'].toString(),
      priceTCS: json['Price_TCS'].toString(),
      priceTDS: json['Price_TDS'].toString(),
      priceServiceCharge: json['Price_ServiceCharge'].toString(),
      priceTotalGSTAmount: json['Price_TotalGSTAmount'].toString(),
      priceGSTCGSTAmount: json['Price_GST_CGSTAmount'].toString(),
      priceGSTCGSTRate: json['Price_GST_CGSTRate'].toString(),
      priceGSTCessAmount: json['Price_GST_CessAmount'].toString(),
      priceGSTCessRate: json['Price_GST_CessRate'].toString(),
      priceGSTIGSTAmount: json['Price_GST_IGSTAmount'].toString(),
      priceGSTIGSTRate: json['Price_GST_IGSTRate'].toString(),
      priceGSTSGSTAmount: json['Price_GST_SGSTAmount'].toString(),
      priceGSTSGSTRate: json['Price_GST_SGSTRate'].toString(),
      priceGSTTaxableAmount: json['Price_GST_TaxableAmount'].toString(),
      roomPromotion: json['RoomPromotion'].toString(),
      amenities: json['Amenities'].toString(),
      amenity: json['Amenity'].toString(),
      smokingPreference: json['SmokingPreference'].toString(),
      bedTypes: json['BedTypes'].toString(),
      hotelSupplements: json['HotelSupplements'].toString(),
      lastCancellationDate: json['LastCancellationDate'].toString(),
      lastVoucherDate: json['LastVoucherDate'].toString(),
      cancellationPolicy: json['CancellationPolicy'].toString(),
      inclusion: json['Inclusion'].toString(),
      isPassportMandatory: json['IsPassportMandatory'].toString(),
      isPANMandatory: json['IsPANMandatory'].toString(),
      hotelNorms: json['HotelNorms'].toString(),
      hotelPolicyDetail: json['HotelPolicyDetail'].toString(),
      gstAllowed: json['GSTAllowed'].toString(),
      usersCurrency: json['UsersCurrency'].toString(),
      usersCurrencyRate: json['UsersCurrencyRate'].toString(),
      usersCurrencyDate: json['UsersCurrencyDate'].toString(),
      defaultCurrency: json['DefaultCurrency'].toString(),
      defaultCurrencyRate: json['DefaultCurrencyRate'].toString(),
      adminCurrency: json['AdminCurrency'].toString(),
      adminCurrencyRate: json['AdminCurrencyRate'].toString(),
    );
  }
}
