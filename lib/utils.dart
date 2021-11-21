class QLCTUtils {

  static String dateTimeToString(DateTime dateTime, String suffix) {
    String monthStr = dateTime.month.toString();
    String dayStr = dateTime.day.toString();
    if (monthStr.length == 1) {
      monthStr = "0" + monthStr;
    }
    if (dayStr.length == 1) {
      dayStr = "0" + dayStr;
    }
    return "${dateTime.year}$monthStr$dayStr$suffix";
  }
}