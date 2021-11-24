import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:qlct/firebase/auth_service.dart';
import 'package:qlct/model/transaction.dart';
import 'package:qlct/provider/budget_provider.dart';
import 'package:qlct/services/transaction_service/transaction_service.dart';

class TransactionProvider with ChangeNotifier {

  AuthService authService = AuthService();
  final BudgetProvider _budgetProvider = BudgetProvider();
  TransactionService transactionService = TransactionService();
  List<Transaction> _transactions = [];

  List<Transaction> get transactions {
    return _transactions;
  }

  Future<List<Transaction>> fetch(String _fromDate, String _toDate, List<String> _budgetCodes) async {
    Future<List<Transaction>> transactionFu =
    transactionService.getTransactionListByDate(_fromDate, _toDate, _budgetCodes);
    List<Transaction> transactions = await transactionFu;
    _transactions = transactions;
    notifyListeners();
    return transactions;
  }
}