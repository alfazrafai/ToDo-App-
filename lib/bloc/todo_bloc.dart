import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/bloc/todo_state.dart';
import '../data/services/todo_api_service.dart';

part 'todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoApiService service;

  TodoBloc(this.service) : super(TodoInitial()) {
    on<FetchTodosEvent>(_fetchTodos);
  }

  Future<void> _fetchTodos(
    FetchTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoadingState());
    try {
      final todos = await service.fetchTodo();
      emit(TodoLoadedState(todos: todos));
    } catch (e) {
      emit(TodoErrorState("No Internet Connection or API Error"));
    }
  }
}
