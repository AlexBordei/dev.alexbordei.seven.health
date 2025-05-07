import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sevenhealth/core/theme/app_theme.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/mood_activity.dart';

class MoodActivityCard extends StatelessWidget {
  final Mood mood;
  final Activity activity;
  final HeartRate heartRate;

  const MoodActivityCard({
    super.key,
    required this.mood,
    required this.activity,
    required this.heartRate,
  });

  // Helper to get color from string
  Color _getColorFromString(String colorString) {
    if (colorString == 'yellow-100') return const Color(0xFFFEF3C7);
    if (colorString == 'yellow-500') return const Color(0xFFF59E0B);
    if (colorString == 'green-100') return const Color(0xFFD1FAE5);
    if (colorString == 'green-500') return const Color(0xFF10B981);
    if (colorString == 'purple-100') return const Color(0xFFEDE9FE);
    if (colorString == 'purple-500') return const Color(0xFF8B5CF6);

    // Default fallback
    return Colors.grey.shade100;
  }

  // Helper to get icon from string
  IconData _getIconFromString(String iconString) {
    if (iconString == 'fa-regular fa-face-smile')
      return FontAwesomeIcons.faceSmile;
    if (iconString == 'fa-solid fa-dumbbell') return FontAwesomeIcons.dumbbell;
    if (iconString == 'fa-solid fa-heart-pulse')
      return FontAwesomeIcons.heartPulse;

    // Default fallback
    return FontAwesomeIcons.chartLine;
  }

  Widget _buildInfoCircle(
    BuildContext context, {
    required String iconName,
    required String backgroundColor,
    required String iconColor,
    required String label,
  }) {
    final bgColor = _getColorFromString(backgroundColor);
    final fgColor = _getColorFromString(iconColor);
    final icon = _getIconFromString(iconName);

    return Column(
      children: [
        // Circle with icon
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: FaIcon(
              icon,
              color: fgColor,
              size: 20,
            ),
          ),
        ),

        SizedBox(height: AppTheme.spacingXs),

        // Label
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.borderRadiusLarge,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            "Today's Mood & Activity",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),

          SizedBox(height: AppTheme.spacingMd),

          // Info circles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Mood
              _buildInfoCircle(
                context,
                iconName: mood.iconName,
                backgroundColor: mood.backgroundColor,
                iconColor: mood.iconColor,
                label: mood.label,
              ),

              // Activity
              _buildInfoCircle(
                context,
                iconName: activity.iconName,
                backgroundColor: activity.backgroundColor,
                iconColor: activity.iconColor,
                label: activity.label,
              ),

              // Heart Rate
              _buildInfoCircle(
                context,
                iconName: heartRate.iconName,
                backgroundColor: heartRate.backgroundColor,
                iconColor: heartRate.iconColor,
                label: '${heartRate.beatsPerMinute} bpm',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
