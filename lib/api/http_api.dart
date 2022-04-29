import 'package:dio/dio.dart';
import 'package:download_image_example/api/logging.dart';

class Api {
  final _dio = createDio();

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ))..interceptors.add(Logging());
    return dio;
  }

  Future<Response> download(String url, String path) {
    return _dio.download(url, path);
  }
}