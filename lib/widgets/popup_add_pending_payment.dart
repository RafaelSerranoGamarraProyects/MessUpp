import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:messup/providers/providers.dart';

import '../models/models.dart';
import '../theme/custom_styles.dart';

class PopUpFormAddPendingPayment extends StatefulWidget {
	const PopUpFormAddPendingPayment({super.key});

  @override
  State<PopUpFormAddPendingPayment> createState() => _PopUpFormAddExpenditureState();
}

class _PopUpFormAddExpenditureState extends State<PopUpFormAddPendingPayment> {
	TextEditingController dateinput = TextEditingController(); 

	@override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

	@override
	Widget build(BuildContext context) {
		final size = MediaQuery.of(context).size;
    final debtsProvider = Provider.of<DebtsProvider>(context);
    final usersProvider = Provider.of<UsersProvider>(context);
    final addPendingPaymentForm = Provider.of<AddPendingPaymentProvider>(context);

		return ElevatedButton(
					style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: Colors.white, minimumSize: const Size(50,50)),
					child: const Icon(Icons.add, size: 25,color: Colors.black),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
										shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    scrollable: true,
                    title: const Text('Crear un Pago Pendiente', style: TextStyle(color: AppTheme.primaryColor),),
                    content: Container(
											height: size.height * 0.25,
											width: size.width * 0.7,
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: addPendingPaymentForm.formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                               decoration: InputDecorations.formInputDecoration(
              									  hintText: 'Alejandro Gomez Garcia',
              									  labelText: 'Tercera Persona',
              									  prefixIcon: Icons.person,  
              								),
                              onChanged: ( value ) => addPendingPaymentForm.payer = value,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecorations.formInputDecoration(
              									  hintText: '14.00',
              									  labelText: 'Cuantía',
              									  prefixIcon: Icons.monetization_on_outlined
              								),
                              onChanged: ( value ) => addPendingPaymentForm.amount = double.parse(value),
                            ),
                            DropdownButtonFormField(
                              decoration: const InputDecoration( 
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.primaryColor
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.primaryColor,
                                    width: 2
                                  )
                                )
                              ),
                              items: const [
		                                  DropdownMenuItem(
                                        value: "Pago Pendiente",
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.money_off,color: AppTheme.primaryColor),Text("Pago"),],
                                         )),
		                                  	DropdownMenuItem(
                                        value: "Cobro Pendiente",
                                        child: Row(
                                          children: <Widget>[Icon(Icons.wallet_outlined,color: AppTheme.primaryColor),Text("Cobro"),],
		                                  	)),
	                            ],
                              onChanged: (value) {
                                if(value != null) addPendingPaymentForm.type = value;
                                setState(() {});
                              },
                              value: addPendingPaymentForm.type.isNotEmpty ? addPendingPaymentForm.type : null,
                            )
                          ],
                        ),
                      ),
                    ),
                     actions: [
                      ElevatedButton(
													style: ElevatedButton.styleFrom(
														shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
													 	backgroundColor: AppTheme.primaryColor,
													),
                          onPressed: addPendingPaymentForm.isLoading ? null : () async {
                            FocusScope.of(context).unfocus();
                            if( !addPendingPaymentForm.isValidForm() ) return;
                    
                            addPendingPaymentForm.isLoading = true;
                            DateTime date = DateTime.now();
                            Debt newDebt;
                            if(addPendingPaymentForm.type == "Cobro Pendiente") {
                              newDebt = Debt(date: date, amount: addPendingPaymentForm.amount, destinationUser: usersProvider.userLogged!.email,
                                originUser: addPendingPaymentForm.payer, isPaid: false);
                            }
                            else {
                              newDebt = Debt(date: date, amount: addPendingPaymentForm.amount, destinationUser: addPendingPaymentForm.payer,
                                originUser: usersProvider.userLogged!.email, isPaid: false);
                            }                
                            debtsProvider.createDebt(newDebt);
                            Navigator.pushReplacementNamed(context, 'debts');
                          },
                          child: const Text("Añadir", style: TextStyle(color: AppTheme.textColorPrimary, fontSize: 20,fontWeight: FontWeight.bold),)
                      )
                    ],
                  );
                });
          },
        );
	}
}