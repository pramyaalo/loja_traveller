class TravellerDetailModel {
  final int travellerId;
  final String udEmployeeCode;
  final int udTitleId;
  final String udFirstName;
  final String udMiddName;
  final String udLastName;
  final int genderId;
  final String udEMailID;
  final String udUserName;
  final String udPassword;
  final String udBranchNameId;
  final int udLanguageId;
  final String udResistance;
  final String streetAddress;
  final String city;
  final String state;
  final String postCode;
  final String udPhoneCC;
  final String udPhoneAC;
  final String udPhoneNo;
  final String udPhoneExtn;
  final String udMobileCC;
  final String udMobileAC;
  final String udMobileNo;
  final String udMobileExtn;
  final String udRemarks;
  final int udDepartmentId;
  final int udDesignation;
  final int udEmployerGrade;
  final int udCategoryId;
  final int udCostCenterId;
  final int udProjectId;
  final String udManager;
  final int udCoordinationId;
  final int udUserTypeId;
  final int udTravellerTypeId;
  final int isActive;
  final String createdDate;
  final int createdBy;
  final String modifyDate;
  final int modifyBy;
  final int userTypeId;
  final int userId;
  final dynamic gstNumber;
  final dynamic panNumber;
  final dynamic accountName;
  final dynamic accountNumber;
  final dynamic ifscCode;
  final dynamic bankName;
  final dynamic bankLocation;
  final String udPassword1;
  final String udMobileExtn1;
  final int approveStatus;
  final String udDOB;
  final int nationalityId;
  final dynamic countryName;
  final int refreshPNR;
  final int viewPNR;
  final int seatMap;
  final int backofficeFile;
  final int importBooking;
  final int salesReport;
  final int issueTicket;
  final int cancelBooking;
  final int cancelTicket;
  final int manageServices;
  final int manageElement;
  final int changeBooking;
  final int viewTicket;
  final int downloadDocument;
  final int bookingOptions;
  final String language;
  final String currencyCode;
  final String photo;
  final int agencyId;
  final int banchId;
  final String udBranchName;
  final String udStatus;
  final String gender;
  final int travellerTypeId;
  final String udTitle;
  final String udTravellerType;
  final String customerType;
  final String customerName;
  final String corporateName;
  final double creditLimit;
  final double flightMarkup;
  final double hotelMarkup;
  final double carMarkup;
  final double sightSeeingMarkup;
  final double busMarkup;
  final String headerLogo;
  final String footerText;

  TravellerDetailModel({
    required this.travellerId,
    required this.udEmployeeCode,
    required this.udTitleId,
    required this.udFirstName,
    required this.udMiddName,
    required this.udLastName,
    required this.genderId,
    required this.udEMailID,
    required this.udUserName,
    required this.udPassword,
    required this.udBranchNameId,
    required this.udLanguageId,
    required this.udResistance,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.postCode,
    required this.udPhoneCC,
    required this.udPhoneAC,
    required this.udPhoneNo,
    required this.udPhoneExtn,
    required this.udMobileCC,
    required this.udMobileAC,
    required this.udMobileNo,
    required this.udMobileExtn,
    required this.udRemarks,
    required this.udDepartmentId,
    required this.udDesignation,
    required this.udEmployerGrade,
    required this.udCategoryId,
    required this.udCostCenterId,
    required this.udProjectId,
    required this.udManager,
    required this.udCoordinationId,
    required this.udUserTypeId,
    required this.udTravellerTypeId,
    required this.isActive,
    required this.createdDate,
    required this.createdBy,
    required this.modifyDate,
    required this.modifyBy,
    required this.userTypeId,
    required this.userId,
    required this.gstNumber,
    required this.panNumber,
    required this.accountName,
    required this.accountNumber,
    required this.ifscCode,
    required this.bankName,
    required this.bankLocation,
    required this.udPassword1,
    required this.udMobileExtn1,
    required this.approveStatus,
    required this.udDOB,
    required this.nationalityId,
    required this.countryName,
    required this.refreshPNR,
    required this.viewPNR,
    required this.seatMap,
    required this.backofficeFile,
    required this.importBooking,
    required this.salesReport,
    required this.issueTicket,
    required this.cancelBooking,
    required this.cancelTicket,
    required this.manageServices,
    required this.manageElement,
    required this.changeBooking,
    required this.viewTicket,
    required this.downloadDocument,
    required this.bookingOptions,
    required this.language,
    required this.currencyCode,
    required this.photo,
    required this.agencyId,
    required this.banchId,
    required this.udBranchName,
    required this.udStatus,
    required this.gender,
    required this.travellerTypeId,
    required this.udTitle,
    required this.udTravellerType,
    required this.customerType,
    required this.customerName,
    required this.corporateName,
    required this.creditLimit,
    required this.flightMarkup,
    required this.hotelMarkup,
    required this.carMarkup,
    required this.sightSeeingMarkup,
    required this.busMarkup,
    required this.headerLogo,
    required this.footerText,
  });

  factory TravellerDetailModel.fromJson(Map<String, dynamic> json) {
    return TravellerDetailModel(
      travellerId: json['TravellerId'],
      udEmployeeCode: json['UDEmployeeCode'],
      udTitleId: json['UDTitleID'],
      udFirstName: json['UDFirstName'],
      udMiddName: json['UDMiddName'],
      udLastName: json['UDLastName'],
      genderId: json['GenderId'],
      udEMailID: json['UDEMailID'],
      udUserName: json['UDUserName'],
      udPassword: json['UDPassword'],
      udBranchNameId: json['UDBranchNameID'],
      udLanguageId: json['UDLanguageID'],
      udResistance: json['UDResistance'],
      streetAddress: json['StreetAddress'],
      city: json['City'],
      state: json['State'],
      postCode: json['PostCode'],
      udPhoneCC: json['UDPhone_CC'],
      udPhoneAC: json['UDPhone_AC'],
      udPhoneNo: json['UDPhone_No'],
      udPhoneExtn: json['UDPhone_Extn'],
      udMobileCC: json['UDMobile_CC'],
      udMobileAC: json['UDMobile_AC'],
      udMobileNo: json['UDMobile_No'],
      udMobileExtn: json['UDMobile_Extn'],
      udRemarks: json['UDRemarks'],
      udDepartmentId: json['UDDepartmentID'],
      udDesignation: json['UDDesignation'],
      udEmployerGrade: json['UDEmployerGrade'],
      udCategoryId: json['UDCategoryID'],
      udCostCenterId: json['UDCostCenterID'],
      udProjectId: json['UDProjecID'],
      udManager: json['UDManager'],
      udCoordinationId: json['UDCoordinationID'],
      udUserTypeId: json['UDUserTypeID'],
      udTravellerTypeId: json['UDTravellerTypeID'],
      isActive: json['IsActive'],
      createdDate: json['CreatedDate'],
      createdBy: json['CreatedBy'],
      modifyDate: json['ModifyDate'],
      modifyBy: json['ModifyBy'],
      userTypeId: json['UserTypeId'],
      userId: json['UserId'],
      gstNumber: json['GSTNumber'],
      panNumber: json['PANNumber'],
      accountName: json['AccountName'],
      accountNumber: json['AccountNumber'],
      ifscCode: json['IFSCCode'],
      bankName: json['BankName'],
      bankLocation: json['BankLocation'],
      udPassword1: json['UDPassword1'],
      udMobileExtn1: json['UDMobile_Extn1'],
      approveStatus: json['ApproveStatus'],
      udDOB: json['UDDOB'],
      nationalityId: json['NationalityID'],
      countryName: json['CountryName'],
      refreshPNR: json['RefreshPNR'],
      viewPNR: json['ViewPNR'],
      seatMap: json['SeatMap'],
      backofficeFile: json['BackofficeFile'],
      importBooking: json['ImportBooking'],
      salesReport: json['SalesReport'],
      issueTicket: json['IssueTicket'],
      cancelBooking: json['CancelBooking'],
      cancelTicket: json['CancelTicket'],
      manageServices: json['ManageServices'],
      manageElement: json['ManageElement'],
      changeBooking: json['ChangeBooking'],
      viewTicket: json['ViewTicket'],
      downloadDocument: json['DownloadDocument'],
      bookingOptions: json['BookingOptions'],
      language: json['Language'],
      currencyCode: json['CurrencyCode'],
      photo: json['Photo'],
      agencyId: json['AgencyId'],
      banchId: json['BanchId'],
      udBranchName: json['UDBranchName'],
      udStatus: json['UDStatus'],
      gender: json['Gender'],
      travellerTypeId: json['TravellerTypeID'],
      udTitle: json['UDTitle'],
      udTravellerType: json['UDTravellerType'],
      customerType: json['CustomerType'],
      customerName: json['CustomerName'],
      corporateName: json['CorporateName'],
      creditLimit: json['CreditLimit']?.toDouble() ?? 0.00,
      flightMarkup: json['FlightMarkup']?.toDouble() ?? 0.00,
      hotelMarkup: json['HotelMarkup']?.toDouble() ?? 0.00,
      carMarkup: json['CarMarkup']?.toDouble() ?? 0.00,
      sightSeeingMarkup: json['SightSeeingMarkup']?.toDouble() ?? 0.00,
      busMarkup: json['BusMarkup']?.toDouble() ?? 0.00,
      headerLogo: json['HeaderLogo'],
      footerText: json['FooterText'],
    );
  }
}
