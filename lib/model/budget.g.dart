// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Budget _$BudgetFromJson(Map<String, dynamic> json) => Budget(
      id: json['id'] as String?,
      budgetCode: json['budgetCode'] as String?,
      userCode: json['userCode'] as String?,
      password: json['password'] as String?,
      description: json['description'] as String?,
      name: json['name'] as String,
      color: json['color'] as int?,
      amount: QLCTUtils.intToString(json['amount'] as int),
      amountTarget: json['amountTarget'] == null
            ? null
            : QLCTUtils.intToString(json['amountTarget'] as int),
      status: json['status'] as int?,
      type: json['type'] as int?,
      deleteFlag: json['deleteFlag'] as bool?,
      updatedAt: QLCTUtils.stringToDateTime(json['updatedAt'] as String?),
      createdAt: QLCTUtils.stringToDateTime(json['createdAt'] as String?),
      startAt: json['startAt'] == null
          ? null
          : QLCTUtils.stringToDateTime(json['startAt'] as String?),
      endAt: json['endAt'] == null
          ? null
          : QLCTUtils.stringToDateTime(json['endAt'] as String?),
      completeTarget:json['completeTarget'] as String?,
    );

Map<String, dynamic> _$BudgetToJson(Budget instance) => <String, dynamic>{
      'id': instance.id,
      'budgetCode': instance.budgetCode,
      'userCode': instance.userCode,
      'password': instance.password,
      'description': instance.description,
      'name': instance.name,
      'color': instance.color,
      'amount': QLCTUtils.stringToInt(instance.amount),
      'amountTarget':QLCTUtils.stringToInt(instance.amountTarget!),
      'status': instance.status,
      'type': instance.type,
      'deleteFlag': instance.deleteFlag,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'startAt': instance.startAt?.toIso8601String(),
      'endAt': instance.endAt?.toIso8601String(),
      'completeTarget':instance.completeTarget,
    };
