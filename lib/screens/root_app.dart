import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:qlct/screens/budget/budget_list.dart';
import 'package:qlct/screens/overview/overview_screen.dart';
import 'package:qlct/screens/profile/profile_screen.dart';
import 'package:qlct/screens/transaction/add_transaction.dart';
import 'package:qlct/screens/transaction/transaction_list.dart';
import 'package:qlct/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class RootApp extends StatefulWidget {
  final int currentIndex;
  const RootApp({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  List<Widget> pages = [
    const OverviewScreen(),
    const TransactionListScreen(),
    const BudgetListScreen(),
    const ProfileScreen(),
    // const ReportScreen(),
    const AddTransactionScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    pageIndex = widget.currentIndex;
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(context: context, builder: (context) => CupertinoAlertDialog(
          title: const Text('Thông báo'),
          content: const Text('Ứng dụng của chúng tôi muốn gửi cho bạn thông báo'),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text(
                    'Không cho phép',
                  style: TextStyle(color: Colors.grey),
                )
            ),
            TextButton(
                onPressed: (){
                  AwesomeNotifications().requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context));
                },
                child: const Text(
                  'Cho phép',
                  style: TextStyle(
                      color: QLCTColors.mainPurpleColor,
                      fontWeight: FontWeight.bold),
                )
            ),
          ],
          )
        );
      }
    });

    AwesomeNotifications().createdStream.listen((ReceivedNotification noti) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('Notification create on ${noti.channelKey}'),
      // ));
    });
    AwesomeNotifications().actionStream.listen((event) {
      // Navigator.push(context, MaterialPageRoute(
      //     builder: (context) => const RootApp(currentIndex: 4)));
      if (event.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then((value) => 
        AwesomeNotifications().setGlobalBadgeCounter(value - 1));
      }
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) =>
      //     const RootApp(currentIndex: 2),
      // ), (route) => route.isFirst);
    });
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: getBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              selectedTab(4);
            },
            child: const Icon(
              Icons.add,
              size: 25,
            ),
            backgroundColor: QLCTColors.mainPurpleColor
            //params
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      FontAwesomeIcons.calendar,
      Iconic.list,
      FontAwesomeIcons.wallet,
      FontAwesomeIcons.user,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: QLCTColors.mainPurpleColor,
      splashColor: QLCTColors.mainPurpleColor,
      inactiveColor: Colors.black38,
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }

}
