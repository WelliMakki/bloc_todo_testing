part of 'blog_bloc.dart';

abstract class BlogEvent extends Equatable {
  BlogEvent();

  final DioAssistant dio = DioAssistant();
  @override
  List<Object> get props => [];
}

class GetBlogs extends BlogEvent {
  final List<Blog> blogs;
  final BlogRepo repo = BlogRepo(BlogService());

  GetBlogs({this.blogs = const <Blog>[]});

  @override
  List<Object> get props => [blogs, repo];
}

class AddBlogs extends BlogEvent {
  final Map<String, dynamic> blog;
  AddBlogs(this.blog);
  Future<Map> publishBlog() async {
    try {
      var response = await dio.dio.post('blogs', data: blog);
      if (response.statusCode! < 300) {
        print('Done');
      }
      return response.data['data'];
    } on DioError catch (e) {
      throw e.message;
    }
  }

  @override
  List<Object> get props => [blog];
}

class DeleteBlogs extends BlogEvent {
  final Blog blog;

  DeleteBlogs(this.blog);

  Future<void> deleteBlog() async {
    try {
      var response = await dio.dio.delete(
        'blogs/${blog.id}',
      );
      if (response.statusCode! < 300) {
        print('Done');
      }
    } on DioError catch (e) {
      throw e.message;
    }
  }

  @override
  List<Object> get props => [blog];
}

class UpdateBlogs extends BlogEvent {}
