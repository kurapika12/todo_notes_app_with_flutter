import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/todo_model.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TodoTile({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: Colors.blueAccent,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: BorderRadius.circular(16),
          ),
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: Colors.redAccent,
            icon: Icons.delete,
            label: 'Hapus',
            borderRadius: BorderRadius.circular(16),
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          leading: Checkbox(value: todo.isDone, onChanged: (_) => onToggle()),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
              color: todo.isDone ? Colors.grey : null,
            ),
          ),
        ),
      ),
    );
  }
}
