import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Add your firebase_options.dart after `flutterfire configure`
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AfyaFeed',
      theme: ThemeData(
        primaryColor: const Color(0xFF14B8A6), // teal
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF0EA5E9)), // blue
      ),
      home: const HomeScreen(),
    );
  }
}
