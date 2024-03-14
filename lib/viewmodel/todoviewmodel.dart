import 'package:flutter/material.dart';
import 'package:todoproject/model/todo.dart';
import 'package:todoproject/services/TodoService.dart';

class TodoViewModel extends ChangeNotifier {
  final TodoService _todoService = TodoService();
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<void> fetchTodos() async {
    _todos = await _todoService.fetchTodos();
    notifyListeners();
  }

  Future<void> addTodo(String title) async {
    await _todoService.addTodo(title);
    await fetchTodos();
  }

  Future<void> toggleTodoCompletion(String id, bool isCompleted) async {
    await _todoService.updateTodoStatus(id, isCompleted);
    await fetchTodos();
  }

   Future<void> updateTodo(String id, String title) async {
    await _todoService.updateTodoTitle(id, title);
    await fetchTodos();
  }


  Future<void> deleteTodo(String id) async {
    await _todoService.deleteTodo(id);
    await fetchTodos();
  }
}