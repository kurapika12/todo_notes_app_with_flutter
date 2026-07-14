class Note {
  String id;
  String title;
  String content;
  int colorIndex; // index warna label, merujuk ke AppTheme.noteLabelColors
  DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.colorIndex = 0,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'content': content,
    'colorIndex': colorIndex,
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory Note.fromMap(Map<String, dynamic> map) => Note(
    id: map['id'],
    title: map['title'],
    content: map['content'],
    colorIndex: map['colorIndex'] ?? 0,
    updatedAt: DateTime.parse(map['updatedAt']),
  );
}
