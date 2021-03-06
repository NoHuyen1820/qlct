import 'dart:core';
import 'dart:developer';

import 'package:big_decimal/big_decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:qlct/constants.dart';
import 'package:qlct/firebase/auth_service.dart';
import 'package:qlct/model/budget.dart';
import 'package:qlct/model/transaction.dart';
import 'package:qlct/screens/finance/finance.dart';
import 'package:qlct/services/budget_service/budget_service.dart';
import 'package:qlct/services/transaction_service/transaction_service.dart';
import 'package:qlct/theme/colors.dart';
import 'package:qlct/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({Key? key}) : super(key: key);

  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  var transactionService = TransactionService();
  var budgetService = BudgetService();
  var authService= AuthService() ;
  String valueChooseMonth = listMonth.first;
  String valueChooseYear = listYear.first;
  String _fromDate = DateFormat.yMMMMd('vi-VN').format(DateTime.now());
  String _fromDateParam = QLCTUtils.dateTimeToString(DateTime.now(), "000000");
  String _toDate = DateFormat.yMMMMd('vi-VN').format(DateTime.now());
  String _toDateParam = QLCTUtils.dateTimeToString(DateTime.now(), "235959");
  String _totalIncome = "0.0";
  String _totalExpense = "0.0";

  List<TransactionItem> transactionItems = [];
  List<String> _budgetCodes = [];
  late String _userCode;

  @override
  void initState() {
    _userCode = authService.getCurrentUID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: const Color(0xfffcfcfc),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                 Text(
                   AppLocalizations.of(context)!.listTransaction,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 35.0,
                      decorationStyle: TextDecorationStyle.wavy),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Form(
                    child: Column(
                  children: [
                    // From Date button
                    Container(
                      color: RallyColors.gray60,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width / 3,
                              child:  Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  AppLocalizations.of(context)!.fromDate,
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: TextButton(
                                  onPressed: () async {
                                    await DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(2018, 3, 5),
                                        maxTime: DateTime.now(),
                                        onChanged: (date) {},
                                        onConfirm: (date) {
                                          String formatDate = DateFormat.yMMMMd('vi-VN').format(date);
                                          _fromDate = formatDate;
                                      _fromDateParam = QLCTUtils.dateTimeToString(date, "000000");
                                      setState(() {});
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.vi);
                                    // setState(() {});
                                  },
                                  child: Text(
                                    " $_fromDate",
                                    style: const TextStyle(
                                      color:Colors.black87,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // To Date button
                    Container(
                      color: RallyColors.gray60,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width / 3,
                              child:  Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  AppLocalizations.of(context)!.toDate,
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: TextButton(
                                  onPressed: () async {
                                    await DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(2018, 3, 5),
                                        maxTime: DateTime.now(),
                                        onChanged: (date) {},
                                        onConfirm: (date) {
                                      String formatDate = DateFormat.yMMMMd('vi-VN').format(date);
                                      _toDate = formatDate;
                                      _toDateParam = QLCTUtils.dateTimeToString(date, "235959");
                                      setState(() {
                                        _toDate = formatDate;
                                      });
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.vi);
                                    // setState(() {});
                                  },
                                  child: Text(
                                    " $_toDate",
                                    style: const TextStyle(
                                      color:Colors.black87,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // button search
                    // Container(
                    //     color: RallyColors.gray60,
                    //     child: buttonCustom("Search", QLCTColors.mainPurpleColor)),
                  ],
                )),
                // Overview report
                const SizedBox(
                  height: 10.0,
                ),
                FutureBuilder(
                  future: buildTransactionItem(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Wrap(
                              spacing: 20.0,
                              children: [
                                Container(
                                  width: (size.width - 60) / 2,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    color:QLCTColors.mainGreenColor,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: QLCTColors.mainGreenColor.withOpacity(0.8),
                                        spreadRadius: 4,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      )
                                    ],),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, top: 20, bottom: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: const Center(
                                              child: Icon(
                                                FontAwesomeIcons.arrowLeft,
                                                color: QLCTColors.mainGreenColor,
                                              )),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                             Text(
                                              AppLocalizations.of(context)!.totalIncome,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              NumberFormat.currency(locale: 'vi').format(double.parse(_totalIncome)),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.white
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: (size.width - 60) / 2,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    color: QLCTColors.mainRedColor,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: QLCTColors.mainRedColor.withOpacity(0.8),
                                        spreadRadius: 4,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      )
                                    ],),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, top: 20, bottom: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: const Center(
                                              child: Icon(
                                                FontAwesomeIcons.arrowRight,
                                                color: QLCTColors.mainRedColor,
                                              )),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                             Text(
                                              AppLocalizations.of(context)!.totalExpense,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              NumberFormat.currency(locale: 'vi').format(double.parse( _totalExpense)),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TransactionFragment(
                              transactionItems: transactionItems,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  BigDecimal amountTotalIncome = BigDecimal.parse("0.0");
  BigDecimal amountTotalExpense = BigDecimal.parse("0.0");
  Future<List<TransactionItem>> buildTransactionItem() async {
    // reset
    transactionItems = [];
    amountTotalIncome = BigDecimal.parse("0.0");
    amountTotalExpense = BigDecimal.parse("0.0");
    logger.i("BEGIN- buildTransactionItem");
    await getBudgetCodes();
    Future<List<Transaction>> transactionFu =
        transactionService.getTransactionListByDate(_fromDateParam, _toDateParam, _budgetCodes);
    List<Transaction> transactions = await transactionFu;
    transactionItems = [];
    for (Transaction trans in transactions) {
      trans.type == 0 ? amountTotalIncome += BigDecimal.parse(trans.amount)
      : amountTotalExpense += BigDecimal.parse(trans.amount);
      String? categorySTR ="Other category";
      if(categorySelect.containsKey(trans.category)){
        categorySTR = categorySelect[trans.category];
      }
      TransactionItem transactionItem = TransactionItem(
        transCode: trans.transactionNumber,
        title: categorySTR,
        subtitle: trans.createdAt.toString().substring(0, 10),
        amount: trans.amount.toString(),
        type: trans.type!.toInt(),
        typeSTR: trans.type!.toString(),
        budget: trans.budgetCode,
        note: trans.note,
        category: trans.category.toString(),

      );
      transactionItems.add(transactionItem);
    }
    logger.i(transactionItems.length.toString());
    _totalIncome = amountTotalIncome.toString();
    _totalExpense = amountTotalExpense.toString();
    log("_totalIncome: " + _totalIncome);
    log("_totalExpense: " + _totalExpense);
    logger.i("END - buildTransactionItem");
    return transactionItems;
  }

  Future<List<String>> getBudgetCodes() async {
    Future<List<Budget>> budgetFu = budgetService.getAllBudget(_userCode);
    List<Budget> budgets = await budgetFu;
    _budgetCodes = [];
    for (Budget b in budgets) {
      var budgetCode = b.budgetCode;
      if (budgetCode != null) {
        _budgetCodes.add(budgetCode);
      }
    }
    return _budgetCodes;
  }
}
