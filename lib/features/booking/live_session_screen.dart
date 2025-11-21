import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:gap/gap.dart';
import 'package:linkwithmentor/core/services/webrtc_service.dart';

class LiveSessionScreen extends HookWidget {
  const LiveSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localRenderer = useMemoized(() => RTCVideoRenderer());
    final remoteRenderer = useMemoized(() => RTCVideoRenderer());
    final isMicOn = useState(true);
    final isCameraOn = useState(true);
    final isConnected = useState(false);

    useEffect(() {
      Future<void> initRenderers() async {
        await localRenderer.initialize();
        await remoteRenderer.initialize();

        webRTCService.onLocalStream.listen((stream) {
          localRenderer.srcObject = stream;
        });

        webRTCService.onRemoteStream.listen((stream) {
          remoteRenderer.srcObject = stream;
          isConnected.value = true;
        });

        await webRTCService.initialize();
        await webRTCService.startCall();
      }

      initRenderers();

      return () {
        localRenderer.dispose();
        remoteRenderer.dispose();
        webRTCService.hangUp();
      };
    }, []);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Remote Video (Full Screen)
          Positioned.fill(
            child: isConnected.value
                ? RTCVideoView(
                    remoteRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  )
                : const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
          ),

          // Local Video (Picture in Picture)
          Positioned(
            right: 16,
            top: 60,
            child: Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: RTCVideoView(
                  localRenderer,
                  mirror: true,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              ),
            ),
          ),

          // Controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ControlBtn(
                  icon: isMicOn.value ? Icons.mic : Icons.mic_off,
                  isActive: isMicOn.value,
                  onTap: () {
                    webRTCService.toggleMic();
                    isMicOn.value = !isMicOn.value;
                  },
                ),
                const Gap(24),
                _ControlBtn(
                  icon: Icons.call_end,
                  isActive: false,
                  color: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  size: 72,
                ),
                const Gap(24),
                _ControlBtn(
                  icon: isCameraOn.value ? Icons.videocam : Icons.videocam_off,
                  isActive: isCameraOn.value,
                  onTap: () {
                    webRTCService.toggleCamera();
                    isCameraOn.value = !isCameraOn.value;
                  },
                ),
              ],
            ),
          ),

          // Header Info
          Positioned(
            top: 60,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Gap(8),
                      const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                const Text(
                  'Mentorship Session',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlBtn extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final Color? color;
  final double size;

  const _ControlBtn({
    required this.icon,
    required this.isActive,
    required this.onTap,
    this.color,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color:
              color ??
              (isActive ? Colors.white : Colors.white.withValues(alpha: 0.3)),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: color != null
              ? Colors.white
              : (isActive ? Colors.black : Colors.white),
          size: size * 0.5,
        ),
      ),
    );
  }
}
