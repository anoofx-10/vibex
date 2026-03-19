import 'package:flutter/material.dart';

void main() {
  runApp(const MoodTrackerApp());
}

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vibex Mood Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFCCFF00), // Neon Green
          surface: Color(0xFF1A1A1A), // Dark Grey for cards
          secondary: Color(0xFFFF8A00), // Orange
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _showWelcome = true;
  String _currentMood = 'Happy';
  int _quizQuestionIndex = 1;
  String _sleepTime = '7h 20min';
  String _stressLevel = 'High';

  final List<Map<String, dynamic>> _logs = [
    {'date': 'Sep 14', 'mood': 'Happy', 'note': 'Feeling great today!'},
    {'date': 'Sep 13', 'mood': 'Sleepy', 'note': 'Long night of coding.'},
  ];

  final List<String> _quizQuestions = [
    'Have you been sleeping well recently?',
    'Did you drink enough water today?',
    'Have you taken a break from screens?',
    'Did you exercise for at least 20 mins?',
    'Have you spent time outdoors?',
    'Did you connect with a friend today?',
    'Have you meditated or breathed deeply?',
    'Are you satisfied with your productivity?',
  ];

  void _nextQuizQuestion() {
    setState(() {
      if (_quizQuestionIndex < 8) {
        _quizQuestionIndex++;
      } else {
        _quizQuestionIndex = 1; // Reset for demo
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Quiz Completed! You are doing great.'),
            backgroundColor: Color(0xFFCCFF00),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void _addLog(String mood, String note) {
    setState(() {
      _currentMood = mood;
      _logs.insert(0, {
        'date': 'Today',
        'mood': mood,
        'note': note.isEmpty ? 'Logged a $mood mood.' : note,
      });
    });
  }

  void _showMoodEntryDialog(String mood) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text('Log $mood Mood', style: const TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Any thoughts or notes?',
            hintStyle: const TextStyle(color: Colors.white30),
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white38)),
          ),
          ElevatedButton(
            onPressed: () {
              _addLog(mood, controller.text);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCCFF00),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showMetricDialog(String title, String currentVal, Function(String) onSave) {
    final TextEditingController controller = TextEditingController(text: currentVal);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text('Update $title', style: const TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFCCFF00), foregroundColor: Colors.black),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF1A1A1A)),
            accountName: Text('Alex Miller', style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: Text('alex.miller@example.com', style: TextStyle(color: Colors.white38)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Color(0xFFCCFF00),
              child: Icon(Icons.person, color: Colors.black, size: 40),
            ),
          ),
          _drawerItem(Icons.settings_rounded, 'Settings'),
          _drawerItem(Icons.notifications_active_rounded, 'Notifications'),
          _drawerItem(Icons.help_outline_rounded, 'Help & Support'),
          const Spacer(),
          _drawerItem(Icons.logout_rounded, 'Sign Out', onTap: () {
            Navigator.pop(context);
            setState(() => _showWelcome = true);
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white70)),
      onTap: onTap ?? () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showWelcome) {
      return WelcomeScreen(onStart: () => setState(() => _showWelcome = false));
    }

    return Scaffold(
      drawer: _buildDrawer(),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            MoodDashboard(
              onMoodSelected: _showMoodEntryDialog,
              quizQuestion: _quizQuestions[_quizQuestionIndex - 1],
              quizIndex: _quizQuestionIndex,
              onQuizAnswer: _nextQuizQuestion,
              sleepTime: _sleepTime,
              stressLevel: _stressLevel,
              onUpdateSleep: () => _showMetricDialog('Sleep Duration', _sleepTime, (v) => setState(() => _sleepTime = v)),
              onUpdateStress: () => _showMetricDialog('Stress Indicator', _stressLevel, (v) => setState(() => _stressLevel = v)),
            ),
            CalendarScreen(currentMood: _currentMood),
            JournalScreen(logs: _logs),
            const FocusDiscoveryScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.black,
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_filled, 0),
            _buildNavItem(Icons.calendar_today_rounded, 1),
            _buildNavItem(Icons.sticky_note_2_rounded, 2),
            _buildNavItem(Icons.grid_view_rounded, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFFCCFF00) : Colors.white38,
            size: 26,
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(color: Color(0xFFCCFF00), shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  final VoidCallback onStart;
  const WelcomeScreen({super.key, required this.onStart});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    top: 100 + (20 * _controller.value),
                    right: -50 + (10 * _controller.value),
                    child: _blob(180, const Color(0xFFCCFF00)),
                  ),
                  Positioned(
                    bottom: 200 - (15 * _controller.value),
                    left: -40 + (20 * _controller.value),
                    child: _blob(150, const Color(0xFFFFB8E0)),
                  ),
                  Positioned(
                    bottom: 50 + (25 * _controller.value),
                    right: 20 - (10 * _controller.value),
                    child: _blob(120, const Color(0xFFFF8A00)),
                  ),
                  Positioned(
                    top: 400 - (30 * _controller.value),
                    left: 100 - (15 * _controller.value),
                    child: _blob(200, const Color(0xFF81B3FF)),
                  ),
                ],
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('9:41', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const Text(
                    'Not Sure\nAbout Your\nMood?',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, height: 1.1),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: widget.onStart,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('Let Us Help!', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          SizedBox(width: 12),
                          Icon(Icons.arrow_forward, color: Colors.black, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _blob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.6),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 40, spreadRadius: 10)],
      ),
      child: Center(
        child: Icon(
          Icons.sentiment_satisfied_alt_rounded,
          size: size * 0.4,
          color: Colors.black26,
        ),
      ),
    );
  }
}

