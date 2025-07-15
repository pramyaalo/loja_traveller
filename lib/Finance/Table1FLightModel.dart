class Table1FLightModel {
  String bftfSlightId;
  String tfsSeg;
  String tfsAirline;
  String tfsFlight;
  String tfsDepAirport;
  String tfsDepDateDt;
  String tfsDepTime;
  String tfsArrAirport;
  String tfsArrDateDt;
  String tfsArrTime;
  String tfsClass;
  String tfsStatus;
  String tfsAirlinePnr;
  String tfsFireBasisCode;
  String tfsTotalStop;
  String tfsDuration;
  String tfsDepTerminal;
  String tfsArrTerminal;
  String tfsAirlinePnr1;
  String tfsFlightNumber;
  String tfsClassName;
  String tfsClassCode;
  String tfsTotalStop1;
  String tfsStopoverInfo;
  String tfsDuration1;
  String equipment;

  Table1FLightModel({
    required this.bftfSlightId,
    required this.tfsSeg,
    required this.tfsAirline,
    required this.tfsFlight,
    required this.tfsDepAirport,
    required this.tfsDepDateDt,
    required this.tfsDepTime,
    required this.tfsArrAirport,
    required this.tfsArrDateDt,
    required this.tfsArrTime,
    required this.tfsClass,
    required this.tfsStatus,
    required this.tfsAirlinePnr,
    required this.tfsFireBasisCode,
    required this.tfsTotalStop,
    required this.tfsDuration,
    required this.tfsDepTerminal,
    required this.tfsArrTerminal,
    required this.tfsAirlinePnr1,
    required this.tfsFlightNumber,
    required this.tfsClassName,
    required this.tfsClassCode,
    required this.tfsTotalStop1,
    required this.tfsStopoverInfo,
    required this.tfsDuration1,
    required this.equipment,
  });

  factory Table1FLightModel.fromJson(Map<String, dynamic> json) {
    return Table1FLightModel(
      bftfSlightId: json['BFTFSlightID'].toString(),
      tfsSeg: json['TFSSeg'].toString(),
      tfsAirline: json['TFSAirline'].toString(),
      tfsFlight: json['TFSFlight'].toString(),
      tfsDepAirport: json['TFSDepAirport'].toString(),
      tfsDepDateDt: json['TFSDepDatedt'].toString(),
      tfsDepTime: json['TFSDepTime'].toString(),
      tfsArrAirport: json['TFSArrAirport'].toString(),
      tfsArrDateDt: json['TFSArrDatedt'].toString(),
      tfsArrTime: json['TFSArrTime'].toString(),
      tfsClass: json['TFSClass'].toString(),
      tfsStatus: json['TFSStatus'].toString(),
      tfsAirlinePnr: json['TFSAirlinePNR'].toString(),
      tfsFireBasisCode: json['TFSFireBasisCode'].toString(),
      tfsTotalStop: json['TFSTotalStop'].toString(),
      tfsDuration: json['TFSDuration'].toString(),
      tfsDepTerminal: json['TFSDepTerminal'].toString(),
      tfsArrTerminal: json['TFSArrTerminal'].toString(),
      tfsAirlinePnr1: json['TFSAirlinePNR1'].toString(),
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
