import 'package:equatable/equatable.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/health_stat.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/mood_activity.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/task.dart';
import 'package:sevenhealth/features/dashboard/domain/usecases/get_dashboard_data_use_case.dart';

enum DashboardStatus {
  initial,
  loading,
  loaded,
  error,
}

class DashboardState extends Equatable {
  final DashboardStatus status;
  final List<HealthStat> healthStats;
  final Mood? mood;
  final Activity? recentActivity;
  final HeartRate? heartRate;
  final List<Task> tasks;
  final String? errorMessage;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.healthStats = const [],
    this.mood,
    this.recentActivity,
    this.heartRate,
    this.tasks = const [],
    this.errorMessage,
  });

  // Helper getters
  bool get isInitial => status == DashboardStatus.initial;
  bool get isLoading => status == DashboardStatus.loading;
  bool get isLoaded => status == DashboardStatus.loaded;
  bool get hasError => status == DashboardStatus.error;

  // Factory to create from DashboardData
  factory DashboardState.fromDashboardData(DashboardData data) {
    return DashboardState(
      status: DashboardStatus.loaded,
      healthStats: data.healthStats,
      mood: data.mood,
      recentActivity: data.recentActivity,
      heartRate: data.heartRate,
      tasks: data.tasks,
    );
  }

  // Helper methods to create different states
  DashboardState copyWith({
    DashboardStatus? status,
    List<HealthStat>? healthStats,
    Mood? mood,
    Activity? recentActivity,
    HeartRate? heartRate,
    List<Task>? tasks,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      healthStats: healthStats ?? this.healthStats,
      mood: mood ?? this.mood,
      recentActivity: recentActivity ?? this.recentActivity,
      heartRate: heartRate ?? this.heartRate,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  DashboardState loading() {
    return copyWith(status: DashboardStatus.loading);
  }

  DashboardState error(String message) {
    return copyWith(
      status: DashboardStatus.error,
      errorMessage: message,
    );
  }

  DashboardState updateTask(Task updatedTask) {
    final updatedTasks = tasks.map((task) {
      if (task.id == updatedTask.id) {
        return updatedTask;
      }
      return task;
    }).toList();

    return copyWith(tasks: updatedTasks);
  }

  DashboardState addTask(Task newTask) {
    return copyWith(tasks: [...tasks, newTask]);
  }

  @override
  List<Object?> get props => [
        status,
        healthStats,
        mood,
        recentActivity,
        heartRate,
        tasks,
        errorMessage,
      ];
}
