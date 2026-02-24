import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_unity.dart';

class AppInterceptor {
  Dio dio = Dio();
  static String baseUrl = 'http://192.168.1.103:3000';

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
          if (e.statusCode == 200) {
            handler.next(e);
          } else {
            // log(jsonEncode(e.data));
            return handler.reject(
              DioException(
                requestOptions: e.requestOptions,
                error: e.data['message'],
              ),
            );
          }
        },
        onError: (DioException err, ErrorInterceptorHandler handler) async {
          return handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: "เกิดข้อผิดพลาด",
            ),
          );
        },
      ),
    );
  }
}
