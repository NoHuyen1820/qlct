import 'package:json_annotation/json_annotation.dart';
import 'package:qlct/utils.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  String? id;

  String? transactionNumber;

  String? budgetCode;

  List<String>? budgetCodes;

  String? userCode;

  @JsonKey(fromJson: QLCTUtils.intToString, toJson: QLCTUtils.stringToInt)
  String amount;

  int? category;

  bool? schedule;

  int? type;

  String? note;

  String? transactionName;

  int? payment;

  int? status;

  bool? deleteFlag;

  @JsonKey(fromJson: QLCTUtils.stringToDateTime)
  DateTime? updatedAt;

  @JsonKey(fromJson: QLCTUtils.stringToDateTime)
  DateTime? createdAt;

  @JsonKey(nullable: true)
  DateTime? startAt;

  @JsonKey(nullable: true)
  DateTime? endAt;

  @JsonKey(nullable: true)
  String? fromDate;

  @JsonKey(nullable: true)
  String? toDate;

  Transaction(
      {this.id,
      this.transactionNumber,
      this.budgetCode,
      this.userCode,
      required this.amount,
      this.category,
      this.schedule,
      this.type,
      this.note,
      this.transactionName,
      this.payment,
      this.status,
      this.deleteFlag,
      this.updatedAt,
      this.createdAt,
      this.startAt,
      this.endAt,
      this.fromDate,
      this.toDate,
      this.budgetCodes});

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

}
