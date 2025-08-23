import 'package:flutter/material.dart';
import 'package:to_do_app/categories/categorycard.dart';
import 'package:to_do_app/db/app_database.dart';
import 'package:to_do_app/todo_tile.dart';
import 'package:to_do_app/utili/dialogbox.dart';
import 'package:to_do_app/utili/mydrawer.dart';

class ToDoApp extends StatefulWidget {
  final Map<String, dynamic> user; // <-- logged in user (id, name, email, etc.)
  const ToDoApp({super.key, required this.user});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final _controller = TextEditingController();
  final _description = TextEditingController();
  final appDatabase = AppDatabase();
  List<Map<String, dynamic>> todoList = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  // ✅ Load only this user’s todos
  Future<void> _loadTodos() async {
    final data = await appDatabase.getUserTodos(widget.user['id']);
    setState(() {
      todoList = data;
    });
  }

  // ✅ Save a new task linked to this user
  void onSaveNewTask() async {
    if (_controller.text.isEmpty) return;

    final db = await appDatabase.database;
    await db.insert('todos', {
      'title': _controller.text.trim(),
      'description': _description.text.trim(),
      'timestamp': DateTime.now().toIso8601String(),
      'userId': widget.user['id'], // link todo to logged-in user
    });

    _controller.clear();
    _description.clear();
    Navigator.of(context).pop();
    _loadTodos();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialogbox(
          controller: _controller,
          description: _description,
          onSave: onSaveNewTask,
          onCancel: Navigator.of(context).pop,
        );
      },
    );
  }

  void _editTask(Map<String, dynamic> todo) {
    _controller.text = todo['title'] ?? '';
    _description.text = todo['description'] ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return Dialogbox(
          controller: _controller,
          description: _description,
          onSave: () async {
            final db = await appDatabase.database;
            await db.update(
              'todos',
              {
                'title': _controller.text.trim(),
                'description': _description.text.trim(),
              },
              where: 'id = ?',
              whereArgs: [todo['id']],
            );
            _controller.clear();
            _description.clear();
            Navigator.of(context).pop();
            _loadTodos();
          },
          onCancel: () {
            _controller.clear();
            _description.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            tooltip: '',
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/login_page');
            },
            icon: Icon(
              Icons.notifications_none_sharp,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      drawer: Mydrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Show logged-in user name
            Text(
              "What's up, ${widget.user['name']}!",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Categories", style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),

            SizedBox(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryCard(
                    title: "Business",
                    taskCount: 40,
                    progress: 0.6,
                    progressColor: Colors.pink,
                  ),
                  SizedBox(width: 12),
                  CategoryCard(
                    title: "Personal",
                    taskCount: 18,
                    progress: 0.3,
                    progressColor: Colors.blue,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  final todo = todoList[index];

                  return TodoTile(
                    taskName: todo['title'] ?? '',
                    taskDescription: todo['description'] ?? '',
                    dateCreated: todo['timestamp'] ?? '',
                    taskCompleted: (todo['completed'] ?? 0) == 1,
                    onChange: (value) async {
                      await appDatabase.updateTodoStatus(
                        todo['id'],
                        value ?? false,
                        widget.user['id'],  
                      );
                      _loadTodos();
                    },
                    onEdit: () {
                      _editTask(todo);
                    },
                    onDelete: () async {
                      final db = await appDatabase.database;
                      await db.delete(
                        'todos',
                        where: 'id = ?',
                        whereArgs: [todo['id']],
                      );
                      _loadTodos();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 30,
        ),
      ),
    );
  }
}
