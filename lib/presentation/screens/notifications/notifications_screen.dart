import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key}); // Se agregó `super.key`

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notificaciones")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          NotificationCard(
            title: "Nuevo pedido asignado",
            message: "Tienes un nuevo pedido para entregar.",
          ),
          NotificationCard(
            title: "Pedido entregado",
            message: "El pedido #12345 ha sido entregado con éxito.",
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;

  const NotificationCard({
    required this.title,
    required this.message,
    super.key, // Se agregó `super.key`
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title),
        subtitle: Text(message),
        trailing: const Icon(Icons.notifications),
      ),
    );
  }
}
