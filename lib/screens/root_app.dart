import 'package:qlct/screens/budget/budget_list.dart';
import 'package:qlct/screens/overview/overview_screen.dart';
import 'package:qlct/screens/profile/profile_screen.dart';
import 'package:qlct/screens/report/report_screen.dart';
import 'package:qlct/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  List<Widget> pages = [
    const OverviewScreen(),
    const ReportScreen(),
    const BudgetListScreen(),
    const ProfileScreen(),
    const OverviewScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
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
            backgroundColor: QLCTColors.mainColor
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
      FontAwesomeIcons.table,
      FontAwesomeIcons.wallet,
      FontAwesomeIcons.user,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: QLCTColors.mainColor,
      splashColor: QLCTColors.mainColor,
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
