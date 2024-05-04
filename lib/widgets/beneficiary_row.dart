// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../theme/custom_styles.dart';

class ParticipantRow extends StatefulWidget {
  final TransactionBeneficiary participant;

  const ParticipantRow({Key? key, required this.participant}) : super(key: key);

  @override
  _ParticipantRowState createState() => _ParticipantRowState();
}

class _ParticipantRowState extends State<ParticipantRow> {
  @override
  Widget build(BuildContext context) {
    final creationGroupExpenseProvider = Provider.of<CreateGroupExpenseProvider>(context);
    return Card(
      child: ListTile(
        title: Text(
          widget.participant.name,
          style: const TextStyle(color: AppTheme.primaryColor, fontSize: 19),
        ),
        trailing: Checkbox(
          checkColor: AppTheme.primaryColor,
          fillColor: MaterialStateProperty.all(Colors.white),
          value: widget.participant.isBeneficiary,
          onChanged: (newValue) {
            setState(() {
              if (newValue != null) {
                widget.participant.isBeneficiary = newValue;
                creationGroupExpenseProvider.updateBeneficiaries(widget.participant);
              }
            });
          },
        ),
      ),
    );
  }
}
