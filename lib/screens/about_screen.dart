import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('О программе')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AIChatFlutter - Чат-приложение с ИИ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Version: 1.0.1'),
            SizedBox(height: 16),
            Text(
                'Developed by Sergey Starodubtsev, additional development by Valeriy Stromilov'),
            SizedBox(height: 16),
            Text('THE FOUNDER, 2024-2025'),
          ],
        ),
      ),
    );
  }
}
