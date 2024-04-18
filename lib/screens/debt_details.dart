import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:Messup/theme/app_theme.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class DebtDetailScreen extends StatelessWidget {
	 
	const DebtDetailScreen({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		return  Scaffold(
			appBar: AppBar(title: const Text("Detalle de Deuda", style: TextStyle(color: Colors.white),),),
			drawer: const Drawer(child: MyDrawer(),),
			body:  const Stack(
			  children: [
			    Background(),
			    _ScreenBody(),
			  ]
			),
		);
	}
}

class _ScreenBody extends StatelessWidget {

	_launchUrl(String url) async {
		final Uri uri = Uri(scheme: "https", host: url); 
		if(!await launchUrl(uri, mode: LaunchMode.externalApplication)){
			throw "Can not launch url";
		}

	}

  const _ScreenBody();
  @override
  Widget build(BuildContext context) {
		final Debt debt = ModalRoute.of(context)!.settings.arguments as Debt;
		String formattedDate = DateFormat('dd-MM-yyyy').format(debt.date); 

    return SafeArea(
			child: Container(
				padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  			height: double.infinity,
  			width: double.infinity,
  			child: Column(
  			  children:  [

						_CustomText(text: formattedDate, size: 25,),

						SizedBox(
							height: 250,
							width: 250,
							child:  IconButton(
							icon:  const Image(image: AssetImage('assets/images/paypalIcon.png'), fit: BoxFit.fill),
							style: ButtonStyle(
								shape: MaterialStateProperty.all<RoundedRectangleBorder>(
									const RoundedRectangleBorder(
										borderRadius: BorderRadius.all(Radius.circular(10)),
								))
							),
							onPressed: () {
							  _launchUrl("www.paypal.com/signin");
							},)
						),
						const _CustomText(text: 'Escanea el QR para efectuar el pago',size: 20,),
						_CustomText(text: 'El importe es de: ${debt.amount.toStringAsFixed(2)}€',size: 22,),
						MarkAsPaidButton(debt: debt)
  				]
				)
			)
		);
  }
}

class MarkAsPaidButton extends StatelessWidget {
  const MarkAsPaidButton({
    super.key,
     required this.debt,
  });

  final Debt debt;

  @override
  Widget build(BuildContext context) {
		final debtProvider = Provider.of<DebtsProvider>(context);
    return SizedBox(
    	height: 75,
    	width: 300,
    	child: FilledButton(
    			style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppTheme.primaryColor)),
    			onPressed: () {
    				debtProvider.updateDebt(debt);
    				Navigator.popAndPushNamed(context, "debts");
    			},
    			child: const Text("Pagado", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),
    );
  }
}

class _CustomText extends StatelessWidget {
  const _CustomText({
    required this.text, this.size
  });

  final String text;
	final double? size;

  @override
  Widget build(BuildContext context) {
    return Text(text,style:  TextStyle(color: Colors.white, fontSize: size ?? 20, fontWeight: FontWeight.bold));
  }
}
