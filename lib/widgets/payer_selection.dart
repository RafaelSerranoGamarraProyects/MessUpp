import 'package:messup/theme/custom_styles.dart';
import 'package:flutter/material.dart';

class PayerDropdown extends StatefulWidget {
  final List<String> participants;
  final Function(String) onPayerSelected;

  const PayerDropdown({super.key, required this.participants, required this.onPayerSelected});

  @override
  // ignore: library_private_types_in_public_api
  _PayerDropdownState createState() => _PayerDropdownState();
}

class _PayerDropdownState extends State<PayerDropdown> {
  String? _selectedPayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        color: Colors.white,
        child: DropdownButtonFormField<String>(
          validator: (value) => CustomValidators.notEmptyField(value: value),
          value: _selectedPayer,
          items: widget.participants.map((participant) {
            return DropdownMenuItem<String>(
              value: participant,
              child: Text(participant),
            );
          }).toList(),
          onChanged: (selectedPayer) {
            setState(() {
              _selectedPayer = selectedPayer;
            });
            widget.onPayerSelected(selectedPayer!);
          },
          decoration: InputDecorations.dropDownMenuInputDecoration(labelText: 'Seleccione un pagador', icon: Icons.money),
          onTap: () {
            FocusScope.of(context).unfocus(); // Cierra el teclado si está abierto
          },
        ),
      ),
    );
  }
}
