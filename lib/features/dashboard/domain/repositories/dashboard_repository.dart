import 'package:dartz/dartz.dart' hide Task;
import 'package:sevenhealth/core/error/failures.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/health_stat.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/mood_activity.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/task.dart';

abstract class DashboardRepository {
  /// Get the user's health stats for the current day
  Future<Either<Failure, List<HealthStat>>> getHealthStats();

  /// Get the user's current mood
  Future<Either<Failure, Mood>> getUserMood();

  /// Get the user's most recent activity
  Future<Either<Failure, Activity>> getRecentActivity();

  /// Get the user's latest heart rate
  Future<Either<Failure, HeartRate>> getLatestHeartRate();

  /// Get the user's tasks for today
  Future<Either<Failure, List<Task>>> getTodayTasks();

  /// Update a task's status
  Future<Either<Failure, Task>> updateTask(Task task);

  /// Add a new task
  Future<Either<Failure, Task>> addTask(Task task);
}
