  class Table3HolidayVoucherModel {
    final String holidayPID;
    final String holidayPID1;
    final String type;
    final String tfpIdentityNo;
    final String passenger;
    final String dob;
    final String phoneNo;
    final String email;
    final String pnr;
    final String age;
    final String city;
    final String countryName;
    final String state;
    final String address;
    final String gender;

    Table3HolidayVoucherModel({
      required this.holidayPID,
      required this.holidayPID1,
      required this.type,
      required this.tfpIdentityNo,
      required this.passenger,
      required this.dob,
      required this.phoneNo,
      required this.email,
      required this.pnr,
      required this.age,
      required this.city,
      required this.countryName,
      required this.state,
      required this.address,
      required this.gender,
    });

    factory Table3HolidayVoucherModel.fromJson(Map<String, dynamic> json) {
      return Table3HolidayVoucherModel(
        holidayPID: json['HolidayPID'].toString(),
        holidayPID1: json['HolidayPID1'].toString(),
        type: json['Type'].toString(),
        tfpIdentityNo: json['TFPIdentityNo'].toString(),
        passenger: json['Passenger'].toString(),
        dob: json['DOB'].toString(),
        phoneNo: json['PhoneNo'].toString(),
        email: json['Email'].toString(),
        pnr: json['PNR'].toString(),
        age: json['Age'].toString(),
        city: json['City'].toString(),
        countryName: json['CountryName'].toString(),
        state: json['State'].toString(),
        address: json['Address'].toString(),
        gender: json['Gender'].toString(),
      );
    }

    Map<String, dynamic> toJson() {
      return {
        'HolidayPID': holidayPID,
        'HolidayPID1': holidayPID1,
        'Type': type,
        'TFPIdentityNo': tfpIdentityNo,
        'Passenger': passenger,
        'DOB': dob,
        'PhoneNo': phoneNo,
        'Email': email,
        'PNR': pnr,
        'Age': age,
        'City': city,
        'CountryName': countryName,
        'State': state,
        'Address': address,
        'Gender': gender,
      };
    }

    @override
    String toString() {
      return 'HolidayPassenger(passenger: $passenger, age: $age, phone: $phoneNo)';
    }
  }
