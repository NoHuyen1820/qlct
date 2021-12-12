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

  Future<List<Transaction>> getTransactionMultiBudgetCode(List<String> budgetCodes) async {
    log("BEGIN - TransactionService:getTransactionMultiBudgetCode");
    String url = Hosting.getAllTransactionByMultiBudgetCode;
    Transaction transaction = Transaction(
      amount: '20000',
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
    log("Length of transaction list by budget code: " + transactions.length.toString());
    log("END- TransactionService:getTransactionMultiBudgetCode");
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

  createTransaction(Transaction transaction) async {
    log("BEGIN - TransactionService: createTransaction");
    String url = Hosting.createTransaction;
    String jsonBody = jsonEncode(transaction);
    log(jsonBody);
    Future<ResponseDTO> responseFu = Protocol.makePostRequest(url, jsonBody);
    ResponseDTO responseDTO = await responseFu;
    dynamic data = responseDTO.data; // [dynamic, dynamic, ..., dynamic]
    log(data.runtimeType.toString());
    log("END - TransactionService: createTransaction");
  }

  updateTransaction(Transaction transaction) async {
    log("BEGIN - TransactionService: updateTransaction");
    String url = Hosting.updateTransaction;
    String jsonBody = jsonEncode(transaction);
    log(jsonBody);
    Future<ResponseDTO> responseFu = Protocol.makePostRequest(url, jsonBody);
    ResponseDTO responseDTO = await responseFu;
    dynamic data = responseDTO.data; // [dynamic, dynamic, ..., dynamic]
    log(data.runtimeType.toString());
    log("END - TransactionService: updateTransaction");
  }

  deleteTransaction(String transactionNumber) async {
    log("BEGIN - TransactionService: deleteTransaction");
    String url = Hosting.deleteTransaction;
    String param = "?transactionNumber=" + transactionNumber;
    url += param;
    Future<ResponseDTO> responseFu = Protocol.makePostRequest(url, null);
    ResponseDTO responseDTO = await responseFu;
    dynamic data = responseDTO.data; // [dynamic, dynamic, ..., dynamic]
    log(data.runtimeType.toString());
    log("END - TransactionService: deleteTransaction");


  }
}
