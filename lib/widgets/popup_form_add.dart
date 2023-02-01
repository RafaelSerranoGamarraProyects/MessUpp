import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/providers/providers.dart';

import '../models/models.dart';
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
    final expensesProvider = Provider.of<ExpensesProvider>(context);
    //final usersProvider = Provider.of<UsersProvider>(context);
    final addExpenditureForm = Provider.of<AddExpenditureFormProvider>(context);


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
                        key: addExpenditureForm.formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                               decoration: InputDecorations.formInputDecoration(
              									  hintText: 'Compra Mensual',
              									  labelText: 'Asunto',
              									  prefixIcon: Icons.title_outlined,  
              								),
                              onChanged: ( value ) => addExpenditureForm.description = value,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecorations.formInputDecoration(
              									  hintText: '14.00',
              									  labelText: 'Cuantía',
              									  prefixIcon: Icons.monetization_on_outlined
              								),
                              onChanged: ( value ) => addExpenditureForm.amount = value,

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
                                       addExpenditureForm.date = formattedDate;
                							      });
                							  }
															},

                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Categoria',
                                icon: Icon(Icons.category , color: AppTheme.primaryColor,),
                              ),
                              onChanged: ( value ) => addExpenditureForm.category = value,

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
                          onPressed: addExpenditureForm.isLoading ? null : () async {
                            FocusScope.of(context).unfocus();
                            if( !addExpenditureForm.isValidForm() ) return;

                            var stringArray = addExpenditureForm.date.split('-');
                           
                            var year = int.parse(stringArray[0]);
                            var month = int.parse(stringArray[1]);
                            var day = int.parse(stringArray[2]);
                            var amount = double.parse(addExpenditureForm.amount); 

                            addExpenditureForm.isLoading = true;
                            var finalDate = DateTime(year,month,day);

                            final newExpenditure = Expenditure(date: finalDate, amount: amount,
                              category: addExpenditureForm.category, description: addExpenditureForm.description, image: '');
                            
                            expensesProvider.addExpenditure(newExpenditure,addExpenditureForm.date);

                            Navigator.pop(context);
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




