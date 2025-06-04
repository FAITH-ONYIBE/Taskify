import 'package:flutter/material.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final TextEditingController controller = TextEditingController();
  List task = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('TODO APP', style: TextStyle(color: Colors.white))),
        backgroundColor: const Color.fromARGB(255, 3, 73, 131),
      ),
      body: TextField(),
    );
  }
}
