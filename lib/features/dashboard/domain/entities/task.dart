import 'package:equatable/equatable.dart';

/// A class representing a task that the user needs to complete
class Task extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime dueDate;
  final DateTime? completedAt;
  final String? category;
  final int? priority; // 1-3 with 3 being highest priority

  const Task({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.dueDate,
    this.completedAt,
    this.category,
    this.priority,
  });

  /// Creates a copy of the current task with specific values changed
  Task copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? dueDate,
    DateTime? completedAt,
    String? category,
    int? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      completedAt: completedAt ?? this.completedAt,
      category: category ?? this.category,
      priority: priority ?? this.priority,
    );
  }

  /// Marks the task as completed
  Task markAsCompleted() {
    return copyWith(
      isCompleted: true,
      completedAt: DateTime.now(),
    );
  }

  /// Marks the task as incomplete
  Task markAsIncomplete() {
    return copyWith(
      isCompleted: false,
      completedAt: null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        isCompleted,
        dueDate,
        completedAt,
        category,
        priority,
      ];
}
