import 'package:flutter/material.dart';
import 'package:linkwithmentor/core/theme/app_theme.dart';
import 'package:linkwithmentor/features/auth/onboarding_screen.dart';
import 'package:linkwithmentor/features/live_session/live_session_screen.dart';
import 'package:linkwithmentor/features/tools/badges_screen.dart';
import 'package:linkwithmentor/features/tools/career_path_screen.dart';
import 'package:linkwithmentor/features/tools/interview_prep_screen.dart';
import 'package:linkwithmentor/features/tools/skill_assessment_screen.dart';
import 'package:linkwithmentor/features/tools/resume_builder_screen.dart';
import 'package:linkwithmentor/features/shared/feedback_screen.dart';

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
      routes: {
        '/live-session': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as String? ?? '';
          return LiveSessionScreen(sessionId: args);
        },
        '/badges': (context) => const BadgesScreen(),
        '/career-path': (context) => const CareerPathScreen(),
        '/interview-prep': (context) => const InterviewPrepScreen(),
        '/skill-assessment': (context) => const SkillAssessmentScreen(),
        '/resume-builder': (context) => const ResumeBuilderScreen(),
        '/feedback': (context) => const FeedbackScreen(),
      },
    );
  }
}
