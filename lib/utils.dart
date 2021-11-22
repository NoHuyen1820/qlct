class QLCTUtils {
  // convert int to String
  static String intToString(int integer) {
    return integer.toString();
  }

  // convert String to int
  static int stringToInt(String string) {
    return int.parse(string);
  }

  static DateTime? stringToDateTime(String? string) {
    var s = string;
    if (s != null) {
      return DateTime.parse(s.substring(0, 8) + 'T' + s.substring(8));
    }
    return null;
  }
  
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



