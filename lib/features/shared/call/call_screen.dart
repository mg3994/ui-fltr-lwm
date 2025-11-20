import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class CallScreen extends HookWidget {
  final String userName;
  final String userImage;

  const CallScreen({
    super.key,
    required this.userName,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    final isMuted = useState(false);
    final isVideoOff = useState(false);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Remote Video (Full Screen)
          Image.network(
            userImage,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Colors.grey[900]),
          ),

          // Overlay Gradient
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black54, Colors.transparent, Colors.black54],
              ),
            ),
          ),

          // Header
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.fiber_manual_record,
                            color: Colors.red,
                            size: 12,
                          ),
                          Gap(8),
                          Text('05:23', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Local Video (Inset)
          Positioned(
            right: 16,
            bottom: 120,
            child: Container(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24),
                boxShadow: const [
                  BoxShadow(color: Colors.black45, blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: isVideoOff.value
                    ? const Center(
                        child: Icon(Icons.videocam_off, color: Colors.white),
                      )
                    : Image.network(
                        'https://i.pravatar.cc/150?u=99', // Self
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),

          // Controls
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton.filledTonal(
                    onPressed: () => isMuted.value = !isMuted.value,
                    style: IconButton.styleFrom(
                      backgroundColor: isMuted.value
                          ? Colors.white
                          : Colors.white24,
                      foregroundColor: isMuted.value
                          ? Colors.black
                          : Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                    icon: Icon(isMuted.value ? Icons.mic_off : Icons.mic),
                  ),
                  IconButton.filled(
                    onPressed: () => Navigator.pop(context),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.all(24),
                    ),
                    icon: const Icon(Icons.call_end, size: 32),
                  ),
                  IconButton.filledTonal(
                    onPressed: () => isVideoOff.value = !isVideoOff.value,
                    style: IconButton.styleFrom(
                      backgroundColor: isVideoOff.value
                          ? Colors.white
                          : Colors.white24,
                      foregroundColor: isVideoOff.value
                          ? Colors.black
                          : Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                    icon: Icon(
                      isVideoOff.value ? Icons.videocam_off : Icons.videocam,
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

