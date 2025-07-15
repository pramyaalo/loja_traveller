class Table26FlightOnwardSegmentModel {
  final String bftfSlightID;
  final String tfsSeg;
  final String tfsAirline;
  final String tfsFlight;
  final String tfsDepAirport;
  final String tfsDepDatedt;
  final String tfsDepTime;
  final String tfsArrAirport;
  final String tfsArrDatedt;
  final String tfsArrTime;
  final String tfsClass;
  final String tfsStatus;
  final String tfsAirlinePNR;
  final String tfsFireBasisCode;
  final String tfsTotalStop;
  final String tfsDuration;
  final String tfsDepTerminal;
  final String tfsArrTerminal;
  final String tfsAirlinePNR1;
  final String tfsFlightNumber;
  final String tfsClassName;
  final String tfsClassCode;
  final String tfsTotalStop1;
  final String tfsStopoverInfo;
  final String tfsDuration1;
  final String equipment;

  Table26FlightOnwardSegmentModel({
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
    required  this.tfsClass,
    required this.tfsStatus,
    required  this.tfsAirlinePNR,
    required this.tfsFireBasisCode,
    required this.tfsTotalStop,
    required this.tfsDuration,
    required this.tfsDepTerminal,
    required this.tfsArrTerminal,
    required  this.tfsAirlinePNR1,
    required this.tfsFlightNumber,
    required this.tfsClassName,
    required this.tfsClassCode,
    required this.tfsTotalStop1,
    required this.tfsStopoverInfo,
    required this.tfsDuration1,
    required this.equipment,
  });

  factory Table26FlightOnwardSegmentModel.fromJson(Map<String, dynamic> json) {
    return Table26FlightOnwardSegmentModel(
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

  Map<String, dynamic> toJson() {
    return {
      'BFTFSlightID': bftfSlightID,
      'TFSSeg': tfsSeg,
      'TFSAirline': tfsAirline,
      'TFSFlight': tfsFlight,
      'TFSDepAirport': tfsDepAirport,
      'TFSDepDatedt': tfsDepDatedt,
      'TFSDepTime': tfsDepTime,
      'TFSArrAirport': tfsArrAirport,
      'TFSArrDatedt': tfsArrDatedt,
      'TFSArrTime': tfsArrTime,
      'TFSClass': tfsClass,
      'TFSStatus': tfsStatus,
      'TFSAirlinePNR': tfsAirlinePNR,
      'TFSFireBasisCode': tfsFireBasisCode,
      'TFSTotalStop': tfsTotalStop,
      'TFSDuration': tfsDuration,
      'TFSDepTerminal': tfsDepTerminal,
      'TFSArrTerminal': tfsArrTerminal,
      'TFSAirlinePNR1': tfsAirlinePNR1,
      'TFSFlightNumber': tfsFlightNumber,
      'TFSClassName': tfsClassName,
      'TFSClassCode': tfsClassCode,
      'TFSTotalStop1': tfsTotalStop1,
      'TFSStopoverInfo': tfsStopoverInfo,
      'TFSDuration1': tfsDuration1,
      'Equipment': equipment,
    };
  }
}
