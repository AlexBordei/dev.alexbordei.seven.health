import 'package:equatable/equatable.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/task.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load dashboard data
class LoadDashboardEvent extends DashboardEvent {
  const LoadDashboardEvent();
}

/// Event to refresh dashboard data
class RefreshDashboardEvent extends DashboardEvent {
  const RefreshDashboardEvent();
}

/// Event to update a task's completion status
class UpdateTaskEvent extends DashboardEvent {
  final Task task;
  final bool isCompleted;

  const UpdateTaskEvent({
    required this.task,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [task, isCompleted];
}

/// Event to add a new task
class AddTaskEvent extends DashboardEvent {
  final String title;
  final String? category;
  final int? priority;

  const AddTaskEvent({
    required this.title,
    this.category,
    this.priority,
  });

  @override
  List<Object?> get props => [title, category, priority];
}
