# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

- **Build/Run**: `flutter run`
- **Tests**:
  - Run all tests: `flutter test`
  - Run a single test file: `flutter test test/widget_test.dart`
- **Lint/Analyze**: `flutter analyze`
- **Dependencies**:
  - Get packages: `flutter pub get`
  - Upgrade packages: `flutter pub upgrade`
- **Code Generation** (if applicable): `flutter pub run build_runner build`

## Code Architecture

- **Entry Point**: `lib/main.dart`
- **Main Components**:
  - `MoodTrackerApp`: Root widget, defines the dark theme with neon accents.
  - `MainScreen`: Handles global state (mood logs, quiz progress, navigation).
  - `WelcomeScreen`: Animated onboarding with floating blobs.
  - `MoodDashboard`: Home dashboard with interactive mood selection, metrics, and a daily quiz.
  - `CalendarScreen`: Displays a mood calendar grid and monthly summary.
  - `JournalScreen`: List of detailed mood logs with notes.
  - `FocusDiscoveryScreen`: Personalized recommendations and focus scores.
- **State Management**: Uses local `setState` in `MainScreen` for simple data persistence across tabs during the session.
- **Styling**: High-contrast dark theme using `0xFFCCFF00` (Neon Green) as the primary brand color.

