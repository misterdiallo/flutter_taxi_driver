import 'package:intl/intl.dart';

formatToDateTimeFromApi(String date) {
  DateTime parse = DateTime.parse(date);
  String formated = DateFormat('dd MMM yyyy HH:mm').format(parse);
  return formated;
}

formatToDateFromApi(String date) {
  DateTime parse = DateTime.parse(date);
  String formated = DateFormat('dd MMM yyyy').format(parse);
  return formated;
}

formatToTimeFromApi(String date) {
  DateTime parse = DateTime.parse(date);
  String formated = DateFormat('HH:mm').format(parse);
  return formated;
}

bool isTodayOrNot(DateTime date) {
  DateTime now = DateTime.now();
  DateTime nowdate = DateTime(now.year, now.month, now.day);
  var value = nowdate.compareTo(date);
  if (value >= 0) {
    if (value == 0) {
      return true; // "today";
    } else {
      return false; //  "isPassed";
    }
  } else {
    return false; // "isFuture";
  }
}
