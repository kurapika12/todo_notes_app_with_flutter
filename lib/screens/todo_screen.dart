import '../widgets/confirm_dialog.dart'; // tambahkan import di paling atas
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_tile.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  String _query = '';

  void _showTodoDialog(BuildContext context, {String? id, String? initial}) {
    final controller = TextEditingController(text: initial);
    final isEdit = id != null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(
            ctx,
          ).viewInsets.bottom, // pakai ctx, bukan context luar
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(ctx).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          ctx,
                        ).colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isEdit ? Icons.edit_rounded : Icons.add_task_rounded,
                        color: Theme.of(ctx).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isEdit ? 'Edit Todo' : 'Todo Baru',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller,
                  autofocus: true,
                  maxLines: 3,
                  minLines: 1,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Apa yang ingin kamu lakukan?',
                    filled: true,
                    fillColor: Theme.of(ctx).brightness == Brightness.dark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.black.withValues(alpha: 0.03),
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Batal'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: const Icon(Icons.check_rounded, size: 20),
                        label: Text(
                          isEdit ? 'Simpan Perubahan' : 'Tambah Todo',
                        ),
                        onPressed: () {
                          final text = controller.text.trim();
                          if (text.isEmpty) return;
                          final provider = context.read<TodoProvider>();
                          if (id == null) {
                            provider.addTodo(text);
                          } else {
                            provider.editTodo(id, text);
                          }
                          Navigator.pop(ctx);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoProvider>();
    final todos = todoProvider.todos
        .where((t) => t.title.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              onChanged: (value) => setState(() => _query = value),
              decoration: const InputDecoration(
                hintText: 'Cari todo...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: todos.isEmpty
                ? Center(
                    child: Text(
                      _query.isEmpty
                          ? 'Belum ada todo. Yuk tambahkan!'
                          : 'Todo tidak ditemukan.',
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 4, bottom: 80),
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return TodoTile(
                        todo: todo,
                        onToggle: () => todoProvider.toggleTodo(todo.id),
                        onDelete: () async {
                          final confirmed = await showConfirmDialog(
                            context,
                            title: 'Hapus Todo?',
                            message:
                                'Todo "${todo.title}" akan dihapus permanen.',
                          );
                          if (confirmed) {
                            todoProvider.deleteTodo(todo.id);
                          }
                        },
                        onEdit: () => _showTodoDialog(
                          context,
                          id: todo.id,
                          initial: todo.title,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTodoDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
