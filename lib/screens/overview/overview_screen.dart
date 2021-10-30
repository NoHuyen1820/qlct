import 'package:flutter/material.dart';
import 'package:qlct/components/chart/pie_finance_chart.dart';
import 'package:qlct/screens/finance/finance.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  // temp
  final financeItems = List<FinanceItem>.generate(
      10,
      (index) => index % 2 == 0
          ? const FinanceItem(
              title: "Dalat travel",
              subtitle: "25/10/2022",
              amount: "-500000")
          : const FinanceItem(
              title: "English course",
              subtitle: "25/10/2022",
              amount: "3500000"));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfffcfcfc),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40.0,
            ),
            const Text(
              "Overview",
              style: TextStyle(color: Colors.black, fontSize: 35.0),
            ),
            const SizedBox(
              height: 5.0,
            ),
            PieFinanceChart(),
            const SizedBox(
              height: 20.0,
            ),
            Center(
                child: FinanceOverviewFragment(
              title: 'BUDGET',
              amount: '10.000.000đ',
              items: financeItems.sublist(0, 3),
            )),
            Center(
                child: FinanceOverviewFragment(
              title: 'TRANSACTION',
              amount: '3.500.000đ',
              items: financeItems.sublist(0, 3),
            )),
          ],
        ),
      )),
    );
  }
}
