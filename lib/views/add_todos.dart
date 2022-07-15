import 'package:bloc_reminder/bloc/blog_bloc.dart';
import 'package:bloc_reminder/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController id = TextEditingController();
    final TextEditingController task = TextEditingController();
    final TextEditingController desc = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<BlogBloc, BlogState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is BlogLoaded) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Blog Created')));
            Navigator.pop(context);
          }
        },
        child: Column(
          children: [
            _inputFields('id', id),
            _inputFields('Task', task),
            _inputFields('description', desc),
            ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> blog = {
                    'data': {
                      'title': task.text,
                      'body': desc.text,
                    }
                  };
                  // var todo = Todo.fromJson(data);

                  context.read<BlogBloc>().add(AddBlogs(blog));
                  // context.read<TodoBloc>().add(AddTodos(todo: todo));
                },
                child: const Center(
                  child: Text('publish'),
                ))
          ],
        ),
      ),
    );
  }
}

Column _inputFields(String title, TextEditingController controller) {
  return Column(children: [
    Text(title),
    TextField(
      controller: controller,
    ),
  ]);
}
