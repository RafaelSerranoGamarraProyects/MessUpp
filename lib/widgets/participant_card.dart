import 'package:flutter/material.dart';

class ParticipantCard extends StatelessWidget {
  final String username;
  final VoidCallback onDeletePressed;

  const ParticipantCard({
    super.key,
    required this.username,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Foto circular
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/userPlaceholder.png'),
              radius: 30.0,
            ),
            const SizedBox(width: 16.0),
            // Nombre de usuario
            Expanded(
              child: Text(
                username,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            // Botón de eliminar
            IconButton(
              onPressed: onDeletePressed, 
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
