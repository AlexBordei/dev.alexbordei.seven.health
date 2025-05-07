import 'package:dartz/dartz.dart' hide Task;
import 'package:injectable/injectable.dart';
import 'package:sevenhealth/core/error/failures.dart';
import 'package:sevenhealth/core/services/health_service.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/health_stat.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/mood_activity.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/task.dart';
import 'package:sevenhealth/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:flutter/material.dart'; // For Color

@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  final HealthService _healthService;

  DashboardRepositoryImpl(this._healthService);

  // Mock mood
  final Mood _mockMood = Mood(
    id: '1',
    type: MoodType.happy,
    iconName: 'fa-regular fa-face-smile',
    label: 'Happy',
    backgroundColor: 'yellow-100',
    iconColor: 'yellow-500',
    timestamp: DateTime.now(),
  );

  // Mock tasks
  final List<Task> _mockTasks = [
    Task(
      id: '1',
      title: 'Morning yoga session',
      isCompleted: false,
      dueDate: DateTime.now(),
      category: 'Exercise',
      priority: 2,
    ),
    Task(
      id: '2',
      title: 'Drink 500ml water',
      isCompleted: true,
      dueDate: DateTime.now(),
      completedAt: DateTime.now().subtract(const Duration(hours: 1)),
      category: 'Health',
      priority: 1,
    ),
    Task(
      id: '3',
      title: 'Evening walk - 30min',
      isCompleted: false,
      dueDate: DateTime.now().add(const Duration(hours: 4)),
      category: 'Exercise',
      priority: 2,
    ),
  ];

  @override
  Future<Either<Failure, List<HealthStat>>> getHealthStats() async {
    try {
      // Check if health data is available
      bool isAvailable = await _healthService.checkHealthDataAvailable();
      if (!isAvailable) {
        return Right(_getMockHealthStats());
      }

      // Request permissions if needed and get real health data
      bool permissionsGranted = await _healthService.requestPermissions();
      if (!permissionsGranted) {
        return Right(_getMockHealthStats());
      }

      // Get real steps data
      int steps = await _healthService.getStepsToday();
      double water = await _healthService.getWaterIntakeToday();

      // Format the numbers for display
      String stepsValue = steps.toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          );
      String waterValue = water.toStringAsFixed(1);

      // Create health stats with real data
      List<HealthStat> healthStats = [
        HealthStat(
          id: '1',
          title: 'Steps',
          value: stepsValue,
          unit: 'steps today',
          progress: steps.toDouble(),
          goal: 10000,
          iconName: 'fa-solid fa-shoe-prints',
          backgroundColor: 'blue-50',
          progressColor: 'blue-500',
        ),
        HealthStat(
          id: '2',
          title: 'Water',
          value: waterValue,
          unit: 'L water intake',
          progress: water,
          goal: 2.0,
          iconName: 'fa-solid fa-droplet',
          backgroundColor: 'cyan-50',
          progressColor: 'cyan-500',
        ),
      ];

      return Right(healthStats);
    } catch (e) {
      return Left(ServerFailure([e.toString()]));
    }
  }

  // Helper method to get mock health stats when real data isn't available
  List<HealthStat> _getMockHealthStats() {
    return [
      const HealthStat(
        id: '1',
        title: 'Steps',
        value: '6,234',
        unit: 'steps today',
        progress: 6234,
        goal: 10000,
        iconName: 'fa-solid fa-shoe-prints',
        backgroundColor: 'blue-50',
        progressColor: 'blue-500',
      ),
      const HealthStat(
        id: '2',
        title: 'Water',
        value: '1.2',
        unit: 'L water intake',
        progress: 1.2,
        goal: 2.0,
        iconName: 'fa-solid fa-droplet',
        backgroundColor: 'cyan-50',
        progressColor: 'cyan-500',
      ),
    ];
  }

  @override
  Future<Either<Failure, Mood>> getUserMood() async {
    try {
      await Future.delayed(
          const Duration(milliseconds: 800)); // Simulate network delay
      return Right(_mockMood);
    } catch (e) {
      return Left(ServerFailure([e.toString()]));
    }
  }

  @override
  Future<Either<Failure, Activity>> getRecentActivity() async {
    try {
      bool isAvailable = await _healthService.checkHealthDataAvailable();
      bool permissionsGranted =
          isAvailable ? await _healthService.requestPermissions() : false;

      if (permissionsGranted) {
        // Get workout minutes from health data
        int minutes = await _healthService.getWorkoutMinutesToday();

        if (minutes > 0) {
          return Right(Activity(
            id: '1',
            type: ActivityType.exercise,
            iconName: 'fa-solid fa-dumbbell',
            label: '${minutes}min',
            backgroundColor: 'green-100',
            iconColor: 'green-500',
            durationMinutes: minutes,
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          ));
        }
      }

      // Return mock data if no real data available or no workouts recorded
      return Right(Activity(
        id: '1',
        type: ActivityType.exercise,
        iconName: 'fa-solid fa-dumbbell',
        label: '45min',
        backgroundColor: 'green-100',
        iconColor: 'green-500',
        durationMinutes: 45,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ));
    } catch (e) {
      return Left(ServerFailure([e.toString()]));
    }
  }

  @override
  Future<Either<Failure, HeartRate>> getLatestHeartRate() async {
    try {
      bool isAvailable = await _healthService.checkHealthDataAvailable();
      bool permissionsGranted =
          isAvailable ? await _healthService.requestPermissions() : false;

      if (permissionsGranted) {
        // Get heart rate from health data
        int heartRateValue = await _healthService.getLatestHeartRate();

        if (heartRateValue > 0) {
          return Right(HeartRate(
            id: '1',
            beatsPerMinute: heartRateValue,
            iconName: 'fa-solid fa-heart-pulse',
            backgroundColor: 'purple-100',
            iconColor: 'purple-500',
            timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          ));
        }
      }

      // Return mock data if no real data available
      return Right(HeartRate(
        id: '1',
        beatsPerMinute: 125,
        iconName: 'fa-solid fa-heart-pulse',
        backgroundColor: 'purple-100',
        iconColor: 'purple-500',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      ));
    } catch (e) {
      return Left(ServerFailure([e.toString()]));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getTodayTasks() async {
    try {
      await Future.delayed(
          const Duration(milliseconds: 900)); // Simulate network delay
      return Right(_mockTasks);
    } catch (e) {
      return Left(ServerFailure([e.toString()]));
    }
  }

  @override
  Future<Either<Failure, Task>> updateTask(Task task) async {
    try {
      await Future.delayed(
          const Duration(milliseconds: 500)); // Simulate network delay

      // Find and update the task in the mock list
      final index = _mockTasks.indexWhere((t) => t.id == task.id);

      if (index != -1) {
        _mockTasks[index] = task;
        return Right(task);
      } else {
        return Left(ServerFailure(['Task not found']));
      }
    } catch (e) {
      return Left(ServerFailure([e.toString()]));
    }
  }

  @override
  Future<Either<Failure, Task>> addTask(Task task) async {
    try {
      await Future.delayed(
          const Duration(milliseconds: 500)); // Simulate network delay

      // Add the task to the mock list
      _mockTasks.add(task);
      return Right(task);
    } catch (e) {
      return Left(ServerFailure([e.toString()]));
    }
  }
}
