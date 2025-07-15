class Table1CreditNoteFlightReceiptModel {
  String bftfSlightID;
  String tfsSeg;
  String tfsAirline;
  String tfsFlight;
  String tfsDepAirport;
  String tfsDepDatedt;
  String tfsDepTime;
  String tfsArrAirport;
  String tfsArrDatedt;
  String tfsArrTime;
  String tfsClass;
  String tfsStatus;
  String tfsAirlinePNR;
  String tfsFireBasisCode;
  String tfsTotalStop;
  String tfsDuration;
  String tfsDepTerminal;
  String tfsArrTerminal;
  String tfsAirlinePNR1;
  String tfsFlightNumber;
  String tfsClassName;
  String tfsClassCode;
  String tfsTotalStop1;
  String tfsStopoverInfo;
  String tfsDuration1;
  String equipment;

  Table1CreditNoteFlightReceiptModel({
    required this.bftfSlightID,
    required this.tfsSeg,
    required this.tfsAirline,
    required this.tfsFlight,
    required this.tfsDepAirport,
    required this.tfsDepDatedt,
    required this.tfsDepTime,
    required this.tfsArrAirport,
    required this.tfsArrDatedt,
    required this.tfsArrTime,
    required this.tfsClass,
    required this.tfsStatus,
    required this.tfsAirlinePNR,
    required this.tfsFireBasisCode,
    required this.tfsTotalStop,
    required this.tfsDuration,
    required this.tfsDepTerminal,
    required this.tfsArrTerminal,
    required this.tfsAirlinePNR1,
    required this.tfsFlightNumber,
    required this.tfsClassName,
    required this.tfsClassCode,
    required this.tfsTotalStop1,
    required this.tfsStopoverInfo,
    required this.tfsDuration1,
    required this.equipment,
  });

  factory Table1CreditNoteFlightReceiptModel.fromJson(
      Map<String, dynamic> json) {
    return Table1CreditNoteFlightReceiptModel(
      bftfSlightID: json['BFTFSlightID'].toString(),
      tfsSeg: json['TFSSeg'].toString(),
      tfsAirline: json['TFSAirline'].toString(),
      tfsFlight: json['TFSFlight'].toString(),
      tfsDepAirport: json['TFSDepAirport'].toString(),
      tfsDepDatedt: json['TFSDepDatedt'].toString(),
      tfsDepTime: json['TFSDepTime'].toString(),
      tfsArrAirport: json['TFSArrAirport'].toString(),
      tfsArrDatedt: json['TFSArrDatedt'].toString(),
      tfsArrTime: json['TFSArrTime'].toString(),
      tfsClass: json['TFSClass'].toString(),
      tfsStatus: json['TFSStatus'].toString(),
      tfsAirlinePNR: json['TFSAirlinePNR'].toString(),
      tfsFireBasisCode: json['TFSFireBasisCode'].toString(),
      tfsTotalStop: json['TFSTotalStop'].toString(),
      tfsDuration: json['TFSDuration'].toString(),
      tfsDepTerminal: json['TFSDepTerminal'].toString(),
      tfsArrTerminal: json['TFSArrTerminal'].toString(),
      tfsAirlinePNR1: json['TFSAirlinePNR1'].toString(),
      tfsFlightNumber: json['TFSFlightNumber'].toString(),
      tfsClassName: json['TFSClassName'].toString(),
      tfsClassCode: json['TFSClassCode'].toString(),
      tfsTotalStop1: json['TFSTotalStop1'].toString(),
      tfsStopoverInfo: json['TFSStopoverInfo'].toString(),
      tfsDuration1: json['TFSDuration1'].toString(),
      equipment: json['Equipment'].toString(),
    );
  }
}
