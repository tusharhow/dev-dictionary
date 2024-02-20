import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                'https://placekitten.com/200/200',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Our Team',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'We are a passionate team dedicated to creating amazing Flutter apps. '
              'Our mission is to deliver high-quality, user-friendly solutions that '
              'make a positive impact on people\'s lives.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality, e.g., navigate to team member profiles
              },
              child: const Text('Meet the Team'),
            ),
          ],
        ),
      ),
    );
  }
}
