import 'dart:developer';

import 'package:big_decimal/big_decimal.dart';
import 'package:flutter/material.dart';
import 'package:qlct/components/chart/pie_finance_chart.dart';
import 'package:qlct/model/budget.dart';
import 'package:qlct/model/transaction.dart';
import 'package:qlct/screens/finance/finance.dart';
import 'package:qlct/services/budget_service/budget_service.dart';
import 'package:qlct/services/budget_service/transaction_service.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  // Declare need services
  var budgetService = BudgetService();
  var transactionService = TransactionService();

  @override
  void initState() {
    super.initState();
  }

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
                futureAmount: buildAmountTotalBudgets(),
                //futureItems:
                //    buildBudgetFinanceItem(),
                items: budgetItem,
              )),
              // Center(
              //   child: FinanceOverviewFragment(
              //     title: 'TRANSACTION',
              //     futureAmount: '3.500.000d',
              //     futureItems: buildTransactionFinanceItem(),
              //   ),
              // ),
            ],
          ),
        )),
      ),
    );
  }

  List<FinanceItem> budgetItem = [];
  BigDecimal amountTotalBudgets = BigDecimal.parse("0.0");

  // Call budgetService get all budgets
  // and add into budgetItems
  Future<List<FinanceItem>> buildBudgetFinanceItem() async {
    log("BEGIN - buildFinanceItem");
    Future<List<Budget>> budgetFu = budgetService.getAllBudget();
    List<Budget> budgets = await budgetFu;
    for (Budget b in budgets) {
      amountTotalBudgets += BigDecimal.parse(b.amount);
      log("amount" + b.amount);
      FinanceItem f = FinanceItem(
          title: b.name,
          subtitle: b.createdAt.toString().substring(0, 10),
          amount: b.amount);
      budgetItem.add(f);
    }
    log(budgetItem.length.toString());
    log("END - buildFinanceItem");
    return budgetItem.sublist(0, 4);
  }
  Future<String> buildAmountTotalBudgets() async {
    budgetItem = await buildBudgetFinanceItem();
    log("BEGIN - END - buildAmountTotalBudgets: " + amountTotalBudgets.toString());
    return amountTotalBudgets.toString() + "đ";
  }

  List<FinanceItem> transactionItem = [];

  Future<List<FinanceItem>> buildTransactionFinanceItem() async {
    log("BEGIN - buildTransactionFinanceItem");
    Future<List<Transaction>> transactionFu =
        transactionService.getAllTransaction();
    List<Transaction> transactions = await transactionFu;
    for (Transaction trans in transactions) {
      FinanceItem financeItem = FinanceItem(
          title: trans.transactionName,
          subtitle: trans.createdAt.toString().substring(0, 10),
          amount: trans.amount.toString());
      transactionItem.add(financeItem);
    }
    log(transactionItem.length.toString());
    log("END - buildTransactionFinanceItem");
    return transactionItem.sublist(0, 4);
  }
}
