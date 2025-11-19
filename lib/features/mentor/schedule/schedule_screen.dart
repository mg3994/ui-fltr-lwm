import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class ScheduleScreen extends HookWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDays = useState<Set<int>>({1, 3, 5}); // Mon, Wed, Fri
    final hourlyRate = useTextEditingController(text: '50');

    return Scaffold(
      appBar: AppBar(title: const Text('Availability & Pricing')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Set Hourly Rate',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          TextField(
            controller: hourlyRate,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: '\$ ',
              suffixText: '/ hr',
              border: OutlineInputBorder(),
              helperText: 'This is your base rate for mentorship sessions.',
            ),
          ),

          const Gap(32),

          const Text(
            'Weekly Availability',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          const Text(
            'Select days you are available to mentor.',
            style: TextStyle(color: Colors.grey),
          ),
          const Gap(16),

          Wrap(
            spacing: 8,
            children: List.generate(7, (index) {
              final dayName = [
                'Sun',
                'Mon',
                'Tue',
                'Wed',
                'Thu',
                'Fri',
                'Sat',
              ][index];
              final isSelected = selectedDays.value.contains(index);

              return FilterChip(
                label: Text(dayName),
                selected: isSelected,
                onSelected: (selected) {
                  final newSet = Set<int>.from(selectedDays.value);
                  if (selected) {
                    newSet.add(index);
                  } else {
                    newSet.remove(index);
                  }
                  selectedDays.value = newSet;
                },
              );
            }),
          ),

          const Gap(24),

          if (selectedDays.value.isNotEmpty) ...[
            const Text(
              'Time Blocks',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Gap(12),
            ...selectedDays.value.map((dayIndex) {
              final dayName = [
                'Sunday',
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
                'Saturday',
              ][dayIndex];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          dayName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          children: [
                            Chip(
                              label: const Text('9:00 AM - 12:00 PM'),
                              onDeleted: () {},
                            ),
                            ActionChip(
                              avatar: const Icon(Icons.add, size: 16),
                              label: const Text('Add'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],

          const Gap(32),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Availability Saved!')),
              );
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
