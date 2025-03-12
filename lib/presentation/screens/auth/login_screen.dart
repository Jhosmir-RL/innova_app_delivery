import 'package:flutter/material.dart';
import 'package:app_innova_delivery/presentation/screens/home/home_screen.dart'; // Importamos home_screen.dart

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  void _login(BuildContext context) {
    // Aquí iría la lógica para autenticar al usuario
    final email = _emailController.text;
    final password = _passwordController.text;

    // Simulación de autenticación exitosa
    if (email.isNotEmpty && password.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()), // Redirigir a HomeScreen
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa tus credenciales')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFB792C6), // Color de fondo
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.1), // Espacio superior
          child: Center(
            child: Column(
              children: [
                _buildLogo(screenWidth),
                SizedBox(height: screenHeight * 0.05), // Espacio entre logo y formulario
                _buildLoginForm(context, screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(double screenWidth) {
    return Image.asset(
      'assets/logo.png', // Asegúrate de tener el logo en la carpeta assets
      width: screenWidth * 0.5, // 50% del ancho de la pantalla
      height: screenWidth * 0.5, // 50% del ancho de la pantalla
    );
  }

  Widget _buildLoginForm(BuildContext context, double screenWidth) {
    return Container(
      width: screenWidth * 0.9, // 90% del ancho de la pantalla
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25), // Usamos withAlpha en lugar de withOpacity
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Iniciar Sesión',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFB792C6),
            ),
          ),
          const SizedBox(height: 20),
          _buildEmailField(),
          const SizedBox(height: 20),
          _buildPasswordField(),
          const SizedBox(height: 30),
          _buildLoginButton(context),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Correo Electrónico',
        labelStyle: TextStyle(color: const Color(0xFFB792C6)),
        prefixIcon: Icon(Icons.email, color: const Color(0xFFB792C6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color(0xFFB792C6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color(0xFFB792C6), width: 2),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        labelStyle: TextStyle(color: const Color(0xFFB792C6)),
        prefixIcon: Icon(Icons.lock, color: const Color(0xFFB792C6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color(0xFFB792C6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color(0xFFB792C6), width: 2),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _login(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB792C6),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Iniciar Sesión',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}