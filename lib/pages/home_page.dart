

import 'package:firebase_example/data/api/todo_api.dart';
import 'package:firebase_example/utils/utils.dart';
import 'package:firebase_example/widgets/todo_item.dart';
import 'package:flutter/material.dart';

import '../data/models/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Todo> _todos = [];

  bool _isTodosInProgress = false;

  final _todoApi = TodoApi();

  @override
  void initState() {
    super.initState();

    _getTodos();
  }

  // GET TODOS
  void _getTodos() async {
    setState(() {
      _isTodosInProgress = true;
    });
    try {
      List<Todo> todos = await _todoApi.getTodos();
      // success response
      setState(() {
        _isTodosInProgress = false;
        _todos = todos;
      });
    } catch (e) {
      // error response
      setState(() {
        _isTodosInProgress = false;
      });
      Utils.showErrorSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              "assets/images/app_icon.jpg",
              width: 40,
              height: 40,
            ),
          ),
          title: const Text(
            "Todos",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
        ),
        body: _isTodosInProgress? const Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) {
            return TodoItem(
              todo: _todos[index],
            );
          },
        ),
      ),
    );
  }
}
