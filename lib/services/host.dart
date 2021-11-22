class Hosting {
  static const String hostDCT = "192.168.1.3";
  static const String hostNgrok = "http://localhost:1818";
  static const String local = "localhost";
  static const String host = "http://" + local + ":1818";
  static const String getAllBudget = hostNgrok + "/budget/getBudgets";
  static const String getBudget = host + "/budget/getBudget";
  static const String updateBudget = host + "/budget/updateBudget";
  static const String createBudget = host + "/budget/createBudget";
  static const String deleteBudget = host + "/budget/deleteBudget";
  static const String getAllBudgetByUserCode = host + "/budget/getAllBudgetByUserCode";
  static const String getTransaction = host + "/transaction/getTransaction";
  static const String getAllTransaction = hostNgrok + "/transaction/getTransactions";
  static const String getAllTransactionByBudgetCode = hostNgrok + "/transaction/getAllTransactionByBudgetCode";
  static const String getAllTransactionByMultiBudgetCode = hostNgrok + "/transaction/getAllTransactionByMultiBudgetCode";
  static const String updateTransaction = host + "/transaction/updateTransaction";
  static const String createTransaction = host + "/transaction/createTransaction";
  static const String deleteTransaction = host + "/transaction/deleteTransaction";
}

