
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/connection_provider.dart';
import 'services/connectivity_service.dart';
import 'providers/catalog_provider.dart';
import 'repositories/catalog_repository.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConnectionProvider(ConnectivityService()),
        ),
        ChangeNotifierProvider(
          create: (_) => CatalogProvider(CatalogRepository()),
        ),
      ],
      child: const RelicariumApp(),
    ),
  );
}

class RelicariumApp extends StatelessWidget {
  const RelicariumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relicarium II',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: const Color(0xFF7DD3FC),
      scaffoldBackgroundColor: const Color(0xFF0B1220),
      fontFamily: 'CormorantGaramond',
      elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 73, 165, 208),
      foregroundColor: const Color(0xFF0B1220),
      minimumSize: const Size(46, 26), 
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
      home: const HomeScreen(),
    );
  }
}
