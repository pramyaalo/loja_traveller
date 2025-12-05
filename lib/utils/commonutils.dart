import 'package:intl/intl.dart';

class CommonUtils{



  static String convertMinutesToHoursMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return '${hours}h ${mins}m';
  }

  static String convertToFormattedTime(String rawTime) {
    try {
      // Parse input: 11/14/2025 9:40:00 AM
      final date = DateFormat("MM/dd/yyyy").parse(rawTime);

      // Format output: 09:40 AM
      return DateFormat('hh:mm a').format(date);
    } catch (e) {
      print("Invalid date format: $rawTime");
      return rawTime; // fallback if parsing fails
    }
  }
  static String formatToMonthDayWeek(String dateTimeStr) {
    try {
      // Parse the input string
      DateTime dt = DateTime.parse(dateTimeStr);

      // Format as: Nov 20, Thu
      return DateFormat('MMM d, E').format(dt);
    } catch (e) {
      print("⚠️ Error formatting date: $e");
      return dateTimeStr; // fallback
    }
  }
}