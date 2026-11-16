
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const NusaInfoApp());
}

class NusaInfoApp extends StatelessWidget {
  const NusaInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const pink = Color(0xFFFF4F9A);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NusaInfo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: pink,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF101018),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF101018),
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
