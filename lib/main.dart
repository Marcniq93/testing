import 'package:flutter/material.dart';
import 'pages/login_page.dart'; // Assuming you have a login_page.dart
import 'pages/register_page.dart'; // Assuming you have a register_page.dart
import 'pages/home_page.dart'; // HomePage is the main navigation hub

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CommuTrade App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Set the initial route to your login page
      initialRoute: '/login', // Or '/' if your LoginPage is the root
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(), // HomePage is the entry point for main navigation
        // IMPORTANT: Remove or comment out any direct route to MarketplacePage here.
        // MarketplacePage is now accessed as a child of HomePage.
        // For example, if you had: '/marketplace': (context) => const MarketplacePage(),
        // You should remove it.
      },
    );
  }
}
