import 'package:flutter/material.dart';
import 'package:messup/models/models.dart';

import 'widgets.dart';

class BeneficiariesList extends StatefulWidget {
  final Group group;

  const BeneficiariesList({Key? key, required this.group}) : super(key: key);

  @override
  BeneficiariesListState createState() => BeneficiariesListState();
}

class BeneficiariesListState extends State<BeneficiariesList> {
  final TextEditingController _controller = TextEditingController();
  late List<TransactionBeneficiary> participants;

  @override
  void initState() {
    super.initState();
		participants = mapStringsToBeneficiaries(widget.group.participants);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        itemCount: participants.length,
        itemBuilder: (context, index) {
          return ParticipantRow(participant: participants[index]);
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
