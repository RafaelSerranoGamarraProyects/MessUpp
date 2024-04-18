import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
class AddGroupName extends StatefulWidget {
  const AddGroupName({super.key});

  @override
  AddGroupNameState createState() => AddGroupNameState();
}

class AddGroupNameState extends State<AddGroupName> {
  final TextEditingController _controller = TextEditingController();
  List<String> participants = [];

  @override
  Widget build(BuildContext context) {
		final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Nombre del Grupo',
										fillColor: Colors.white, // Fondo blanco
    								filled: true,
    								labelStyle: TextStyle(color: Colors.black), // Color del texto de la etiqueta
    								hintStyle: TextStyle(color: Colors.black),
          ),
					onChanged: (value) {
						createGroupProvider.name = value;
					},
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

