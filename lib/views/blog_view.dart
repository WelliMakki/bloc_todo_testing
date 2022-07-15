import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/blog_bloc.dart';
import 'add_todos.dart';

class BlogView extends StatelessWidget {
  const BlogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTodoScreen())),
            icon: const Icon(Icons.add)),
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is BlogLoaded) {
            return state.blogs.isEmpty
                ? const Center(
                    child: Text('Nothing Todo',
                        style: TextStyle(
                          fontSize: 18,
                        )))
                : ListView.builder(
                    itemCount: state.blogs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  content: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                    child: const Center(
                                      child: Text(
                                          'Are you sure deleting this item ?'),
                                    ),
                                  ),
                                  actions: [
                                    TextButton.icon(
                                        onPressed: () {
                                          context.read<BlogBloc>().add(
                                              DeleteBlogs(state.blogs[index]));
                                          Navigator.pop(context);
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
                            title:
                                Text('${state.blogs[index].attributes!.title}'),
                            subtitle:
                                Text('${state.blogs[index].attributes!.body}'),
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
