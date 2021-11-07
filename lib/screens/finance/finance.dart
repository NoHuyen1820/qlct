import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qlct/theme/colors.dart';

class FinanceOverviewFragment extends StatelessWidget {
  final String title;
  final String amount;
  final Future<String>? futureAmount;
  final List<FinanceItem>? items;
  final Future<List<FinanceItem>>? futureItems;

  const FinanceOverviewFragment(
      {Key? key,
      required this.title,
      required this.amount,
      this.futureAmount,
      this.items,
      this.futureItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 13.0, color: QLCTColors.primaryColorDark),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      amount,
                      style: const TextStyle(
                          fontSize: 44.0, color: QLCTColors.primaryColor),
                    ))
              ],
            ),
            for (var item in items!) item,
            SizedBox(
                width: double.maxFinite,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("SEE ALL",
                      style: TextStyle(color: QLCTColors.primaryColorDark)),
                ))
          ],
        ),
      ),
    );
  }
}

class FinanceItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;

  const FinanceItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Decimal amountInt = Decimal.parse(amount);
    bool isNegative = amountInt.isNegative;

    return Slidable(
      child: TextButton(
        onPressed: () {},
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      child: isNegative
                          ? const FaIcon(FontAwesome.down, color: Colors.red)
                          : const FaIcon(FontAwesome.up,
                              color: RallyColors.buttonColor)),
                  Expanded(
                      child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.black87),
                          ),
                          Text(
                            subtitle,
                            style: const TextStyle(
                                fontSize: 13.0, color: Colors.black38),
                          )
                        ],
                      ),
                      Text(
                        amount,
                        style: isNegative
                            ? const TextStyle(fontSize: 20.0, color: Colors.red)
                            : const TextStyle(
                                fontSize: 20.0, color: RallyColors.buttonColor),
                      )
                    ],
                  )),
                  Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: const FaIcon(FontAwesome.angle_right,
                          color: Colors.black38))
                ],
              ),
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
      actionPane: const SlidableScrollActionPane(),
      actions: const <Widget>[
        IconSlideAction(
          caption: 'Remove',
          color: Colors.red,
          icon: FontAwesomeIcons.solidTrashAlt,
        )
      ],
    );
  }
}
