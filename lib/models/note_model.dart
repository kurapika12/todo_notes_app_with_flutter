class Note {
  String id;
  String title;
  String content;
  int colorIndex; // index warna label, merujuk ke AppTheme.noteLabelColors
  bool isPinned;
  int sortOrder;
  DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.colorIndex = 0,
    this.isPinned = false,
    this.sortOrder = 0,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'content': content,
    'colorIndex': colorIndex,
    'isPinned': isPinned ? 1 : 0,
    'sortOrder': sortOrder,
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory Note.fromMap(Map<String, dynamic> map) => Note(
    id: map['id'],
    title: map['title'],
    content: map['content'],
    colorIndex: map['colorIndex'] ?? 0,
    isPinned: (map['isPinned'] ?? 0) == 1,
    sortOrder: map['sortOrder'] ?? 0,
    updatedAt: DateTime.parse(map['updatedAt']),
  );
}
