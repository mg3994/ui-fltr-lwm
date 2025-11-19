import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class TermsOfServiceScreen extends HookWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Service')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Terms of Service',
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
            title: '1. Acceptance of Terms',
            content:
                'By accessing and using LinkWithMentor, you accept and agree to be bound by '
                'the terms and provision of this agreement. If you do not agree to these terms, '
                'please do not use our services.',
          ),

          _Section(
            title: '2. User Accounts',
            content:
                'To use our services, you must:\n\n'
                '• Be at least 13 years old\n'
                '• Provide accurate and complete information\n'
                '• Maintain the security of your account\n'
                '• Accept responsibility for all activities under your account\n'
                '• Notify us immediately of any unauthorized use',
          ),

          _Section(
            title: '3. Mentor and Mentee Responsibilities',
            content:
                'Mentors agree to:\n'
                '• Provide accurate information about their expertise\n'
                '• Conduct sessions professionally\n'
                '• Respect scheduled session times\n'
                '• Maintain confidentiality\n\n'
                'Mentees agree to:\n'
                '• Attend scheduled sessions on time\n'
                '• Treat mentors with respect\n'
                '• Provide honest feedback',
          ),

          _Section(
            title: '4. Payment Terms',
            content:
                'Payment terms include:\n\n'
                '• All fees are in USD unless otherwise stated\n'
                '• Payments are processed securely through our payment partners\n'
                '• Mentors receive payment after session completion\n'
                '• Platform fees apply to all transactions\n'
                '• Refunds are subject to our refund policy',
          ),

          _Section(
            title: '5. Prohibited Activities',
            content:
                'You may not:\n\n'
                '• Use the platform for illegal purposes\n'
                '• Harass, abuse, or harm other users\n'
                '• Share inappropriate content\n'
                '• Attempt to gain unauthorized access\n'
                '• Impersonate others\n'
                '• Spam or send unsolicited messages',
          ),

          _Section(
            title: '6. Intellectual Property',
            content:
                'All content on LinkWithMentor, including text, graphics, logos, and software, '
                'is the property of LinkWithMentor or its content suppliers and is protected by '
                'copyright and intellectual property laws.',
          ),

          _Section(
            title: '7. Cancellation and Refunds',
            content:
                'Cancellation policy:\n\n'
                '• Sessions can be cancelled up to 24 hours before scheduled time\n'
                '• Full refund for cancellations made 24+ hours in advance\n'
                '• 50% refund for cancellations made 12-24 hours in advance\n'
                '• No refund for cancellations made less than 12 hours in advance',
          ),

          _Section(
            title: '8. Limitation of Liability',
            content:
                'LinkWithMentor is not liable for:\n\n'
                '• Quality of mentoring services provided\n'
                '• Disputes between mentors and mentees\n'
                '• Loss of data or content\n'
                '• Indirect or consequential damages\n\n'
                'Our total liability is limited to the amount paid by you in the past 12 months.',
          ),

          _Section(
            title: '9. Termination',
            content:
                'We reserve the right to suspend or terminate your account if you:\n\n'
                '• Violate these terms of service\n'
                '• Engage in fraudulent activity\n'
                '• Harm the platform or other users\n'
                '• Fail to pay fees when due',
          ),

          _Section(
            title: '10. Changes to Terms',
            content:
                'We may modify these terms at any time. We will notify users of any material '
                'changes via email or platform notification. Continued use of the platform after '
                'changes constitutes acceptance of the new terms.',
          ),

          _Section(
            title: '11. Governing Law',
            content:
                'These terms are governed by the laws of the State of California, USA, '
                'without regard to its conflict of law provisions.',
          ),

          _Section(
            title: '12. Contact Information',
            content:
                'For questions about these terms, please contact us:\n\n'
                'Email: legal@linkwithmentor.com\n'
                'Address: 123 Tech Street, San Francisco, CA 94105\n'
                'Phone: +1 (555) 123-4567',
          ),

          const Gap(24),

          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      'By using LinkWithMentor, you agree to these terms of service.',
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
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
