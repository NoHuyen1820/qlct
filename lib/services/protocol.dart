import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:qlct/services/response_dto.dart';

class Protocol {

  static Future<ResponseDTO> makeGetRequest(String url) async {

    Response response = await get(Uri.parse(url));

    log("StatusCode when GET: " +response.statusCode.toString());
    if (response.statusCode == 200) {
      log(response.toString());
      log(response.body);

      return ResponseDTO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get method');
    }

  }
}
