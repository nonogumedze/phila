import 'package:flutter/material.dart';
import 'package:phila/Login/login_screen.dart';
import 'package:phila/widgets/responsive_scaffold.dart';
// ✅ Make sure this path is correct

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: "Home",
      selectedIndex: 0, // Highlights the current nav item
      onDestinationSelected: (index) {
        // Handle sidebar/drawer navigation
        if (index == 0) Navigator.pushReplacementNamed(context, '/');
        if (index == 1) Navigator.pushReplacementNamed(context, '/input');
        if (index == 2) Navigator.pushReplacementNamed(context, '/history');
      },
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the HIV Drug Resistance Tracker.\n\n'
              'You can upload or paste a patient\'s HIV sequence to analyze resistance.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/input');
              },
              child: const Text('Analyze a Sequence'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
