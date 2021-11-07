
class Budget {
  String id;
  String budgetCode;
  String userCode;
  String? password;
  String? description;
  String name;
  int? color;
  String amount;
  int status;
  int type;
  bool deleteFlag;
  DateTime updatedAt;
  DateTime createdAt;
  DateTime? startAt;
  DateTime? endAt;

  Budget({
      required this.id,
      required this.budgetCode,
      required this.userCode,
      this.password,
      this.description,
      required this.name,
      this.color,
      required this.amount,
      required this.status,
      required this.type,
      required this.deleteFlag,
      required this.updatedAt,
      required this.createdAt,
      this.startAt,
      this.endAt
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['budgetCode'] = budgetCode;
    data['userCode'] = userCode;
    data['password'] = password;
    data['description'] = description;
    data['name'] = name;
    data['color'] = color;
    data['amount'] = amount;
    data['status'] = status;
    data['type'] = type;
    data['deleteFlag'] = deleteFlag;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['startAt'] = startAt;
    data['endAt'] = endAt;
    return data;
  }

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'],
      budgetCode: json['budgetCode'],
      userCode: json['userCode'],
      password: json['password'],
      description: json['description'],
      name: json['name'],
      color: json['color'],
      amount: json['amount'].toString(),
      status: json['status'],
      type: json['type'],
      deleteFlag: json['deleteFlag'],
      updatedAt: DateTime.parse(json['updatedAt'].substring(0, 8) + 'T' + json['updatedAt'].substring(8)),
      createdAt: DateTime.parse(json['createdAt'].substring(0, 8) + 'T' + json['createdAt'].substring(8)),
      startAt: DateTime.parse(json['startAt'].substring(0, 8) + 'T' + json['startAt'].substring(8)),
      endAt: DateTime.parse(json['endAt'].substring(0, 8) + 'T' + json['endAt'].substring(8)),
    );
  }
}
