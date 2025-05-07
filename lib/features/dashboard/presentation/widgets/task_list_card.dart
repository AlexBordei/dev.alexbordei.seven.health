import 'package:flutter/material.dart';
import 'package:sevenhealth/core/theme/app_theme.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/task.dart';

class TaskListCard extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task, bool) onTaskToggle;
  final VoidCallback onSeeAllTapped;

  const TaskListCard({
    super.key,
    required this.tasks,
    required this.onTaskToggle,
    required this.onSeeAllTapped,
  });

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
          // Header with title and see all button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Tasks",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              TextButton(
                onPressed: onSeeAllTapped,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingSm,
                    vertical: AppTheme.spacingXs,
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppTheme.spacingMd),

          // Tasks list
          ...tasks.map((task) => _buildTaskItem(context, task)).toList(),
        ],
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, Task task) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.spacingSm),
      child: Row(
        children: [
          // Checkbox
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: task.isCompleted,
              onChanged: (value) => onTaskToggle(task, value ?? false),
              shape: const CircleBorder(),
              activeColor: AppTheme.primaryColor,
            ),
          ),

          SizedBox(width: AppTheme.spacingSm),

          // Task title
          Expanded(
            child: Text(
              task.title,
              style: TextStyle(
                fontSize: 14,
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: task.isCompleted ? Colors.grey : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
