import 'package:dio/dio.dart';

import '../tools/dio_assistant.dart';

class BlogService {
  final DioAssistant dio = DioAssistant();

  Future<List<dynamic>> fetchData() async {
    try {
      var response = await dio.dio.get('blogs');
      return response.data['data'];
    } on DioError catch (e) {
      throw e.message;
    }
  }
}
