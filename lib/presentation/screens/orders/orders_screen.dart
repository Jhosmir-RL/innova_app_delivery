import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      'orderNumber': '#32456',
      'location': 'Calle 123, Ciudad',
      'products': ['Producto 1', 'Producto 2', 'Producto 3'],
      'orderDate': '2023-10-01',
      'estimatedDelivery': '2023-10-05',
      'status': 'En camino', // Puede ser: Tienda, En camino, Entregado
    },
    {
      'orderNumber': '#32457',
      'location': 'Avenida 456, Ciudad',
      'products': ['Producto 4', 'Producto 5'],
      'orderDate': '2023-10-02',
      'estimatedDelivery': '2023-10-06',
      'status': 'Tienda',
    },
    {
      'orderNumber': '#32458',
      'location': 'Calle 789, Ciudad',
      'products': ['Producto 6'],
      'orderDate': '2023-10-03',
      'estimatedDelivery': '2023-10-07',
      'status': 'Entregado',
    },
  ];

  OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFB792C6),
        title: const Text(
          'Pedidos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _buildOrderCard(order, context);
        },
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _showOrderDetails(order, context),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pedido ${order['orderNumber']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB792C6),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Estado: ${order['status']}',
                style: TextStyle(
                  fontSize: 16,
                  color: _getStatusColor(order['status']),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Entrega estimada: ${order['estimatedDelivery']}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Tienda':
        return Colors.orange;
      case 'En camino':
        return Colors.blue;
      case 'Entregado':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showOrderDetails(Map<String, dynamic> order, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detalles del Pedido ${order['orderNumber']}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ubicación: ${order['location']}'),
                const SizedBox(height: 10),
                const Text('Productos:'),
                ...order['products'].map((product) => Text('- $product')).toList(),
                const SizedBox(height: 10),
                Text('Fecha de pedido: ${order['orderDate']}'),
                const SizedBox(height: 10),
                Text('Fecha estimada de entrega: ${order['estimatedDelivery']}'),
                const SizedBox(height: 10),
                Text(
                  'Estado: ${order['status']}',
                  style: TextStyle(color: _getStatusColor(order['status'])),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}