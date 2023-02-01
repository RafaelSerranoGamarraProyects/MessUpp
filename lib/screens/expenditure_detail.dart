import 'package:flutter/material.dart';
import 'package:tfg_app/models/expenditure.dart';

import '../widgets/widgets.dart';


class ExpenditureScreen extends StatelessWidget {
	const ExpenditureScreen({super.key});

	@override
	Widget build(BuildContext context) {
		final Expenditure expenditure = ModalRoute.of(context)!.settings.arguments as Expenditure;

		return Scaffold(
			appBar: AppBar(elevation: 0,title: Text("Detalles: \"${expenditure.description}\""),),
			drawer: const  Drawer(child:  MyDrawer()),
			body: SizedBox(
				height: double.infinity,
				width: double.infinity,
				child: Column(
					children: [
						//TODO:Imagen del gasto, ver como subir imagenes a internet
						Text("Fecha: ${expenditure.date.day}-${expenditure.date.month}-${expenditure.date.year}"),
						Text("Gasto: ${expenditure.amount}"),
						Text("Categoria: ${expenditure.category}"),
				]),
			),
		);
	}
}