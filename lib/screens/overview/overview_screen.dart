import 'dart:developer';

import 'package:big_decimal/big_decimal.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:qlct/components/chart/pie_finance_chart.dart';
import 'package:qlct/model/budget.dart';
import 'package:qlct/model/transaction.dart';
import 'package:qlct/screens/finance/finance.dart';
import 'package:qlct/services/budget_service/budget_service.dart';
import 'package:qlct/services/transaction_service/transaction_service.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  var logger = Logger(printer: PrettyPrinter(),);
  // Declare need services
  var budgetService = BudgetService();
  var transactionService = TransactionService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xfffcfcfc),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "Overview",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35.0,
                    decorationStyle: TextDecorationStyle.wavy),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const PieFinanceChart(),
              const SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                future: Future.wait([
                  buildAmountTotalBudgets(),
                ]),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return FinanceOverviewFragment(
                      title: 'BUDGET',
                      amount: snapshot.data[0].toString(),
                      items: budgetItems,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              FutureBuilder(
                future: Future.wait([
                  buildAmountTotalTransactions(),
                ]),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return FinanceOverviewFragment(
                      title: 'TRANSACTION',
                      amount: snapshot.data[0].toString(),
                      items: transactionItems,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        )),
      ),
    );
  }

  // Call budgetService get all budgets
  // and add into budgetItems
  List<FinanceItem> budgetItems = [];
  BigDecimal amountTotalBudgets = BigDecimal.parse("0.0");
  Future<String> buildAmountTotalBudgets() async {
    budgetItems = await buildBudgetFinanceItem();
    logger.i("BEGIN - END - buildAmountTotalBudgets: " +
        amountTotalBudgets.toString());
    return amountTotalBudgets.toString() + "đ";
  }
  Future<List<FinanceItem>> buildBudgetFinanceItem() async {
    logger.i("BEGIN - buildBudgetFinanceItem");
    Future<List<Budget>> budgetFu = budgetService.getAllBudget();
    List<Budget> budgets = await budgetFu;
    for (Budget b in budgets) {
      amountTotalBudgets += BigDecimal.parse(b.amount);
      logger.i("amount" + b.amount);
      FinanceItem f = FinanceItem(
          title: b.name,
          subtitle: b.createdAt.toString().substring(0, 10),
          amount: b.amount);
      budgetItems.add(f);
    }
    logger.i(budgetItems.length.toString());
    logger.i("END - buildBudgetFinanceItem");
    return budgetItems;
  }

  // Call transactionService get all transactions
  // and add into transactionItems
  List<FinanceItem> transactionItems = [];
  BigDecimal amountTotalTransactions = BigDecimal.parse("0.0");
  Future<String> buildAmountTotalTransactions() async {
    transactionItems = await buildTransactionFinanceItem();
    logger.i("BEGIN - END - buildAmountTotalTransactions: " +
        amountTotalTransactions.toString());
    return amountTotalTransactions.toString() + "đ";
  }
  Future<List<FinanceItem>> buildTransactionFinanceItem() async {
    logger.i("BEGIN - buildTransactionFinanceItem");
    Future<List<Transaction>> transactionFu =
        transactionService.getAllTransaction();
    List<Transaction> transactions = await transactionFu;
    for (Transaction trans in transactions) {
      amountTotalTransactions += BigDecimal.parse(trans.amount);
      FinanceItem financeItem = FinanceItem(
          title: trans.transactionName,
          subtitle: trans.createdAt.toString().substring(0, 10),
          amount: trans.amount.toString());
      transactionItems.add(financeItem);
    }
    logger.i(transactionItems.length.toString());
    logger.i("END - buildTransactionFinanceItem");
    return transactionItems;
  }
}
