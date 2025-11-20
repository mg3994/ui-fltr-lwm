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
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: (currentStep.value + 1) / 4),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            builder: (context, value, _) {
              return LinearProgressIndicator(
                value: value,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
                minHeight: 6,
              );
            },
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: SingleChildScrollView(
                key: ValueKey<int>(currentStep.value),
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getStepTitle(currentStep.value),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        _getStepDescription(currentStep.value),
                        style: TextStyle(
                          fontSize: 16,
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
          ),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                if (currentStep.value > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => currentStep.value--,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
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
                          const SnackBar(
                            content: Text('Resume Generated!'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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
            Gap(20),
            _CustomTextField(label: 'Email', icon: Icons.email),
            Gap(20),
            _CustomTextField(label: 'Phone', icon: Icons.phone),
            Gap(20),
            _CustomTextField(label: 'LinkedIn URL', icon: Icons.link),
          ],
        );
      case 1:
        return Column(
          children: [
            const _CustomTextField(label: 'Job Title', icon: Icons.work),
            const Gap(20),
            const _CustomTextField(label: 'Company', icon: Icons.business),
            const Gap(20),
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
            const Gap(20),
            const _CustomTextField(
              label: 'Description',
              icon: Icons.description,
              maxLines: 4,
            ),
            const Gap(32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add Another Position'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        );
      case 2:
        return const Column(
          children: [
            _CustomTextField(label: 'School / University', icon: Icons.school),
            Gap(20),
            _CustomTextField(label: 'Degree', icon: Icons.workspace_premium),
            Gap(20),
            _CustomTextField(
              label: 'Graduation Year',
              icon: Icons.calendar_today,
            ),
          ],
        );
      case 3:
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.picture_as_pdf,
                  size: 48,
                  color: Colors.red,
                ),
              ),
              const Gap(24),
              const Text(
                'Ready to Generate',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Gap(8),
              Text(
                'Your resume has been compiled and is ready for download.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const Gap(24),
              const Divider(),
              const Gap(16),
              _PreviewRow(label: 'Template', value: 'Modern Professional'),
              const Gap(12),
              _PreviewRow(label: 'Format', value: 'PDF (A4)'),
              const Gap(12),
              _PreviewRow(label: 'Size', value: '~1.2 MB'),
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}

class _PreviewRow extends StatelessWidget {
  final String label;
  final String value;

  const _PreviewRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
