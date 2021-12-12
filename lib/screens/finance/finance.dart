
import 'dart:developer';

import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qlct/screens/transaction/edit_transaction.dart';
import 'package:qlct/services/budget_service/budget_service.dart';
import 'package:qlct/services/transaction_service/transaction_service.dart';
import 'package:qlct/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../root_app.dart';

class FinanceOverviewFragment extends StatelessWidget {
  final String title;
  final String amount;
  final String? amount2;
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
      this.indexPage, this.amount2})
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
                      NumberFormat.currency(locale: 'vi').format(double.parse(amount)),
                      style: const TextStyle(
                          fontSize: 30.0, color: QLCTColors.mainPurpleColor),
                    )),
                  const SizedBox(height: 10,),
                  amount2 != null ?  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      NumberFormat.currency(locale: 'vi').format(double.parse(amount2!)),
                      style: const TextStyle(
                          fontSize: 30.0, color: QLCTColors.mainRedColor),
                    )): const SizedBox(height: 20,),
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
                  child:  Text(AppLocalizations.of(context)!.seeAll,
                      style: const TextStyle(color: QLCTColors.mainPurpleColor)),
                ))
          ],
        ),
      ),
    );
  }
}

class FinanceItem extends StatelessWidget{
  final String? title;
  final String subtitle;
  final String amount;
  final int? type;
  final String? itemNumber;
  final int? kind;

  final BudgetService budgetService = BudgetService();
  final TransactionService transactionService =TransactionService();

  FinanceItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.amount,
      this.type,
      this.itemNumber,
      this.kind})
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
                            title!.trim(),
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
                        NumberFormat.currency(locale: 'vi').format(double.parse(amount)),
                        style: isNegative
                            ? const TextStyle(fontSize: 16.0, color: QLCTColors.mainRedColor)
                            : const TextStyle(
                                fontSize: 16.0, color: RallyColors.buttonColor),
                      )
                    ],
                  )),
                  // Container(
                  //     margin: const EdgeInsets.only(left: 10.0),
                  //     child: const FaIcon(FontAwesome.angle_right,
                  //         color: Colors.black38))
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
      actions:  <Widget>[
        IconSlideAction(
          caption: AppLocalizations.of(context)!.remove,
          color: QLCTColors.mainRedColor,
          icon: FontAwesomeIcons.solidTrashAlt,
          onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context ) => CupertinoAlertDialog(
              content: Column(
                children: [
                  Text(

                    kind == 1 ? AppLocalizations.of(context)!.detailBudgetItem
                        :AppLocalizations.of(context)!.detailTrans,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  ]
              ),
              actions:<Widget> [
                CupertinoButton(
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoButton(
                    child: Text(
                      AppLocalizations.of(context)!.buttonDelete,
                      style: const TextStyle(
                        color: QLCTColors.mainRedColor,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Đang xử lý"))
                      );
                            if (kind == 1) {
                             await budgetService.deleteBudget(itemNumber!);
                            }
                            if (kind == 2) {
                              await transactionService
                                  .deleteTransaction(itemNumber!);
                            }
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const RootApp(currentIndex: 0)));
                    })
              ],
            )
          ),
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
                  NumberFormat.currency(locale: 'vi').format(double.parse(amount)),
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
  final String? transCode;
  final String? title;
  final String subtitle;
  final String amount;
  final String? category;
  final int type;
  final String? typeSTR;
  final String? budget;
  final String? note;

  const TransactionItem(
      {Key? key,
      this.icon,
      required this.transCode,
      required this.title,
      required this.subtitle,
      required this.amount,
      required this.type, this.budget, this.note, this.category, this.typeSTR})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionService transactionService = TransactionService();
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
        onPressed: () {
          log("nhan nut nay");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTransactionScreen(
                transCode: transCode!,
                typeSTR: typeSTR,
                note:note,
                budget: budget,
                category: category,
                amount: amount,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: isNegative
                    ? const FaIcon(WebSymbols.updown_circle,
                        color: QLCTColors.mainRedColor)
                    : const FaIcon(WebSymbols.updown_circle,
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
                      title!.trim(),
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
                  NumberFormat.currency(locale: 'vi').format(double.parse(amount)),
                  style: isNegative
                      ? const TextStyle(
                          fontSize: 16.0, color: QLCTColors.mainRedColor)
                      : const TextStyle(
                          fontSize: 16.0, color: RallyColors.buttonColor),
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
      actions:  <Widget>[
        IconSlideAction(
          caption: AppLocalizations.of(context)!.remove,
          color: QLCTColors.mainRedColor,
          icon: FontAwesomeIcons.solidTrashAlt,
          onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context ) => CupertinoAlertDialog(
                content: Column(
                    children: [
                      Text(

                        AppLocalizations.of(context)!.detailTrans,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ]
                ),
                actions:<Widget> [
                  CupertinoButton(
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  CupertinoButton(
                      child: Text(
                        AppLocalizations.of(context)!.buttonDelete,
                        style: const TextStyle(
                          color: QLCTColors.mainRedColor,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Đang xử lý"))
                        );

                        await transactionService.deleteTransaction(transCode!);

                        Navigator.of(context).pop();
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const RootApp(currentIndex: 0)));
                      })
                ],
              )
          ),
        )
      ],
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
