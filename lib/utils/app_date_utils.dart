

class AppDateUtils {

  // CONVERT MILLIS TO DATE STRING
  static String toDateString(int millis) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    return dateTime.toString();
  }
}