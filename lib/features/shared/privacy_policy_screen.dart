import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class PrivacyPolicyScreen extends HookWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Privacy Policy',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          Text(
            'Last updated: January 15, 2024',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const Gap(24),

          _Section(
            title: '1. Information We Collect',
            content:
                'We collect information you provide directly to us, including:\n\n'
                '• Account information (name, email, password)\n'
                '• Profile information (bio, skills, experience)\n'
                '• Payment information (for processing transactions)\n'
                '• Communication data (messages, session recordings)\n'
                '• Usage data (app interactions, preferences)',
          ),

          _Section(
            title: '2. How We Use Your Information',
            content:
                'We use the information we collect to:\n\n'
                '• Provide and improve our services\n'
                '• Process your transactions\n'
                '• Send you updates and notifications\n'
                '• Personalize your experience\n'
                '• Ensure platform safety and security',
          ),

          _Section(
            title: '3. Information Sharing',
            content:
                'We may share your information with:\n\n'
                '• Other users (as part of your public profile)\n'
                '• Service providers (payment processors, analytics)\n'
                '• Legal authorities (when required by law)\n\n'
                'We never sell your personal information to third parties.',
          ),

          _Section(
            title: '4. Data Security',
            content:
                'We implement industry-standard security measures to protect your data:\n\n'
                '• Encryption of data in transit and at rest\n'
                '• Regular security audits\n'
                '• Secure payment processing\n'
                '• Access controls and authentication',
          ),

          _Section(
            title: '5. Your Rights',
            content:
                'You have the right to:\n\n'
                '• Access your personal data\n'
                '• Correct inaccurate information\n'
                '• Delete your account and data\n'
                '• Export your data\n'
                '• Opt-out of marketing communications',
          ),

          _Section(
            title: '6. Cookies and Tracking',
            content:
                'We use cookies and similar technologies to:\n\n'
                '• Remember your preferences\n'
                '• Analyze usage patterns\n'
                '• Improve our services\n'
                '• Provide personalized content\n\n'
                'You can control cookie settings in your browser.',
          ),

          _Section(
            title: '7. Children\'s Privacy',
            content:
                'Our services are not intended for users under 13 years of age. '
                'We do not knowingly collect information from children under 13.',
          ),

          _Section(
            title: '8. Changes to This Policy',
            content:
                'We may update this privacy policy from time to time. '
                'We will notify you of any changes by posting the new policy on this page '
                'and updating the "Last updated" date.',
          ),

          _Section(
            title: '9. Contact Us',
            content:
                'If you have questions about this privacy policy, please contact us:\n\n'
                'Email: privacy@linkwithmentor.com\n'
                'Address: 123 Tech Street, San Francisco, CA 94105',
          ),

          const Gap(24),

          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.shield,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      'Your privacy is important to us. We are committed to protecting your personal information.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String content;

  const _Section({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Gap(12),
          Text(
            content,
            style: TextStyle(
              height: 1.6,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
