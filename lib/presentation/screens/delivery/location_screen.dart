import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget { // Hacer la clase pública
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubicación")),
      body: const Center(
        child: Text("Aquí se mostrará el mapa"),
      ),
    );
  }
}
