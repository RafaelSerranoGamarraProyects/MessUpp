import 'dart:io';

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
			appBar: AppBar(title: const Text('Tricount App'),),
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

class GroupItem extends StatelessWidget {
	final Group userGroup;
  const GroupItem({
    super.key, required this.userGroup,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
				Card(
					color: Colors.white.withOpacity(0.4),
					child: ListTile(
						trailing: const Icon(Icons.keyboard_arrow_right_outlined,color: Colors.white, size: 30,),
						title: Text(userGroup.name,style: const TextStyle(color: Colors.white, fontSize: 20),),
						//leading: Container(height: 50,width: 50,decoration: const BoxDecoration(color: Colors.amber,shape: BoxShape.circle),child: Container(),)
					),
				)
      ],
    );
  }

/*   Widget groupImage(String url) {
		if(url == "no-image") {
		  return  const Image(
          image: AssetImage('assets/images/no-image.jpg'),
          fit: BoxFit.fill,
        );
		}
		if(url.startsWith('http')) {
		  return  FadeInImage(
          image: NetworkImage( url ),
          placeholder: const AssetImage('assets/images/loading-gif.gif'),
          fit: BoxFit.fill,
        );
		} 
		else{
			return Image.file(
      File( url ),
      fit: BoxFit.fill,
    );
		}
	} */
}