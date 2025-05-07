import 'package:equatable/equatable.dart';

/// Represents a mood type
enum MoodType {
  happy,
  neutral,
  sad,
  anxious,
  tired,
  energetic,
}

/// Represents an activity type
enum ActivityType {
  exercise,
  walking,
  running,
  yoga,
  swimming,
  cycling,
  hiit,
  weights,
  rest,
}

/// A class representing a user's mood for a specific day
class Mood extends Equatable {
  final String id;
  final MoodType type;
  final String iconName;
  final String label;
  final String backgroundColor;
  final String iconColor;
  final DateTime timestamp;

  const Mood({
    required this.id,
    required this.type,
    required this.iconName,
    required this.label,
    required this.backgroundColor,
    required this.iconColor,
    required this.timestamp,
  });

  @override
  List<Object?> get props =>
      [id, type, iconName, label, backgroundColor, iconColor, timestamp];
}

/// A class representing an activity completed by a user
class Activity extends Equatable {
  final String id;
  final ActivityType type;
  final String iconName;
  final String label;
  final String backgroundColor;
  final String iconColor;
  final int durationMinutes;
  final DateTime timestamp;

  const Activity({
    required this.id,
    required this.type,
    required this.iconName,
    required this.label,
    required this.backgroundColor,
    required this.iconColor,
    required this.durationMinutes,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        iconName,
        label,
        backgroundColor,
        iconColor,
        durationMinutes,
        timestamp,
      ];
}

/// Heart rate info for a specific time
class HeartRate extends Equatable {
  final String id;
  final int beatsPerMinute;
  final String iconName;
  final String backgroundColor;
  final String iconColor;
  final DateTime timestamp;

  const HeartRate({
    required this.id,
    required this.beatsPerMinute,
    required this.iconName,
    required this.backgroundColor,
    required this.iconColor,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        id,
        beatsPerMinute,
        iconName,
        backgroundColor,
        iconColor,
        timestamp,
      ];
}