class MoodDashboard extends StatelessWidget {
  final Function(String) onMoodSelected;
  final String quizQuestion;
  final int quizIndex;
  final VoidCallback onQuizAnswer;
  final String sleepTime;
  final String stressLevel;
  final VoidCallback onUpdateSleep;
  final VoidCallback onUpdateStress;

  const MoodDashboard({
    super.key,
    required this.onMoodSelected,
    required this.quizQuestion,
    required this.quizIndex,
    required this.onQuizAnswer,
    required this.sleepTime,
    required this.stressLevel,
    required this.onUpdateSleep,
    required this.onUpdateStress,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          _buildMoodSection(context),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _buildSleepCard()),
              const SizedBox(width: 16),
              Expanded(child: _buildStressCard()),
            ],
          ),
          const SizedBox(height: 24),
          _buildQuizCard(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Welcome back', style: TextStyle(color: Colors.white38, fontSize: 12)),
                Text('Alex Miller', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ],
    );
  }

  Widget _buildMoodSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Sep 14, 2025', style: TextStyle(color: Colors.white38, fontSize: 14)),
        const SizedBox(height: 8),
        const Text('Hello Alex! How are\nyou feeling today?',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, height: 1.2)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _moodIcon('😊', 'Happy', const Color(0xFFCCFF00)),
              _moodIcon('😡', 'Angry', const Color(0xFFFF8A00)),
              _moodIcon('😴', 'Sleepy', const Color(0xFF81B3FF)),
              _moodIcon('😑', 'Bored', const Color(0xFFFFB8E0)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _moodIcon(String emoji, String label, Color color) {
    return GestureDetector(
      onTap: () => onMoodSelected(label),
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSleepCard() {
    return GestureDetector(
      onTap: onUpdateSleep,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFDAB9),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.bed, color: Colors.black, size: 16),
                SizedBox(width: 4),
                Text('Sleep Duration', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) => _bar(index == 2 ? 40.0 : 20.0 + (index * 5), Colors.orange)),
            ),
            const SizedBox(height: 16),
            Text(sleepTime, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildStressCard() {
    return GestureDetector(
      onTap: onUpdateStress,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFE6E6FA),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.remove_red_eye, color: Colors.black, size: 16),
                SizedBox(width: 4),
                Text('Stress Indicator', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) => _bar(10.0 + (index * 8), Colors.purple)),
            ),
            const SizedBox(height: 16),
            Text(stressLevel, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _bar(double height, Color color) {
    return Container(
      width: 6,
      height: height,
      decoration: BoxDecoration(
        color: color.withOpacity(0.5),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildQuizCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFCCFF00),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.psychology, color: Colors.black, size: 20),
                  SizedBox(width: 8),
                  Text('Yes or No Quiz', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
              Text('Question $quizIndex/8', style: const TextStyle(color: Colors.black54, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Text(quizQuestion, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _quizButton('Yes', onQuizAnswer)),
              const SizedBox(width: 12),
              Expanded(child: _quizButton('No', onQuizAnswer)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quizButton(String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class CalendarScreen extends StatelessWidget {
  final String currentMood;
  const CalendarScreen({super.key, required this.currentMood});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalendarHeader(),
          const SizedBox(height: 24),
          _buildCalendarGrid(),
          const SizedBox(height: 32),
          _buildSummaryCard(context),
          const SizedBox(height: 24),
          _buildStatsRow(),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.arrow_back_ios, size: 18, color: Colors.white38),
            Column(
              children: const [
                Text('Mood Calendar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text('September, 2025', style: TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
            const Icon(Icons.calendar_month, size: 24, color: Colors.white),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    final List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final List<Color> moodColors = [
      const Color(0xFFCCFF00),
      const Color(0xFFFF8A00),
      const Color(0xFF81B3FF),
      const Color(0xFFFFB8E0),
      const Color(0xFF1A1A1A),
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: days.map((day) => Expanded(child: Center(child: Text(day, style: const TextStyle(color: Colors.white38, fontSize: 10))))).toList(),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: 31,
          itemBuilder: (context, index) {
            final colorIndex = (index * 3 + 2) % moodColors.length;
            return Container(decoration: BoxDecoration(color: moodColors[colorIndex], borderRadius: BorderRadius.circular(8)));
          },
        ),
      ],
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    String description = '';
    switch (currentMood) {
      case 'Happy':
        description = 'You\'re feeling calm and optimistic.\nKeep up the good vibes!';
        break;
      case 'Angry':
        description = 'You seem a bit frustrated.\nTry some deep breathing.';
        break;
      case 'Sleepy':
        description = 'You\'re feeling a bit drained.\nMaybe take a short nap.';
        break;
      case 'Bored':
        description = 'Feeling a bit uninspired?\nTry a new hobby today.';
        break;
      default:
        description = 'Keep tracking to see your patterns!';
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: const Color(0xFFCCFF00), borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Monthly Mood Summary', style: TextStyle(color: Colors.black54, fontSize: 12)),
                const SizedBox(height: 4),
                Text(currentMood, style: const TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(description, style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12)),
              ],
            ),
          ),
          _moodSummaryIcon(currentMood),
        ],
      ),
    );
  }

  Widget _moodSummaryIcon(String mood) {
    IconData icon;
    switch (mood) {
      case 'Happy': icon = Icons.sentiment_very_satisfied_rounded; break;
      case 'Angry': icon = Icons.sentiment_very_dissatisfied_rounded; break;
      case 'Sleepy': icon = Icons.bedtime_rounded; break;
      case 'Bored': icon = Icons.sentiment_neutral_rounded; break;
      default: icon = Icons.sentiment_satisfied_rounded;
    }
    return Icon(icon, size: 60, color: Colors.black);
  }

  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statItem('Activity', '101,513', 'Steps', const Color(0xFFCCFF00)),
          _statItem('Therapy', '10/30', 'Sessions', const Color(0xFF81B3FF)),
          _statItem('Discipline', '88%', 'Focus', const Color(0xFFFF8A00)),
        ],
      ),
    );
  }

  Widget _statItem(String title, String value, String unit, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white38, fontSize: 10)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
        Text(unit, style: const TextStyle(color: Colors.white38, fontSize: 10)),
      ],
    );
  }
}

