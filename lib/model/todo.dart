import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String? id;
  final String? task;
  final String? description;
  final bool isCompleted;
  final bool isCanceled;
  const Todo(
      {this.id,
      this.task,
      this.description,
      required this.isCompleted,
      required this.isCanceled});

  Todo copyWith(int? id, String? task, String? description, bool? isCompleted,
      bool? isCanceled) {
    return Todo(
      id: this.id,
      task: task ?? this.task,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isCanceled: isCanceled ?? this.isCanceled,
    );
  }

  factory Todo.fromJson(json) => Todo(
        id: json['id'],
        task: json['task'],
        description: json['description'],
        isCanceled: json['isCanceled'],
        isCompleted: json['isCompleted'],
      );
  @override
  List<Object?> get props => [id, task, description, isCompleted, isCanceled];
}
