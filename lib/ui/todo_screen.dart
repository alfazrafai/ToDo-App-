import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bloc/todo_bloc.dart';
import '../bloc/todo_state.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoBloc>().add(FetchTodosEvent());
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Todos")),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoLoadedState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("API Success!")));
          } else if (state is TodoErrorState) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TodoLoadedState) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (_, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text(todo.todo),
                  trailing: Checkbox(
                    value: todo.completed,
                    onChanged: (_) {}, // readonly for now
                  ),
                );
              },
            );
          }

          if (state is TodoErrorState) {
            return const Center(child: Text("Something went wrong"));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
