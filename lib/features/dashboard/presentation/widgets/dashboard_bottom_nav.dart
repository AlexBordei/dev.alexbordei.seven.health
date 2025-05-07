import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sevenhealth/core/theme/app_theme.dart';

enum NavItem {
  home,
  progress,
  calendar,
  profile,
}

class DashboardBottomNav extends StatelessWidget {
  final NavItem selectedItem;
  final Function(NavItem) onNavItemTap;

  const DashboardBottomNav({
    super.key,
    required this.selectedItem,
    required this.onNavItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.spacingMd,
            vertical: AppTheme.spacingSm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                context: context,
                item: NavItem.home,
                icon: FontAwesomeIcons.house,
                label: 'Home',
              ),
              _buildNavItem(
                context: context,
                item: NavItem.progress,
                icon: FontAwesomeIcons.chartLine,
                label: 'Progress',
              ),
              _buildNavItem(
                context: context,
                item: NavItem.calendar,
                icon: FontAwesomeIcons.calendar,
                label: 'Calendar',
              ),
              _buildNavItem(
                context: context,
                item: NavItem.profile,
                icon: FontAwesomeIcons.user,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required NavItem item,
    required IconData icon,
    required String label,
  }) {
    final isSelected = selectedItem == item;
    final color = isSelected ? AppTheme.primaryColor : Colors.grey;

    return InkWell(
      onTap: () => onNavItemTap(item),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingSm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              size: 18,
              color: color,
            ),
            SizedBox(height: AppTheme.spacingXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
