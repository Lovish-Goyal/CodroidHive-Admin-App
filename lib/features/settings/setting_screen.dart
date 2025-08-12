import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Settings'),
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromARGB(255, 10, 29, 86),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Settings Section
            const Text(
              'Account Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSettingOption(
              icon: Icons.person,
              title: 'Profile',
              onTap: () {
                // Navigate to Profile Settings
              },
            ),
            _buildSettingOption(
              icon: Icons.lock,
              title: 'Change Password',
              onTap: () {
                // Navigate to Change Password
              },
            ),
            const Divider(),

            // Notifications Settings Section
            const Text(
              'Notifications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSettingOption(
              icon: Icons.notifications,
              title: 'Enable Notifications',
              onTap: () {
                // Enable/Disable Notifications
              },
            ),
            _buildSettingOption(
              icon: Icons.notifications_off,
              title: 'Mute Notifications',
              onTap: () {
                // Mute Notifications
              },
            ),
            const Divider(),

            // Theme Settings Section
            const Text(
              'Appearance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSettingOption(
              icon: Icons.dark_mode,
              title: 'Dark Mode',
              onTap: () {
                // Toggle Dark Mode
              },
            ),
            _buildSettingOption(
              icon: Icons.light_mode,
              title: 'Light Mode',
              onTap: () {
                // Toggle Light Mode
              },
            ),
            const Divider(),

            // Logout Button Section
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              onTap: () {
                // Handle Logout
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
        leading: Icon(icon, color: const Color.fromARGB(255, 10, 29, 86)),
        title: Text(title),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        hoverColor: Colors.blue.withAlpha(25),
        splashColor: Colors.blue.withAlpha(51));
  }
}
