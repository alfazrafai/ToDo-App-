import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../model/todo_model.dart';

class TodoApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://dummyjson.com"))
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    );

  Future<List<TodoModel>> fetchTodo() async {
    final response = await _dio.get('/todos');
    final List todosJson = response.data['todos'];
    return todosJson.map((json) => TodoModel.fromJson(json)).toList();
  }
}
