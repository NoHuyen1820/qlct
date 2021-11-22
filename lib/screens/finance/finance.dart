import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qlct/theme/colors.dart';

import '../root_app.dart';

class FinanceOverviewFragment extends StatelessWidget {
  final String title;
  final String amount;
  final Future<String>? futureAmount;
  final List<FinanceItem>? items;
  final Future<List<FinanceItem>>? futureItems;
  final int? indexPage;

  const FinanceOverviewFragment(
      {Key? key,
      required this.title,
      required this.amount,
      this.futureAmount,
      this.items,
      this.futureItems,
      this.indexPage})
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
                          fontSize: 13.0, color: QLCTColors.mainPurpleColor),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      amount,
                      style: const TextStyle(
                          fontSize: 44.0, color: QLCTColors.mainPurpleColor),
                    ))
              ],
            ),
            for (var item in items!) item,
            SizedBox(
                width: double.maxFinite,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => RootApp(currentIndex: indexPage??0,)));
                  },
                  child: const Text("SEE ALL",
                      style: TextStyle(color: QLCTColors.mainPurpleColor)),
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
  final int? type;

  const FinanceItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.amount,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isNegative;
    if (type != null) {
      if (type != 1) {
        isNegative = false;
      } else {
        isNegative = true;
      }
    } else {
      Decimal amountInt = Decimal.parse(amount);
      isNegative = amountInt.isNegative;
    }

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
                          ? const FaIcon(FontAwesome.down, color: QLCTColors.mainRedColor)
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
                            title.trim(),
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.black87),
                          ),
                          Text(
                            subtitle.trim(),
                            style: const TextStyle(
                                fontSize: 13.0, color: Colors.black38),
                          )
                        ],
                      ),
                      Text(
                        amount,
                        style: isNegative
                            ? const TextStyle(fontSize: 20.0, color: QLCTColors.mainRedColor)
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
          color: QLCTColors.mainRedColor,
          icon: FontAwesomeIcons.solidTrashAlt,
        )
      ],
    );
  }
}

class BudgetCard extends StatelessWidget {
  final String? svgSrc;
  final String? pngSrc;
  final String title;
  final String amount;
  final String? password;
  final Function()? press;
  final bool isCreate;

  const BudgetCard({
    Key? key,
    required this.title,
    required this.amount,
    this.password,
    required this.press,
    this.svgSrc,
    this.pngSrc,
    required this.isCreate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Decimal amountInt = Decimal.parse(amount);
    bool isNegative = amountInt.isNegative;
    return Container(
      // padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isCreate ? Colors.purpleAccent : const Color(0xfff7f7f7),
        borderRadius: BorderRadius.circular(13),
        boxShadow: isCreate
            ? [
                BoxShadow(
                  offset: const Offset(7, 7),
                  color: Colors.purpleAccent.withOpacity(0.7),
                  blurRadius: 10,
                )
              ]
            : const [
                BoxShadow(
                  offset: Offset(10, 10),
                  color: Colors.black12,
                  blurRadius: 13,
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                const Spacer(),
                if (null != svgSrc)
                  SvgPicture.asset(
                    svgSrc!,
                    height: 40,
                    width: 40,
                    fit: BoxFit.scaleDown,
                  ),
                if (null != pngSrc)
                  Image.asset(
                    pngSrc!,
                    height: 20,
                    width: 20,
                    fit: BoxFit.scaleDown,
                  ),
                null == password ? Text(
                  amount,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(
                    fontFamily: "Rubik-Bold",
                    color: isNegative ? QLCTColors.mainRedColor : QLCTColors
                        .mainGreenColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 25,
                  ),
                ) :
                  const FaIcon(FontAwesomeIcons.eyeSlash),
                // const Spacer(),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(
                    fontFamily: "Rubik-Bold",
                    color: isCreate ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w300,
                    fontSize: 25,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final Icon? icon;
  final String title;
  final String subtitle;
  final String amount;
  final int type;

  const TransactionItem(
      {Key? key,
      this.icon,
      required this.title,
      required this.subtitle,
      required this.amount,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Decimal amountInt = Decimal.parse(amount);
    bool isNegative = amountInt.isNegative;
    if (type == 1) {
      isNegative = true;
    } else {
      isNegative = false;
    }
    return Slidable(
      actionPane: const SlidableScrollActionPane(),
      child: TextButton(
        onPressed: () {},
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: isNegative
                    ? const FaIcon(FontAwesome.down,
                        color: QLCTColors.mainRedColor)
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
                      title.trim(),
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.black87),
                    ),
                    Text(
                      subtitle.trim(),
                      style: const TextStyle(
                          fontSize: 13.0, color: Colors.black38),
                    ),
                  ],
                ),
                Text(
                  amount,
                  style: isNegative
                      ? const TextStyle(
                          fontSize: 20.0, color: QLCTColors.mainRedColor)
                      : const TextStyle(
                          fontSize: 20.0, color: RallyColors.buttonColor),
                ),
                const Divider(
                  height: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.grey,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class TransactionFragment extends StatelessWidget {
  final List<TransactionItem>? transactionItems;
  final Future<List<TransactionItem>>? futureItems;

  const TransactionFragment({Key? key, this.transactionItems, this.futureItems})
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
            for (var item in transactionItems!) item,
          ],
        ),
      ),
    );
  }
}
