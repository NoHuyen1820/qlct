

import 'package:big_decimal/big_decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:qlct/components/chart/pie_finance_chart.dart';
import 'package:qlct/firebase/auth_service.dart';
import 'package:qlct/model/budget.dart';
import 'package:qlct/model/transaction.dart';
import 'package:qlct/screens/finance/finance.dart';
import 'package:qlct/services/budget_service/budget_service.dart';
import 'package:qlct/services/transaction_service/transaction_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  // Declare need services
  var budgetService = BudgetService();
  var transactionService = TransactionService();
  var authService = AuthService();
  late String _userCode;
  List<String> _budgetCodes =[];

  @override
  void initState() {
    _userCode = authService.getCurrentUID();
    WidgetsBinding.instance!.addPostFrameCallback((_) => showAlertBudget());
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
              Text(
                AppLocalizations.of(context)!.overview,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 35.0,
                    decorationStyle: TextDecorationStyle.wavy),
              ),
              const SizedBox(
                height: 5.0,
              ),
              FutureBuilder(
                future: buildAmountTotalTransactions(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return PieFinanceChart(transactions: transactions);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
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
                      title: AppLocalizations.of(context)!.budget,
                      amount: snapshot.data[0].toString(),
                      items: budgetItems,
                      indexPage: 2,
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
                      title: AppLocalizations.of(context)!.transaction,
                      amount: snapshot.data[0][0].toString(),
                      amount2: snapshot.data[0][1].toString(),
                      items: transactionItems,
                      indexPage: 1,
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

  final keyIsFirstLoaded = 'is_first_loaded';
 showAlertBudget() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   bool? isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
     if(isFirstLoaded == null){
       showDialog <void> (
         context: context,
         barrierDismissible: false,
         builder: ( BuildContext context) => CupertinoAlertDialog(
           title: const Text("Congratulation"),
           content: Text("^_^"),
           actions: <Widget>
           [
             CupertinoButton(
               onPressed: () {
                 Navigator.of(context).pop();
                 prefs.setBool(keyIsFirstLoaded, false);
               },
               child:const Text("OK"),
             ),

           ],
         ),
       );

     }

  }
  // Call budgetService get all budgets
  // and add into budgetItems
  List<FinanceItem> budgetItems = [];
  BigDecimal amountTotalBudgets = BigDecimal.parse("0.0");
  Future<String> buildAmountTotalBudgets() async {
    budgetItems = await buildBudgetFinanceItem();
    logger.i("BEGIN - END - buildAmountTotalBudgets: " +
        amountTotalBudgets.toString());
    return amountTotalBudgets.toString();
  }
  Future<List<FinanceItem>> buildBudgetFinanceItem() async {
    logger.i("BEGIN - buildBudgetFinanceItem");
    Future<List<Budget>> budgetFu = budgetService.getAllBudget(_userCode);
    List<Budget> budgets = await budgetFu;
    budgetItems = [];
    amountTotalBudgets = BigDecimal.parse("0.0");
    for (Budget b in budgets) {
      amountTotalBudgets += BigDecimal.parse(b.amount);
      logger.i("amount" + b.amount);
      FinanceItem f = FinanceItem(
          title: b.name.toString(),
          subtitle: b.createdAt.toString().substring(0, 10),
          amount: b.amount,
          kind: 1,
          itemNumber: b.budgetCode,);
      budgetItems.add(f);
    }
    logger.i(budgetItems.length.toString());
    logger.i("END - buildBudgetFinanceItem");
    return budgetItems;
  }

  // Call transactionService get all transactions
  // and add into transactionItems
  List<Transaction> transactions = [];
  List<FinanceItem> transactionItems = [];
  BigDecimal amountTotalTransactions = BigDecimal.parse("0.0"); // income
  BigDecimal amount2TotalTransactions = BigDecimal.parse("0.0"); // outcome
  List<String> amountsTransactions = [];
  Future<List<String>> buildAmountTotalTransactions() async {
    transactionItems = await buildTransactionFinanceItem();
    logger.i("BEGIN - END - buildAmountTotalTransactions: " +
        amountTotalTransactions.toString());
    amountsTransactions.insert(0, amountTotalTransactions.toString());
    amountsTransactions.insert(1,"-" + amount2TotalTransactions.toString());
    return amountsTransactions;
  }
  Future<List<FinanceItem>> buildTransactionFinanceItem() async {
    logger.i("BEGIN - buildTransactionFinanceItem");
    await getBudgetCodes();
    Future<List<Transaction>> transactionFu =
        transactionService.getTransactionMultiBudgetCode(_budgetCodes);
    transactions = await transactionFu;
    transactionItems = [];
    amountTotalTransactions = BigDecimal.parse("0.0");
    amount2TotalTransactions = BigDecimal.parse("0.0");
    for (Transaction trans in transactions) {
      if (trans.type == 0) {
        amountTotalTransactions += BigDecimal.parse(trans.amount);
      }
      if (trans.type == 1) {
        amount2TotalTransactions += BigDecimal.parse(trans.amount);
      }

      String? categorySTR ="Other category";
      if(categorySelect.containsKey(trans.category)){
        categorySTR = categorySelect[trans.category];
      }
      FinanceItem financeItem = FinanceItem(
        title: categorySTR,
        subtitle: trans.createdAt.toString().substring(0, 10),
        amount: trans.amount.toString(),
        type: trans.type!.toInt(),
        kind: 2,
        itemNumber: trans.transactionNumber,
      );
      transactionItems.add(financeItem);
    }
    logger.i(transactionItems.length.toString());
    logger.i("END - buildTransactionFinanceItem");
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
