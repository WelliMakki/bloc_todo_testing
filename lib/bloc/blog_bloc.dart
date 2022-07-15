import 'package:bloc/bloc.dart';
import 'package:bloc_reminder/repo/blog_repo.dart';
import 'package:bloc_reminder/services/blog_service.dart';
import 'package:bloc_reminder/tools/dio_assistant.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/blog_model.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc() : super(BlogInitial()) {
    on<GetBlogs>(_onGetBlogs);
    on<AddBlogs>(_onAddBlogs);
    on<DeleteBlogs>(_onDeleteBlogs);
  }

  final DioAssistant dio = DioAssistant();
  Future<void> _onGetBlogs(GetBlogs event, Emitter<BlogState> emit) async {
    await event.repo.handleData().then((value) {
      print(value[0].id);
      emit(BlogLoaded(blogs: value));
    });
  }

  Future<void> _onAddBlogs(AddBlogs event, Emitter<BlogState> emit) async {
    var state = this.state;
    if (state is BlogLoaded) {
      await event.publishBlog().then((value) {
        emit(BlogLoaded(
            blogs: List.from(state.blogs)..add(Blog.fromJson(value))));
      });
    }
  }

  Future<void> _onDeleteBlogs(
      DeleteBlogs event, Emitter<BlogState> emit) async {
    var state = this.state;
    if (state is BlogLoaded) {
      await event.deleteBlog().then((value) {
        emit(BlogLoaded(
            blogs: List.from(state.blogs)
              ..removeWhere((element) => element == event.blog)));
      });
    }
  }
}
