import 'package:bloc_reminder/services/blog_service.dart';

import '../model/blog_model.dart';

class BlogRepo {
  BlogService service;
  BlogRepo(this.service);

  Future<List<Blog>> handleData() async {
    var blog = await service.fetchData();

    return blog.map((element) => Blog.fromJson(element)).toList();
  }
}
