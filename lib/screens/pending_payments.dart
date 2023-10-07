import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/theme/custom_styles.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';


class TypeOfPayment {

    TypeOfPayment({required this.type});
		String type;
		
		Color color() {
			if (type == "earn"){
				return Colors.green;
			}
			else if(type == "pay"){
				return Colors.red;
			}
			else { return Colors.white.withOpacity(0);}
		}

		String message() {
			if (type == "earn"){
				return "Cobro Pendiente";
			}
			else if(type == "pay"){
				return "Pago Pendiente";
			}
			else { return "";}
		}

		String checkBoxMessage(){
			if (type == "earn"){
				return "Cobrado";
			}
			else if(type == "pay"){
				return "Pagado";
			}
			else { return "";}
		}

}

class DebtsScreen extends StatelessWidget {
	 
	const DebtsScreen({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		final debtsprovider = Provider.of<DebtsProvider>(context);
		return  Scaffold(
			appBar: AppBar(title: const Text("Pagos Pendientes", style: TextStyle(color: Colors.white)),),
			drawer: const Drawer(child: MyDrawer()),
			body: Center(
				 child: Stack(
						children: [
							const Background(),
					 		Column(
							 children: [
							 	Expanded(child:	
							 		SizedBox(
										height: 600,
      							child: ListView.builder(
											itemCount: debtsprovider.userDebts.length,
											itemBuilder: (context, index) =>  CustomCardDebt(debt: debtsprovider.userDebts[index],))
      						),
								),
						 	]
					 	),			
					],	
				),
			)
		);
	}
}

class CustomCardDebt extends StatelessWidget {
	setupCard(){
		
	}

  const CustomCardDebt({
    super.key, required this.debt,
  });
	final Debt debt;

  @override
  Widget build(BuildContext context) {
		final usersProvider = Provider.of<UsersProvider>(context);
		TypeOfPayment typeOfPayment;
		String otherUser = "";

		if(debt.originUser == usersProvider.user) {
			typeOfPayment = TypeOfPayment(type: "pay");
			otherUser = debt.destinationUser;
		} else{
			typeOfPayment = TypeOfPayment(type: "earn");
			otherUser = debt.originUser;
		}

    return Container(
			padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
			child: Card(
					color: Colors.white.withOpacity(0.9),
					child: Container(
							padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
							alignment: Alignment.center,
							height: 135,
							width: double.infinity,
							child: GestureDetector(	
								onTap: () => Navigator.pushReplacementNamed(context, 'debtDetail', arguments: debt),			
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										DebtInfoRow(typeOfPayment: typeOfPayment, otherUser: otherUser, debt: debt),
										const Divider(color: AppTheme.primaryColor,thickness: 1,),
									 	MarkAsPaidRow(debt: debt, typeOfPayment: typeOfPayment)
	
									]
								),
							),
					),
				),
		);
  }
}

class MarkAsPaidRow extends StatelessWidget {
  const MarkAsPaidRow({
    super.key,
		required this.debt,
		required this.typeOfPayment
  });

	final Debt debt;
	final TypeOfPayment typeOfPayment;

  @override
  Widget build(BuildContext context) {
		final debtsprovider = Provider.of<DebtsProvider>(context);
    return Row(
      children: [
        Text(typeOfPayment.checkBoxMessage(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),),
      	const Spacer(),
    		Checkbox(
					value: debt.isPaid,
				 	checkColor: AppTheme.primaryColor,
					fillColor: MaterialStateColor.resolveWith((states){
						if(debt.isPaid == true){
							return AppTheme.secondaryBlue.withOpacity(0.7);
						}
						return Colors.white;
					}),
					onChanged: (value){
						debt.isPaid = value!;
						debtsprovider.updateDebt(debt);
					}
				)
    	],
    );
  }
}

class DebtInfoRow extends StatelessWidget {
  const DebtInfoRow({
    super.key,
    required this.typeOfPayment,
    required this.otherUser,
    required this.debt,
  });

  final TypeOfPayment typeOfPayment;
  final String otherUser;
  final Debt debt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
    		Column(
					crossAxisAlignment: CrossAxisAlignment.start,
    		  children: [
    		    Text(typeOfPayment.message(),style: TextStyle(color: typeOfPayment.color(), fontSize: 20, fontWeight: FontWeight.bold),),
    		    Row(
    		      children: [
    		        const Padding(
									padding: EdgeInsets.symmetric(horizontal: 5.0),
									child: Icon(Icons.person, color: AppTheme.secondaryBlue,),
								),
								Text(otherUser,style: const TextStyle(color: Colors.black, fontSize: 18),),
    		      ],
    		    ),
    		  ],
    		),
    		const Spacer(),
    		Text("${debt.amount} €", style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),)
      ],
    );
  }
}
