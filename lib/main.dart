import 'package:flutter/material.dart';

import 'SplashScreen.dart';
import 'bookings/flight/multicity_flight_list.dart';
import 'bookings/flight/one_way_flight_list.dart';
import 'bookings/flight/two_way_boarding_flight_list.dart';
import 'bookings/flight/two_way_booking.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        //appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Color(0xFF00ADEE)),backgroundColor: Color(0xffffffff), titleTextStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Color(0xFF00ADEE))),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Color(0xFF00ADEE)),
            backgroundColor: Color(0xffffffff),
            titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00ADEE))),
        primaryColor: Color(0xFF00ADEE),
        //primaryColor: Color(0xFF00ADEE),
        // primaryColor: Color(0xffa82e9b),
        useMaterial3: false,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Color(0xffef83b4), // Set accent color
        ),
      ),
      home: SplashScreen(),
    );
  }
}
