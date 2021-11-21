import 'package:json_annotation/json_annotation.dart';
import 'package:qlct/utils.dart';

part 'budget.g.dart';

@JsonSerializable()
class Budget {
  String? id;
  String? budgetCode;
  String? userCode;
  String? password;
  String? description;
  String name;
  int? color;

  @JsonKey(fromJson: QLCTUtils.intToString, toJson: QLCTUtils.stringToInt)
  String amount;
  int? status;
  int? type;
  bool? deleteFlag;

  @JsonKey(fromJson: QLCTUtils.stringToDateTime)
  DateTime? updatedAt;

  @JsonKey(fromJson: QLCTUtils.stringToDateTime)
  DateTime? createdAt;

  @JsonKey(nullable: true)
  DateTime? startAt;

  @JsonKey(nullable: true)
  DateTime? endAt;

  Budget({
      this.id,
      this.budgetCode,
      this.userCode,
      this.password,
      this.description,
      required this.name,
      this.color,
      required this.amount,
      this.status,
      this.type,
      this.deleteFlag,
      this.updatedAt,
      this.createdAt,
      this.startAt,
      this.endAt
  });

  Map<String, dynamic> toJson() => _$BudgetToJson(this);

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);

}
