  class Table7HolidayRemittanceModel {
    String passenger;
    String bookingNumber;
    String name;
    String totalNett;
    String checkOutDtt;

    Table7HolidayRemittanceModel({
      required this.passenger,
      required this.bookingNumber,
      required this.name,
      required this.totalNett,
      required this.checkOutDtt,
    });

    factory Table7HolidayRemittanceModel.fromJson(Map<String, dynamic> json) {
      return Table7HolidayRemittanceModel(
        passenger: json['Passenger'].toString(),
        bookingNumber: json['BookingNumber'].toString(),
        name: json['Name'].toString(),
        totalNett: json['TotalNett'].toString(),
        checkOutDtt: json['CheckOutDtt'].toString(),
      );
    }

    Map<String, dynamic> toJson() {
      return {
        'Passenger': passenger,
        'BookingNumber': bookingNumber,
        'Name': name,
        'TotalNett': totalNett,
        'CheckOutDtt': checkOutDtt,
      };
    }
  }
