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

    // Mock time slots
    final timeSlots = [
      '09:00 AM',
      '10:00 AM',
      '11:00 AM',
      '02:00 PM',
      '03:00 PM',
      '04:00 PM',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Book Session')),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FilledButton(
            onPressed: selectedTimeSlot.value == null
                ? null
                : () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirm Booking'),
                        content: Text(
                          'Book a session with ${mentor.name} on ${DateFormat('MMM d').format(selectedDate.value)} at ${selectedTimeSlot.value}?',
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
                                  content: Text('Booking Request Sent!'),
                                ),
                              );
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    );
                  },
            child: Text('Book for \$${mentor.hourlyRate.toInt()}'),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Mentor Summary
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(mentor.imageUrl),
              ),
              const Gap(16),
              Column(
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
                ],
              ),
            ],
          ),
          const Gap(32),

          // Calendar
          const Text(
            'Select Date',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Gap(16),
          CalendarDatePicker(
            initialDate: selectedDate.value,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)),
            onDateChanged: (date) {
              selectedDate.value = date;
              selectedTimeSlot.value = null; // Reset time slot
            },
          ),

          const Gap(24),

          // Time Slots
          const Text(
            'Available Time Slots',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Gap(16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: timeSlots.map((slot) {
              final isSelected = selectedTimeSlot.value == slot;
              return ChoiceChip(
                label: Text(slot),
                selected: isSelected,
                onSelected: (selected) {
                  selectedTimeSlot.value = selected ? slot : null;
                },
              );
            }).toList(),
          ),

          const Gap(32),

          // Note
          const Text(
            'Add a Note (Optional)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Gap(8),
          TextField(
            controller: noteController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Briefly describe what you want to discuss...',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
