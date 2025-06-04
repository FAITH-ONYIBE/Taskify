import 'package:flutter/material.dart';
import 'package:to_do_app/to_do_app.dart';

void main(List<String> args) {
  runApp(TodoList());
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ToDoApp());
  }
}
