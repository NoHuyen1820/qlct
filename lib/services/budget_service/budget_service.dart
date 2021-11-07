import 'dart:convert';
import 'dart:developer';

import 'package:qlct/model/budget.dart';
import 'package:qlct/services/host.dart';
import 'package:qlct/services/protocol.dart';
import 'package:qlct/services/response_dto.dart';

class BudgetService {
  // same as same
  Future<List<Budget>> getAllBudget() async {
    log("BEGIN - BudgetService: getAllBudget");
    String url = Hosting.getAllBudget;
    Future<ResponseDTO> responseFu = Protocol.makeGetRequest(url);
    ResponseDTO responseDTO = await responseFu; // remove Future
    dynamic data = responseDTO.data; // [dynamic, dynamic, ..., dynamic]
    log(data.runtimeType.toString());
    List<Budget> budgets = [];
    for (dynamic d in data) {
      try {
        var validMap = jsonDecode(jsonEncode(d)) as Map<String, dynamic>;
        Budget budget = Budget.fromJson(validMap);
        budgets.add(budget);
      } catch (e) {
        log(e.toString());
        break;
      }
    }

    log("Type of result: " + budgets.runtimeType.toString());
    log("Length of budget list: " + budgets.length.toString());
    log("END - BudgetService: getAllBudget");
    return budgets;
  }

  getBudget(String budgetCode) async {
    if (budgetCode.trim() == "") return;
    String url = Hosting.getBudget;
    String param = "?budgetCode=" + budgetCode;
    url += param;
    // Future<String> response = Protocol.makeGetRequest(url);
    // String responseJson = await response;
    // log(responseJson);
  }
}