class JournalScreen extends StatelessWidget {
  final List<Map<String, dynamic>> logs;
  const JournalScreen({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mood Journal', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildPatternCard(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: _getMoodColor(log['mood']).withOpacity(0.2), shape: BoxShape.circle),
                        child: Text(_getMoodEmoji(log['mood']), style: const TextStyle(fontSize: 20)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(log['mood'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(log['date'], style: const TextStyle(color: Colors.white38, fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(log['note'], style: const TextStyle(color: Colors.white70, fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatternCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your Patterns', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white38)),
          const SizedBox(height: 16),
          Row(
            children: [
              _patternBar(const Color(0xFFCCFF00), 50),
              _patternBar(const Color(0xFFFF8A00), 20),
              _patternBar(const Color(0xFF81B3FF), 20),
              _patternBar(const Color(0xFFFFB8E0), 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget _patternBar(Color color, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 8,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      ),
    );
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case 'Happy': return const Color(0xFFCCFF00);
      case 'Angry': return const Color(0xFFFF8A00);
      case 'Sleepy': return const Color(0xFF81B3FF);
      case 'Bored': return const Color(0xFFFFB8E0);
      default: return Colors.white24;
    }
  }

  String _getMoodEmoji(String mood) {
    switch (mood) {
      case 'Happy': return '😊';
      case 'Angry': return '😡';
      case 'Sleepy': return '😴';
      case 'Bored': return '😑';
      default: return '😶';
    }
  }
}

class FocusDiscoveryScreen extends StatelessWidget {
  const FocusDiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Focus & Discipline', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildDiscoveryCard(context, 'Daily Goal', '88%', 'Focus Score', const Color(0xFFCCFF00), Icons.bolt_rounded),
          const SizedBox(height: 16),
          _buildDiscoveryCard(context, 'Meditation', '15/20', 'Min session', const Color(0xFF81B3FF), Icons.self_improvement_rounded),
          const SizedBox(height: 24),
          const Text('Recommended for you', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildRecommendationItem('Deep Breathing Exercise', '5 mins • Relaxing', const Color(0xFFFFB8E0), Icons.air_rounded),
          const SizedBox(height: 12),
          _buildRecommendationItem('Morning Gratitude', '10 mins • Journal', const Color(0xFFFF8A00), Icons.auto_awesome_rounded),
        ],
      ),
    );
  }

  Widget _buildDiscoveryCard(BuildContext context, String title, String value, String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white38, fontSize: 14)),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(value, style: TextStyle(color: color, fontSize: 36, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ],
          ),
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle), child: Icon(icon, color: color, size: 32)),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String title, String subtitle, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(16)), child: Icon(icon, color: color, size: 24)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.play_arrow_rounded, color: Colors.white38),
        ],
      ),
    );
  }
}
