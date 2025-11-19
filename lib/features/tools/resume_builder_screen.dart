import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class ResumeBuilderScreen extends HookWidget {
  const ResumeBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStep = useState(0);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      appBar: AppBar(title: const Text('Resume Builder')),
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
                        // Finish
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Resume Generated!')),
                        );
                      }
                    },
                    child: Text(
                      currentStep.value == 3 ? 'Generate PDF' : 'Next',
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
        return 'Personal Info';
      case 1:
        return 'Experience';
      case 2:
        return 'Education';
      case 3:
        return 'Review';
      default:
        return '';
    }
  }

  String _getStepDescription(int step) {
    switch (step) {
      case 0:
        return 'Let\'s start with the basics.';
      case 1:
        return 'Add your relevant work experience.';
      case 2:
        return 'Where did you study?';
      case 3:
        return 'Check everything before generating.';
      default:
        return '';
    }
  }

  Widget _buildStepContent(int step, BuildContext context) {
    switch (step) {
      case 0:
        return const Column(
          children: [
            _CustomTextField(label: 'Full Name', icon: Icons.person),
            Gap(16),
            _CustomTextField(label: 'Email', icon: Icons.email),
            Gap(16),
            _CustomTextField(label: 'Phone', icon: Icons.phone),
            Gap(16),
            _CustomTextField(label: 'LinkedIn URL', icon: Icons.link),
          ],
        );
      case 1:
        return Column(
          children: [
            const _CustomTextField(label: 'Job Title', icon: Icons.work),
            const Gap(16),
            const _CustomTextField(label: 'Company', icon: Icons.business),
            const Gap(16),
            Row(
              children: [
                const Expanded(
                  child: _CustomTextField(
                    label: 'Start Date',
                    icon: Icons.calendar_today,
                  ),
                ),
                const Gap(16),
                const Expanded(
                  child: _CustomTextField(
                    label: 'End Date',
                    icon: Icons.calendar_today,
                  ),
                ),
              ],
            ),
            const Gap(16),
            const _CustomTextField(
              label: 'Description',
              icon: Icons.description,
              maxLines: 3,
            ),
            const Gap(24),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add Another Position'),
            ),
          ],
        );
      case 2:
        return const Column(
          children: [
            _CustomTextField(label: 'School / University', icon: Icons.school),
            Gap(16),
            _CustomTextField(label: 'Degree', icon: Icons.workspace_premium),
            Gap(16),
            _CustomTextField(
              label: 'Graduation Year',
              icon: Icons.calendar_today,
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
              Icon(Icons.picture_as_pdf, size: 64, color: Colors.red),
              Gap(16),
              Text(
                'Preview Available',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text('Your resume is ready to be generated.'),
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
