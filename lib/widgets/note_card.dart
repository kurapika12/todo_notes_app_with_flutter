import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note_model.dart';
import '../theme/app_theme.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onDelete,
  });

  String _formatDateTime(DateTime dt) {
    final date = DateFormat('dd/MM/yyyy').format(dt);
    final time = DateFormat('HH:mm').format(dt);
    return '$date • $time';
  }

  @override
  Widget build(BuildContext context) {
    final labelColor =
        AppTheme.noteLabelColors[note.colorIndex.clamp(
          0,
          AppTheme.noteLabelColors.length - 1,
        )];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Garis warna label di kiri
              Container(
                width: 6,
                height: 60,
                margin: const EdgeInsets.only(right: 12, top: 2),
                decoration: BoxDecoration(
                  color: labelColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title.isEmpty ? '(Tanpa judul)' : note.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Tanggal + jam + preview isi, mirip gaya Apple Notes
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: _formatDateTime(note.updatedAt),
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (note.content.isNotEmpty)
                            TextSpan(
                              text: '  ${note.content}',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12.5,
                              ),
                            ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
