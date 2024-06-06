class Todo {
  final String id;
  final String title;
  final bool isCompleted;
  final bool isPinned;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.isPinned = false,
  });

  Todo copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    bool? isPinned,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      isPinned: isPinned ?? this.isPinned,
    );
  }
}
