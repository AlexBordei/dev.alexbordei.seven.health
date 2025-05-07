import 'package:equatable/equatable.dart';

/// A health statistic entity that holds information about a particular health metric.
class HealthStat extends Equatable {
  final String id;
  final String title;
  final String value;
  final String unit;
  final double progress;
  final double goal;
  final String iconName;
  final String backgroundColor;
  final String progressColor;

  const HealthStat({
    required this.id,
    required this.title,
    required this.value,
    required this.unit,
    required this.progress,
    required this.goal,
    required this.iconName,
    required this.backgroundColor,
    required this.progressColor,
  });

  /// Get the progress percentage (0-1)
  double get progressPercentage => progress / goal;

  @override
  List<Object?> get props => [
        id,
        title,
        value,
        unit,
        progress,
        goal,
        iconName,
        backgroundColor,
        progressColor,
      ];
}
