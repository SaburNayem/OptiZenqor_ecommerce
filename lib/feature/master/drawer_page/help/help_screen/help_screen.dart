import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'How can we help you?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _faq(
            'How do I reset my password?',
            'Go to settings > Account > Reset Password.',
          ),
          _faq(
            'How can I update the app?',
            'Check the Play Store/App Store for updates.',
          ),
          _faq(
            'How do I change my username?',
            'Go to settings > Edit Profile > Change Username.',
          ),
          _faq(
            'How do I enable notifications?',
            'Go to settings > Notifications and enable alerts.',
          ),
          _faq(
            'App is crashing?',
            'Try restarting your device or reinstalling the app.',
          ),
          _faq(
            'Cannot login?',
            'Check your internet connection and reset password if needed.',
          ),
          _faq(
            'Why is my screen freezing?',
            'Ensure your app is updated and restart your phone.',
          ),
        ],
      ),
    );
  }

  Widget _faq(String question, String answer) {
    return Card(
      child: ExpansionTile(
        title: Text(question),
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(16), child: Text(answer)),
        ],
      ),
    );
  }
}
