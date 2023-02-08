import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/providers/objetives_provider.dart';
import 'package:tfg_app/providers/users_provider.dart';
import 'widgets.dart';


class ObjetiveView extends StatelessWidget {
	const ObjetiveView({super.key});
	

	@override
	Widget build(BuildContext context) {
		final userProvider = Provider.of<UsersProvider>(context);
		return ChangeNotifierProvider(
			create: (_) => ObjetivesProvider(userProvider.user), lazy: false,
			child: Stack(
				children: const  [
					Background(),
					ObjetiveScreenBody()
				]),
			);
		
	}
}

class ObjetiveScreenBody extends StatelessWidget {
	const ObjetiveScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
		final objetivesProvider = Provider.of<ObjetivesProvider>(context);
		
		if(objetivesProvider.spentByCategoryList == []) return const CircularProgressIndicator();
    return Column(
			children: const [
				OverViewGraph(),
				Divider(color: Colors.white, thickness: 2,),
			  Details()
			],
    );
  }
}

class _ObjetiveDescription extends StatelessWidget {
  const _ObjetiveDescription({
    required this.objetivesProvider,
  });

  final ObjetivesProvider objetivesProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(objetivesProvider.monthlyObjetive.description,
       style: const TextStyle(color: Colors.white, fontSize: 16,),),
    );
  }
}

class _ObjetiveTitle extends StatelessWidget {
  const _ObjetiveTitle({
    super.key,
    required this.objetivesProvider,
  });

  final ObjetivesProvider objetivesProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Objetivo del Mes de ${objetivesProvider.monthlyObjetive.date.month}',
       style: const TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold),),
    );
  }
}

class Details extends StatelessWidget {
  const Details({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
			padding: const EdgeInsets.all(8),
    	height: 400,
    	width: double.infinity,
			child: Expanded(
							child: Column(
								children: [
									Container(
										alignment: Alignment.topLeft,
										padding: const EdgeInsets.all(8),
										child: const Text("Detalles", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
									
									const ListCategoryCards(),
								],
							),
						),
    );
  }
}




class OverViewGraph extends StatelessWidget {
  
	const OverViewGraph({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
		final objetivesProvider = Provider.of<ObjetivesProvider>(context);
    return Expanded(

			child: Column(children: [
				_ObjetiveTitle(objetivesProvider: objetivesProvider),
				_ObjetiveDescription(objetivesProvider: objetivesProvider),
				HorizontalBarChart(data : objetivesProvider.spentByCategoryList)
			]),
    );
  }
}





