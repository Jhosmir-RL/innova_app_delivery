import 'package:flutter/material.dart';
import 'package:app_innova_delivery/presentation/screens/orders/orders_screen.dart';
import 'package:app_innova_delivery/presentation/screens/notifications/notifications_screen.dart';
import 'package:app_innova_delivery/presentation/screens/profile/profile_screen.dart';
import 'package:app_innova_delivery/presentation/screens/settings/settings_screen.dart';
import 'package:app_innova_delivery/presentation/screens/deliveries/deliveries_screen.dart';
import 'package:app_innova_delivery/presentation/screens/delivery/order_history_screen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isSidebarOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 0.7).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
      if (_isSidebarOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _closeSidebar() {
    if (_isSidebarOpen) {
      _toggleSidebar();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final sidebarWidth = screenWidth * 0.7;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Barra lateral
          _buildSidebar(screenHeight, sidebarWidth),
          // Pantalla principal con GestureDetector para cerrar la barra lateral
          GestureDetector(
            onTap: _closeSidebar,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: Matrix4.translationValues(_animation.value * screenWidth, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(_isSidebarOpen ? 20.0 : 0.0),
                ),
                child: _buildMainScreen(screenWidth, screenHeight),
              ),
            ),
          ),
          // Botón de menú
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: _toggleSidebar,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(double screenHeight, double sidebarWidth) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _isSidebarOpen ? sidebarWidth : 0,
      height: screenHeight,
      decoration: BoxDecoration(
        color: const Color(0xFFB792C6), // Color de la barra lateral
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0), // Esquina inferior curvada
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0), // Esquina inferior curvada
        ),
        child: Column(
          children: [
            // Encabezado del Drawer
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFB792C6), // Mismo color que la barra lateral
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/profile.png'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Usuario 08',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            // Opciones de la barra lateral
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildSidebarOption(Icons.notifications, 'Historial de notificaciones', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationsScreen()),
                    );
                  }),
                  _buildSidebarOption(Icons.person, 'Perfil', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  }),
                  _buildSidebarOption(Icons.settings, 'Configuración', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  }),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.white),
                    title: const Text(
                      'Cerrar Sesión',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Lógica para cerrar sesión
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainScreen(double screenWidth, double screenHeight) {
    return Column(
      children: [
        // Encabezado con logo
        Container(
          width: screenWidth,
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: const Color(0xFFB792C6),
          child: Image.asset(
            'assets/logo.png',
            width: screenWidth * 0.3,
            height: screenWidth * 0.3,
          ),
        ),
        // Contenido principal
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/frase.png'),
                const SizedBox(height: 20),
                const Text(
                  'Procesos',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 10),
                _buildProcessGrid(),
                const SizedBox(height: 20),
                const Text(
                  'Notificaciones',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 10),
                _buildNotificationList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProcessGrid() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1,
      children: [
        _buildProcessCard(Icons.list, 'Pedidos Pendientes', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrdersScreen()),
          );
        }),
        _buildProcessCard(Icons.check_circle, 'Pedidos Finalizados', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderHistoryScreen()),
          );
        }),
        _buildProcessCard(Icons.edit, 'Cambiar Estado de Pedido', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DeliveriesScreen()), // Navegación a OrderDetailsScreen
          );
        }),
      ],
    );
  }

  Widget _buildNotificationList() {
    return Column(
      children: [
        _buildNotificationCard('Pedido #32456', 'Calle 123, Ciudad', '10:00 AM'),
        _buildNotificationCard('Pedido #32457', 'Avenida 456, Ciudad', '09:30 AM'),
        _buildNotificationCard('Pedido #32458', 'Calle 789, Ciudad', '08:45 AM'),
      ],
    );
  }

  Widget _buildSidebarOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  Widget _buildProcessCard(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        color: const Color(0xFFB792C6),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.white),
              const SizedBox(height: 5),
              Text(title, style: const TextStyle(fontSize: 12, color: Colors.white), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(String title, String address, String time) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: const Icon(Icons.notifications, color: Color(0xFFB792C6)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(address),
            Text(time, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}