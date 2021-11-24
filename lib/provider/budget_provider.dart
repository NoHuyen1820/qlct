import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qlct/firebase/auth_service.dart';
import 'package:qlct/model/budget.dart';
import 'package:qlct/services/budget_service/budget_service.dart';

class BudgetProvider with ChangeNotifier {

  AuthService authService = AuthService();
  BudgetService budgetService = BudgetService();
  List<Budget> _budgets = [];
  final List<String> _budgetCodes = [];

  List<Budget> get budgets {
    return _budgets;
  }

  List<String> get budgetCodes {
    log("prov2; " + budgets.length.toString());

    return _budgetCodes;
  }

  Future<List<Budget>> fetch() async {
    Future<List<Budget>> budgetFu = budgetService.getAllBudget(authService.getCurrentUID());
    List<Budget> budgets = await budgetFu;
    _budgets = budgets;
    for (var element in _budgets) {
      _budgetCodes.add(element.budgetCode!);
    }
    log("checkprov: " + _budgets.length.toString());
    notifyListeners();
    return budgets;
  }
}