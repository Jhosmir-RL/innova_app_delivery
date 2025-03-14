import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final List<Map<String, dynamic>> _allOrders = [
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

  List<Map<String, dynamic>> _filteredOrders = [];
  String _searchQuery = '';
  String _selectedStatus = 'Todos';

  @override
  void initState() {
    super.initState();
    _filteredOrders = _allOrders;
  }

  void _filterOrders() {
    setState(() {
      _filteredOrders = _allOrders.where((order) {
        final matchesStatus = _selectedStatus == 'Todos' || order['status'] == _selectedStatus;
        final matchesSearch = order['orderNumber'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            order['location'].toLowerCase().contains(_searchQuery.toLowerCase());
        return matchesStatus && matchesSearch;
      }).toList();
    });
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: OrderSearchDelegate(_allOrders, _filterOrders),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatusFilter(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _filteredOrders.length,
              itemBuilder: (context, index) {
                final order = _filteredOrders[index];
                return _buildOrderCard(order, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ['Todos', 'Tienda', 'En camino', 'Entregado'].map((status) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text(status),
                selected: _selectedStatus == status,
                onSelected: (selected) {
                  setState(() {
                    _selectedStatus = selected ? status : 'Todos';
                    _filterOrders();
                  });
                },
                selectedColor: const Color(0xFFB792C6),
                labelStyle: TextStyle(
                  color: _selectedStatus == status ? Colors.white : Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pedido ${order['orderNumber']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB792C6),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.map, color: Color(0xFFB792C6)),
                    onPressed: () => _showMap(order['location']),
                  ),
                ],
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

  void _showMap(String address) {
    final LatLng location = _getLocationFromAddress(address); // Simulación
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubicación del Cliente'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: location,
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('customer_location'),
                position: location,
              ),
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  LatLng _getLocationFromAddress(String address) {
    // Simulación de conversión de dirección a coordenadas
    return const LatLng(19.4326, -99.1332); // Coordenadas de Ciudad de México
  }
}

class OrderSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> orders;
  final VoidCallback onFilterChanged;

  OrderSearchDelegate(this.orders, this.onFilterChanged);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final results = orders.where((order) {
      return order['orderNumber'].toLowerCase().contains(query.toLowerCase()) ||
          order['location'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final order = results[index];
        return ListTile(
          title: Text('Pedido ${order['orderNumber']}'),
          subtitle: Text(order['location']),
          onTap: () {
            close(context, order['orderNumber']);
          },
        );
      },
    );
  }
}