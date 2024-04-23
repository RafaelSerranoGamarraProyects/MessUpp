// ignore_for_file: library_private_types_in_public_api

import 'package:Messup/theme/custom_validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class AddGroupDebtName extends StatefulWidget {
  const AddGroupDebtName({super.key});

  @override
  AddGroupDebtState createState() => AddGroupDebtState();
}

class AddGroupDebtState extends State<AddGroupDebtName> {
  final TextEditingController _controller = TextEditingController();
  List<String> participants = [];

  @override
  Widget build(BuildContext context) {
		final createGroupExpense = Provider.of<CreateGroupExpenseProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Expanded(
        child: TextFormField(
          controller: _controller,
          validator: (value) => CustomValidators.notEmptyField(value: value),
          decoration: const InputDecoration(
            labelText: 'Entrada del Cine',
										fillColor: Colors.white, // Fondo blanco
    								filled: true,
    								labelStyle: TextStyle(color: Colors.black), // Color del texto de la etiqueta
    								hintStyle: TextStyle(color: Colors.black),
          ),
					onChanged: (value) {
						createGroupExpense.name = value;
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

class AddGroupDebtAmount extends StatefulWidget {
  const AddGroupDebtAmount({Key? key}) : super(key: key);

  @override
  _AddGroupDebtAmountState createState() => _AddGroupDebtAmountState();
}

class _AddGroupDebtAmountState extends State<AddGroupDebtAmount> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final createGroupExpense = Provider.of<CreateGroupExpenseProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextFormField(
        controller: _controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true), // Acepta números decimales
        validator: (value) => CustomValidators.notEmptyField(value: value.toString()),
        decoration: const InputDecoration(
          labelText: 'Monto',
          fillColor: Colors.white,
          filled: true,
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.black),
        ),
        onChanged: (value) {
          createGroupExpense.amount = double.tryParse(value) ?? 0.0;
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

