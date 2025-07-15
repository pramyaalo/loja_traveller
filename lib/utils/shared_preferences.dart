//import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const String PREFS_USER_TYPE = "UserType";
  static const String PREFS_USER_TYPE_ID = "UserTypeId";
  static const String PREFS_USER_ID = "UserID";
  static const String PREFS_USER_NAME = "Username";
  static const String PREFS_NAME = "Name";
  static const String PREFS_PASSWORD = "Password";
  static const String PREFS_TRANSACTION_PASSWORD = "TransactionPassword";
  static const String PREFS_CONTACT_EMAIL = "ContactEmail";
  static const String PREFS_MOBILE = "Mobile";
  static const String PREFS_TIME_IN = "Timein";
  static const String PREFS_TIME_OUT = "Timeout";
  static const String PREFS_IS_ACTIVE = "IsActive";
  static const String PREFS_TWO = "Two";
  static const String PREFS_PHOTO = "Photo";
  static const String PREFS_PAYPAL = "Paypal";
  static const String PREFS_PAYZA = "Payza";
  static const String PREFS_DATE_CREATED = "Datecreated";
  static const String PREFS_CURRENCY = "Currency";

  static saveStringValue(String key, String value) async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static saveBoolValue(String key, bool value) async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
}
