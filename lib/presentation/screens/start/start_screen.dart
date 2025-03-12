import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget { // Se cambió de `_StartScreen` a `StartScreen`
  const StartScreen({super.key}); // Se agregó `super.key`

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
