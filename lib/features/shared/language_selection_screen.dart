import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class LanguageSelectionScreen extends HookWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedLanguage = useState('English');

    final languages = [
      {'name': 'English', 'native': 'English', 'code': 'en', 'flag': '🇺🇸'},
      {'name': 'Spanish', 'native': 'Español', 'code': 'es', 'flag': '🇪🇸'},
      {'name': 'French', 'native': 'Français', 'code': 'fr', 'flag': '🇫🇷'},
      {'name': 'German', 'native': 'Deutsch', 'code': 'de', 'flag': '🇩🇪'},
      {'name': 'Italian', 'native': 'Italiano', 'code': 'it', 'flag': '🇮🇹'},
      {
        'name': 'Portuguese',
        'native': 'Português',
        'code': 'pt',
        'flag': '🇵🇹',
      },
      {'name': 'Russian', 'native': 'Русский', 'code': 'ru', 'flag': '🇷🇺'},
      {'name': 'Chinese', 'native': '中文', 'code': 'zh', 'flag': '🇨🇳'},
      {'name': 'Japanese', 'native': '日本語', 'code': 'ja', 'flag': '🇯🇵'},
      {'name': 'Korean', 'native': '한국어', 'code': 'ko', 'flag': '🇰🇷'},
      {'name': 'Arabic', 'native': 'العربية', 'code': 'ar', 'flag': '🇸🇦'},
      {'name': 'Hindi', 'native': 'हिन्दी', 'code': 'hi', 'flag': '🇮🇳'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Language')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Select Your Language',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          Text(
            'Choose your preferred language for the app',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const Gap(24),

          ...languages.map((language) {
            final isSelected = selectedLanguage.value == language['name'];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Text(
                  language['flag'] as String,
                  style: const TextStyle(fontSize: 32),
                ),
                title: Text(language['name'] as String),
                subtitle: Text(language['native'] as String),
                trailing: isSelected
                    ? Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () {
                  selectedLanguage.value = language['name'] as String;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Language changed to ${language['name']}'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
