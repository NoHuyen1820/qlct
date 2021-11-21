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
}
