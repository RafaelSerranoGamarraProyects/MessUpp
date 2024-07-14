import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:messup/providers/providers.dart';
import '../../theme/custom_styles.dart';
import '../../widgets/widgets.dart';

class GroupScreen extends StatelessWidget {
	 
	const GroupScreen({super.key});
	
	@override
	Widget build(BuildContext context) {
		final groupProvider = Provider.of<GroupsProvider>(context);
		final size = MediaQuery.of(context).size;
		return Scaffold(
			appBar: AppBar(title: const Text('Grupos', style: TextStyle(color: AppTheme.textColorPrimary)), iconTheme: const IconThemeData(color: AppTheme.textColorPrimary)),
			drawer: const Drawer(child: MyDrawer()),
			resizeToAvoidBottomInset: false,
			body: Stack(
			children: [
				const Background(),
					 Column(
						children:  [
							 Container(
								padding: const EdgeInsets.only(top: 5),
								alignment: Alignment.center,
								height: size.height - 170,
      					child: ListView.builder(
									itemCount: groupProvider.userGroups.length,
									itemBuilder: (_, index) =>  GroupItem(userGroup: groupProvider.userGroups[index])
      					),
							 ),
							 	Container(
									padding: const EdgeInsets.only(bottom: 20),
									alignment: Alignment.bottomCenter,
									height: 90,
									width: size.width,
									child: const PopUpFormAddGroupPayment()
								),		
						],
					 ),			
				],)
			);	
	}
}

