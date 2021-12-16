import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:qlct/provider/notify_provider.dart';
import 'package:qlct/services/schedule_service/schedule_service.dart';
import 'package:qlct/theme/colors.dart';

import '../../notifications.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({Key? key}) : super(key: key);

  @override
  _ScheduleListScreenState createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  bool _isLoading = false;
  var scheService = ScheduleService();
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<NotifyProvider>(context, listen: false)
        .fetch()
        .then((_) {
      setState(() {_isLoading = false;});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var scheduleData = Provider.of<NotifyProvider>(context);
    var fetchedSchedules = scheduleData.schedules;
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: QLCTColors.mainPurpleColor,
        ),
        title: const Text("Chi tiêu định kì",
        style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            decorationStyle: TextDecorationStyle.wavy)),

      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: fetchedSchedules.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(fetchedSchedules[index].name),
                            subtitle: Text(fetchedSchedules[index].body),
                            trailing: IconButton(
                              onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CupertinoAlertDialog(
                                        content: Column(children: const [
                                          Text(
                                            "Bạn có chắc chắn xóa định kì này?",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ]),
                                        actions: <Widget>[
                                          CupertinoButton(
                                            child: const Text(
                                              "Huỷ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          CupertinoButton(
                                              child: const Text(
                                                "Đồng ý",
                                                style: TextStyle(
                                                  color:
                                                      QLCTColors.mainRedColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              onPressed: () async {
                                                await scheService
                                                    .deleteSchedule(
                                                        fetchedSchedules[
                                                                index]
                                                            .id
                                                            .toString());
                                                await cancelScheduleNotificationById(
                                                    fetchedSchedules[index]
                                                        .id);
                                                await scheduleData.fetch();
                                                Navigator.of(context).pop();
                                              })
                                        ],
                                      )),
                              icon: const Icon(
                                Typicons.trash,
                                color: QLCTColors.mainRedColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
