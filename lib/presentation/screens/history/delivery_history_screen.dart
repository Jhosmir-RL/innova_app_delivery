import 'package:flutter/material.dart';

class DeliveriesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> completedOrders = [
    {
      'id': '12345',
      'deliveryDate': '15 Oct 2023',
      'deliveryTime': '10:00 AM',
      'estimatedDeliveryDate': '16 Oct 2023',
      'shippingMethod': 'Envío estándar',
      'courierCompany': 'Mensajería Rápida SA',
      'trackingNumber': 'ABC123456789',
      'deliveryAddress': 'Calle 123, Ciudad A',
      'shippingStatus': 'Entregado',
      'contact': 'Juan Pérez - +123 456 7890',
      'shippingCost': '\$15.00',
    },
    {
      'id': '67890',
      'deliveryDate': '16 Oct 2023',
      'deliveryTime': '02:30 PM',
      'estimatedDeliveryDate': '17 Oct 2023',
      'shippingMethod': 'Envío express',
      'courierCompany': 'Envíos Veloces SL',
      'trackingNumber': 'XYZ987654321',
      'deliveryAddress': 'Avenida 456, Ciudad B',
      'shippingStatus': 'Entregado',
      'contact': 'María Gómez - +987 654 3210',
      'shippingCost': '\$25.00',
    },
  ];

  DeliveriesScreen({super.key}); // Constructor sin 'const'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pedidos Finalizados', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: completedOrders.length,
        itemBuilder: (context, index) {
          final order = completedOrders[index];
          return _buildOrderCard(order, context);
        },
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(order: order),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pedido #${order['id']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: const Color(0xFFB792C6)),
                  const SizedBox(width: 8),
                  Text(
                    'Fecha de entrega: ${order['deliveryDate']}',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.access_time, color: const Color(0xFFB792C6)),
                  const SizedBox(width: 8),
                  Text(
                    'Hora de entrega: ${order['deliveryTime']}',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Detalles del Pedido', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem('Número de Pedido', '#${order['id']}'),
            _buildDetailItem('Fecha Estimada de Entrega', order['estimatedDeliveryDate']),
            _buildDetailItem('Método de Envío', order['shippingMethod']),
            _buildDetailItem('Empresa de Mensajería', order['courierCompany']),
            _buildDetailItem('Número de Seguimiento', order['trackingNumber']),
            _buildDetailItem('Dirección de Entrega', order['deliveryAddress']),
            _buildDetailItem('Estado del Envío', order['shippingStatus']),
            _buildDetailItem('Contacto para la Entrega', order['contact']),
            _buildDetailItem('Costos de Envío', order['shippingCost']),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFB792C6),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}