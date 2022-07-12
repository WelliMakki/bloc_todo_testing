import 'package:bloc/bloc.dart';
import 'package:bloc_reminder/model/todo.dart';
import 'package:equatable/equatable.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoading()) {
    on<LoadTodos>(_onLoadTodo);
    on<AddTodos>(_onAddTodo);
    on<UpdateTodos>(_onUpdateTodo);
    on<DeleteTodos>(_onDeleteTodo);
  }

  void _onLoadTodo(LoadTodos event, Emitter<TodoState> emit) {
    emit(TodoLoaded(todos: event.todos));
  }

  void _onAddTodo(AddTodos event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      emit(TodoLoaded(todos: List.from(state.todos)..add(event.todo)));
    }
  }

  void _onUpdateTodo(UpdateTodos event, Emitter<TodoState> emit) {}
  void _onDeleteTodo(DeleteTodos event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      emit(TodoLoaded(
          todos: List.from(state.todos)
            ..removeWhere((element) => element == event.todo)));
    }
  }
}
