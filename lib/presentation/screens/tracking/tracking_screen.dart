import 'package:flutter/material.dart';

class TrackingScreen extends StatelessWidget { // Se cambió de `_TrackingScreen` a `TrackingScreen`
  const TrackingScreen({super.key}); // Se agregó `super.key`

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seguimiento del Pedido")),
      body: const Center(
        child: Text("Aquí se mostrará el seguimiento del pedido"),
      ),
    );
  }
}
