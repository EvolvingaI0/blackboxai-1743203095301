enum Priority { high, medium, low }

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final Priority priority;
  bool isCompleted;
  List<Task>? subtasks;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
    this.subtasks,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority.index,
      'isCompleted': isCompleted,
      'subtasks': subtasks?.map((task) => task.toMap()).toList(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      priority: Priority.values[map['priority']],
      isCompleted: map['isCompleted'],
      subtasks: map['subtasks'] != null
          ? (map['subtasks'] as List).map((t) => Task.fromMap(t)).toList()
          : null,
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    Priority? priority,
    bool? isCompleted,
    List<Task>? subtasks,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      subtasks: subtasks ?? this.subtasks,
    );
  }
}