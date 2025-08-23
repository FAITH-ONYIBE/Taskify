import 'package:flutter/material.dart';
import 'package:to_do_app/utili/my_button.dart';

class Dialogbox extends StatelessWidget {
  final controller;
  final description;
  VoidCallback onSave;
  VoidCallback onCancel;

  Dialogbox({
    super.key,
    required this.controller,
    required this.description,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        child: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add A new Task',
                ),
              ),
              TextField(
                controller: description,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add Descriptions',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // add button
                  MyButton(text: "Save", onPressed: onSave),

                  const SizedBox(width: 8),

                  // cancel button
                  MyButton(text: "Cancel", onPressed: onCancel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
