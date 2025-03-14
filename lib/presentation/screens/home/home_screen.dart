import 'package:flutter/material.dart';
import 'package:app_innova_delivery/presentation/screens/orders/orders_screen.dart';
import 'package:app_innova_delivery/presentation/screens/notifications/notifications_screen.dart';
import 'package:app_innova_delivery/presentation/screens/profile/profile_screen.dart';
import 'package:app_innova_delivery/presentation/screens/deliveries/deliveries_screen.dart';
import 'package:app_innova_delivery/presentation/screens/delivery/order_history_screen.dart';
import 'package:app_innova_delivery/presentation/screens/auth/login_screen.dart';

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
      duration: const Duration(milliseconds: 400),
    );
    _animation = Tween<double>(begin: 0, end: 0.75).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart), // Curva personalizada
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Barra lateral
          _buildSidebar(screenHeight, screenWidth * 0.7),
          // Pantalla principal con GestureDetector para cerrar la barra lateral
          GestureDetector(
            onTap: _closeSidebar,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              transform: Matrix4.translationValues(_animation.value * screenWidth, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(_isSidebarOpen ? 20.0 : 0.0),
                ),
                child: AbsorbPointer(
                  absorbing: _isSidebarOpen,
                  child: Container(
                    color: _isSidebarOpen ? Color.fromRGBO(0, 0, 0, 0.3) : Colors.white,
                    child: _buildMainScreen(),
                  ),
                ),
              ),
            ),
          ),
          // Botón de menú
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 32),
              onPressed: _toggleSidebar,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(double screenHeight, double sidebarWidth) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: _isSidebarOpen ? sidebarWidth : 0,
      height: screenHeight,
      decoration: BoxDecoration(
        color: const Color(0xFFB792C6),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0),
        ),
        child: Column(
          children: [
            // Encabezado del Drawer
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFB792C6),
              ),
              child: DrawerHeader(
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
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.white),
                    title: const Text(
                      'Cerrar Sesión',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Cerrar sesión'),
                          content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                );
                              },
                              child: const Text('Cerrar sesión'),
                            ),
                          ],
                        ),
                      );
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

  Widget _buildMainScreen() {
    return Column(
      children: [
        // Encabezado con logo
        _buildHeader(),
        // Contenido principal
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: const Color(0xFFB792C6),
      child: Image.asset(
        'assets/logo.png',
        width: 100,
        height: 100,
      ),
    );
  }

  Widget _buildProcessGrid() {
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 3, // Responsivo para tablets
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
            MaterialPageRoute(builder: (context) => DeliveriesScreen()),
          );
        }),
      ],
    );
  }

  Widget _buildNotificationList() {
    // Ejemplo de notificaciones dinámicas (puedes cargarlas desde una API)
    final notifications = [
      {'title': 'Pedido #32456', 'address': 'Calle 123, Ciudad', 'time': '10:00 AM'},
      {'title': 'Pedido #32457', 'address': 'Avenida 456, Ciudad', 'time': '09:30 AM'},
      {'title': 'Pedido #32458', 'address': 'Calle 789, Ciudad', 'time': '08:45 AM'},
    ];

    return Column(
      children: notifications.map((notification) {
        return _buildNotificationCard(
          notification['title']!,
          notification['address']!,
          notification['time']!,
        );
      }).toList(),
    );
  }

  Widget _buildSidebarOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 28),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
      onTap: onTap,
    );
  }

  Widget _buildProcessCard(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
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