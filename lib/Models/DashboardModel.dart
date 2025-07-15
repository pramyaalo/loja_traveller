import 'package:flutter/cupertino.dart';

class DashboardModel {
  List<Table0> table0;
  List<Table1> table1;
  List<Table2> table2;
  List<Table3> table3;
  List<Table4> table4;
  List<Table5> table5;
  List<Table6> table6;

  DashboardModel({
    required this.table0,
    required this.table1,
    required this.table2,
    required this.table3,
    required this.table4,
    required this.table5,
    required this.table6,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      table0: (json['Table'] as List<dynamic>)
          .map((e) => Table0.fromJson(e as Map<String, dynamic>))
          .toList(),
      table1: (json['Table1'] as List<dynamic>)
          .map((e) => Table1.fromJson(e as Map<String, dynamic>))
          .toList(),
      table2: (json['Table2'] as List<dynamic>)
          .map((e) => Table2.fromJson(e as Map<String, dynamic>))
          .toList(),
      table3: (json['Table3'] as List<dynamic>)
          .map((e) => Table3.fromJson(e as Map<String, dynamic>))
          .toList(),
      table4: (json['Table4'] as List<dynamic>)
          .map((e) => Table4.fromJson(e as Map<String, dynamic>))
          .toList(),
      table5: (json['Table5'] as List<dynamic>)
          .map((e) => Table5.fromJson(e as Map<String, dynamic>))
          .toList(),
      table6: (json['Table6'] as List<dynamic>)
          .map((e) => Table6.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Table0 {
  String peopleAC;
  String peopleDeAC;
  String agentName;
  String totalBookings;
  String totalInvoice;
  String totalSales;
  String totalCancelation;
  String totalTicket;
  String availableCredit;
  String totalPeople;

  Table0({
    required this.peopleAC,
    required this.peopleDeAC,
    required this.agentName,
    required this.totalBookings,
    required this.totalInvoice,
    required this.totalSales,
    required this.totalCancelation,
    required this.totalTicket,
    required this.availableCredit,
    required this.totalPeople,
  });

  factory Table0.fromJson(Map<String, dynamic> json) {
    return Table0(
      peopleAC: json['PeopleAC'].toString(),
      peopleDeAC: json['PeopleDeAC'].toString(),
      agentName: json['AgentName'].toString(),
      totalBookings: json['TotalBookings'].toString(),
      totalInvoice: json['TotalInvoice'].toString(),
      totalSales: json['TotalSales'].toString(),
      totalCancelation: json['TotalCancelation'].toString(),
      totalTicket: json['TotalTicket'].toString(),
      availableCredit: json['AvailableCredit'].toString(),
      totalPeople: json['TotalPepole'].toString(),
    );
  }
}

class Table1 {
  String number;
  String label;
  String value1;
  String value2;

  Table1({
    required this.number,
    required this.label,
    required this.value1,
    required this.value2,
  });

  factory Table1.fromJson(Map<String, dynamic> json) {
    return Table1(
      number: json['number'].toString(),
      label: json['label'].toString(),
      value1: json['value1'].toString(),
      value2: json['value2'].toString(),
    );
  }
}

class Table2 {
  String number;
  String label;
  String value1;
  String value2;
  String value3;
  String value4;
  String value5;
  String value6;
  String value7;
  String value8;
  String value10;

  Table2({
    required this.number,
    required this.label,
    required this.value1,
    required this.value2,
    required this.value3,
    required this.value4,
    required this.value5,
    required this.value6,
    required this.value7,
    required this.value8,
    required this.value10,
  });

  factory Table2.fromJson(Map<String, dynamic> json) {
    return Table2(
      number: json['number'].toString(),
      label: json['label'].toString(),
      value1: json['value1'].toString(),
      value2: json['value2'].toString(),
      value3: json['value3'].toString(),
      value4: json['value4'].toString(),
      value5: json['value5'].toString(),
      value6: json['value6'].toString(),
      value7: json['value7'].toString(),
      value8: json['value8'].toString(),
      value10: json['value10'].toString(),
    );
  }
}

class Table3 {
  String number;
  String label;
  String value1;
  String value2;
  String value3;

  Table3({
    required this.number,
    required this.label,
    required this.value1,
    required this.value2,
    required this.value3,
  });

  factory Table3.fromJson(Map<String, dynamic> json) {
    return Table3(
      number: json['number'].toString(),
      label: json['label'].toString(),
      value1: json['value1'].toString(),
      value2: json['value2'].toString(),
      value3: json['value3'].toString(),
    );
  }
}

class Table4 {
  String number;
  String label;
  String value1;

  Table4({
    required this.number,
    required this.label,
    required this.value1,
  });

  factory Table4.fromJson(Map<String, dynamic> json) {
    return Table4(
      number: json['number'].toString(),
      label: json['label'].toString(),
      value1: json['value1'].toString(),
    );
  }
}

class Table5 {
  String creditLimt;
  String balance;

  Table5({
    required this.creditLimt,
    required this.balance,
  });

  factory Table5.fromJson(Map<String, dynamic> json) {
    return Table5(
      creditLimt: json['CreditLimt'].toString(),
      balance: json['Balance'].toString(),
    );
  }
}

class Table6 {
  String availableCredit;

  Table6({
    required this.availableCredit,
  });

  factory Table6.fromJson(Map<String, dynamic> json) {
    return Table6(
      availableCredit: json['AvailableCredit'].toString(),
    );
  }
}

// Repeat the same structure for Table2, Table3, Table4, Table5, and Table6
