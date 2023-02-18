import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class GroupScreen extends StatelessWidget {
	 
	const GroupScreen({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Tricount App'),),
			drawer: const Drawer(child: MyDrawer()),
			body: Stack(
			children: [
				const Background(),
					 Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children:  [
							 Container(
								color: Colors.amber,
								height: 700,
      					child: ListView.builder(
								itemCount: 10,
								itemBuilder: (context, index) =>  const GroupItem()
      					),
							 )	
						],
					 ),			
				],)
			);	
	}
}

class GroupItem extends StatelessWidget {
  const GroupItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  const ListTile(
			title: Text("Nombre del grupo"),
			leading: Icon(Icons.people),
		);
  }
}