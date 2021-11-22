// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'] as String?,
      transactionNumber: json['transactionNumber'] as String?,
      budgetCode: json['budgetCode'] as String?,
      userCode: json['userCode'] as String?,
      amount: QLCTUtils.intToString(json['amount'] as int),
      category: json['category'] as int?,
      schedule: json['schedule'] as bool?,
      type: json['type'] as int?,
      note: json['note'] as String?,
      transactionName: json['transactionName'] as String?,
      payment: json['payment'] as int?,
      status: json['status'] as int?,
      deleteFlag: json['deleteFlag'] as bool?,
      updatedAt: QLCTUtils.stringToDateTime(json['updatedAt'] as String?),
      createdAt: QLCTUtils.stringToDateTime(json['createdAt'] as String?),
      startAt: json['startAt'] == null
          ? null
          : QLCTUtils.stringToDateTime(json['startAt'] as String?),
      endAt: json['endAt'] == null
          ? null
          : QLCTUtils.stringToDateTime(json['endAt'] as String?),
      fromDate: json['fromDate'] as String?,
      toDate: json['toDate'] as String?,
    )..budgetCodes = (json['budgetCodes'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList();

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionNumber': instance.transactionNumber,
      'budgetCode': instance.budgetCode,
      'budgetCodes': instance.budgetCodes,
      'userCode': instance.userCode,
      'amount': QLCTUtils.stringToInt(instance.amount),
      'category': instance.category,
      'schedule': instance.schedule,
      'type': instance.type,
      'note': instance.note,
      'transactionName': instance.transactionName,
      'payment': instance.payment,
      'status': instance.status,
      'deleteFlag': instance.deleteFlag,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'startAt': instance.startAt?.toIso8601String(),
      'endAt': instance.endAt?.toIso8601String(),
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
    };
