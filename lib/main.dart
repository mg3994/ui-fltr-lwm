import 'package:flutter/material.dart';
import 'package:linkwithmentor/core/theme/app_theme.dart';
import 'package:linkwithmentor/features/auth/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinkWithMentor',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.light,
      home: const OnboardingScreen(),
    );
  }
}
