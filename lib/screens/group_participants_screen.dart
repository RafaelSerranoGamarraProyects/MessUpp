import 'package:messup/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class ParticipantsScreen extends StatelessWidget {

	bool isInGroup(Group group, User user) {
		return group.participants.contains(user.email) || group.participants.contains(user.userName);
	}
	 
	const ParticipantsScreen({super.key});
	
	@override
	Widget build(BuildContext context) {
		final Group group = ModalRoute.of(context)!.settings.arguments as Group;
		final groupProvider = Provider.of<GroupsProvider>(context);
		return  Scaffold(
			appBar: AppBar(title: Row(
			  children: [
					ReturnToButton(route: "group_details", arguments: group),
			    const Text("Participantes del grupo", style: TextStyle(color: Colors.white)),
			  ],
			),),
			resizeToAvoidBottomInset: false,
			body: Center(
				 child: Stack(
						children: [
							const Background(),
					 		Expanded(child:	Center(
      							child: ListView.builder(
										itemCount: group.participants.length,
										itemBuilder: (context, index) =>  ParticipantCard(username: group.participants[index],
										 onDeletePressed: () {
										  group.participants.removeAt(index);
											groupProvider.updateParticipants(group);
											if (group.participants.isEmpty) {
												groupProvider.deleteGroup(group);
											}
											if (isInGroup(group, groupProvider.userInfo) == false ) {
												Navigator.pushReplacementNamed(context, "groups");
											}
										},
									))
      					),
							),			
					],	
				),
			)
		);
	}
}

