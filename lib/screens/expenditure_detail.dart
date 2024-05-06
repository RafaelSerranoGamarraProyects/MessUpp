import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:messup/models/Entity/expenditure.dart';
import '../providers/providers.dart';
import '../theme/custom_styles.dart';
import '../widgets/widgets.dart';


class ExpenditureScreen extends StatelessWidget {
	const ExpenditureScreen({super.key});

	@override
	Widget build(BuildContext context) {
		final Expenditure expenditure = ModalRoute.of(context)!.settings.arguments as Expenditure;
		return Scaffold(
      resizeToAvoidBottomInset: false,
			body: Stack(
			  children:[
			    const Background(),
			    SafeArea(child: _ModifyBody(expenditure: expenditure)),
			    const ReturnButton(),
			    PickImageButton(expenditure: expenditure,),
			  ]
			),
		);
	}
}

class SubmitModifyButton extends StatelessWidget {
  const SubmitModifyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final expensesProvider = Provider.of<ExpensesProvider>(context);
    final modifyExpenditureFormProvider = Provider.of<ModifyExpenditureFormProvider>(context);
    return Container(
     width: 300,
     height: 100,
     alignment: Alignment.bottomCenter,
     child: ElevatedButton(
       style: ElevatedButton.styleFrom(minimumSize: const Size(300, 80), backgroundColor: AppTheme.primaryColor),
       onPressed: () async {
          
          if ( !modifyExpenditureFormProvider.isValidForm() ) return;

          final String? imageUrl = await expensesProvider.uploadImage();
//
          if ( imageUrl != null ) expensesProvider.selectedExpenditure!.image = imageUrl;
          expensesProvider.selectedExpenditure!.amount = modifyExpenditureFormProvider.expenditure.amount;
          if(modifyExpenditureFormProvider.date != "") {
            expensesProvider.selectedExpenditure!.date = DateTime.parse(modifyExpenditureFormProvider.date);
          }
          expensesProvider.selectedExpenditure!.description = modifyExpenditureFormProvider.expenditure.description;

          expensesProvider.updateExpenditure();
          // ignore: use_build_context_synchronously
          Navigator.popAndPushNamed(context, 'home');

      },
      child: const Text("Modificar", style: TextStyle(fontSize: 20,color: Colors.white),),)
    );
  }
}

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpensesProvider>(context);
    return Positioned(
      top: 60,
      left: 20,
      child: IconButton(
        onPressed: () {
          if(expenseProvider.selectedExpenditure != null){
            expenseProvider.selectedExpenditure = null;
            expenseProvider.newPictureFile = null;
          }
          Navigator.popAndPushNamed(context, 'home');

        }, 
        icon: const Icon( Icons.arrow_back_ios_new, size: 40, color: Colors.black ),
      )
    );
  }
}

class PickImageButton extends StatelessWidget {
  const PickImageButton({
    super.key,
    required this.expenditure,
  });


  final Expenditure expenditure;

  @override
  Widget build(BuildContext context) {
		final expensesProvider = Provider.of<ExpensesProvider>(context);
    return Positioned(
      top: 60,
      right: 20,
      child: IconButton(
      onPressed: () async {
          final picker = ImagePicker();
          final XFile? pickedFile = await picker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 100
          );
          if( pickedFile == null ) {
            return;
          }
          
          expensesProvider.updateSelectedImage(pickedFile.path);
    
        }, 
        style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: Colors.grey, minimumSize: const Size(50,50)),
        icon: const Icon( Icons.camera_alt_outlined, size: 40, color: Colors.black ),
      )
    );
  }
}

class _ModifyBody extends StatelessWidget {
  const _ModifyBody({
    required this.expenditure,
  });
  final Expenditure expenditure;

  @override
  Widget build(BuildContext context) {
    final expensesProvider = Provider.of<ExpensesProvider>(context);
    expensesProvider.selectedExpenditure = expenditure;
    

    return SizedBox(
    height: double.infinity,
    width: double.infinity,
    child: SingleChildScrollView(
      child: Column(
        children: [
            ExpenditureImage( url: expensesProvider.selectedExpenditure!.image ),
            _ExpenditureForm(date: DateFormat('yyyy-MM-dd').format(expensesProvider.selectedExpenditure!.date)),
            const SubmitModifyButton(),
    
        ]),
    ),
	  );
  }
}
class _ExpenditureForm extends StatefulWidget {
  
  const _ExpenditureForm({required this.date});
  final String date;
  
  @override
  State<_ExpenditureForm> createState() => _ExpenditureFormState();
}

class _ExpenditureFormState extends State<_ExpenditureForm> {
  
  TextEditingController dateinput = TextEditingController();
  

	@override
  void initState() {
    dateinput.text = widget.date;//set the initial value of text field
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {

    final expenditureForm = Provider.of<ModifyExpenditureFormProvider>(context);
    final expensesProvider = Provider.of<ExpensesProvider>(context);
    expenditureForm.expenditure = expensesProvider.selectedExpenditure!;


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 300,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: expenditureForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  initialValue: expensesProvider.selectedExpenditure!.description,
                  onChanged: ( value ) {
                    if(value == "") {
                      expenditureForm.expenditure.description = "Sin descripcion";
                    } else {
                      expenditureForm.expenditure.description = value;
                    }
                  } ,
                  decoration: InputDecorations.formInputDecoration(
                    hintText: 'Titulo del Gasto', 
                    labelText: 'Titulo:'
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  initialValue: '${expensesProvider.selectedExpenditure!.amount}',

                  onChanged: ( value ) {
                    if ( double.tryParse(value) != null ) {
                      expenditureForm.expenditure.amount = double.parse(value);
                    } else {
                      expenditureForm.expenditure.amount = 0;
                    }
                  },

                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.formInputDecoration(
                    hintText: '\$150', 
                    labelText: 'Cuantía:'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
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
                           expenditureForm.date = formattedDate;
                        });
                    }
                  },
              
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0,5),
        blurRadius: 5
      )
    ]
  );