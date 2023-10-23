import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/providers/providers.dart';

import '../models/models.dart';
import '../theme/custom_styles.dart';

class PopUpFormAddGroupDebt extends StatefulWidget {
	const PopUpFormAddGroupDebt({super.key});

  @override
  State<PopUpFormAddGroupDebt> createState() => _PopUpFormAddGroupDebtState();
}

class _PopUpFormAddGroupDebtState extends State<PopUpFormAddGroupDebt> {
	TextEditingController dateinput = TextEditingController(); 

	@override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

	@override
	Widget build(BuildContext context) {
		final size = MediaQuery.of(context).size;
    final groupsProvider = Provider.of<GroupsProvider>(context);
    final addGroupDebtForm = Provider.of<AddGroupDebtForm>(context);

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
                    title: const Text('Añadir gasto al grupo', style: TextStyle(color: AppTheme.primaryColor),),
                    content: Container(
											height: size.height * 0.25,
											width: size.width * 0.7,
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: addGroupDebtForm.formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                               decoration: InputDecorations.formInputDecoration(
              									  hintText: 'Alejandro Gomez Garcia',
              									  labelText: 'Pagador',
              									  prefixIcon: Icons.person,  
              								),
                              onChanged: ( value ) => addGroupDebtForm.payer = value,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecorations.formInputDecoration(
              									  hintText: '14.00',
              									  labelText: 'Cuantía',
              									  prefixIcon: Icons.monetization_on_outlined
              								),
                              onChanged: ( value ) => addGroupDebtForm.amount = double.parse(value),
                            ),
                            TextFormField(
                               decoration: InputDecorations.formInputDecoration(
              									  hintText: 'Cena del Sabado',
              									  labelText: 'Descripcion',
              									  prefixIcon: Icons.title_outlined,  
              								),
                              onChanged: ( value ) => addGroupDebtForm.description = value,
                            ),
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
                          onPressed: addGroupDebtForm.isLoading ? null : () async {
                            FocusScope.of(context).unfocus();
                            if( !addGroupDebtForm.isValidForm() ) return;
                    
                            addGroupDebtForm.isLoading = true;


                            groupsProvider.addDebt();
                            Navigator.pushReplacementNamed(context, 'groups');
                          },
                          child: const Text("Añadir", style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                      )
                    ],
                  );
                });
          },
        );
	}
}