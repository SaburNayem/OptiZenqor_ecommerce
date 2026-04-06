import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  static const List<Map<String, String>> _teamMembers = <Map<String, String>>[
    <String, String>{'name': 'Md Nayem Hossen', 'role': 'Founder & CEO'},
    <String, String>{'name': 'Jannatul Mawa', 'role': 'Co-Founder & COO'},
    <String, String>{'name': 'Samia Islam', 'role': 'CMO'},
    <String, String>{'name': 'Asaduzzaman', 'role': 'CTO'},
    <String, String>{'name': 'Ariyan Shakib', 'role': 'Lead Designer'},
    <String, String>{'name': 'Chinmoy Roy', 'role': 'Project Manager'},
  ];

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
            'Optizenqor Store',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            'Version: 1.0.0',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Optizenqor Store helps users discover products, manage orders, and shop more easily from one mobile experience.',
          ),
          const SizedBox(height: 20),
          _section('Our Mission', const <Widget>[
            Text(
              'To provide a simple and reliable shopping experience with fast browsing, secure ordering, and helpful support.',
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
            _teamMembers.map((Map<String, String> member) {
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
              subtitle: Text('support@optizenqorstore.com'),
            ),
            ListTile(title: Text('Phone'), subtitle: Text('+880 1700 000000')),
            ListTile(
              title: Text('Website'),
              subtitle: Text('www.optizenqorstore.com'),
            ),
            ListTile(
              title: Text('Address'),
              subtitle: Text('Dhaka, Bangladesh'),
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
