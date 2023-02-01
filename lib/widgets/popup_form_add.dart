import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/custom_styles.dart';

class PopUpFormAddExpenditure extends StatefulWidget {
	const PopUpFormAddExpenditure({super.key});

  @override
  State<PopUpFormAddExpenditure> createState() => _PopUpFormAddExpenditureState();
}

class _PopUpFormAddExpenditureState extends State<PopUpFormAddExpenditure> {
	TextEditingController dateinput = TextEditingController(); 

	@override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

	@override
	Widget build(BuildContext context) {
		final size = MediaQuery.of(context).size;
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
                    title: const Text('Añadir un gasto'),
                    content: Container(
											height: size.height * 0.3,
											width: size.width * 0.7,
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                               decoration: InputDecorations.formInputDecoration(
              									  hintText: 'Compra Mensual',
              									  labelText: 'Asunto',
              									  prefixIcon: Icons.title_outlined
              								),
                            ),
                            TextFormField(
                               decoration: InputDecorations.formInputDecoration(
              									  hintText: '14.00',
              									  labelText: 'Cuantía',
              									  prefixIcon: Icons.monetization_on_outlined
              								),
                            ),
                            TextFormField(
															controller: dateinput,
                              decoration: InputDecorations.dateInputDecoration(labelText: "Introduce la fecha"),
 															readOnly: true,  //set it true, so that user will not able to edit text
                							onTap: () async {
																setState(() {dateinput.text = "";});
                							  DateTime? pickedDate = await showDatePicker(
                							      context: context,
																		initialDate: DateTime.now(),
                							      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                							      lastDate: DateTime(2101)
                							  );

                							  if(pickedDate != null ){
                							      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                							      setState(() {
                							         dateinput.text = formattedDate;
                							      });
                							  }
															},
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Categoria',
                                icon: Icon(Icons.category , color: AppTheme.primaryColor,),
                              ),
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
                          child: const Text("Añadir", style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                          onPressed: () {
                            // your code
                          })
                    ],
                  );
                });
          },
        );
	}
}




