import 'package:flutter/cupertino.dart';

class ViewTravellerModel {
  List<Table0> table0;
  List<Tablee1> table1;
  List<Tablee2> table2;
  List<Tablee3> table3;
  List<Tablee4> table4;
  List<Tablee5> table5;
  List<Tablee6> table6;

  ViewTravellerModel({
    required this.table0,
    required this.table1,
    required this.table2,
    required this.table3,
    required this.table4,
    required this.table5,
    required this.table6,
  });

  factory ViewTravellerModel.fromJson(Map<String, dynamic> json) {
    return ViewTravellerModel(
      table0: (json['Table'] as List<dynamic>)
          .map((e) => Table0.fromJson(e as Map<String, dynamic>))
          .toList(),
      table1: (json['Table1'] as List<dynamic>)
          .map((e) => Tablee1.fromJson(e as Map<String, dynamic>))
          .toList(),
      table2: (json['Table2'] as List<dynamic>)
          .map((e) => Tablee2.fromJson(e as Map<String, dynamic>))
          .toList(),
      table3: (json['Table3'] as List<dynamic>)
          .map((e) => Tablee3.fromJson(e as Map<String, dynamic>))
          .toList(),
      table4: (json['Table4'] as List<dynamic>)
          .map((e) => Tablee4.fromJson(e as Map<String, dynamic>))
          .toList(),
      table5: (json['Table5'] as List<dynamic>)
          .map((e) => Tablee5.fromJson(e as Map<String, dynamic>))
          .toList(),
      table6: (json['Table6'] as List<dynamic>)
          .map((e) => Tablee6.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Table0 {
  String travellerId;
  String uDEmployeeCode;
  String uDTitleID;
  String uDFirstName;
  String uDMiddName;
  String uDLastName;
  String genderId;
  String uDEMailID;
  String uDUserName;
  String uDPassword;
  String uDBranchNameID;
  String uDLanguageID;
  String uDResistance;
  String streetAddress;
  String city;
  String state;
  String postCode;
  String uDPhone_CC;
  String uDPhone_AC;
  String uDPhone_No;
  String uDPhone_Extn;
  String uDMobile_CC;
  String uDMobile_AC;
  String uDMobile_No;
  String uDMobile_Extn;
  String uDRemarks;
  String uDDepartmentID;
  String uDDesignation;
  String uDEmployerGrade;
  String uDCategoryID;
  String uDCostCenterID;
  String uDProjecID;
  String uDManager;
  String uDCoordinationID;
  String uDUserTypeID;
  String uDTravellerTypeID;
  String isActive;
  String createdDate;
  String createdBy;
  String modifyDate;
  String modifyBy;
  String userTypeId;
  String userId;
  String gSTNumber;
  String pANNumber;
  String accountName;
  String accountNumber;
  String iFSCCode;
  String bankName;
  String bankLocation;
  String uDPassword1;
  String uDMobile_Extn1;
  String approveStatus;
  String uDDOB;
  String nationalityID;
  String countryName;
  String refreshPNR;
  String viewPNR;
  String seatMap;
  String backofficeFile;
  String importBooking;
  String salesReport;
  String issueTicket;
  String cancelBooking;
  String cancelTicket;
  String manageServices;
  String manageElement;
  String changeBooking;
  String viewTicket;
  String downloadDocument;
  String bookingOptions;
  String language;
  String currencyCode;
  String photo;
  String agencyId;
  String banchId;
  String uDBranchName;
  String uDStatus;
  String gender;
  String uDTitle;
  String uDTravellerType;
  String customerType;
  String customerName;
  String corporateName;

  Table0({
    required this.travellerId,
    required this.uDEmployeeCode,
    required this.uDTitleID,
    required this.uDFirstName,
    required this.uDMiddName,
    required this.uDLastName,
    required this.genderId,
    required this.uDEMailID,
    required this.uDUserName,
    required this.uDPassword,
    required this.uDBranchNameID,
    required this.uDLanguageID,
    required this.uDResistance,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.postCode,
    required this.uDPhone_CC,
    required this.uDPhone_AC,
    required this.uDPhone_No,
    required this.uDPhone_Extn,
    required this.uDMobile_CC,
    required this.uDMobile_AC,
    required this.uDMobile_No,
    required this.uDMobile_Extn,
    required this.uDRemarks,
    required this.uDDepartmentID,
    required this.uDDesignation,
    required this.uDEmployerGrade,
    required this.uDCategoryID,
    required this.uDCostCenterID,
    required this.uDProjecID,
    required this.uDManager,
    required this.uDCoordinationID,
    required this.uDUserTypeID,
    required this.uDTravellerTypeID,
    required this.isActive,
    required this.createdDate,
    required this.createdBy,
    required this.modifyDate,
    required this.modifyBy,
    required this.userTypeId,
    required this.userId,
    required this.gSTNumber,
    required this.pANNumber,
    required this.accountName,
    required this.accountNumber,
    required this.iFSCCode,
    required this.bankName,
    required this.bankLocation,
    required this.uDPassword1,
    required this.uDMobile_Extn1,
    required this.approveStatus,
    required this.uDDOB,
    required this.nationalityID,
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
    required this.uDBranchName,
    required this.uDStatus,
    required this.gender,
    required this.uDTitle,
    required this.uDTravellerType,
    required this.customerType,
    required this.customerName,
    required this.corporateName,
  });
  factory Table0.fromJson(Map<String, dynamic> json) {
    return Table0(
      travellerId: json['TravellerId'].toString(),
      uDEmployeeCode: json['UDEmployeeCode'].toString(),
      uDTitleID: json['UDTitleID'].toString(),
      uDFirstName: json['UDFirstName'].toString(),
      uDMiddName: json['UDMiddName'].toString(),
      uDLastName: json['UDLastName'].toString(),
      genderId: json['GenderId'].toString(),
      uDEMailID: json['UDEMailID'].toString(),
      uDUserName: json['UDUserName'].toString(),
      uDPassword: json['UDPassword'].toString(),
      uDBranchNameID: json['UDBranchNameID'].toString(),
      uDLanguageID: json['UDLanguageID'].toString(),
      uDResistance: json['UDResistance'].toString(),
      streetAddress: json['StreetAddress'].toString(),
      city: json['City'].toString(),
      state: json['State'].toString(),
      postCode: json['PostCode'].toString(),
      uDPhone_CC: json['UDPhone_CC'].toString(),
      uDPhone_AC: json['UDPhone_AC'].toString(),
      uDPhone_No: json['UDPhone_No'].toString(),
      uDPhone_Extn: json['UDPhone_Extn'].toString(),
      uDMobile_CC: json['UDMobile_CC'].toString(),
      uDMobile_AC: json['UDMobile_AC'].toString(),
      uDMobile_No: json['UDMobile_No'].toString(),
      uDMobile_Extn: json['UDMobile_Extn'].toString(),
      uDRemarks: json['UDRemarks'].toString(),
      uDDepartmentID: json['UDDepartmentID'].toString(),
      uDDesignation: json['UDDesignation'].toString(),
      uDEmployerGrade: json['UDEmployerGrade'].toString(),
      uDCategoryID: json['UDCategoryID'].toString(),
      uDCostCenterID: json['UDCostCenterID'].toString(),
      uDProjecID: json['UDProjecID'].toString(),
      uDManager: json['UDManager'].toString(),
      uDCoordinationID: json['UDCoordinationID'].toString(),
      uDUserTypeID: json['UDUserTypeID'].toString(),
      uDTravellerTypeID: json['UDTravellerTypeID'].toString(),
      isActive: json['IsActive'].toString(),
      createdDate: json['CreatedDate'].toString(),
      createdBy: json['CreatedBy'].toString(),
      modifyDate: json['ModifyDate'].toString(),
      modifyBy: json['ModifyBy'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      gSTNumber: json['GSTNumber'].toString(),
      pANNumber: json['PANNumber'].toString(),
      accountName: json['AccountName'].toString(),
      accountNumber: json['AccountNumber'].toString(),
      iFSCCode: json['IFSCCode'].toString(),
      bankName: json['BankName'].toString(),
      bankLocation: json['BankLocation'].toString(),
      uDPassword1: json['UDPassword1'].toString(),
      uDMobile_Extn1: json['UDMobile_Extn1'].toString(),
      approveStatus: json['ApproveStatus'].toString(),
      uDDOB: json['UDDOB'].toString(),
      nationalityID: json['NationalityID'].toString(),
      countryName: json['CountryName'].toString(),
      refreshPNR: json['RefreshPNR'].toString(),
      viewPNR: json['ViewPNR'].toString(),
      seatMap: json['SeatMap'].toString(),
      backofficeFile: json['BackofficeFile'].toString(),
      importBooking: json['ImportBooking'].toString(),
      salesReport: json['SalesReport'].toString(),
      issueTicket: json['IssueTicket'].toString(),
      cancelBooking: json['CancelBooking'].toString(),
      cancelTicket: json['CancelTicket'].toString(),
      manageServices: json['ManageServices'].toString(),
      manageElement: json['ManageElement'].toString(),
      changeBooking: json['ChangeBooking'].toString(),
      viewTicket: json['ViewTicket'].toString(),
      downloadDocument: json['DownloadDocument'].toString(),
      bookingOptions: json['BookingOptions'].toString(),
      language: json['Language'].toString(),
      currencyCode: json['CurrencyCode'].toString(),
      photo: json['Photo'].toString(),
      agencyId: json['AgencyId'].toString(),
      banchId: json['BanchId'].toString(),
      uDBranchName: json['UDBranchName'].toString(),
      uDStatus: json['UDStatus'].toString(),
      gender: json['Gender'].toString(),
      uDTitle: json['UDTitle'].toString(),
      uDTravellerType: json['UDTravellerType'].toString(),
      customerType: json['CustomerType'].toString(),
      customerName: json['CustomerName'].toString(),
      corporateName: json['CorporateName'].toString(),
    );
  }
}

class Tablee1 {
  String traPassID;
  String pdTravellerId;
  String pdPassportNo;
  String pdDateOfBirth;
  String pdNationality;
  String pdIssuingCountry;
  String pdDateOfExpiry;
  String pdIsPrimary;
  String pdDocument;
  String pdDateOfBirthdt;
  String pdDateOfExpirydt;

  Tablee1({
    required this.traPassID,
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

  factory Tablee1.fromJson(Map<String, dynamic> json) {
    return Tablee1(
      traPassID: json['TraPassID'].toString(),
      pdTravellerId: json['PDTravellerId'].toString(),
      pdPassportNo: json['PDPassportNo'].toString(),
      pdDateOfBirth: json['PDDateofBirth'].toString(),
      pdNationality: json['PDNationality'].toString(),
      pdIssuingCountry: json['PDIssuingCountry'].toString(),
      pdDateOfExpiry: json['PDDateofExpiry'].toString(),
      pdIsPrimary: json['PDIsPrimary'].toString(),
      pdDocument: json['PDDocument'].toString(),
      pdDateOfBirthdt: json['PDDateofBirthdt'].toString(),
      pdDateOfExpirydt: json['PDDateofExpirydt'].toString(),
    );
  }
}

class Tablee2 {
  String traVisaId;
  String vdTravellerId;
  String vdVisaName;
  String vdCountryOfVisa;
  String vdTypeOfVisa;
  String vdDateOfIssue;
  String vdDateOfExpiry;
  String vdDateOfIssuedt;
  String vdDateOfExpirydt;

  Tablee2({
    required this.traVisaId,
    required this.vdTravellerId,
    required this.vdVisaName,
    required this.vdCountryOfVisa,
    required this.vdTypeOfVisa,
    required this.vdDateOfIssue,
    required this.vdDateOfExpiry,
    required this.vdDateOfIssuedt,
    required this.vdDateOfExpirydt,
  });

  factory Tablee2.fromJson(Map<String, dynamic> json) {
    return Tablee2(
      traVisaId: json['TraVisaID'].toString(),
      vdTravellerId: json['VDTravellerId'].toString(),
      vdVisaName: json['VDVisaName'].toString(),
      vdCountryOfVisa: json['VDCountryOfVisa'].toString(),
      vdTypeOfVisa: json['VDTypeOfVisa'].toString(),
      vdDateOfIssue: json['VDDateofIssue'].toString(),
      vdDateOfExpiry: json['VDDateofExpiry'].toString(),
      vdDateOfIssuedt: json['VDDateofIssuedt'].toString(),
      vdDateOfExpirydt: json['VDDateofExpirydt'].toString(),
    );
  }
}

class Tablee3 {
  String traDependantId;
  String ddTravellerId;
  String ddTitleId;
  String ddFirstName;
  String ddMiddleName;
  String ddLastName;
  String ddDOB;
  String ddRelation;
  String ddPassportNo;
  String ddPassportExpiry;
  String ddNationality;
  String ddPassportIssuingCountry;
  String ddEmailId;
  String ddMobileCC;
  String ddMobileAC;
  String ddMobileNo;
  String ddCountryOfVisa;
  String ddTypeOfVisa;
  String ddDateOfIssue;
  String ddDateOfExpiry;
  String ddDOBdt;
  String ddPassportExpirydt;
  String ddDateOfIssuedt;
  String ddDateOfExpirydt;

  Tablee3({
    required this.traDependantId,
    required this.ddTravellerId,
    required this.ddTitleId,
    required this.ddFirstName,
    required this.ddMiddleName,
    required this.ddLastName,
    required this.ddDOB,
    required this.ddRelation,
    required this.ddPassportNo,
    required this.ddPassportExpiry,
    required this.ddNationality,
    required this.ddPassportIssuingCountry,
    required this.ddEmailId,
    required this.ddMobileCC,
    required this.ddMobileAC,
    required this.ddMobileNo,
    required this.ddCountryOfVisa,
    required this.ddTypeOfVisa,
    required this.ddDateOfIssue,
    required this.ddDateOfExpiry,
    required this.ddDOBdt,
    required this.ddPassportExpirydt,
    required this.ddDateOfIssuedt,
    required this.ddDateOfExpirydt,
  });

  factory Tablee3.fromJson(Map<String, dynamic> json) {
    return Tablee3(
      traDependantId: json['TraDependantID'].toString(),
      ddTravellerId: json['DDTravellerId'].toString(),
      ddTitleId: json['DDTitleID'].toString(),
      ddFirstName: json['DDFirstName'].toString(),
      ddMiddleName: json['DDMiddleName'].toString(),
      ddLastName: json['DDLastName'].toString(),
      ddDOB: json['DDDOB'].toString(),
      ddRelation: json['DDRelation'].toString(),
      ddPassportNo: json['DDPassportNo'].toString(),
      ddPassportExpiry: json['DDPassportExpiry'].toString(),
      ddNationality: json['DDNationality'].toString(),
      ddPassportIssuingCountry: json['DDPassportIssuingCountry'].toString(),
      ddEmailId: json['DDEmailId'].toString(),
      ddMobileCC: json['DDMobile_CC'].toString(),
      ddMobileAC: json['DDMobile_AC'].toString(),
      ddMobileNo: json['DDMobile_No'].toString(),
      ddCountryOfVisa: json['DDCountryOfVisa'].toString(),
      ddTypeOfVisa: json['DDTypeOfVisa'].toString(),
      ddDateOfIssue: json['DDDateOfIssue'].toString(),
      ddDateOfExpiry: json['DDDateOfExpiry'].toString(),
      ddDOBdt: json['DDDOBdt'].toString(),
      ddPassportExpirydt: json['DDPassportExpirydt'].toString(),
      ddDateOfIssuedt: json['DDDateofIssuedt'].toString(),
      ddDateOfExpirydt: json['DDDateofExpirydt'].toString(),
    );
  }
}

class Tablee4 {
  String travellerId;
  String cardName;
  String cardOption;
  String cardType;
  String nameOnCard;
  String cardNumber;
  String expiryMonth;
  String expiryYear;
  String billingAddress;
  String cardLimit;
  String issuedCountry;
  String currency;
  String bankCharges;
  String paymentPeriod;
  String ruleAppliedOn;
  String personal;
  String corporate;
  String virtualCard;
  String physicalCard;
  String userTypeId;
  String userId;
  String cardName1;
  String cardOption1;
  String cardType1;
  String currencyName;
  String issuedCountryName;
  String personal1;
  String corporate1;
  String virtualCard1;
  String physicalCard1;
  String ruleAppliedOnName;

  Tablee4({
    required this.travellerId,
    required this.cardName,
    required this.cardOption,
    required this.cardType,
    required this.nameOnCard,
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.billingAddress,
    required this.cardLimit,
    required this.issuedCountry,
    required this.currency,
    required this.bankCharges,
    required this.paymentPeriod,
    required this.ruleAppliedOn,
    required this.personal,
    required this.corporate,
    required this.virtualCard,
    required this.physicalCard,
    required this.userTypeId,
    required this.userId,
    required this.cardName1,
    required this.cardOption1,
    required this.cardType1,
    required this.currencyName,
    required this.issuedCountryName,
    required this.personal1,
    required this.corporate1,
    required this.virtualCard1,
    required this.physicalCard1,
    required this.ruleAppliedOnName,
  });

  factory Tablee4.fromJson(Map<String, dynamic> json) {
    return Tablee4(
      travellerId: json['TravellerId'].toString(),
      cardName: json['CardName'].toString(),
      cardOption: json['CardOption'].toString(),
      cardType: json['CardType'].toString(),
      nameOnCard: json['NameOnCard'].toString(),
      cardNumber: json['CardNumber'].toString(),
      expiryMonth: json['ExpiryMonth'].toString(),
      expiryYear: json['ExpiryYear'].toString(),
      billingAddress: json['BillingAddress'].toString(),
      cardLimit: json['CardLimit'].toString(),
      issuedCountry: json['IssuedCountry'].toString(),
      currency: json['Currency'].toString(),
      bankCharges: json['BankCharges'].toString(),
      paymentPeriod: json['PaymentPeriod'].toString(),
      ruleAppliedOn: json['RuleAppliedOn'].toString(),
      personal: json['Personal'].toString(),
      corporate: json['Corporate'].toString(),
      virtualCard: json['VirtualCard'].toString(),
      physicalCard: json['PhysicalCard'].toString(),
      userTypeId: json['UserTypeId'].toString(),
      userId: json['UserId'].toString(),
      cardName1: json['CardName1'].toString(),
      cardOption1: json['CardOption1'].toString(),
      cardType1: json['CardType1'].toString(),
      currencyName: json['CurrencyName'].toString(),
      issuedCountryName: json['IssuedCountryName'].toString(),
      personal1: json['Personal1'].toString(),
      corporate1: json['Corporate1'].toString(),
      virtualCard1: json['VirtualCard1'].toString(),
      physicalCard1: json['PhysicalCard1'].toString(),
      ruleAppliedOnName: json['RuleAppliedOnName'].toString(),
    );
  }
}

class Tablee5 {
  String traPreferId;
  String apTravellerId;
  String apLonghaulSeat;
  String apShorthaulSeat;
  String apMealh;
  String apStopOver;
  String apMaxLayout;
  String apClass;
  String apOther;
  String hpRoom;
  String hpSmoking;
  String hpFacilities;
  String hpHotelChain;
  String hpHotelChainCode;
  String hpMembershipNo;
  String apShorthaulSeatName;
  String apLonghaulSeatName;
  String apStopOverName;
  String apMaxLayoutName;
  String economyPremiumEconomy;
  String mealPreference;
  String hpRoomName;
  String hpSmokingName;

  Tablee5({
    required this.traPreferId,
    required this.apTravellerId,
    required this.apLonghaulSeat,
    required this.apShorthaulSeat,
    required this.apMealh,
    required this.apStopOver,
    required this.apMaxLayout,
    required this.apClass,
    required this.apOther,
    required this.hpRoom,
    required this.hpSmoking,
    required this.hpFacilities,
    required this.hpHotelChain,
    required this.hpHotelChainCode,
    required this.hpMembershipNo,
    required this.apShorthaulSeatName,
    required this.apLonghaulSeatName,
    required this.apStopOverName,
    required this.apMaxLayoutName,
    required this.economyPremiumEconomy,
    required this.mealPreference,
    required this.hpRoomName,
    required this.hpSmokingName,
  });

  factory Tablee5.fromJson(Map<String, dynamic> json) {
    return Tablee5(
      traPreferId: json['TraPreferID'].toString(),
      apTravellerId: json['APTravellerId'].toString(),
      apLonghaulSeat: json['APLonghaulSeat'].toString(),
      apShorthaulSeat: json['APShorthaulSeat'].toString(),
      apMealh: json['APMealh'].toString(),
      apStopOver: json['APStopOver'].toString(),
      apMaxLayout: json['APMaxLayout'].toString(),
      apClass: json['APClass'].toString(),
      apOther: json['APOther'].toString(),
      hpRoom: json['HPRoom'].toString(),
      hpSmoking: json['HPSmoking'].toString(),
      hpFacilities: json['HPFacilities'].toString(),
      hpHotelChain: json['HPHotelChain'].toString(),
      hpHotelChainCode: json['HPHotelChainCode'].toString(),
      hpMembershipNo: json['HPMembershipNo'].toString(),
      apShorthaulSeatName: json['APShorthaulSeatName'].toString(),
      apLonghaulSeatName: json['APLonghaulSeatName'].toString(),
      apStopOverName: json['APStopOverName'].toString(),
      apMaxLayoutName: json['APMaxLayoutName'].toString(),
      economyPremiumEconomy: json['EconomyPremiumEconomy'].toString(),
      mealPreference: json['MealPreference'].toString(),
      hpRoomName: json['HPRoomName'].toString(),
      hpSmokingName: json['HPSmokingName'].toString(),
    );
  }
}

class Tablee6 {
  String TraFlightID;
  String PFTravellerId;
  String PFSelectAirlines;
  String PFLoyaltyNumber;

  Tablee6({
    required this.TraFlightID,
    required this.PFTravellerId,
    required this.PFSelectAirlines,
    required this.PFLoyaltyNumber,
  });

  factory Tablee6.fromJson(Map<String, dynamic> json) {
    return Tablee6(
      TraFlightID: json['TraFlightID'].toString(),
      PFTravellerId: json['PFTravellerId'].toString(),
      PFSelectAirlines: json['PFSelectAirlines'].toString(),
      PFLoyaltyNumber: json['PFLoyaltyNumber'].toString(),
    );
  }
}

// Repeat the same structure for Table2, Table3, Table4, Table5, and Table6
