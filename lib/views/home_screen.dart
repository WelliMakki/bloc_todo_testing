import 'package:bloc_reminder/views/add_todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTodoScreen())),
            icon: const Icon(Icons.add)),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoLoaded) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Removed !!!')));
          }
        },
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TodoLoaded) {
            return state.todos.isEmpty
                ? const Center(
                    child: Text('Nothing Todo',
                        style: TextStyle(
                          fontSize: 18,
                        )))
                : ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  content: const Center(
                                    child: Text(
                                        'Are you sure deleting this item ?'),
                                  ),
                                  actions: [
                                    TextButton.icon(
                                        onPressed: () {
                                          context.read<TodoBloc>().add(
                                              DeleteTodos(
                                                  todo: state.todos[index]));
                                        },
                                        icon: const Icon(Icons.check),
                                        label: const Text('Yes')),
                                    TextButton.icon(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.close),
                                        label: const Text('No'))
                                  ],
                                );
                              });
                        },
                        child: Card(
                          child: ListTile(
                            title: Text('${state.todos[index].id}'),
                            subtitle: Text('${state.todos[index].task}'),
                          ),
                        ),
                      );
                    });
          } else {
            return const Text('Somnething Went Wrong');
          }
        },
      ),
    );
  }
}
