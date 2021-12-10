import 'package:json_annotation/json_annotation.dart';
import 'package:qlct/utils.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  String? id;

  int scheduleId;

  String? scheduleCode;

  String? budgetCode;

  int? hour;

  int? dayOfWeek;

  int? dayOfMonth;

  List<String>? budgetCodes;

  String? userCode;

  @JsonKey(fromJson: QLCTUtils.intToString, toJson: QLCTUtils.stringToInt)
  String amount;

  int? category;

  bool? schedule;

  int? type;

  String? note;

  String? scheduleName;

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

  Schedule(
      {this.id,
        required this.scheduleId,
        this.scheduleCode,
        this.budgetCode,
        this.hour,
        this.dayOfWeek,
        this.dayOfMonth,
        this.userCode,
        required this.amount,
        this.category,
        this.schedule,
        this.type,
        this.note,
        this.scheduleName,
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

  factory Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

}
