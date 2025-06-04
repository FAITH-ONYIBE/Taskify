import 'package:flutter/material.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final TextEditingController faithbook = TextEditingController();
  List tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('TODO APP', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: const Color.fromARGB(255, 3, 73, 131),
      ),
      body: Column(
        children: [
          TextField(controller: faithbook),
          ElevatedButton(
            onPressed: () {
              setState(() {
                tasks.add(faithbook.text);
                faithbook.clear();
              });
            },
            child: Text('ADD'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]),
                  onTap: () {
                    setState(() {
                      tasks.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
