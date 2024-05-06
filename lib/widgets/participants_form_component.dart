import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../theme/custom_styles.dart';
import 'widgets.dart';

class AddParticipantForm extends StatefulWidget {
  const AddParticipantForm({super.key});

  @override
  AddParticipantFormState createState() => AddParticipantFormState();
}

class AddParticipantFormState extends State<AddParticipantForm> {
  final TextEditingController _controller = TextEditingController();
  List<String> participants = [];

  @override
  Widget build(BuildContext context) {
		final creationGroupProvider = Provider.of<CreateGroupProvider>(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del participante',
										fillColor: Colors.white, // Fondo blanco
    								filled: true,
    								labelStyle: TextStyle(color: AppTheme.textColorSecundary), // Color del texto de la etiqueta
    								hintStyle: TextStyle(color: AppTheme.textColorSecundary),
                  ),
                ),
              ),
            const SizedBox(width: 8.0),
              ElevatedButton(
								style: ElevatedButton.styleFrom(backgroundColor: AppTheme.secondaryBlue),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    setState(() {
                      participants.add(_controller.text);
											creationGroupProvider.updateParticipants(participants);
                      _controller.clear();
                    });
                  }
                },
                child: const Text('Añadir'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 450,
          child: ListView.builder(
            itemCount: participants.length,
            itemBuilder: (context, index) {
              return ParticipantItem(participants: participants, index: index);
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}