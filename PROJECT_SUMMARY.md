# LinkWithMentor - Flutter UI Project

## Project Overview
**LinkWithMentor** is a comprehensive dual-role (Mentor/Mentee) Flutter application for connecting mentors and mentees in a professional mentorship platform. The app features a modern, responsive UI with platform-specific aesthetics, clean animations, and reactive state management.

## Tech Stack
- **Framework**: Flutter (Web, iOS, Android)
- **State Management**: `signals_flutter` + `signal_hooks` + `flutter_hooks`
- **Theming**: `flex_color_scheme` for advanced Material Design 3 theming
- **Typography**: `google_fonts` (configured but not yet applied globally)
- **Utilities**: `gap` for spacing, `intl` for date formatting

## Project Structure

```
lib/
├── core/
│   ├── config/
│   │   └── flavor.dart                 # Environment configuration (dev/staging/prod)
│   ├── data/
│   │   └── mock_data.dart              # Mock data models (Mentor, Session)
│   ├── state/
│   │   └── app_state.dart              # Global state management (mentor mode toggle)
│   └── theme/
│       ├── app_theme.dart              # Light/Dark theme configuration
│       └── brand_theme.dart            # Custom theme extension
│
├── features/
│   ├── auth/
│   │   ├── onboarding_screen.dart      # 3-step onboarding slider
│   │   └── login_screen.dart           # Login/Signup screen
│   │
│   ├── mentee/
│   │   └── home/
│   │       ├── home_screen.dart        # Mentor discovery with search & filters
│   │       └── mentor_profile_screen.dart  # Detailed mentor profile
│   │
│   ├── mentor/
│   │   ├── dashboard/
│   │   │   ├── mentor_dashboard_screen.dart  # Earnings, sessions, requests
│   │   │   └── payouts_screen.dart     # Transaction history
│   │   └── schedule/
│   │       └── schedule_screen.dart    # Set availability & hourly rate
│   │
│   ├── shared/
│   │   ├── main_screen.dart            # Bottom navigation hub
│   │   ├── sessions_screen.dart        # Upcoming/Past sessions
│   │   ├── session_details_screen.dart # Session details & actions
│   │   ├── review_screen.dart          # Rate mentor after session
│   │   ├── chat/
│   │   │   ├── chat_list_screen.dart   # Conversations list
│   │   │   └── chat_screen.dart        # 1-on-1 messaging
│   │   ├── call/
│   │   │   └── call_screen.dart        # WebRTC-style video call UI
│   │   └── profile/
│   │       ├── profile_screen.dart     # User profile & role toggle
│   │       ├── edit_profile_screen.dart # Edit user details
│   │       ├── settings_screen.dart    # App settings
│   │       └── help_support_screen.dart # FAQ & contact
│   │
│   ├── booking/
│   │   └── booking_screen.dart         # Calendar & time slot selection
│   │
│   ├── community/
│   │   ├── forum_screen.dart           # Q&A forum feed
│   │   ├── create_post_screen.dart     # Ask new question
│   │   └── post_details_screen.dart    # Question with answers
│   │
│   ├── tools/
│   │   ├── resume_builder_screen.dart  # Multi-step resume wizard
│   │   ├── portfolio_builder_screen.dart # Project showcase builder
│   │   └── goals_screen.dart           # Learning goals tracker
│   │
│   └── notifications/
│       └── notifications_screen.dart   # Push notifications list
│
└── main.dart                           # App entry point
```

## Key Features

### 🎯 Dual-Role System
- **Mentor Mode**: Dashboard, availability management, request handling, payouts
- **Mentee Mode**: Mentor discovery, booking, learning tools
- **Seamless Toggle**: Switch roles instantly from profile screen

### 🔍 Mentee Features
1. **Discovery & Search**
   - Search bar with category filters
   - Featured mentors carousel
   - Mentor cards with ratings, skills, hourly rate
   
2. **Mentor Profiles**
   - Detailed bio, skills, certifications
   - Reviews & ratings
   - Schedule preview
   - Direct booking & messaging

3. **Booking System**
   - Calendar date picker
   - Available time slots
   - Session notes
   - Confirmation dialog

4. **Learning Tools**
   - **Resume Builder**: 4-step wizard (Personal Info → Experience → Education → Review)
   - **Portfolio Builder**: Add projects with images & descriptions
   - **Community Forum**: Ask questions, browse by tags, upvote/downvote

### 👨‍🏫 Mentor Features
1. **Dashboard**
   - Earnings overview
   - Upcoming sessions count
   - Pending booking requests (Accept/Reject)
   
2. **Availability Management**
   - Set hourly rate
   - Select available days
   - Define time blocks

3. **Payouts**
   - Current balance
   - Withdraw funds
   - Transaction history

### 💬 Communication
1. **In-App Messaging**
   - Real-time chat UI
   - Message history
   - Quick actions (video/voice call)

2. **Video Calls**
   - Full-screen WebRTC-style interface
   - Remote & local video feeds
   - Mute, video toggle, end call controls

### 📅 Session Management
1. **Sessions List**
   - Segmented control (Upcoming/Past)
   - Session cards with mentor info, date, topic
   - Context-aware CTAs ("Join Call" vs "View History")

2. **Session Details**
   - Full session information
   - Join call (upcoming)
   - Cancel session (upcoming)
   - Leave review (past)
   - View receipt (past)

