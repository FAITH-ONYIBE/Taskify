import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final String taskDescription;
  final String dateCreated;
  final bool taskCompleted;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final void Function(bool?)? onChange;

  const TodoTile({
    super.key,
    required this.taskName,
    required this.taskDescription,
    required this.dateCreated,
    required this.taskCompleted,
    required this.onChange,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface, // adapts with theme
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: taskCompleted,
              onChanged: onChange,
              checkColor: colors.onPrimary,
              shape: const CircleBorder(),
              activeColor: colors.primary, // follows theme
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskName,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    taskDescription,
                    style: TextStyle(
                      color: colors.onSurface.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Created: $dateCreated",
                    style: TextStyle(
                      color: colors.onSurface.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: colors.tertiary), 
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: colors.error),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
