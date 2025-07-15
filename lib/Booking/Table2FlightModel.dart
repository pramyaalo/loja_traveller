class Table2FlightModel {
  final String bftFlightId;
  final String tfsBookFlightId;
  final String pnr;
  final String ticketNo;
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
  final String tfsAirlinePnr;
  final String tfsFireBasisCode;
  final String tfsTotalStop;
  final String tfsDuration;
  final String tfsDepTerminal;
  final String tfsArrTerminal;
  final String tfsAirlinePnr1;
  final String tfsFlightNumber;
  final String tfsClassName;
  final String tfsClassCode;
  final String tfsTotalStop1;
  final String tfsStopoverInfo;
  final String tfsDuration1;
  final String equipment;

  Table2FlightModel({
    required this.bftFlightId,
    required this.tfsBookFlightId,
    required this.pnr,
    required this.ticketNo,
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
    required this.tfsAirlinePnr,
    required  this.tfsFireBasisCode,
    required this.tfsTotalStop,
    required this.tfsDuration,
    required this.tfsDepTerminal,
    required this.tfsArrTerminal,
    required  this.tfsAirlinePnr1,
    required this.tfsFlightNumber,
    required this.tfsClassName,
    required this.tfsClassCode,
    required this.tfsTotalStop1,
    required this.tfsStopoverInfo,
    required this.tfsDuration1,
    required this.equipment,
  });

  factory Table2FlightModel.fromJson(Map<String, dynamic> json) {
    return Table2FlightModel(
      bftFlightId: json['BFTFSlightID'].toString(),
      tfsBookFlightId: json['TFSBookFlightId'].toString(),
      pnr: json['PNR'].toString(),
      ticketNo: json['TicketNo'].toString(),
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

  Map<String, dynamic> toJson() {
    return {
      'BFTFSlightID': bftFlightId,
      'TFSBookFlightId': tfsBookFlightId,
      'PNR': pnr,
      'TicketNo': ticketNo,
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
      'TFSAirlinePNR': tfsAirlinePnr,
      'TFSFireBasisCode': tfsFireBasisCode,
      'TFSTotalStop': tfsTotalStop,
      'TFSDuration': tfsDuration,
      'TFSDepTerminal': tfsDepTerminal,
      'TFSArrTerminal': tfsArrTerminal,
      'TFSAirlinePNR1': tfsAirlinePnr1,
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

