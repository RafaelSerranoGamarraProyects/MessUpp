import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Messup/providers/providers.dart';
import 'package:Messup/widgets/popup_add_group_payment.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class GroupScreen extends StatelessWidget {
	 
	const GroupScreen({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		final groupProvider = Provider.of<GroupsProvider>(context);
		final size = MediaQuery.of(context).size;
		return Scaffold(
			appBar: AppBar(title: const Text('Grupos', style: TextStyle(color: Colors.white))),
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

class GroupItem extends StatefulWidget {
	final Group userGroup;
  const GroupItem({
    super.key, required this.userGroup,
  });

  @override
  State<GroupItem> createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
				Card(
					color: Colors.white,
					child: ListTile(
						trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.black, size: 30),
						title: Text(widget.userGroup.name,style: const TextStyle(color: Colors.black, fontSize: 20),),
						onTap: () => Navigator.pushReplacementNamed(context, 'group_details', arguments: widget.userGroup),
						//leading: Container(height: 50,width: 50,decoration: const BoxDecoration(color: Colors.amber,shape: BoxShape.circle),child: Container(),)
					),
				)
      ],
    );
  }
}