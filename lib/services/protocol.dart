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

       return ResponseDTO.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to get method');
    }
  }

  static Future<ResponseDTO> makePostRequest(
      String url, String? jsonBody) async {
    Map<String, String> headers = {"Content-type": "application/json"};

    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);

    log("StatusCode when GET: " + response.statusCode.toString());
    if (response.statusCode == 200) {
      log(response.toString());
      log(response.body);
      return ResponseDTO.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to post method');
    }
  }
}
