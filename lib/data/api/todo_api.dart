

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoApi {

  final _db = FirebaseFirestore.instance;

  // GET TODOS
  // return List<Todo>
  Future<List<Todo>> getTodos() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection("todo").get();
      debugPrint(querySnapshot.docs.length.toString());
      List<Todo> todos = [];
      for (var element in querySnapshot.docs) {
        Todo todo = Todo.fromJson(element.data() as Map<String, dynamic>);
        todos.add(todo);
      }
      return todos;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }
}