import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../models/note_model.dart';
import '../widgets/note_card.dart';
import '../theme/app_theme.dart';
import '../widgets/confirm_dialog.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  String _query = '';

  void _openEditor(BuildContext context, {Note? note}) {
    final titleController = TextEditingController(text: note?.title ?? '');
    final contentController = TextEditingController(text: note?.content ?? '');
    final isEdit = note != null;
    int selectedColor = note?.colorIndex ?? 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx2).viewInsets.bottom, // pakai ctx2
            ),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(ctx2).size.height * 0.85,
              ),
              decoration: BoxDecoration(
                color: Theme.of(ctx2).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
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
                            color: AppTheme.noteLabelColors[selectedColor]
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            isEdit
                                ? Icons.edit_note_rounded
                                : Icons.note_add_rounded,
                            color: AppTheme.noteLabelColors[selectedColor],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          isEdit ? 'Edit Catatan' : 'Catatan Baru',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: titleController,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Judul catatan',
                        filled: true,
                        fillColor: Theme.of(ctx2).brightness == Brightness.dark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.black.withValues(alpha: 0.03),
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: contentController,
                      maxLines: 6,
                      minLines: 4,
                      style: const TextStyle(fontSize: 15, height: 1.4),
                      decoration: InputDecoration(
                        hintText: 'Tulis catatan kamu di sini...',
                        filled: true,
                        fillColor: Theme.of(ctx2).brightness == Brightness.dark
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
                    Text(
                      'Label warna',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 12,
                      children: List.generate(AppTheme.noteLabelColors.length, (
                        i,
                      ) {
                        final isSelected = selectedColor == i;
                        return GestureDetector(
                          onTap: () => setModalState(() => selectedColor = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: isSelected ? 38 : 32,
                            height: isSelected ? 38 : 32,
                            decoration: BoxDecoration(
                              color: AppTheme.noteLabelColors[i],
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(
                                      color:
                                          Theme.of(ctx2).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                      width: 2,
                                    )
                                  : null,
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: AppTheme.noteLabelColors[i]
                                            .withValues(alpha: 0.5),
                                        blurRadius: 8,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    size: 18,
                                    color: Colors.black,
                                  )
                                : null,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
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
                            onPressed: () => Navigator.pop(ctx2),
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
                              isEdit ? 'Simpan Perubahan' : 'Simpan Catatan',
                            ),
                            onPressed: () {
                              final title = titleController.text.trim();
                              final content = contentController.text.trim();
                              if (title.isEmpty && content.isEmpty) return;
                              final provider = context.read<NoteProvider>();
                              if (note == null) {
                                provider.addNote(
                                  title,
                                  content,
                                  colorIndex: selectedColor,
                                );
                              } else {
                                provider.editNote(
                                  note.id,
                                  title,
                                  content,
                                  colorIndex: selectedColor,
                                );
                              }
                              Navigator.pop(ctx2);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = context.watch<NoteProvider>();
    final notes = noteProvider.notes.where((n) {
      final q = _query.toLowerCase();
      return n.title.toLowerCase().contains(q) ||
          n.content.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              onChanged: (value) => setState(() => _query = value),
              decoration: const InputDecoration(
                hintText: 'Cari catatan...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: notes.isEmpty
                ? Center(
                    child: Text(
                      _query.isEmpty
                          ? 'Belum ada catatan. Tulis sesuatu!'
                          : 'Catatan tidak ditemukan.',
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 4, bottom: 80),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return NoteCard(
                        note: note,
                        onTap: () => _openEditor(context, note: note),
                        onDelete: () async {
                          final confirmed = await showConfirmDialog(
                            context,
                            title: 'Hapus Catatan?',
                            message:
                                'Catatan "${note.title.isEmpty ? "(Tanpa judul)" : note.title}" akan dihapus permanen.',
                          );
                          if (confirmed) {
                            noteProvider.deleteNote(note.id);
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEditor(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
