import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  final Color primaryColor = const Color.fromARGB(255, 10, 29, 86);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Color.fromARGB(255, 10, 29, 86),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Welcome Admin!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'admin@gmail.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            _buildDrawerItem(
              icon: Icons.people,
              title: 'Users',
              onTap: () => context.push('/users'),
            ),

            // _buildDrawerItem(
            //   icon: Icons.settings,
            //   title: 'Settings',
            //   onTap: () => context.push('/settings'),
            // ),
            _buildDrawerItem(
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () => context.push('/notifications'),
            ),

            _buildDrawerItem(
              icon: Icons.notifications,
              title: 'News',
              onTap: () => context.push('/news'),
            ),

            const Spacer(),

            const Divider(),

            // Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => context.go('/login'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      hoverColor: primaryColor.withAlpha(20),
      splashColor: primaryColor.withAlpha(20),
    );
  }
}
