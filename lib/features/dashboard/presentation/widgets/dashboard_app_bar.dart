import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sevenhealth/core/theme/app_theme.dart';
import 'package:intl/intl.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String? avatarUrl;
  final VoidCallback onNotificationTap;

  const DashboardAppBar({
    super.key,
    required this.userName,
    this.avatarUrl,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    // Get today's date in the format "Month d, yyyy"
    final today = DateFormat('MMMM d, yyyy').format(DateTime.now());

    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Avatar and greeting
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 16,
                  backgroundImage: avatarUrl != null
                      ? NetworkImage(avatarUrl!) as ImageProvider
                      : const AssetImage('assets/images/default_avatar.png'),
                  backgroundColor: Colors.grey.shade200,
                ),

                SizedBox(width: AppTheme.spacingSm),

                // User info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, $userName!',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      today,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Notification button
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.bell, size: 18),
              color: Colors.grey.shade600,
              onPressed: onNotificationTap,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: Colors.grey.shade200,
          height: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
