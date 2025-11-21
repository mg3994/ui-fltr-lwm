import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class SettingsScreen extends HookWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationsEnabled = useState(true);
    final emailUpdates = useState(true);
    final darkMode = useState(true);
    final language = useState('English');

    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: ListView(
        children: [
          _buildSectionHeader(context, 'Account'),
          _buildListTile(
            context,
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () {},
          ),
          _buildListTile(
            context,
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {},
          ),
          _buildListTile(
            context,
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy',
            onTap: () {},
          ),
          const Gap(24),
          _buildSectionHeader(context, 'Preferences'),
          SwitchListTile(
            value: notificationsEnabled.value,
            onChanged: (value) => notificationsEnabled.value = value,
            title: const Text('Push Notifications'),
            secondary: const Icon(Icons.notifications_outlined),
          ),
          SwitchListTile(
            value: emailUpdates.value,
            onChanged: (value) => emailUpdates.value = value,
            title: const Text('Email Updates'),
            secondary: const Icon(Icons.email_outlined),
          ),
          SwitchListTile(
            value: darkMode.value,
            onChanged: (value) => darkMode.value = value,
            title: const Text('Dark Mode'),
            secondary: const Icon(Icons.dark_mode_outlined),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: Text(language.value),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Gap(24),
          _buildSectionHeader(context, 'Other'),
          _buildListTile(
            context,
            icon: Icons.info_outline,
            title: 'About App',
            onTap: () {},
          ),
          _buildListTile(
            context,
            icon: Icons.logout,
            title: 'Log Out',
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () {},
          ),
          const Gap(40),
          Center(
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Theme.of(context).colorScheme.onSurface,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
