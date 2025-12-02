import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/ui/todo_screen.dart';

import 'bloc/todo_bloc.dart';
import 'data/services/todo_api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc(TodoApiService())..add(FetchTodosEvent()),
      child: MaterialApp(
        title: 'BLoC Todo Demo',
        debugShowCheckedModeBanner: false,
        home: const TodoPage(),
      ),
    );
  }
}
