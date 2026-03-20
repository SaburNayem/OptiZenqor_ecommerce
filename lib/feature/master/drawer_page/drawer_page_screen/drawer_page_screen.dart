import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/feature/master/drawer_page/drawer_page_controller/drawer_page_controller.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';
import 'package:optizenqor/http_mathod/network_service/catalog_service.dart';

class DrawerPageScreen extends StatelessWidget {
  const DrawerPageScreen({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final data = const DrawerPageController().fromTitle(title);

    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
        backgroundColor: _appBarColor(data.title),
        foregroundColor: Colors.white,
      ),
      body: _bodyFor(data.title),
    );
  }

  Widget _bodyFor(String title) {
    switch (title) {
      case 'Order History':
        return _OrderHistoryBody();
      case 'Support':
        return _SupportBody();
      case 'Review':
        return _ReviewBody();
      case 'Help':
        return _HelpBody();
      case 'About Us':
        return _AboutUsBody();
      default:
        return const SizedBox.shrink();
    }
  }

  Color _appBarColor(String title) {
    if (title == 'Support') {
      return Colors.transparent;
    }
    if (title == 'Help' || title == 'Review' || title == 'Order History') {
      return Colors.blueAccent;
    }
    return Colors.teal;
  }
}

class _OrderHistoryBody extends StatelessWidget {
  const _OrderHistoryBody();

  List<_OrderHistoryItem> _orders() {
    final List<ProductModel> products = const CatalogService().getProducts();
    return <_OrderHistoryItem>[
      _OrderHistoryItem(
        orderId: '#123456',
        date: 'March 8, 2025',
        amount: '\$${products[0].price.toStringAsFixed(2)}',
        status: 'Delivered',
        product: products[0],
      ),
      _OrderHistoryItem(
        orderId: '#123457',
        date: 'March 5, 2025',
        amount: '\$${products[4].price.toStringAsFixed(2)}',
        status: 'Cancelled',
        product: products[4],
      ),
      _OrderHistoryItem(
        orderId: '#123458',
        date: 'March 1, 2025',
        amount: '\$${products[6].price.toStringAsFixed(2)}',
        status: 'Processing',
        product: products[6],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<_OrderHistoryItem> orders = _orders();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildOrderSection(context, orders, 'Processing', Colors.orange),
          _buildOrderSection(context, orders, 'Delivered', Colors.green),
          _buildOrderSection(context, orders, 'Cancelled', Colors.red),
        ],
      ),
    );
  }

  Widget _buildOrderSection(
    BuildContext context,
    List<_OrderHistoryItem> orders,
    String status,
    Color color,
  ) {
    final List<_OrderHistoryItem> filteredOrders = orders
        .where((_OrderHistoryItem order) => order.status == status)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            status,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        ...filteredOrders.map(
          (_OrderHistoryItem order) => Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColor.border),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 14,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.productDetails,
                  arguments: order.product,
                );
              },
              borderRadius: BorderRadius.circular(22),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(
                        order.product.imageUrl,
                        width: 84,
                        height: 84,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            order.product.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            order.orderId,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            order.date,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.14),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  order.status,
                                  style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                order.amount,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OrderHistoryItem {
  const _OrderHistoryItem({
    required this.orderId,
    required this.date,
    required this.amount,
    required this.status,
    required this.product,
  });

  final String orderId;
  final String date;
  final String amount;
  final String status;
  final ProductModel product;
}

class _SupportBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(color: const Color(0xFF20B2AA)),
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Contact Support',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We\'re here to help! Reach out to us by email, phone, or start a live chat conversation.',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              _card(
                context: context,
                icon: Icons.email,
                title: 'Email',
                subtitle: 'support@yourapp.com',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const _SupportEmailScreen(),
                    ),
                  );
                },
              ),
              _card(
                context: context,
                icon: Icons.phone,
                title: 'Phone',
                subtitle: '+1 234 567 890',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const _SupportPhoneScreen(),
                    ),
                  );
                },
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
                      builder: (BuildContext context) =>
                          const _LiveChatScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
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
      color: Colors.white.withValues(alpha: 0.15),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
        trailing: onTap != null
            ? const Icon(Icons.chevron_right, color: Colors.white)
            : null,
      ),
    );
  }
}

