import 'package:flutter/material.dart';

void main() {
  runApp(const AfyafeedApp());
}

class AfyafeedApp extends StatelessWidget {
  const AfyafeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afyafeed',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Afyafeed - Health News')),
      body: ListView(
        children: [
          _newsCard('Drink 2L of Water Daily', 'Doctors recommend staying hydrated for better health.'),
          _newsCard('5 Foods That Boost Immunity', 'Add oranges, garlic, and ginger to your diet.'),
          _newsCard('Exercise 30 Minutes a Day', 'A short walk reduces risk of heart disease.'),
        ],
      ),
    );
  }

  Widget _newsCard(String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: ListTile(
        leading: const Icon(Icons.health_and_safety, color: Colors.green, size: 40),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
