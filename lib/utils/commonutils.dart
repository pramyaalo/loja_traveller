import 'package:intl/intl.dart';

class CommonUtils{
  static String convertToFormattedTime(String dateTimeString) {
    try{
      DateTime dateTime = DateTime.parse(dateTimeString);
      String formattedTime =
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      return DateFormat('hh:mm a')
          .format(DateFormat('HH:mm').parse(formattedTime));
    }catch(e){
      return '00:00';
    }
  }

  static String convertMinutesToHoursMinutes(String minutesString) {
    int totalMinutes = int.tryParse(minutesString) ?? 0;
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    // Return in the format '2h0m'
    return '${hours}h ${minutes}m';
  }

}