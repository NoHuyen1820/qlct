import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class NotificationWeekAndTime {
  late int day;
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime({
    required this.dayOfTheWeek,
    required this.timeOfDay,
});
}

Future<NotificationWeekAndTime?> pickSchedule(
  BuildContext context,
) async {
  List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  TimeOfDay? timeOfDay;
  DateTime now = DateTime.now();
  int? selectedDay;

  await showDialog(context: context, builder: (context) {
    return CupertinoAlertDialog(
      title: const Text(
        'I want to be reminded every:',
        textAlign: TextAlign.center,
      ),
      content: Wrap(
        alignment: WrapAlignment.center,
        spacing: 3,
        children: [
          for (int index = 0; index < weekdays.length; index++)
            ElevatedButton(
                onPressed: () {
                  selectedDay = index + 1;
                  Navigator.pop(context);
                },
                child: Text(weekdays[index]))
        ],
      ),
    );
  });
}

class NotificationDateTime {
  final DateTime dateTime;
  NotificationDateTime({
    required this.dateTime,
  });
}

class NotificationWeek {
  final int dayOfTheWeek;
  NotificationWeek({
    required this.dayOfTheWeek,
  });
}

class NotificationMonth {
  final int dayOfTheMonth;
  NotificationMonth({
    required this.dayOfTheMonth,
  });
}