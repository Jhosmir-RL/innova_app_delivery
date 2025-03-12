import 'package:flutter/material.dart';

class TrackOrdersScreen extends StatelessWidget {
  const TrackOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seguimiento de Pedidos')),
      body: const Center(
        child: Text('Aquí se mostrará el seguimiento de los pedidos'),
      ),
    );
  } 
}
