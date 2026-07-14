class Todo {
  String id;
  String title;
  bool isDone;
  DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'isDone': isDone ? 1 : 0,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Todo.fromMap(Map<String, dynamic> map) => Todo(
    id: map['id'],
    title: map['title'],
    isDone: map['isDone'] == 1,
    createdAt: DateTime.parse(map['createdAt']),
  );
}
