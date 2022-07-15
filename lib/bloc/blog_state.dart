part of 'blog_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;
  const BlogLoaded({required this.blogs});
  @override
  List<Object> get props => [blogs];
}
