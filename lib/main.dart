import 'package:flutter/material.dart';
import 'package:app_innova_delivery/presentation/screens/landing/landing_screen.dart';
import 'package:app_innova_delivery/presentation/screens/start/start_screen.dart';
import 'package:app_innova_delivery/presentation/screens/tracking/tracking_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INNOVA Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/landing',
      routes: {
        '/landing': (context) => const LandingScreen(),
        '/start': (context) => const StartScreen(),
        '/tracking': (context) => const TrackingScreen(),
      },
    );
  }
}
