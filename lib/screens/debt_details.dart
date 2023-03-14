import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfg_app/widgets/my_drawer.dart';
import 'package:uuid/uuid.dart';

import '../models/models.dart';
import '../widgets/background.dart';

class DebtDetailScreen extends StatelessWidget {
	 
	const DebtDetailScreen({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		return  Scaffold(
			appBar: AppBar(title: const Text("TricountApp"),),
			drawer: const Drawer(child: MyDrawer(),),
			body:  Stack(
			  children: const [
			    Background(),
			    _ScreenBody(),
			  ]
			),
		);
	}
}

class _ScreenBody extends StatelessWidget {
  const _ScreenBody();
	

  @override
  Widget build(BuildContext context) {
		const uuid = Uuid();
		final upiId = uuid.v1();
		final Debt debt = ModalRoute.of(context)!.settings.arguments as Debt;
		String formattedDate = DateFormat('dd-MM-yyyy').format(debt.date); 

    return SafeArea(
			child: Container(
				padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  			height: double.infinity,
  			width: double.infinity,
  			child: Column(
  			  children:  [

						_CustomText(text: formattedDate),

						Container(
							color: Colors.white.withOpacity(0.9),
							child: Container(height: 300, width: 300, color: Colors.white,), //TODO: do the payment via qr
						),
						const _CustomText(text: 'Escanea el QR para efectuar el pago',size: 12),
						_CustomText(text: '${debt.amount.toStringAsFixed(2)}€'),
						Container(
							alignment: Alignment.bottomCenter,
							height: 300,
							padding: const EdgeInsets.symmetric(horizontal: 30),
							child: const _CustomText(text: '1. Presione "Escanea tu QR de Messupp"\n\n2. Apunte con la camara al codigo QR\n\n3. Ha efectuado su pago con exito',size: 18,),
						),

  				]
				)
			)
		);
  }
}

class _CustomText extends StatelessWidget {
  const _CustomText({
    required this.text,  this.size,
  });

  final String text;
	final double? size;

  @override
  Widget build(BuildContext context) {
    return Padding(
    	padding: const EdgeInsets.symmetric(vertical: 10),
    	child: Text(text,style:  TextStyle(color: Colors.white, fontSize: size ?? 20, fontWeight: FontWeight.bold),),
    );
  }
}
