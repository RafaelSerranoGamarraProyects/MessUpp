import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../theme/custom_styles.dart';

class ParticipantItem extends StatelessWidget {
  const ParticipantItem({
    super.key,
    required this.participants,
		required this.index
  });

  final List<String> participants;
	final int index;

  @override
  Widget build(BuildContext context) {
		final creationGroupProvider = Provider.of<CreateGroupProvider>(context);

    return Row(
			children: [
				Expanded(flex: 7,child: Container(
					alignment: Alignment.center ,height: 50,
				 	child: Text(participants[index], style: const TextStyle(color: AppTheme.textColorPrimary, fontWeight: FontWeight.bold, fontSize: 17),)),),
				Expanded(
					flex: 3,
					child: ElevatedButton(
						onPressed: () {
							participants.removeAt(index);
							creationGroupProvider.updateParticipants(participants);
						},
						child: const Icon(Icons.restore_from_trash_sharp)
					),
				)
			],
    );
  }
}