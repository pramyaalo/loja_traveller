class Table2ClientInvoicecarReceiptModel {
  final String tCarID;
  final String bookingRefNo;
  final String source;
  final String supplier;
  final String pickupLocation;
  final String pickupAddress;
  final String pickupDate;
  final String ticketCode;
  final String dropoffLocation;
  final String dropoffAddress;
  final String dropoffDate;
  final String carName;
  final String carType;
  final String leadDriver;
  final String driverDOB;
  final String additionalDriver;
  final String pnrNumber;
  final String confirmationNo;
  final String carGroup;
  final String carStatus;
  final String supplierPaymentDate;
  final String supplierCurrency;
  final String additionalReffNo;
  final String payAtSupplier;
  final String luggage;
  final String includes;
  final String excludes;
  final String freeText1;
  final String carGroup1;
  final String luggage1;
  final String pickupDtt;
  final String dropoffDtt;
  final String pickupTime;
  final String dropoffTime;

  Table2ClientInvoicecarReceiptModel({
    required this.tCarID,
    required this.bookingRefNo,
    required this.source,
    required this.supplier,
    required this.pickupLocation,
    required this.pickupAddress,
    required this.pickupDate,
    required this.ticketCode,
    required this.dropoffLocation,
    required this.dropoffAddress,
    required this.dropoffDate,
    required this.carName,
    required this.carType,
    required this.leadDriver,
    required this.driverDOB,
    required this.additionalDriver,
    required this.pnrNumber,
    required this.confirmationNo,
    required this.carGroup,
    required this.carStatus,
    required this.supplierPaymentDate,
    required this.supplierCurrency,
    required this.additionalReffNo,
    required this.payAtSupplier,
    required this.luggage,
    required this.includes,
    required this.excludes,
    required this.freeText1,
    required this.carGroup1,
    required this.luggage1,
    required this.pickupDtt,
    required this.dropoffDtt,
    required this.pickupTime,
    required this.dropoffTime,
  });

  // Factory constructor to create a CarBooking object from JSON
  factory Table2ClientInvoicecarReceiptModel.fromJson(Map<String, dynamic> json) {
    return Table2ClientInvoicecarReceiptModel(
      tCarID: json["TCarID"].toString(),
      bookingRefNo: json["BookingRefNo"].toString(),
      source: json["Source"].toString(),
      supplier: json["Supplier"].toString(),
      pickupLocation: json["PickupLocation"].toString(),
      pickupAddress: json["PickupAddress"].toString(),
      pickupDate: json["PickupDate"].toString(),
      ticketCode: json["TicketCode"].toString(),
      dropoffLocation: json["DropoffLocation"].toString(),
      dropoffAddress: json["DropoffAddress"].toString(),
      dropoffDate: json["DropoffDate"].toString(),
      carName: json["CarName"].toString(),
      carType: json["Cartype"].toString(),
      leadDriver: json["LeadDriver"].toString(),
      driverDOB: json["DriverDOB"].toString(),
      additionalDriver: json["AdditionalDriver"].toString(),
      pnrNumber: json["PNRNumber"].toString(),
      confirmationNo: json["ConfirmationNo"].toString(),
      carGroup: json["CarGroup"].toString(),
      carStatus: json["CarStatus"].toString(),
      supplierPaymentDate: json["SupplierPaymentDate"].toString(),
      supplierCurrency: json["SupplierCurrency"].toString(),
      additionalReffNo: json["AdditinoalReffNo"].toString(),
      payAtSupplier: json["PayatSupplier"].toString(),
      luggage: json["Luggage"].toString(),
      includes: json["Includes"].toString(),
      excludes: json["Excludes"].toString(),
      freeText1: json["FreeText1"].toString(),
      carGroup1: json["CarGroup1"].toString(),
      luggage1: json["Luggage1"].toString(),
      pickupDtt: json["PickupDtt"].toString(),
      dropoffDtt: json["DropoffDtt"].toString(),
      pickupTime: json["PickupTime"].toString(),
      dropoffTime: json["DropoffTime"].toString(),
    );
  }

  // Convert CarBooking object to JSON
  Map<String, dynamic> toJson() {
    return {
      "TCarID": tCarID,
      "BookingRefNo": bookingRefNo,
      "Source": source,
      "Supplier": supplier,
      "PickupLocation": pickupLocation,
      "PickupAddress": pickupAddress,
      "PickupDate": pickupDate,
      "TicketCode": ticketCode,
      "DropoffLocation": dropoffLocation,
      "DropoffAddress": dropoffAddress,
      "DropoffDate": dropoffDate,
      "CarName": carName,
      "Cartype": carType,
      "LeadDriver": leadDriver,
      "DriverDOB": driverDOB,
      "AdditionalDriver": additionalDriver,
      "PNRNumber": pnrNumber,
      "ConfirmationNo": confirmationNo,
      "CarGroup": carGroup,
      "CarStatus": carStatus,
      "SupplierPaymentDate": supplierPaymentDate,
      "SupplierCurrency": supplierCurrency,
      "AdditinoalReffNo": additionalReffNo,
      "PayatSupplier": payAtSupplier,
      "Luggage": luggage,
      "Includes": includes,
      "Excludes": excludes,
      "FreeText1": freeText1,
      "CarGroup1": carGroup1,
      "Luggage1": luggage1,
      "PickupDtt": pickupDtt,
      "DropoffDtt": dropoffDtt,
      "PickupTime": pickupTime,
      "DropoffTime": dropoffTime,
    };
  }
}
