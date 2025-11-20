import 'package:signals_flutter/signals_flutter.dart';

// Global state for the application
class AppState {
  // Singleton instance
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  // Signals
  final isMentorMode = signal(false);
  final userAvatar = signal('https://i.pravatar.cc/150?u=99');
  final userName = signal('Manish Kumar');
  final notificationCount = signal(3);
}

final appState = AppState();
