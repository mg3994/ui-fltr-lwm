import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class MentorApplicationScreen extends HookWidget {
  const MentorApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStep = useState(0);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      appBar: AppBar(title: const Text('Become a Mentor')),
      body: Column(
        children: [
          // Progress Indicator
          LinearProgressIndicator(
            value: (currentStep.value + 1) / 4,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest,
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getStepTitle(currentStep.value),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      _getStepDescription(currentStep.value),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Gap(32),
                    _buildStepContent(currentStep.value, context),
                  ],
                ),
              ),
            ),
          ),

          // Navigation Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (currentStep.value > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => currentStep.value--,
                      child: const Text('Back'),
                    ),
                  ),
                if (currentStep.value > 0) const Gap(16),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      if (currentStep.value < 3) {
                        currentStep.value++;
                      } else {
                        // Submit application
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Application Submitted!'),
                            content: const Text(
                              'Thank you for applying to become a mentor. We\'ll review your application and get back to you within 3-5 business days.',
                            ),
                            actions: [
                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close dialog
                                  Navigator.pop(
                                    context,
                                  ); // Close application screen
                                },
                                child: const Text('Done'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text(
                      currentStep.value == 3 ? 'Submit Application' : 'Next',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return 'Professional Background';
      case 1:
        return 'Expertise & Skills';
      case 2:
        return 'Availability & Pricing';
      case 3:
        return 'Review & Submit';
      default:
        return '';
    }
  }

  String _getStepDescription(int step) {
    switch (step) {
      case 0:
        return 'Tell us about your professional experience';
      case 1:
        return 'What can you teach?';
      case 2:
        return 'Set your schedule and rates';
      case 3:
        return 'Review your application before submitting';
      default:
        return '';
    }
  }

  Widget _buildStepContent(int step, BuildContext context) {
    switch (step) {
      case 0:
        return const Column(
          children: [
            _CustomTextField(label: 'Current Job Title', icon: Icons.work),
            Gap(16),
            _CustomTextField(label: 'Company', icon: Icons.business),
            Gap(16),
            _CustomTextField(
              label: 'Years of Experience',
              icon: Icons.timeline,
            ),
            Gap(16),
            _CustomTextField(label: 'LinkedIn Profile URL', icon: Icons.link),
            Gap(16),
            _CustomTextField(
              label: 'Professional Bio',
              icon: Icons.description,
              maxLines: 4,
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _CustomTextField(
              label: 'Primary Expertise',
              icon: Icons.star,
            ),
            const Gap(16),
            const Text(
              'Select Skills',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Wrap(
              spacing: 8,
              children:
                  ['Flutter', 'React', 'Node.js', 'Python', 'AWS', 'UI/UX']
                      .map(
                        (skill) => FilterChip(
                          label: Text(skill),
                          selected: false,
                          onSelected: (selected) {},
                        ),
                      )
                      .toList(),
            ),
            const Gap(16),
            const _CustomTextField(
              label: 'What makes you a great mentor?',
              icon: Icons.lightbulb,
              maxLines: 4,
            ),
          ],
        );
      case 2:
        return const Column(
          children: [
            _CustomTextField(
              label: 'Hourly Rate (USD)',
              icon: Icons.attach_money,
            ),
            Gap(16),
            Text(
              'Available Days',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Gap(8),
            // Day selection would go here
            Gap(16),
            _CustomTextField(
              label: 'Preferred Session Duration (minutes)',
              icon: Icons.timer,
            ),
          ],
        );
      case 3:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: const Column(
            children: [
              Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
              Gap(16),
              Text(
                'Application Ready',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Gap(8),
              Text(
                'Please review all information before submitting your mentor application.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final int maxLines;

  const _CustomTextField({
    required this.label,
    required this.icon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
