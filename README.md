# Vibex — Mood Tracker & Focus Discovery

![Vibex Banner](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Material 3](https://img.shields.io/badge/Material--3-6750A4?style=for-the-badge&logo=materialdesign&logoColor=white)

> **"Not Sure About Your Mood? Let Us Help!"**

Vibex is a high-contrast, neon-infused mood tracking application built with Flutter. It combines emotional logging with health metrics, micro-quizzes, and personalized focus recommendations to help you understand your mental well-being patterns.

---

## ✨ Key Features

### 🌈 Intelligent Mood Logging
Log your emotions with ease. Choose from interactive mood states and add personalized notes to capture the "why" behind your "how."

### 🧠 Daily Micro-Reflections
An 8-question "Yes/No" quiz designed to help you reflect on essential habits:
- Sleep quality
- Hydration
- Screen breaks
- Physical activity
- Social connection

### 📊 Vitality Metrics
Track more than just feelings. Monitor your **Sleep Duration** and **Stress Indicators** through intuitive, color-coded bar charts integrated directly into your dashboard.

### 📅 Mood Calendar & Analytics
Visualize your emotional journey over time. The monthly grid provides an at-a-glance view of your patterns, helping you identify trends and triggers.

### 🧘 Focus & Discipline
Get personalized recommendations based on your current state:
- Deep Breathing Exercises
- Morning Gratitude Journaling
- Focus Scores and Daily Goals tracking

---

## 🎨 Design Language

Vibex features a bold, high-contrast **Dark Theme** inspired by cyberpunk aesthetics:
- **Primary Color:** Neon Green (`#CCFF00`)
- **Accent Colors:** Electric Orange, Soft Lavender, and Sky Blue.
- **Atmosphere:** Fluid, animated background "blobs" in the onboarding flow for a calming, modern feel.

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Latest stable version)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / VS Code with Flutter extension

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/vibex.git
   cd vibex
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

---

## 🏗️ Architecture

The project follows a clean, single-source-of-truth approach using `StatefulWidget` for immediate session persistence.

- `lib/main.dart`: Entry point and core navigation logic.
- `WelcomeScreen`: Animated onboarding.
- `MoodDashboard`: Core interaction hub.
- `CalendarScreen`: Data visualization.
- `JournalScreen`: History and pattern analysis.
- `FocusDiscoveryScreen`: Actionable insights.

---

## 🛠️ Built With

- **Flutter** - The UI toolkit for beautiful, natively compiled applications.
- **Shared Preferences** - For local data persistence of your logs and settings.
- **Custom Animations** - Smooth transitions and floating background elements.
- **Material 3** - Leveraging the latest design standards.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

*Designed with 💚 and Neon by the Vibex Team.*
