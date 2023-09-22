
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../theme/custom_styles.dart';

class PopUpFormAddObjetive extends StatefulWidget {
	const PopUpFormAddObjetive({super.key});

  @override
  State<PopUpFormAddObjetive> createState() => _PopUpFormAddObjetiveState();
}

class _PopUpFormAddObjetiveState extends State<PopUpFormAddObjetive> {

	@override
  void initState() {
    super.initState();
  }

	@override
	Widget build(BuildContext context) {
		final size = MediaQuery.of(context).size;
    final usersProvider = Provider.of<UsersProvider>(context);
    final objetivesProvider = Provider.of<ObjetivesProvider>(context);
    final addObjetiveForm = Provider.of<AddObjetiveFormProvider>(context);

		return ElevatedButton(
					style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: Colors.grey, minimumSize: const Size(50,50)),
					child: const Icon(Icons.add, size: 25,color: Colors.black),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
										shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    scrollable: true,
                    title: const Text('Añadir un Objetivo Mensual'),
                    content: Container(
											height: size.height * 0.3,
											width: size.width * 0.7,
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: addObjetiveForm.formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                hintText: "Este mes quiero ahorrar unos 300 euros para poder irme el mes que viene de vacaciones",
                                labelText: "Descripción",
                                labelStyle: TextStyle(
                                    color: Colors.grey
                                  ),

                                prefix: Icon(Icons.title_outlined, color: AppTheme.primaryColor,),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppTheme.primaryColor,)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                   color: AppTheme.primaryColor,
                                   width: 2
                                  ),),
                                  
                              ),

                              onChanged: ( value ) => addObjetiveForm.description = value,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecorations.formInputDecoration(
              									  hintText: '14.00',
              									  labelText: 'Cuantía',
              									  prefixIcon: Icons.monetization_on_outlined,
              								),
                              onChanged: ( value ) => addObjetiveForm.amount = double.parse(value),

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
                          onPressed: addObjetiveForm.isLoading ? null : () async {
                            FocusScope.of(context).unfocus();
                            if( !addObjetiveForm.isValidForm() ) return;
                    
                            addObjetiveForm.isLoading = true;
                        
                            final newObjetive = Objetive(date: DateTime.now(), amount: addObjetiveForm.amount,
                              description: addObjetiveForm.description, user: usersProvider.user, isAchived: false);
                
                            objetivesProvider.addObjetive(newObjetive);

                            Navigator.pushReplacementNamed(context, 'home');
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




