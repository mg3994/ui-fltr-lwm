import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class LiveSessionScreen extends HookWidget {
  const LiveSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isConnected = useState(false);
    final participants = useState<List<Map<String, String>>>([
      {'name': 'You', 'avatar': 'https://i.pravatar.cc/100?u=you'},
      {'name': 'Sarah Jenkins', 'avatar': 'https://i.pravatar.cc/100?u=1'},
      {'name': 'David Chen', 'avatar': 'https://i.pravatar.cc/100?u=2'},
    ]);

    return Scaffold(
      body: Stack(
        children: [
          // Video placeholder (would be replaced by WebRTC view)
          Container(
            color: Colors.black,
            child: Center(
              child: Icon(Icons.videocam, color: Colors.white54, size: 80),
            ),
          ),
          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.8),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'Live Session',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      isConnected.value ? Icons.call_end : Icons.call,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () => isConnected.value = !isConnected.value,
                  ),
                ],
              ),
            ),
          ),
          // Participants avatars at bottom
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: participants.value.map((p) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(p['avatar']!),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.chat),
        label: const Text('Open Chat'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
