class ConversionUtil {
  static String metersToKilometers(double meters) {
    double kilometers = meters / 1000;
    return kilometers.toStringAsFixed(2);
  }

  static String secondsToHoursOrMinutes(double seconds) {
    if (seconds >= 3600) {
      double hours = seconds / 3600;
      return '${hours.toStringAsFixed(2)} hours';
    } else {
      double minutes = seconds / 60;
      return '${minutes.toStringAsFixed(0)} minutes';
    }
  }

  static double metersToKilometersDouble(double meters) {
    double kilometers = meters / 1000;
    return kilometers;
  }

  static double secondsToHoursOrMinutesDouble(double seconds) {
    double minutes = seconds / 60;
    return minutes;
  }
}
