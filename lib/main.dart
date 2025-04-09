import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ParkingApp());
}

class ParkingApp extends StatelessWidget {
  const ParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '智能停车管理系统',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: const AppBarTheme(centerTitle: true),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
