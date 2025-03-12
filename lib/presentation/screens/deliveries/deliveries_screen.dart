import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Para seleccionar imágenes
import 'dart:io'; // Para manejar archivos de imagen

class DeliveriesScreen extends StatelessWidget {
  const DeliveriesScreen({super.key});

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
      body: const OrderDetailsScreen(),
    );
  }
}

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final List<Map<String, dynamic>> _orders = [
    {
      'id': '12345',
      'location': 'Calle 123, Ciudad A',
      'deliveryDate': '15 Oct 2023',
      'status': 'En Tienda',
      'image': null,
      'description': '',
    },
    {
      'id': '67890',
      'location': 'Avenida 456, Ciudad B',
      'deliveryDate': '16 Oct 2023',
      'status': 'En Camino',
      'image': null,
      'description': '',
    },
  ];

  Future<void> _changeStatus(int index, String newStatus) async {
    if (newStatus == 'Entregado') {
      final result = await showDialog(
        context: context,
        builder: (context) => const DeliveryConfirmationDialog(),
      );

      if (result != null && result['image'] != null) {
        setState(() {
          _orders[index]['status'] = newStatus;
          _orders[index]['image'] = result['image'];
          _orders[index]['description'] = result['description'];
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Debes subir una imagen y una descripción para cambiar a "Entregado"')),
          );
        }
      }
    } else {
      setState(() {
        _orders[index]['status'] = newStatus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        final order = _orders[index];
        return _buildOrderCard(order, index);
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, int index) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Número de pedido
            Text(
              'Pedido #${order['id']}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            // Ubicación de entrega
            _buildOrderDetail(Icons.location_on, order['location']),
            const SizedBox(height: 10),
            // Fecha de entrega
            _buildOrderDetail(Icons.calendar_today, 'Fecha de entrega: ${order['deliveryDate']}'),
            const SizedBox(height: 20),
            // Estado actual
            Text(
              'Estado: ${order['status']}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _getStatusColor(order['status']),
              ),
            ),
            const SizedBox(height: 20),
            // Botones para cambiar estado
            _buildStatusButtons(index, order['status']),
            if (order['status'] == 'Entregado' && order['image'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        order['image'],
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Descripción: ${order['description']}',
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFB792C6)),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildStatusButtons(int index, String currentStatus) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatusButton('En Tienda', currentStatus == 'En Tienda', () {
          _changeStatus(index, 'En Tienda');
        }),
        _buildStatusButton('En Camino', currentStatus == 'En Camino', () {
          _changeStatus(index, 'En Camino');
        }),
        _buildStatusButton('Entregado', currentStatus == 'Entregado', () {
          _changeStatus(index, 'Entregado');
        }),
      ],
    );
  }

  Widget _buildStatusButton(String label, bool isActive, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? const Color(0xFFB792C6) : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'En Tienda':
        return Colors.orange;
      case 'En Camino':
        return Colors.blue;
      case 'Entregado':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}

// Diálogo para confirmar la entrega
class DeliveryConfirmationDialog extends StatefulWidget {
  const DeliveryConfirmationDialog({super.key});

  @override
  State<DeliveryConfirmationDialog> createState() => _DeliveryConfirmationDialogState();
}

class _DeliveryConfirmationDialogState extends State<DeliveryConfirmationDialog> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _confirmDelivery() {
    if (_image == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, sube una imagen y escribe una descripción')),
      );
    } else {
      Navigator.pop(context, {
        'image': _image,
        'description': _descriptionController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Subir imagen
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: _image == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, color: const Color(0xFFB792C6)),
                          const SizedBox(height: 10),
                          Text(
                            'Subir imagen',
                            style: TextStyle(
                              color: const Color(0xFFB792C6),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            // Campo de descripción
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                labelStyle: TextStyle(color: const Color(0xFFB792C6)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFB792C6)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            // Botón de confirmar
            ElevatedButton(
              onPressed: _confirmDelivery,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB792C6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'Confirmar Entrega',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}