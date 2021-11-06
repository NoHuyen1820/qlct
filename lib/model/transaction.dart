class Transaction {
  String id;

  String transactionNumber;

  String budgetCode;

  String userCode;

  String amount;

  int category;

  bool? schedule;

  int type;

  String? note;

  String transactionName;

  int payment;

  int status;

  bool deleteFlag;

  DateTime updatedAt;

  DateTime createdAt;

  DateTime? startAt;

  DateTime? endAt;

  Transaction(
      {required this.id,
      required this.transactionNumber,
      required this.budgetCode,
      required this.userCode,
      required this.amount,
      required this.category,
      this.schedule,
      required this.type,
      this.note,
      required this.transactionName,
      required this.payment,
      required this.status,
      required this.deleteFlag,
      required this.updatedAt,
      required this.createdAt,
      this.startAt,
      this.endAt});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      transactionNumber: json['transactionNumber'],
      budgetCode: json['budgetCode'],
      userCode: json['userCode'],
      amount: json['amount'].toString(),
      category: json['category'],
      note: json['note'],
      transactionName: json['transactionName'],
      type: json['type'],
      payment: json['payment'],
      status: json['status'],
      deleteFlag: json['deleteFlag'],
      updatedAt: DateTime.parse(json['updatedAt'].substring(0, 8) + 'T' + json['updatedAt'].substring(8)),
      createdAt: DateTime.parse(json['createdAt'].substring(0, 8) + 'T' + json['createdAt'].substring(8)),
      startAt: DateTime.parse(json['startAt'].substring(0, 8) + 'T' + json['startAt'].substring(8)),
      endAt: DateTime.parse(json['endAt'].substring(0, 8) + 'T' + json['endAt'].substring(8)),
      schedule: json['schedule'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transactionNumber'] = transactionNumber;
    data['budgetCode'] = budgetCode;
    data['userCode'] = userCode;
    data['amount'] = amount;
    data['category'] = category;
    data['note'] = note;
    data['transactionName'] = transactionName;
    data['type'] = type;
    data['payment'] = payment;
    data['status'] = status;
    data['deleteFlag'] = deleteFlag;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['startAt'] = startAt;
    data['endAt'] = endAt;
    data['schedule'] = schedule;
    return data;
  }
}
