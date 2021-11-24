import 'dart:convert';
import 'dart:developer';

import 'package:qlct/model/transaction.dart';
import 'package:qlct/services/host.dart';
import 'package:qlct/services/protocol.dart';
import 'package:qlct/services/response_dto.dart';

class TransactionService {
  Future<List<Transaction>> getAllTransaction() async {
    log("BEGIN - TransactionService: getAllTransaction");
    String url = Hosting.getAllTransaction;
    Future<ResponseDTO> responseFu = Protocol.makeGetRequest(url);
    ResponseDTO responseDTO = await responseFu;
    dynamic data = responseDTO.data;
    log(data.runtimeType.toString());
    List<Transaction> transactions = [];
    for (dynamic trans in data) {
      try {
        var validMap = jsonDecode(jsonEncode(trans)) as Map<String, dynamic>;
        Transaction transaction = Transaction.fromJson(validMap);
        transactions.add(transaction);
      } catch (e) {
        break;
      }
    }
    log("Length of transaction list: " + transactions.length.toString());
    log("END- BudgetService: getAllTransaction");
    return transactions;
  }

  Future<List<Transaction>> getTransactionListByDate(
      String fromDate, String toDate, List<String> budgetCodes) async {
    log("BEGIN - TransactionService:getTransactionListByDate");
    String url = Hosting.getAllTransactionByMultiBudgetCode;
    Transaction transaction = Transaction(
      amount: '20000',
      fromDate: fromDate,
      toDate: toDate,
      budgetCodes: budgetCodes,
    );
    String jsonBody = jsonEncode(transaction);
    log(jsonBody);
    Future<ResponseDTO> responseFu = Protocol.makePostRequest(url, jsonBody);
    ResponseDTO responseDTO = await responseFu;
    dynamic data = responseDTO.data; // [dynamic, dynamic, ..., dynamic]
    log(data.runtimeType.toString());
    List<Transaction> transactions = [];
    for (dynamic trans in data) {
      try {
        var validMap = jsonDecode(jsonEncode(trans)) as Map<String, dynamic>;
        Transaction transaction = Transaction.fromJson(validMap);
        transactions.add(transaction);
      } catch (e) {
        break;
      }
    }
    log("Length of transaction list: " + transactions.length.toString());
    log("END- TransactionService:getTransactionListByDate");
    return transactions;
  }
}
