class Table3FlightTicketVoucherModel {
  final String bftfSlightID;
  final String tfSSeg;
  final String tfSAirline;
  final String tfsFlight;
  final String tfsDepAirport;
  final String tfsDepDatedt;
  final String tfsDepTime;
  final String tfsArrAirport;
  final String tfsArrDatedt;
  final String tfsArrTime;
  final String tfsClass;
  final String tfsStatus;
  final String tfSAirlinePNR;
  final String tfsFireBasisCode;
  final String tfsTotalStop;
  final String tfsDuration;
  final String tfsDepTerminal;
  final String tfsArrTerminal;
  final String tfSAirlinePNR1;
  final String tfsFlightNumber;
  final String tfsClassName;
  final String tfsClassCode;
  final String tfsTotalStop1;
  final String tfsStopoverInfo;
  final String tfsDuration1;
  final String equipment;

  Table3FlightTicketVoucherModel({
    required this.bftfSlightID,
    required this.tfSSeg,
    required this.tfSAirline,
    required this.tfsFlight,
    required this.tfsDepAirport,
    required this.tfsDepDatedt,
    required this.tfsDepTime,
    required this.tfsArrAirport,
    required this.tfsArrDatedt,
    required this.tfsArrTime,
    required  this.tfsClass,
    required this.tfsStatus,
    required this.tfSAirlinePNR,
    required  this.tfsFireBasisCode,
    required this.tfsTotalStop,
    required this.tfsDuration,
    required this.tfsDepTerminal,
    required this.tfsArrTerminal,
    required this.tfSAirlinePNR1,
    required this.tfsFlightNumber,
    required this.tfsClassName,
    required this.tfsClassCode,
    required this.tfsTotalStop1,
    required this.tfsStopoverInfo,
    required this.tfsDuration1,
    required this.equipment,
  });

  factory Table3FlightTicketVoucherModel.fromJson(Map<String, dynamic> json) {
    return Table3FlightTicketVoucherModel(
      bftfSlightID: json['BFTFSlightID'].toString(),
      tfSSeg: json['TFSSeg'].toString(),
      tfSAirline: json['TFSAirline'].toString(),
      tfsFlight: json['TFSFlight'].toString(),
      tfsDepAirport: json['TFSDepAirport'].toString(),
      tfsDepDatedt: json['TFSDepDatedt'].toString(),
      tfsDepTime: json['TFSDepTime'].toString(),
      tfsArrAirport: json['TFSArrAirport'].toString(),
      tfsArrDatedt: json['TFSArrDatedt'].toString(),
      tfsArrTime: json['TFSArrTime'].toString(),
      tfsClass: json['TFSClass'].toString(),
      tfsStatus: json['TFSStatus'].toString(),
      tfSAirlinePNR: json['TFSAirlinePNR'].toString(),
      tfsFireBasisCode: json['TFSFireBasisCode'].toString(),
      tfsTotalStop: json['TFSTotalStop'].toString(),
      tfsDuration: json['TFSDuration'].toString(),
      tfsDepTerminal: json['TFSDepTerminal'].toString(),
      tfsArrTerminal: json['TFSArrTerminal'].toString(),
      tfSAirlinePNR1: json['TFSAirlinePNR1'].toString(),
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
