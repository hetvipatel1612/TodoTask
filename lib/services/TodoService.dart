// lib/services/todo_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoproject/model/todo.dart';

class TodoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Todo>> fetchTodos() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('todos').get();
    return querySnapshot.docs.map((doc) {
      return Todo(
        id: doc.id,
        title: doc['title'],
        isCompleted: doc['isCompleted'],
      );
    }).toList();
  }

  Future<void> addTodo(String title) async {
    await _firestore.collection('todos').add({
      'title': title,
      'isCompleted': false,
    });
  }

  Future<void> updateTodoStatus(String id, bool isCompleted) async {
    await _firestore.collection('todos').doc(id).update({
      'isCompleted': isCompleted,
    });
  } Future<void> updateTodoTitle(String id, String title) async {
    await _firestore.collection('todos').doc(id).update({
      'title': title,
    });
  }

  Future<void> deleteTodo(String id) async {
    await _firestore.collection('todos').doc(id).delete();
  }
}
