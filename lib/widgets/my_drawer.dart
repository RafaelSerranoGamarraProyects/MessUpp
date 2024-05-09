import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../theme/custom_styles.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      	children: [
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
		final usersProvider = Provider.of<UsersProvider>(context);
		return Container(
			color: AppTheme.primaryColor,
			width: double.infinity,
			height: 200,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					usersProvider.userLogged!.image != null ? const CacheImage() : const DrawerUserImagePlaceholder(),
					Text(usersProvider.userLogged!.getUserName, style: const TextStyle(color: AppTheme.textColorPrimary, fontWeight: FontWeight.bold, fontSize: 20),),
				],

			),
		);
	}
}

class CacheImage extends StatelessWidget {
  const CacheImage({
    super.key,
  
  });

  @override
  Widget build(BuildContext context) {
		final usersProvider = Provider.of<UsersProvider>(context);
    return CachedNetworkImage(
    		imageUrl: usersProvider.userLogged!.image!,
    		imageBuilder: (context, imageProvider) => 
    	    Container(
    				margin: const EdgeInsets.only(bottom: 10),
    				height: 120,
    	    	decoration: BoxDecoration(
    					shape: BoxShape.circle,
    					color: Colors.white,
    	      	image: DecorationImage(
    	          image: imageProvider,
    	          fit: BoxFit.contain,
    	    		),
    				),   
    	    ),   
    	 placeholder: (context, url) => const DrawerUserImagePlaceholder(),
    	 
    	);
  }
}

class DrawerUserImagePlaceholder extends StatelessWidget {
  const DrawerUserImagePlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
			margin: const EdgeInsets.only(bottom: 10),
			height: 120,
     	decoration: const BoxDecoration(
				shape: BoxShape.circle,
				color: Colors.white,
       	image: DecorationImage(
           image:AssetImage("assets/images/userPlaceholder.png"),
           fit: BoxFit.scaleDown,
     		),
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
					usersProvider.user = "";
					usersProvider.logOut();
					Navigator.pushReplacementNamed(context, 'login');
				} ,
    		trailing: const Icon(Icons.logout_outlined, color: AppTheme.errorColor,),
    		title: const Text("Cerrar Sesión",style: TextStyle(color: AppTheme.errorColor, fontWeight: FontWeight.bold, fontSize: 20),),
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
    			title: Text(option.name,style: const TextStyle(color: AppTheme.textColorSecundary, fontWeight: FontWeight.bold, fontSize: 20),),
    		),
			),
		);
	}
}