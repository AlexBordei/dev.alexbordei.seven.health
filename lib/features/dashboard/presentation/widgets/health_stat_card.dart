import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sevenhealth/core/theme/app_theme.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/health_stat.dart';

class HealthStatCard extends StatelessWidget {
  final HealthStat stat;

  const HealthStatCard({
    super.key,
    required this.stat,
  });

  // Helper to get color from string
  Color _getColorFromString(String colorString) {
    if (colorString == 'blue-50') return const Color(0xFFEFF6FF);
    if (colorString == 'blue-500') return const Color(0xFF3B82F6);
    if (colorString == 'cyan-50') return const Color(0xFFECFEFF);
    if (colorString == 'cyan-500') return const Color(0xFF06B6D4);

    // Default fallback
    return Colors.grey.shade100;
  }

  // Helper to get icon from string
  IconData _getIconFromString(String iconString) {
    if (iconString == 'fa-solid fa-shoe-prints')
      return FontAwesomeIcons.shoePrints;
    if (iconString == 'fa-solid fa-droplet') return FontAwesomeIcons.droplet;

    // Default fallback
    return FontAwesomeIcons.chartLine;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getColorFromString(stat.backgroundColor);
    final progressColor = _getColorFromString(stat.progressColor);
    final iconData = _getIconFromString(stat.iconName);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppTheme.borderRadiusLarge,
      ),
      padding: EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and goal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FaIcon(
                iconData,
                color: progressColor,
                size: 16,
              ),
              Text(
                'Daily Goal',
                style: TextStyle(
                  fontSize: 12,
                  color: progressColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: AppTheme.spacingSm),

          // Value
          Text(
            stat.value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),

          // Unit
          Text(
            stat.unit,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade700,
                ),
          ),

          SizedBox(height: AppTheme.spacingSm),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: stat.progressPercentage,
              backgroundColor: progressColor.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
