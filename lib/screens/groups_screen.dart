import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/providers/providers.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class GroupScreen extends StatelessWidget {
	 
	const GroupScreen({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		final groupProvider = Provider.of<GroupsProvider>(context);
		final size = MediaQuery.of(context).size;
		return Scaffold(
			appBar: AppBar(title: const Text('Tricount App', style: TextStyle(color: Colors.white))),
			drawer: const Drawer(child: MyDrawer()),
			body: Stack(
			children: [
				const Background(),
					 Column(
						children:  [
							 Container(
								padding: const EdgeInsets.only(top: 5),
								alignment: Alignment.center,
								height: size.height - 110,
      					child: ListView.builder(
									itemCount: groupProvider.userGroups.length,
									itemBuilder: (_, index) =>  GroupItem(userGroup: groupProvider.userGroups[index])
      					),
							 )	
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
					color: Colors.white.withOpacity(0.4),
					child: ListTile(
						trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.white, size: 30,),
						title: Text(widget.userGroup.name,style: const TextStyle(color: Colors.white, fontSize: 20),),
						onTap: () => Navigator.pushReplacementNamed(context, 'group_details', arguments: widget.userGroup),
						//leading: Container(height: 50,width: 50,decoration: const BoxDecoration(color: Colors.amber,shape: BoxShape.circle),child: Container(),)
					),
				)
      ],
    );
  }
}