import 'dart:io';
// import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart' as g;

// Logger logger = Logger(level: Level.nothing);
Logger logger = Logger();

/// Returns a DioClient with the correct settings and error handling to communicate with the geco database
Future<Dio> client() async {
  Dio dio = Dio();

  // PersistCookieJar is a cookie manager which implements
  //  the standard cookie policy declared in RFC. PersistCookieJar persists
  //  the cookies in files, so if the application exit, the cookies always
  //  exist unless call delete explicitly.
  // Directory appDocDir = await getApplicationDocumentsDirectory();
  // String appDocPath = appDocDir.path;
  // var cj = PersistCookieJar(
  //     ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));

  // dio.interceptors.add(CookieManager(cj));

  // Set default configs
  dio.options.baseUrl = "http://127.0.0.1:8000";
  // dio.options.baseUrl = "http://193.190.127.212";
  // dio.options.baseUrl = "http://10.0.2.2:8000";
  dio.options.connectTimeout = Duration(seconds: 10); //10s
  dio.options.receiveTimeout = Duration(seconds: 5);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        requestInterceptors(options);
        handler.next(options);
      },
      onResponse: (response, handler) {
        responseInterceptors(response);
        tokenInterceptor(response, dio);
        handler.next(response);
      },
      onError: (err, handler) {
        errorInterceptors(err);
        handler.next(err);
      },
    ),
  );
  // dio.interceptors.add(CookieManager(
  //     PersistCookieJar(storage: FileStorage(appDocPath + '/cookies/'))));
  return dio;
}

tokenInterceptor(Response response, Dio dio) {
  if (response.realUri.path == "/login/access-token") {
    dio.options.headers["Authorization"] =
        "Bearer ${response.data["access_token"]}";
    logger.d("got token ${dio.options.headers['Authorization']}");
  }
}

requestInterceptors(RequestOptions options) {
  logger.d(
    "${options.method}: ${options.uri}\n${options.data}\n${options.headers}",
  );
  return options;
}

responseInterceptors(Response response) {
  logger.d(response.data);
  return response;
}

errorInterceptors(DioException error) {
  logger.d("${error.error}\n${error.type}\n${error.response}");
  switch (error.type) {
    /// It occurs when url is opened timeout.
    case DioExceptionType.connectionTimeout:
      g.Get.defaultDialog(
        title: "Connection timeout",
        middleText: "Make sure that you have a working internet connection.",
      );
      break;

    /// It occurs when url is sent timeout.
    case DioExceptionType.sendTimeout:
      g.Get.defaultDialog(
        title: "Send timeout",
        middleText: "Make sure that you have a working internet connection.",
      );
      break;

    ///It occurs when receiving timeout.
    case DioExceptionType.receiveTimeout:
      g.Get.defaultDialog(
        title: "Receive timeout",
        middleText: "Make sure that you have a working internet connection.",
      );
      break;

    default:
      break;
  }
  return error;
}
