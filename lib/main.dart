import 'package:flutter/material.dart';

void main() {
  runApp(const MyCardApp());
}

class MyCardApp extends StatelessWidget {
  const MyCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/avatar.jpg',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 15),

              const Text(
                'Nguyễn Văn Hội',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'FLUTTER DEVELOPER',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(
                width: 250,
                child: Divider(color: Colors.white, thickness: 1),
              ),

              Card(
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.phone, color: Colors.teal),
                  title: const Text('+84 345 855 986'),
                ),
              ),

              Card(
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.email, color: Colors.teal),
                  title: const Text('hoinv.23it@vku.udn.vn'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
