import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRTCService {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;

  final _onRemoteStream = StreamController<MediaStream>.broadcast();
  Stream<MediaStream> get onRemoteStream => _onRemoteStream.stream;

  final _onLocalStream = StreamController<MediaStream>.broadcast();
  Stream<MediaStream> get onLocalStream => _onLocalStream.stream;

  final _configuration = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
    ],
  };

  Future<void> initialize() async {
    // Get user media
    final mediaConstraints = {
      'audio': true,
      'video': {'facingMode': 'user'},
    };

    try {
      _localStream = await navigator.mediaDevices.getUserMedia(
        mediaConstraints,
      );
      _onLocalStream.add(_localStream!);
    } catch (e) {
      debugPrint('Error getting user media: $e');
    }
  }

  Future<void> startCall() async {
    if (_localStream == null) await initialize();

    _peerConnection = await createPeerConnection(_configuration);

    _peerConnection!.onIceCandidate = (candidate) {
      // Send candidate to remote peer via signaling
      debugPrint('ICE Candidate: ${candidate.candidate}');
    };

    _peerConnection!.onTrack = (event) {
      if (event.streams.isNotEmpty) {
        _remoteStream = event.streams[0];
        _onRemoteStream.add(_remoteStream!);
      }
    };

    _localStream?.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });

    // Create Offer
    final offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);

    // Simulate receiving an answer (Mock Signaling)
    // In a real app, you would send the offer to the signaling server
    // and wait for an answer.
    _simulateRemotePeer();
  }

  // Mocking a remote peer for testing UI
  Future<void> _simulateRemotePeer() async {
    await Future.delayed(const Duration(seconds: 2));
    // Just loopback the local stream as remote for now to test UI
    if (_localStream != null) {
      _onRemoteStream.add(_localStream!);
    }
  }

  void toggleMic() {
    if (_localStream != null) {
      final audioTrack = _localStream!.getAudioTracks()[0];
      audioTrack.enabled = !audioTrack.enabled;
    }
  }

  void toggleCamera() {
    if (_localStream != null) {
      final videoTrack = _localStream!.getVideoTracks()[0];
      videoTrack.enabled = !videoTrack.enabled;
    }
  }

  Future<void> hangUp() async {
    await _localStream?.dispose();
    await _remoteStream?.dispose();
    await _peerConnection?.close();
    _localStream = null;
    _remoteStream = null;
    _peerConnection = null;
  }
}

final webRTCService = WebRTCService();
