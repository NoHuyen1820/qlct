import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:qlct/notifications.dart';

class NotifyProvider with ChangeNotifier {
  List<Schedule> _schedules = [];

  List<Schedule> get schedules {
    return _schedules;
  }

  Future<List<Schedule>> fetch() async {
    List<NotificationModel> notifiesModel = await getReminderNotifications();
    final List<Schedule> loadNotifies = [];
    for (NotificationModel nM in notifiesModel) {
      loadNotifies.add(
          Schedule(
              id: nM.content!.id!,
              periodic: nM.schedule.toString(),
              name: nM.content!.title!,
              isEnable: true));
    }
    _schedules = loadNotifies;
    notifyListeners();
    return _schedules;
  }

  void add(Schedule schedule) {
    _schedules.add(schedule);
    notifyListeners();
  }

  void remove(Schedule schedule) {
    _schedules.remove(schedule);
    notifyListeners();
  }

}

class Schedule {
  final int id;
  final String periodic;
  final String name;
  final bool isEnable;
  Schedule({
    required this.id,
    required this.periodic,
    required this.name,
    required this.isEnable,
});
}