import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_unity.dart';

class AppInterceptor {
  Dio dio = Dio();
  static String baseUrl = 'http://10.0.2.2:3000';

  AppInterceptor() {
    dio.options = BaseOptions(
      contentType: 'application/json',
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      // sendTimeout: const Duration(
      //   seconds: 20,
      // ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions requestOptions, RequestInterceptorHandler handler) {
              // requestOptions.headers
              //     .putIfAbsent('authtoken', () => MyConnect.ketDev);

              // AppUnity.sharedPreferences.then((value) async {
              //   await requestOptions.headers.putIfAbsent(
              //       'usertoken', () => value.getString('token_cyclecount'));
              // });
              handler.next(requestOptions);
            },
        onResponse: (e, handler) {
        if (e.statusCode != null && e.statusCode! >= 200 && e.statusCode! < 300) {
  handler.next(e);
} else {
  handler.reject(
    DioException(
      requestOptions: e.requestOptions,
      response: e,
      error: e.data,
    ),
  );
}
        },
onError: (DioException err, ErrorInterceptorHandler handler) {
  print("STATUS CODE => ${err.response?.statusCode}");
  print("RESPONSE DATA => ${err.response?.data}");
  print("ERROR TYPE => ${err.type}");

  handler.next(err); // 👈 ส่ง error เดิมต่อไปเลย
},
      ),
    );
  }
}
