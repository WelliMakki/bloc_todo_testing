import 'package:dio/dio.dart';

class DioAssistant {
  late Dio dio;
  final String url = 'http://192.168.152.254:1337/api/';

  DioAssistant() {
    dio = Dio(
      BaseOptions(
        baseUrl: url,
        sendTimeout: 60 * 1000,
        receiveTimeout: 60 * 1000,
      ),
    );
  }
}
