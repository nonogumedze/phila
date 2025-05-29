import 'package:flutter/material.dart';
import 'package:phila/Screens/Nurse/sequence_input_screen.dart';

class NurseHomeScreen extends StatelessWidget {
  const NurseHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nurse Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome Nurse!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Upload patient DNA sequence to initiate ARV resistance analysis.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload DNA Sequence'),
              onPressed:
                  () => Navigator.push(
                    context,
                    SequenceInputScreen as Route<Object?>,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
