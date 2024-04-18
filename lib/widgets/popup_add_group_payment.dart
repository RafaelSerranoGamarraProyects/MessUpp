import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Messup/providers/providers.dart';

import '../models/models.dart';
import '../theme/custom_styles.dart';

class PopUpFormAddGroupPayment extends StatefulWidget {
	const PopUpFormAddGroupPayment({super.key});

  @override
  State<PopUpFormAddGroupPayment> createState() => _PopUpFormAddExpenditureState();
}

class _PopUpFormAddExpenditureState extends State<PopUpFormAddGroupPayment> {
	TextEditingController dateinput = TextEditingController(); 

	@override
  void initState() {
    super.initState();
  }

	@override
	Widget build(BuildContext context) {
		final size = MediaQuery.of(context).size;
    final groupsProvider = Provider.of<GroupsProvider>(context);
    final usersProvider = Provider.of<UsersProvider>(context);
    final addGroupPaymentForm = Provider.of<AddGroupPaymentProvider>(context);

		return ElevatedButton(
					style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: Colors.white, minimumSize: const Size(50,50)),
					child: const Icon(Icons.add, size: 25,color: Colors.black),
          onPressed: () {
            /*
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialogAddGroup(size: size, addGroupPaymentForm: addGroupPaymentForm, usersProvider: usersProvider, groupsProvider: groupsProvider);
                });
                */
                Navigator.pushReplacementNamed(context, 'create_group');
          },
        );
	}
}

class AlertDialogAddGroup extends StatelessWidget {
  const AlertDialogAddGroup({
    super.key,
    required this.size,
    required this.addGroupPaymentForm,
    required this.usersProvider,
    required this.groupsProvider,
  });

  final Size size;
  final AddGroupPaymentProvider addGroupPaymentForm;
  final UsersProvider usersProvider;
  final GroupsProvider groupsProvider;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
										shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
										actionsAlignment: MainAxisAlignment.center,
										elevation: 0,
      scrollable: true,
      title: const Text('Crear un nuevo grupo', style: TextStyle(color: AppTheme.primaryColor),),
      content: Container(
											height: size.height * 0.1,
											width: size.width * 0.7,
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: addGroupPaymentForm.formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                 decoration: InputDecorations.formInputDecoration(
              									  hintText: 'Grupo de Amigos Geniales',
              									  labelText: 'Nombre del grupo',
              									  prefixIcon: Icons.people_rounded,  
              								),
                onChanged: ( value ) => addGroupPaymentForm.name = value,
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
														elevation: 0,
													),
            onPressed: addGroupPaymentForm.isLoading ? null : () async {
              FocusScope.of(context).unfocus();
              if( !addGroupPaymentForm.isValidForm() ) return;
      
              addGroupPaymentForm.isLoading = true;
              Group newGroup = Group(name: addGroupPaymentForm.name, creationDate: DateTime.now(), image: "", participants: [usersProvider.userLogged!.email], transactions: []);

              groupsProvider.createGroup(newGroup);
              Navigator.pushReplacementNamed(context, 'groups');
            },
            child: const Padding(
														padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
														child: Text("Crear Grupo", style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold,),),
													)
        )
      ],
    );
  }
}