import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SettingsScreen extends HookWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationsEnabled = useState(true);
    final darkMode = useState(false);
    final emailUpdates = useState(true);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive alerts for sessions and messages'),
            value: notificationsEnabled.value,
            onChanged: (val) => notificationsEnabled.value = val,
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark theme'),
            value: darkMode.value,
            onChanged: (val) => darkMode.value = val,
          ),
          SwitchListTile(
            title: const Text('Email Updates'),
            subtitle: const Text('Receive newsletters and product updates'),
            value: emailUpdates.value,
            onChanged: (val) => emailUpdates.value = val,
          ),
          const Divider(),
          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            title: const Text('App Version'),
            subtitle: const Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}
