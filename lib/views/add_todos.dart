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
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is TodoLoaded) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Todo Created')));
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
                  // Map data = {
                  //   'id': id.text,
                  //   'task': task.text,
                  //   'description': desc.text,
                  //   'isCanceled': false,
                  //   'isCompleted': false,
                  // };
                  // var todo = Todo.fromJson(data);
                  var todo = Todo(
                      id: id.value.text,
                      task: task.value.text,
                      description: desc.value.text,
                      isCompleted: false,
                      isCanceled: false);
                  print(todo);
                  context.read<TodoBloc>().add(AddTodos(todo: todo));
                  // context.read<TodoBloc>().add(AddTodos(todo: todo));
                },
                child: const Center(
                  child: Text('Add TODO'),
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
