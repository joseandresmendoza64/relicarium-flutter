
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const RelicariumApp());
}

class RelicariumApp extends StatelessWidget {
  const RelicariumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relicarium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.amber,
        fontFamily: 'CormorantGaramond',
      ),
      home: const HomeScreen(),
    );
  }
}
