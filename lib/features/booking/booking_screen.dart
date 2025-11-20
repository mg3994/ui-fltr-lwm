import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:linkwithmentor/core/data/mock_data.dart';

class BookingScreen extends HookWidget {
  final Mentor mentor;
  const BookingScreen({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    final selectedDate = useState(DateTime.now());
    final selectedTimeSlot = useState<String?>(null);
    final noteController = useTextEditingController();

    // Generate next 14 days
    final dates = List.generate(14, (index) {
      return DateTime.now().add(Duration(days: index));
    });

    // Mock time slots
    final timeSlots = [
      '09:00 AM',
      '10:00 AM',
      '11:00 AM',
      '02:00 PM',
      '03:00 PM',
      '04:00 PM',
      '05:00 PM',
      '06:00 PM',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Book Session')),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
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
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '\$${mentor.hourlyRate.toInt()}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  FilledButton(
                    onPressed: selectedTimeSlot.value == null
                        ? null
                        : () {
                            _showConfirmationDialog(
                              context,
                              selectedDate.value,
                              selectedTimeSlot.value!,
                            );
                          },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Confirm Booking'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Mentor Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(mentor.imageUrl),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mentor.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        mentor.title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const Gap(4),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const Gap(4),
                          Text(
                            '${mentor.rating} (${mentor.reviewCount} reviews)',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(24),

          // Date Selector
          const Text(
            'Select Date',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Gap(16),
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              separatorBuilder: (context, index) => const Gap(12),
              itemBuilder: (context, index) {
                final date = dates[index];
                final isSelected =
                    date.day == selectedDate.value.day &&
                    date.month == selectedDate.value.month;

                return InkWell(
                  onTap: () {
                    selectedDate.value = date;
                    selectedTimeSlot.value = null;
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(16),
                      border: isSelected
                          ? null
                          : Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.outlineVariant,
                            ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('EEE').format(date),
                          style: TextStyle(
                            color: isSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const Gap(24),

          // Time Slots
          const Text(
            'Available Time',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Gap(16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: timeSlots.length,
            itemBuilder: (context, index) {
              final slot = timeSlots[index];
              final isSelected = selectedTimeSlot.value == slot;
              return InkWell(
                onTap: () => selectedTimeSlot.value = slot,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.outlineVariant,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      slot,
                      style: TextStyle(
                        color: isSelected
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const Gap(24),

          // Note
          const Text(
            'Add a Note',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Gap(16),
          TextField(
            controller: noteController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Briefly describe what you want to discuss...',
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    DateTime date,
    String time,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.calendar_today, size: 48),
        title: const Text('Confirm Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure you want to book this session?'),
            const Gap(16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _DetailRow(
                    icon: Icons.person,
                    label: 'Mentor',
                    value: mentor.name,
                  ),
                  const Gap(8),
                  _DetailRow(
                    icon: Icons.calendar_month,
                    label: 'Date',
                    value: DateFormat('EEE, MMM d, y').format(date),
                  ),
                  const Gap(8),
                  _DetailRow(
                    icon: Icons.access_time,
                    label: 'Time',
                    value: time,
                  ),
                  const Gap(8),
                  _DetailRow(
                    icon: Icons.attach_money,
                    label: 'Price',
                    value: '\$${mentor.hourlyRate.toInt()}',
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close booking screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking Request Sent Successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Confirm Payment'),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const Gap(8),
        Text(
          '$label:',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
        ),
        const Spacer(),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
