import 'package:health/health.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class HealthService {
  final Health _health = Health();
  bool _isConfigured = false;

  // Types of data to request
  static const List<HealthDataType> _types = [
    HealthDataType.STEPS,
    HealthDataType.WEIGHT,
    HealthDataType.HEIGHT,
    HealthDataType.HEART_RATE,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.BODY_TEMPERATURE,
    HealthDataType.WATER,
    HealthDataType.WORKOUT,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_AWAKE,
    HealthDataType.SLEEP_IN_BED,
  ];

  // Configure the health plugin before use
  Future<void> configure() async {
    if (!_isConfigured) {
      await _health.configure();
      _isConfigured = true;
    }
  }

  // Check if health data access is available
  Future<bool> checkHealthDataAvailable() async {
    try {
      await configure();
      return true;
    } catch (e) {
      print("Error checking health data availability: $e");
      return false;
    }
  }

  // Request health data permissions
  Future<bool> requestPermissions() async {
    // Request device permissions first
    Map<Permission, PermissionStatus> statuses = await [
      Permission.activityRecognition,
      Permission.location,
    ].request();

    bool devicePermissionsGranted = true;
    statuses.forEach((permission, status) {
      if (!status.isGranted) {
        devicePermissionsGranted = false;
      }
    });

    if (!devicePermissionsGranted) {
      return false;
    }

    // Then request Health data permissions
    try {
      await configure();
      List<HealthDataAccess> permissions =
          List.filled(_types.length, HealthDataAccess.READ);
      bool permissionsGranted =
          await _health.requestAuthorization(_types, permissions: permissions);
      return permissionsGranted;
    } catch (e) {
      print("Error requesting health permissions: $e");
      return false;
    }
  }

  // Get steps for today
  Future<int> getStepsToday() async {
    try {
      await configure();
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);

      int? totalSteps = await _health.getTotalStepsInInterval(startOfDay, now);
      return totalSteps ?? 0;
    } catch (e) {
      print("Error fetching steps: $e");
      return 0;
    }
  }

  // Get water intake for today (in liters)
  Future<double> getWaterIntakeToday() async {
    try {
      await configure();
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);

      List<HealthDataPoint> healthData = await _health.getHealthDataFromTypes(
        types: [HealthDataType.WATER],
        startTime: startOfDay,
        endTime: now,
      );

      double totalWater = 0.0;
      for (var point in healthData) {
        if (point.type == HealthDataType.WATER) {
          // Convert mL to L
          totalWater += (point.value as NumericHealthValue).numericValue;
        }
      }
      return totalWater;
    } catch (e) {
      print("Error fetching water intake: $e");
      return 0.0;
    }
  }

  // Get latest heart rate
  Future<int> getLatestHeartRate() async {
    try {
      await configure();
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));

      List<HealthDataPoint> healthData = await _health.getHealthDataFromTypes(
        types: [HealthDataType.HEART_RATE],
        startTime: yesterday,
        endTime: now,
      );

      if (healthData.isNotEmpty) {
        // Sort by date descending to get latest
        healthData.sort((a, b) => b.dateFrom.compareTo(a.dateFrom));
        return (healthData.first.value as NumericHealthValue)
            .numericValue
            .toInt();
      }
      return 0;
    } catch (e) {
      print("Error fetching heart rate: $e");
      return 0;
    }
  }

  // Get workout minutes for today
  Future<int> getWorkoutMinutesToday() async {
    try {
      await configure();
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);

      List<HealthDataPoint> healthData = await _health.getHealthDataFromTypes(
        types: [HealthDataType.WORKOUT],
        startTime: startOfDay,
        endTime: now,
      );

      int totalMinutes = 0;
      for (var workout in healthData) {
        // Calculate duration in minutes
        Duration duration = workout.dateTo.difference(workout.dateFrom);
        totalMinutes += duration.inMinutes;
      }
      return totalMinutes;
    } catch (e) {
      print("Error fetching workout minutes: $e");
      return 0;
    }
  }
}
