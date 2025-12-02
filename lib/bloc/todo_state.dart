import 'package:equatable/equatable.dart';

import '../data/model/todo_model.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoadingState extends TodoState {}

class TodoLoadedState extends TodoState {
  final List<TodoModel> todos;
  TodoLoadedState({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class TodoErrorState extends TodoState {
  final String message;
  TodoErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
