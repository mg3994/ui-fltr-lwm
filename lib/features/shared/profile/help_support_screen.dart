import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Gap(16),
          _buildExpansionTile(
            'How do I book a mentor?',
            'Browse mentors in the "Discover" tab, select a mentor, and click "Book Session". Choose a date and time that works for you.',
          ),
          _buildExpansionTile(
            'How do I become a mentor?',
            'Go to your profile and toggle "Mentor Mode". You can then set your availability and hourly rate in the dashboard.',
          ),
          _buildExpansionTile(
            'Is there a fee for sessions?',
            'Yes, mentors set their own rates. You will see the price before confirming a booking.',
          ),
          _buildExpansionTile(
            'Can I cancel a session?',
            'Yes, you can cancel a session up to 24 hours in advance for a full refund.',
          ),
          const Gap(32),
          const Text(
            'Contact Us',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Gap(16),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text('Email Support'),
            subtitle: const Text('support@linkwithmentor.com'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: const Text('Live Chat'),
            subtitle: const Text('Available 9 AM - 5 PM EST'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile(String title, String content) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      children: [
        Padding(padding: const EdgeInsets.all(16.0), child: Text(content)),
      ],
    );
  }
}
