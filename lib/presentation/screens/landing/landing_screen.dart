import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_innova_delivery/presentation/screens/auth/login_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    const int duration = 5000; // 5 segundos
    const int steps = 50;
    const double increment = 1.0 / steps;
    const int interval = duration ~/ steps;

    Timer.periodic(Duration(milliseconds: interval), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        _progress += increment;
      });

      if (_progress >= 1.0) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()), // Sin 'const'
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFB792C6), // Color de fondo
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(screenWidth),
            SizedBox(height: screenHeight * 0.05), // Espacio proporcional
            _buildProgressBar(screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(double screenWidth) {
    return Image.asset(
      'assets/logo.png',
      width: screenWidth * 0.8, // 50% del ancho de la pantalla
      height: screenWidth * 0.8, // 50% del ancho de la pantalla
    );
  }

  Widget _buildProgressBar(double screenWidth) {
    return Container(
      width: screenWidth * 0.8, // 80% del ancho de la pantalla
      height: 20, // Altura de la barra de progreso
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(51), // Fondo con 20% de opacidad
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25), // Usamos withAlpha en lugar de withOpacity
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Fondo de la barra de progreso
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(77), // 30% de opacidad
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Barra de progreso
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          // Efecto de brillo
          Positioned(
            left: _progress * (screenWidth * 0.8) - 20, // Ajuste de posición
            child: Container(
              width: 40,
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withAlpha(100),
                    Colors.white.withAlpha(0),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}