class _LiveChatScreen extends StatefulWidget {
  const _LiveChatScreen();

  @override
  State<_LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<_LiveChatScreen> {
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

class _SupportEmailScreen extends StatefulWidget {
  const _SupportEmailScreen();

  @override
  State<_SupportEmailScreen> createState() => _SupportEmailScreenState();
}

class _SupportEmailScreenState extends State<_SupportEmailScreen> {
  final TextEditingController _subjectController = TextEditingController(
    text: 'Need help with my account',
  );
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendEmail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Your email has been prepared for support.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Email')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const Text('To', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const TextField(
            enabled: false,
            decoration: InputDecoration(
              hintText: 'support@yourapp.com',
            ),
          ),
          const SizedBox(height: 16),
          const Text('Subject', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          TextField(controller: _subjectController),
          const SizedBox(height: 16),
          const Text('Message', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          TextField(
            controller: _messageController,
            maxLines: 8,
            decoration: const InputDecoration(
              hintText: 'Write your email to support',
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _sendEmail,
            child: const Text('Send Email'),
          ),
        ],
      ),
    );
  }
}

class _SupportPhoneScreen extends StatelessWidget {
  const _SupportPhoneScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Call Support')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColor.border),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Support Hotline',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '+1 234 567 890',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColor.primary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Available every day, 24/7 for urgent help.'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Calling support...')),
                );
              },
              icon: const Icon(Icons.phone),
              label: const Text('Call Now'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Center(
            child: Text(
              'Tell us what you think!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Rate the App',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star_border, color: Colors.amber),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'What needs improvement?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextFormField(
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Describe the issue or improvements...',
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpBody extends StatelessWidget {
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

class _AboutUsBody extends StatelessWidget {
  final List<Map<String, String>> teamMembers = const <Map<String, String>>[
    <String, String>{'name': 'Md Nayem Hossen', 'role': 'Founder & CEO'},
    <String, String>{'name': 'Jannatul Mawa', 'role': 'Co-Founder & COO'},
    <String, String>{'name': 'Samia Islam', 'role': 'CMO'},
    <String, String>{'name': 'Asaduzzaman', 'role': 'CTO'},
    <String, String>{'name': 'Ariyan Shakib', 'role': 'Lead Designer'},
    <String, String>{'name': 'Chinmoy Roy', 'role': 'Project Manager'},
  ];

  const _AboutUsBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const CircleAvatar(radius: 30, child: Icon(Icons.storefront)),
          const SizedBox(height: 10),
          const Text(
            'Your App Name',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            'Version: 1.0.0',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'This app is designed to help users with [your app’s purpose]. We aim to provide the best experience for our users.',
          ),
          const SizedBox(height: 20),
          _section('Our Mission', const <Widget>[
            Text(
              'To provide the best experience for our users by delivering innovative solutions that simplify their daily tasks.',
            ),
          ]),
          _section('App Features', const <Widget>[
            ListTile(leading: Icon(Icons.thumb_up), title: Text('Easy to Use')),
            ListTile(leading: Icon(Icons.security), title: Text('Secure')),
            ListTile(
              leading: Icon(Icons.speed),
              title: Text('Fast Performance'),
            ),
            ListTile(
              leading: Icon(Icons.support_agent),
              title: Text('24/7 Support'),
            ),
          ]),
          _section(
            'Our Team',
            teamMembers.map((Map<String, String> member) {
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(member['name']!),
                subtitle: Text(member['role']!),
              );
            }).toList(),
          ),
          _section('Contact Us', const <Widget>[
            ListTile(
              title: Text('Email'),
              subtitle: Text('support@yourapp.com'),
            ),
            ListTile(title: Text('Phone'), subtitle: Text('+1 234 567 890')),
            ListTile(title: Text('Website'), subtitle: Text('www.yourapp.com')),
            ListTile(
              title: Text('Address'),
              subtitle: Text('123 App Street, Tech City'),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }
}
