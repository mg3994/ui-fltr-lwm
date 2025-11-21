import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../core/services/webrtc_service.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveSessionScreen extends StatefulWidget {
  const LiveSessionScreen({Key? key, required this.sessionId})
    : super(key: key);
  final String sessionId;

  @override
  State<LiveSessionScreen> createState() => _LiveSessionScreenState();
}

class _LiveSessionScreenState extends State<LiveSessionScreen>
    with SingleTickerProviderStateMixin {
  final _webRTC = webRTCService; // singleton from webrtc_service.dart
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // start the call automatically
    _webRTC.startCall();
  }

  @override
  void dispose() {
    _webRTC.hangUp();
    _ctrl.dispose();
    super.dispose();
  }

  Widget _buildRemoteView() {
    return StreamBuilder<MediaStream>(
      stream: _webRTC.onRemoteStream,
      builder: (c, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final renderer = RTCVideoRenderer()
          ..srcObject = snapshot.data!
          ..initialize();
        return RTCVideoView(
          renderer,
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        );
      },
    );
  }

  Widget _buildLocalPiP() {
    return StreamBuilder<MediaStream>(
      stream: _webRTC.onLocalStream,
      builder: (c, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        final renderer = RTCVideoRenderer()
          ..srcObject = snapshot.data!
          ..initialize();
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 120,
            height: 160,
            child: RTCVideoView(
              renderer,
              mirror: true,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          ),
        );
      },
    );
  }

  Widget _controlBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.35),
            borderRadius: BorderRadius.circular(30),
            // glass‑morphism blur effect
            backgroundBlendMode: BlendMode.overlay,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _iconButton(
                icon: Icons.mic,
                onTap: () {
                  _webRTC.toggleMic();
                  _ctrl.forward().then((_) => _ctrl.reverse());
                },
              ),
              const SizedBox(width: 24),
              _iconButton(
                icon: Icons.videocam,
                onTap: () {
                  _webRTC.toggleCamera();
                  _ctrl.forward().then((_) => _ctrl.reverse());
                },
              ),
              const SizedBox(width: 24),
              _iconButton(
                icon: Icons.call_end,
                color: Colors.redAccent,
                onTap: () async {
                  await _webRTC.hangUp();
                  if (mounted) Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
    Color color = Colors.white,
    required VoidCallback onTap,
  }) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 1.0,
        end: 1.2,
      ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack)),
      child: IconButton(
        icon: Icon(icon, color: color, size: 28),
        onPressed: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Remote video (full screen)
          Positioned.fill(child: _buildRemoteView()),
          // Local PiP in top‑right
          Positioned(top: 48, right: 24, child: _buildLocalPiP()),
          // Gradient overlay for premium look
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.15),
                  Theme.of(context).colorScheme.surface.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Control bar at bottom
          _controlBar(),
        ],
      ),
    );
  }
}
