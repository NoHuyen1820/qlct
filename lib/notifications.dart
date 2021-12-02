import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:qlct/utils.dart';

Future<void> createNotification() async {
  log("createNotification");
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'basic_channel',
          title: '${Emojis.time_alarm_clock} ',
          body: 'Florist at 123 main st.....',
          notificationLayout: NotificationLayout.Default,
      )
  );
}

Future<void> createReminderNotification(NotificationWeekAndTime scheduled) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'scheduled_channel',
          title: '${Emojis.time_alarm_clock} Schedule transaction',
          body: 'You have 1 recurring monthly transaction today',
          notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
            key: 'MARK_DONE',
            label: 'Mark done',
        ),
      ],
      schedule: NotificationCalendar(
        repeats: true,
        weekday: scheduled.dayOfTheWeek,
        hour: scheduled.timeOfDay.hour,
        minute: scheduled.timeOfDay.minute,
        second: 0,
        millisecond: 0,
      )
  );
}

Future<void> createReminderNotificationByDay(int id, String name, NotificationDateTime scheduled) async {
  log("BEGIN - createReminderNotificationByDay");
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'scheduled_channel',
        title: '${Emojis.time_alarm_clock} $name',
        body: 'You have 1 recurring daily transaction today',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'CREATE_TRANSACTION',
          label: 'Create transaction',
        ),
      ],
      schedule: NotificationCalendar(
        repeats: true,
        hour: scheduled.dateTime.hour,
        minute: scheduled.dateTime.minute + 1,
        second: 0,
        millisecond: 0,
      )
  );
  log("END - createReminderNotificationByDay");
}

Future<void> createReminderNotificationByWeek(int id, String name, NotificationDateTime scheduled) async {
  log("BEGIN - createReminderNotificationByWeek");
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'scheduled_channel',
        title: '${Emojis.time_alarm_clock} $name',
        body: 'You have 1 recurring weekly transaction today',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'CREATE_TRANSACTION',
          label: 'Create transaction',
        ),
      ],
      schedule: NotificationCalendar(
        repeats: true,
        weekday: scheduled.dateTime.weekday,
        hour: scheduled.dateTime.hour,
        minute: scheduled.dateTime.minute + 1,
        second: 0,
        millisecond: 0,
      )
  );
  log("BEGIN - createReminderNotificationByWeek");
}

Future<void> createReminderNotificationByMonth(int id, String name, NotificationDateTime scheduled) async {
  log("BEGIN - createReminderNotificationByMonth");
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'scheduled_channel',
        title: '${Emojis.time_alarm_clock} $name',
        body: 'You have 1 recurring monthly transaction today',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'CREATE_TRANSACTION',
          label: 'Create transaction',
        ),
      ],
      schedule: NotificationCalendar(
        repeats: true,
        day: scheduled.dateTime.day,
        hour: scheduled.dateTime.hour,
        minute: scheduled.dateTime.minute + 1,
        second: 0,
        millisecond: 0,
      )
  );
  log("END - createReminderNotificationByMonth");
}

Future<List<NotificationModel>> getReminderNotifications() async {
  List<NotificationModel> notifies = await AwesomeNotifications().listScheduledNotifications();
  return notifies;
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}

Future<void> cancelScheduleNotificationById(int id) async {
  await AwesomeNotifications().cancel(id);
}