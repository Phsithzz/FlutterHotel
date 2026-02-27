import 'dart:convert';

import 'package:my_hotel_room_app/service/interceptor_dio.dart';

class HelperApi {
  AppInterceptor appInterceptor = AppInterceptor();

  Future<Map<String, dynamic>> httpGet({required String path}) async {
    try {
      var body = await appInterceptor.dio.get(path);

      return body.data;
    } catch (e) {
      rethrow;
    }
  }



  Future<Map<String, dynamic>> httpPost({
  required String path,
  required String data,
}) async {
  try {
    var body = await appInterceptor.dio.post(path, data: jsonDecode(data));

    return body.data;
  } catch (err) {
    rethrow;
  }
}




}


