import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Perfil")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Nombre"),
              controller: TextEditingController(text: "Juan Pérez"),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: "Correo Electrónico"),
              controller: TextEditingController(text: "juan.perez@example.com"),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: "Teléfono"),
              controller: TextEditingController(text: "+51 987 654 321"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Guardar cambios en el perfil
                Navigator.pop(context);
              },
              child: Text("Guardar Cambios"),
            ),
          ],
        ),
      ),
    );
  }
}
