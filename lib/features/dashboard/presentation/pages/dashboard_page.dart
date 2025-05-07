import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sevenhealth/core/di/injection.dart';
import 'package:sevenhealth/core/theme/app_theme.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/task.dart';
import 'package:sevenhealth/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:sevenhealth/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:sevenhealth/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:sevenhealth/features/dashboard/presentation/widgets/dashboard_app_bar.dart';
import 'package:sevenhealth/features/dashboard/presentation/widgets/dashboard_bottom_nav.dart';
import 'package:sevenhealth/features/dashboard/presentation/widgets/fab_button.dart';
import 'package:sevenhealth/features/dashboard/presentation/widgets/health_stat_card.dart';
import 'package:sevenhealth/features/dashboard/presentation/widgets/mood_activity_card.dart';
import 'package:sevenhealth/features/dashboard/presentation/widgets/task_list_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DashboardBloc>()..add(const LoadDashboardEvent()),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.isInitial || state.isLoading && state.healthStats.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.errorMessage}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<DashboardBloc>()
                          .add(const RefreshDashboardEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Content view
          return RefreshIndicator(
            onRefresh: () async {
              context.read<DashboardBloc>().add(const RefreshDashboardEvent());
              // Wait for refresh to complete
              return Future.delayed(const Duration(seconds: 1));
            },
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Custom app bar
                    _buildCustomAppBar(context),

                    // Health stats section - now using custom layout
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildHealthStatsRow(context, state),
                    ),

                    // Mood and activity section
                    if (state.mood != null &&
                        state.recentActivity != null &&
                        state.heartRate != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: _buildMoodActivityCard(context, state),
                      ),

                    const SizedBox(height: 16),

                    // Tasks section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildTasksSection(context, state),
                    ),

                    // Extra bottom padding for FAB
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    // Get today's date in the format "Month d, yyyy"
    final today = DateFormat('MMMM d, yyyy').format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // User info with avatar
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    const AssetImage('assets/images/default_avatar.png'),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hi, Sarah!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    today,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Notification icon
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications tapped')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHealthStatsRow(BuildContext context, DashboardState state) {
    if (state.healthStats.length < 2) return const SizedBox.shrink();

    return Row(
      children: [
        // Steps stat card (first card)
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF), // Light blue background
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with icon and goal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.directions_walk,
                      color: Color(0xFF3B82F6),
                      size: 20,
                    ),
                    const Text(
                      'Daily Goal',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Value
                const Text(
                  '6,234',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Unit
                Text(
                  'steps today',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: const LinearProgressIndicator(
                    value: 0.62, // 6,234 / 10,000
                    backgroundColor: Color(0xFFBFDBFE),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Water intake stat card (second card)
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFECFEFF), // Light cyan background
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with icon and goal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.water_drop_outlined,
                      color: Color(0xFF06B6D4),
                      size: 20,
                    ),
                    const Text(
                      '2L Goal',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF06B6D4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Value
                const Text(
                  '1.2L',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Unit
                Text(
                  'water intake',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: const LinearProgressIndicator(
                    value: 0.6, // 1.2 / 2.0
                    backgroundColor: Color(0xFFB5EDF8),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF06B6D4)),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMoodActivityCard(BuildContext context, DashboardState state) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            "Today's Mood & Activity",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          // Mood, activity and heart rate indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Mood
              _buildCircleIndicator(
                context,
                backgroundColor: const Color(0xFFFEF3C7),
                iconColor: const Color(0xFFF59E0B),
                icon: Icons.sentiment_satisfied_alt_outlined,
                label: 'Happy',
              ),
              // Activity
              _buildCircleIndicator(
                context,
                backgroundColor: const Color(0xFFD1FAE5),
                iconColor: const Color(0xFF10B981),
                icon: Icons.fitness_center,
                label: '45min',
              ),
              // Heart Rate
              _buildCircleIndicator(
                context,
                backgroundColor: const Color(0xFFEDE9FE),
                iconColor: const Color(0xFF8B5CF6),
                icon: Icons.favorite,
                label: '125 bpm',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIndicator(
    BuildContext context, {
    required Color backgroundColor,
    required Color iconColor,
    required IconData icon,
    required String label,
  }) {
    return Column(
      children: [
        // Circle with icon
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Label
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildTasksSection(BuildContext context, DashboardState state) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and see all button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today's Tasks",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('See All tasks tapped')),
                  );
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Tasks
          ...state.tasks.map((task) => _buildTaskItem(context, task)).toList(),
        ],
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, Task task) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          // Checkbox
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                context.read<DashboardBloc>().add(
                      UpdateTaskEvent(
                        task: task,
                        isCompleted: value ?? false,
                      ),
                    );
              },
              shape: const CircleBorder(),
              activeColor: Colors.blue,
            ),
          ),
          const SizedBox(width: 12),
          // Task title
          Expanded(
            child: Text(
              task.title,
              style: TextStyle(
                fontSize: 16,
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
                color: task.isCompleted ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
