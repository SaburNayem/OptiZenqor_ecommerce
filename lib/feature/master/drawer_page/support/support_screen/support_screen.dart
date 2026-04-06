import 'package:flutter/material.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

const String supportEmail = 'support@yourapp.com';
const String supportPhone = '+1234567890';

Future<void> openSupportEmail(
  BuildContext context, {
  String? subject,
  String? body,
}) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: supportEmail,
    queryParameters: <String, String>{
      if (subject != null && subject.isNotEmpty) 'subject': subject,
      if (body != null && body.isNotEmpty) 'body': body,
    },
  );

  final bool launched = await launchUrl(
    emailUri,
    mode: LaunchMode.externalApplication,
  );

  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open the email app.')),
    );
  }
}

Future<void> openSupportDialer(BuildContext context) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: supportPhone);
  final bool launched = await launchUrl(
    phoneUri,
    mode: LaunchMode.externalApplication,
  );

  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open the phone dialer.')),
    );
  }
}

class SupportBody extends StatelessWidget {
  const SupportBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Contact Support',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'We\'re here to help! Reach out to us by email, phone, or start a live chat conversation.',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _card(
              context: context,
              icon: Icons.email,
              title: 'Email',
              subtitle: supportEmail,
              onTap: () => openSupportEmail(context),
            ),
            _card(
              context: context,
              icon: Icons.phone,
              title: 'Phone',
              subtitle: '+1 234 567 890',
              onTap: () => openSupportDialer(context),
            ),
            _card(
              context: context,
              icon: Icons.chat,
              title: 'Live Chat',
              subtitle: 'Available 24/7 in the app.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const LiveChatScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColor.border),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: AppColor.primary),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: AppColor.textSecondary),
        ),
        trailing: onTap != null
            ? const Icon(Icons.chevron_right, color: AppColor.primary)
            : null,
      ),
    );
  }
}

class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen({super.key});

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = <Map<String, String>>[
    <String, String>{
      'sender': 'Support',
      'message': 'Hello! Welcome to live chat. How can we help today?',
    },
    <String, String>{
      'sender': 'You',
      'message': 'I need help with my recent order.',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final String message = _messageController.text.trim();
    if (message.isEmpty) {
      return;
    }
    setState(() {
      _messages.add(<String, String>{'sender': 'You', 'message': message});
      _messages.add(<String, String>{
        'sender': 'Support',
        'message': 'Thanks, we received your message and will help shortly.',
      });
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Chat')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, String> message = _messages[index];
                final bool isUser = message['sender'] == 'You';
                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    constraints: const BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: isUser ? AppColor.primary : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: isUser
                          ? null
                          : Border.all(color: AppColor.border),
                    ),
                    child: Text(
                      message['message'] ?? '',
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message',
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: _sendMessage,
                    child: const Text('Send'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