### 🌐 Community
1. **Q&A Forum**
   - Browse questions by tag
   - Upvote/downvote
   - View answer count
   - Create new posts

2. **Post Details**
   - Full question with tags
   - Answers list
   - Add new answer

### ⚙️ Settings & Support
- **Profile Management**: Edit name, bio, skills
- **Settings**: Notifications, dark mode, email preferences
- **Help & Support**: FAQ, email support, live chat
- **Notifications**: Session confirmations, messages, payments

### 🔍 Advanced Features (NEW)
1. **Global Search**
   - Search across mentors, sessions, questions, and resources
   - Filter by type (All, Mentors, Sessions, Questions, Resources)
   - Real-time search results
   - Type-specific result cards

2. **Goals Tracking**
   - Set and track learning goals
   - Visual progress indicators
   - Category-based organization
   - Add custom goals
   - Delete completed goals

3. **Analytics Dashboard** (Mentor-only)
   - Key metrics (Sessions, Earnings, Rating, Response Time)
   - Session activity bar chart
   - Most requested skills breakdown
   - Recent reviews display
   - Period selection (Week/Month/Year)

## State Management

### Global State (`AppState`)
```dart
class AppState {
  static final instance = AppState._();
  
  final isMentorMode = signal(false);
  final userName = signal('Manish Kumar');
  final userAvatar = signal('https://i.pravatar.cc/150?u=1');
}
```

### Local State (Hooks)
- `useState`: Component-level reactive state
- `useTextEditingController`: Form inputs
- `usePageController`: Onboarding slider
- `useMemoized`: Cached computations

## Navigation Flow

```
OnboardingScreen
    ↓
LoginScreen
    ↓
MainScreen (Bottom Nav)
    ├── Discover/Dashboard (role-dependent)
    │   ├── MentorProfileScreen
    │   │   └── BookingScreen
    │   └── MentorDashboardScreen
    │       ├── ScheduleScreen
    │       └── PayoutsScreen
    ├── Sessions
    │   └── SessionDetailsScreen
    │       ├── CallScreen
    │       └── ReviewScreen
    ├── Messages
    │   └── ChatScreen
    │       └── CallScreen
    └── Profile
        ├── EditProfileScreen
        ├── SettingsScreen
        ├── HelpSupportScreen
        ├── PayoutsScreen
        ├── ForumScreen
        │   ├── CreatePostScreen
        │   └── PostDetailsScreen
        ├── ResumeBuilderScreen
        └── PortfolioBuilderScreen
```

## Mock Data

### Mentors
- 4 sample mentors with varied skills (Flutter, Design, Backend, Mobile Architecture)
- Ratings: 4.7 - 5.0
- Hourly rates: $45 - $80

### Sessions
- 2 sample sessions (1 upcoming, 1 past)
- Linked to mock mentors

## Theming

### Colors
- **Light Mode**: Blue primary with Material 3 color scheme
- **Dark Mode**: Deep blue with high contrast
- **Brand Extension**: Custom `brandColor` and `isDarkThemeMode` properties

### Typography
- Default Material Design 3 typography
- `google_fonts` package ready for custom fonts

## Running the Project

```bash
# Install dependencies
flutter pub get

# Run on web (Edge)
flutter run -d edge

# Run on other platforms
flutter run -d chrome
flutter run -d windows
flutter run -d android
flutter run -d ios

# Analyze code
flutter analyze

# Build for production
flutter build web
flutter build apk
flutter build ios
```

## Known Issues & Future Enhancements

### Minor Warnings (Non-blocking)
- `withOpacity` deprecation warnings (use `Color.from` instead)
- Unnecessary underscores in private class names

### Future Enhancements
1. **API Integration**: Replace mock data with real backend
2. **WebRTC**: Implement actual video/audio calling
3. **Animations**: Add custom page transitions and micro-interactions
4. **Google Fonts**: Apply custom font family globally
5. **Accessibility**: WCAG compliance, screen reader support
6. **Localization**: Multi-language support
7. **Payment Integration**: Stripe/PayPal for real transactions
8. **Push Notifications**: Firebase Cloud Messaging
9. **Analytics**: Track user behavior and engagement
10. **Testing**: Unit, widget, and integration tests

## Git Repository
- **URL**: https://github.com/mg3994/ui-fltr-lwm.git
- **Branch**: main
- **Latest Commit**: "feat: Add Search, Goals, and Analytics features"

## Recent Updates (Latest)

### Version 1.1.0 - Advanced Features
✅ **New Features**:
- Global Search with multi-type filtering
- Goals tracking system with progress visualization
- Analytics dashboard for mentors
- Comprehensive PROJECT_SUMMARY.md

✅ **Bug Fixes**:
- Fixed `session.date` to `session.dateTime` property error
- Removed unused imports

✅ **Improvements**:
- Enhanced Profile menu with new tools
- Conditional Analytics menu (mentor-only)
- Better code organization

## Development Notes

### Code Quality
- ✅ No critical errors
- ✅ All screens implemented
- ✅ Navigation fully connected
- ⚠️ 24 info-level warnings (non-blocking)

### Performance
- Optimized list rendering with `ListView.builder`
- Efficient state updates with signals
- Minimal rebuilds with `watch(context)`

### Best Practices
- Separation of concerns (features, core, shared)
- Reusable components
- Consistent naming conventions
- Type-safe mock data models

---

**Built with ❤️ using Flutter**
