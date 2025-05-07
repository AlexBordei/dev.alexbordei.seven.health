import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sevenhealth/core/error/failures.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/health_stat.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/mood_activity.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/task.dart';
import 'package:sevenhealth/features/dashboard/domain/repositories/dashboard_repository.dart';

/// Output data class for the dashboard
class DashboardData extends Equatable {
  final List<HealthStat> healthStats;
  final Mood mood;
  final Activity recentActivity;
  final HeartRate heartRate;
  final List<Task> tasks;

  const DashboardData({
    required this.healthStats,
    required this.mood,
    required this.recentActivity,
    required this.heartRate,
    required this.tasks,
  });

  @override
  List<Object?> get props =>
      [healthStats, mood, recentActivity, heartRate, tasks];
}

@injectable
class GetDashboardDataUseCase {
  final DashboardRepository _dashboardRepository;

  GetDashboardDataUseCase(this._dashboardRepository);

  Future<Either<Failure, DashboardData>> call() async {
    // Get health stats
    final healthStatsResult = await _dashboardRepository.getHealthStats();

    // Handle health stats failure
    if (healthStatsResult.isLeft()) {
      return Left(healthStatsResult.fold(
        (failure) => failure,
        (_) => ServerFailure(['Failed to get health stats']),
      ));
    }

    // Get mood
    final moodResult = await _dashboardRepository.getUserMood();

    // Handle mood failure
    if (moodResult.isLeft()) {
      return Left(moodResult.fold(
        (failure) => failure,
        (_) => ServerFailure(['Failed to get user mood']),
      ));
    }

    // Get recent activity
    final activityResult = await _dashboardRepository.getRecentActivity();

    // Handle activity failure
    if (activityResult.isLeft()) {
      return Left(activityResult.fold(
        (failure) => failure,
        (_) => ServerFailure(['Failed to get recent activity']),
      ));
    }

    // Get heart rate
    final heartRateResult = await _dashboardRepository.getLatestHeartRate();

    // Handle heart rate failure
    if (heartRateResult.isLeft()) {
      return Left(heartRateResult.fold(
        (failure) => failure,
        (_) => ServerFailure(['Failed to get latest heart rate']),
      ));
    }

    // Get tasks
    final tasksResult = await _dashboardRepository.getTodayTasks();

    // Handle tasks failure
    if (tasksResult.isLeft()) {
      return Left(tasksResult.fold(
        (failure) => failure,
        (_) => ServerFailure(['Failed to get today\'s tasks']),
      ));
    }

    // Combine all data into the DashboardData model
    return Right(
      DashboardData(
        healthStats: healthStatsResult.getOrElse(() => []),
        mood: moodResult.getOrElse(() => throw UnimplementedError()),
        recentActivity:
            activityResult.getOrElse(() => throw UnimplementedError()),
        heartRate: heartRateResult.getOrElse(() => throw UnimplementedError()),
        tasks: tasksResult.getOrElse(() => []),
      ),
    );
  }
}
