import 'dart:convert';
import 'dart:developer';

import 'package:qlct/model/budget.dart';
import 'package:qlct/services/host.dart';
import 'package:qlct/services/protocol.dart';
import 'package:qlct/services/response_dto.dart';

class BudgetService {
  // same as same
  Future<List<Budget>> getAllBudget(String userCode) async {
    log("BEGIN - BudgetService: getAllBudget");
    String url = Hosting.getAllBudgetByUserCode;
    String param = "?userCode=" + userCode;
    url += param;
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

  getBudgetByUserCode(String budgetCode) async {
    if (budgetCode.trim() == "") return;
    String url = Hosting.getAllBudgetByUserCode;
    String param = "?budgetCode=" + budgetCode;
    url += param;
   Future<ResponseDTO> response = Protocol.makeGetRequest(url);
    String responseJson = (await response) as String;
    log(responseJson);
  }

  createBudget(Budget budget) async {
    log("BEGIN - BudgetService: createBudget");
    String url = Hosting.createBudget;
    String jsonBody = jsonEncode(budget);
    log(jsonBody);
    Future<ResponseDTO> responseFu = Protocol.makePostRequest(url, jsonBody);
    ResponseDTO responseDTO = await responseFu;
    dynamic data = responseDTO.data; // [dynamic, dynamic, ..., dynamic]
    log(data.runtimeType.toString());
    log("END - BudgetService: createBudget");
  }

   updateBudget(Budget budget) async{
     log("BEGIN - BudgetService: updateBudget");
     String url = Hosting.updateBudget;
     String jsonBody = jsonEncode(budget);
     log(jsonBody);
     Future<ResponseDTO> responseFu = Protocol.makePostRequest(url, jsonBody);
     ResponseDTO responseDTO = await responseFu;
     dynamic data = responseDTO.data; // [dynamic, dynamic, ..., dynamic]
     log(data.runtimeType.toString());
     log("END - BudgetService: updateBudget");
   }

  deleteBudget(String budgetCode) async{
    log("BEGIN - BudgetService: deleteBudget");
    String url = Hosting.deleteBudget;
    String param = "?budgetCode=" + budgetCode;
    url += param;
    Future<ResponseDTO> responseFu = Protocol.makePostRequest(url, null);
    ResponseDTO responseDTO = await responseFu;
    dynamic data = responseDTO.data; // [dynamic, dynamic, ..., dynamic]
    log(data.runtimeType.toString());
    log("END - BudgetService: deleteBudget");


  }
}
