import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class AudioRoomScreen extends HookWidget {
  const AudioRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMuted = useState(false);
    final isHandRaised = useState(false);

    final speakers = [
      {
        'name': 'Sarah Jenkins',
        'role': 'Host',
        'avatar': 'https://i.pravatar.cc/150?u=1',
        'isSpeaking': true,
      },
      {
        'name': 'David Chen',
        'role': 'Speaker',
        'avatar': 'https://i.pravatar.cc/150?u=2',
        'isSpeaking': false,
      },
      {
        'name': 'Emily Davis',
        'role': 'Speaker',
        'avatar': 'https://i.pravatar.cc/150?u=3',
        'isSpeaking': false,
      },
    ];

    final listeners = [
      {'name': 'Michael', 'avatar': 'https://i.pravatar.cc/150?u=4'},
      {'name': 'Jessica', 'avatar': 'https://i.pravatar.cc/150?u=5'},
      {'name': 'Chris', 'avatar': 'https://i.pravatar.cc/150?u=6'},
      {'name': 'Amanda', 'avatar': 'https://i.pravatar.cc/150?u=7'},
      {'name': 'Tom', 'avatar': 'https://i.pravatar.cc/150?u=8'},
      {'name': 'You', 'avatar': 'https://i.pravatar.cc/150?u=0'},
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF1A1A2E),
              Theme.of(
                context,
              ).colorScheme.primaryContainer.withValues(alpha: 0.2),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Gap(8),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Career Growth in 2025',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Tech Talk • 45 Listening',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Speakers Section
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Speakers',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(20),
                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.center,
                          children: speakers.map((speaker) {
                            return _SpeakerAvatar(speaker: speaker);
                          }).toList(),
                        ),
                        const Gap(40),
                        const Text(
                          'Listeners',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(20),
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: listeners.map((listener) {
                            return _ListenerAvatar(listener: listener);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Controls
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF16213E),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton.tonal(
                      onPressed: () => Navigator.pop(context),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red.withValues(alpha: 0.2),
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('Leave'),
                    ),
                    Row(
                      children: [
                        IconButton.filled(
                          onPressed: () => isMuted.value = !isMuted.value,
                          style: IconButton.styleFrom(
                            backgroundColor: isMuted.value
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.1),
                            foregroundColor: isMuted.value
                                ? Colors.black
                                : Colors.white,
                          ),
                          icon: Icon(isMuted.value ? Icons.mic_off : Icons.mic),
                        ),
                        const Gap(16),
                        IconButton.filled(
                          onPressed: () =>
                              isHandRaised.value = !isHandRaised.value,
                          style: IconButton.styleFrom(
                            backgroundColor: isHandRaised.value
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white.withValues(alpha: 0.1),
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.pan_tool),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpeakerAvatar extends StatelessWidget {
  final Map<String, dynamic> speaker;

  const _SpeakerAvatar({required this.speaker});

  @override
  Widget build(BuildContext context) {
    final isSpeaking = speaker['isSpeaking'] as bool;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            if (isSpeaking)
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 1 - value),
                        width: 4 * value,
                      ),
                    ),
                  );
                },
                onEnd: () {}, // Loop animation ideally
              ),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSpeaking
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  width: 3,
                ),
                image: DecorationImage(
                  image: NetworkImage(speaker['avatar'] as String),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.mic, size: 12, color: Colors.white),
              ),
            ),
          ],
        ),
        const Gap(8),
        Text(
          speaker['name'] as String,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          speaker['role'] as String,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _ListenerAvatar extends StatelessWidget {
  final Map<String, dynamic> listener;

  const _ListenerAvatar({required this.listener});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(listener['avatar'] as String),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Gap(8),
        Text(
          listener['name'] as String,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
