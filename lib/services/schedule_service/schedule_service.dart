import 'dart:convert';
import 'dart:developer';

import 'package:qlct/model/schedule.dart';
import 'package:qlct/services/host.dart';
import 'package:qlct/services/protocol.dart';
import 'package:qlct/services/response_dto.dart';

class ScheduleService {

  createSchedule(Schedule schedule) async {
    log("BEGIN - ScheduleService: createSchedule");
    String url = Hosting.createSchedule;
    String jsonBody = jsonEncode(schedule);
    log(jsonBody);
    Future<ResponseDTO> responseFu = Protocol.makePostRequest(url, jsonBody);
    ResponseDTO responseDTO = await responseFu;
    dynamic data = responseDTO.data; // [dynamic, dynamic, ..., dynamic]
    log(data.runtimeType.toString());
    log("END - ScheduleService: createSchedule");
  }

  deleteSchedule(String scheduleId) async {
    log("BEGIN - ScheduleService: deleteSchedule");
    String url = Hosting.deleteSchedule;
    String param = "?scheduleId=" + scheduleId;
    url += param;
    Future<ResponseDTO> responseFu = Protocol.makePostRequest(url, null);
    ResponseDTO responseDTO = await responseFu;
    dynamic data = responseDTO.data; // [dynamic, dynamic, ..., dynamic]
    log(data.runtimeType.toString());
    log("END - ScheduleService: deleteSchedule");

  }
}
