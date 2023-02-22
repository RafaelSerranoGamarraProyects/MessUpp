import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/models/models.dart';

import '../providers/providers.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      	children: const [
      		MyDrawerHeader(),
      		MyDrawerOptions(),
      	],	
    );
  }
}

class MyDrawerHeader extends StatelessWidget {
	const MyDrawerHeader({super.key});

	@override
	Widget build(BuildContext context) {
		//TODO: Use the userLogged in the provider to write the username in the drawer aswell as the profile picture
		final usersProvider = Provider.of<UsersProvider>(context);
		return Container(
			color: Colors.deepPurple,
			width: double.infinity,
			height: 200,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Container(
						margin: const EdgeInsets.only(bottom: 10),
						height: 120,
						decoration: const BoxDecoration(
							shape: BoxShape.circle,
							image: DecorationImage(
								fit: BoxFit.contain,
								image: 
								NetworkImage('https://marketplace.canva.com/EAFEits4-uw/1/0/1600w/canva-boy-cartoon-gamer-animated-twitch-profile-photo-oEqs2yqaL8s.jpg'),
							)
						),
					),
					Text(usersProvider.user,style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
					//Text(usersProvider.user.email,style: const TextStyle(color: Colors.white, fontSize: 16),)
				],

			),
		);
	}
}

class MyDrawerOptions extends StatelessWidget {
	static List<DrawerOption> menuOptions = DrawerOptions().options;
	
	const MyDrawerOptions({super.key});
	@override
	Widget build(BuildContext context) {
		return Column(
			children:  [
				SizedBox(
					height: 600,
				  child: ListView.builder(
				  	itemCount: menuOptions.length,
				  	itemBuilder: (_, index) =>  _CustomMenuItem(option: menuOptions[index]),
				  ),
				),
				const LogOutOption(),
			]);
	}
}

class LogOutOption extends StatelessWidget {
  const LogOutOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
		final usersProvider = Provider.of<UsersProvider>(context);
    return Card(
    	elevation: 3,
    	color: Colors.white.withOpacity(1),
			
    	shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    	child: ListTile(
    		onTap: () {
					usersProvider.logOut();
					Navigator.pushReplacementNamed(context, 'login');
				} ,
    		trailing: const Icon(Icons.logout_outlined, color: Colors.red,),
    		title: const Text("Cerrar Sesión",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),),
    	),
		);
  }
}

class _CustomMenuItem extends StatelessWidget {
	final DrawerOption option;
	const _CustomMenuItem({required this.option});

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.only(bottom:5.0),
			child: Card(
				elevation: 3,
				color: Colors.white.withOpacity(1),
				shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
				child: ListTile(
					onTap: () => Navigator.pushReplacementNamed(context, option.route),
    			trailing: Icon(option.icon,color: Colors.black,),
    			title: Text(option.name,style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
    		),
			),
		);
	}
}