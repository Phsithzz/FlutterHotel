 
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_unity.dart';


class AppInterceptor {
  Dio dio = Dio();
  static String baseUrl = '';

  AppInterceptor() {
    dio.options = BaseOptions(
      contentType: 'application/json',
      baseUrl: baseUrl,
      connectTimeout: const Duration(
        seconds: 20,
      ),
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
          if (e.statusCode == 200 && e.data['status'] == 200) {
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
          if (err.response?.statusCode == 401) {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            if (sharedPreferences.getString('token_cyclecount') != null) {
              // try {
   
              String? newToken =
                  sharedPreferences.getString('token_cyclecount');
              if (newToken != null) {
                err.requestOptions.headers['usertoken'] = newToken;
                return handler.resolve(await dio.fetch(err.requestOptions));
              }
              // } catch (e) {
              //   handler.reject(DioException(
              //     requestOptions: err.requestOptions,
              //     error: 'Failed to refresh token.',
              //   ));
              // }
            } else {
              return handler.reject(
                DioException(
                  requestOptions: err.requestOptions,
                  error: err.response?.data['message'],
                ),
              );
            }
          } else if (err.response?.statusCode == 404) {
            return handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: 'ไม่พบ url ${err.requestOptions.path}',
              ),
            );
          } else {
            return handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: err.response?.data['message'] ?? 'เกิดข้อผิดพลาด',
              ),
            );
          }
        },
      ),
    );
  }
}
