import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class SequenceInputScreen extends StatefulWidget {
  const SequenceInputScreen(BuildContext context, {super.key});

  @override
  State<SequenceInputScreen> createState() => _SequenceInputScreenState();
}

class _SequenceInputScreenState extends State<SequenceInputScreen> {
  final TextEditingController _sequenceController = TextEditingController();

  @override
  void dispose() {
    _sequenceController.dispose();
    super.dispose();
  }

  Future<bool> _requestStoragePermission() async {
    // For Android 13+ (API 33+), storage permission is split into media permissions
    if (Platform.isAndroid) {
      var sdkInt = 0;
      try {
        sdkInt =
            (await MethodChannel(
              'flutter/platform',
            ).invokeMethod<int>('getSdkInt')) ??
            0;
      } catch (e) {
        sdkInt = 0;
      }
      if (sdkInt >= 33) {
        var imagesStatus = await Permission.photos.status;
        if (!imagesStatus.isGranted) {
          imagesStatus = await Permission.photos.request();
        }
        return imagesStatus.isGranted;
      }
    }
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }

  Future<void> _pickFastaFile() async {
    bool permissionGranted = await _requestStoragePermission();
    if (!permissionGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage permission is required to select files.'),
        ),
      );
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['fasta'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      setState(() {
        _sequenceController.text = content;
      });
    } else {
      // User canceled the picker or no file selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected or invalid file type.')),
      );
    }
  }

  void _analyzeSequence() {
    final sequence = _sequenceController.text.trim();
    if (sequence.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please paste a sequence first.')),
      );
      return;
    }

    // We'll connect this to backend analysis later
    Navigator.pushNamed(context, '/result', arguments: sequence);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input HIV Sequence')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Paste the HIV FASTA sequence below or select a FASTA file:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _sequenceController,
              maxLines: 8,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '>header\nATGC...',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickFastaFile,
              child: const Text('Select FASTA File'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _analyzeSequence,
              child: const Text('Analyze'),
            ),
          ],
        ),
      ),
    );
  }
}
